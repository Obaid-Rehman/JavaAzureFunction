package com.function;

import com.microsoft.azure.functions.ExecutionContext;
import com.microsoft.azure.functions.HttpMethod;
import com.microsoft.azure.functions.HttpRequestMessage;
import com.microsoft.azure.functions.HttpResponseMessage;
import com.microsoft.azure.functions.HttpStatus;
import com.microsoft.azure.functions.annotation.AuthorizationLevel;
import com.microsoft.azure.functions.annotation.FunctionName;
import com.microsoft.azure.functions.annotation.HttpTrigger;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.StandardCopyOption;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.Collections;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.apache.maven.shared.invoker.DefaultInvocationRequest;
import org.apache.maven.shared.invoker.DefaultInvoker;
import org.apache.maven.shared.invoker.InvocationRequest;
import org.apache.maven.shared.invoker.Invoker;
import org.apache.maven.shared.invoker.MavenInvocationException;

/**
 * Azure Functions with HTTP Trigger.
 */
public class Function {
    /**
     * This function listens at endpoint "/api/Tester". To invoke it using "curl" command in bash:
     * curl -X POST --data-binary "@pq-api-v2-java_eclipse_jre_lib.zip" -H 'Content-Type: application/octet-stream' http://localhost:7071/api/Tester
     * @throws FileNotFoundException
     */
    @FunctionName("HttpExample")
    public HttpResponseMessage run(
            @HttpTrigger(
                name = "req",
                route = "Tester",
                methods = {HttpMethod.POST},
                dataType = "binary",
                authLevel = AuthorizationLevel.FUNCTION)
                HttpRequestMessage<byte[]> request,
            final ExecutionContext context) {
        context.getLogger().info("Java HTTP trigger processed a request.");

        Path SourceDir = null;
        try {
            SourceDir = Files.createTempDirectory("temp");
            context.getLogger().info("SourceDir created: " + SourceDir.toString());
        } catch (IOException e2) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt create SourceDir.ExceptionTrace:\n"+e2.getMessage() ).build();
        }

        Path targetDir = null;
        try {
            targetDir = Files.createTempDirectory("temp2");
            context.getLogger().info("targetDir created: " + targetDir.toString());
        } catch (IOException e2) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt create TargetDir.ExceptionTrace:\n"+e2.getMessage() ).build();
        }

        
        Path sourceFilePath = null;
        try {
            sourceFilePath = Files.createTempFile(SourceDir, "temp", "zip");
            context.getLogger().info("sourceFile created: " + sourceFilePath.toFile().getName());
        } catch (IOException e2) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt create SourceFile.ExceptionTrace:\n"+e2.getMessage() ).build();
        }
        
        

        try (FileOutputStream fos = new FileOutputStream(sourceFilePath.toAbsolutePath().toString())){
            fos.write(request.getBody());
        } catch (FileNotFoundException e1) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt find sourceFile.ExceptionTrace:\n"+e1.getMessage() ).build();
        } catch (IOException e) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt find sourceFile IOException.ExceptionTrace:\n"+e.getMessage() ).build();
        }

        try (ZipInputStream zis = new ZipInputStream(new FileInputStream(sourceFilePath.toAbsolutePath().toString()))) {
            ZipEntry zipEntry = zis.getNextEntry();
            while (zipEntry != null) {
                boolean isDirectory = false;
                
                if (zipEntry.getName().endsWith(File.separator)) {
                    isDirectory = true;
                }

                Path targetDirResolved = targetDir.resolve(zipEntry.getName());
                Path normalizedPath = targetDirResolved.normalize();

                if (isDirectory) {
                    Files.createDirectories(normalizedPath);
                } else {
                    if (normalizedPath.getParent() != null) {
                        if (Files.notExists(normalizedPath.getParent())) {
                            Files.createDirectories(normalizedPath.getParent());
                        }
                    }

                    Files.copy(zis, normalizedPath, StandardCopyOption.REPLACE_EXISTING);
                }

                zipEntry = zis.getNextEntry();
            }
        } catch (Exception e) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt do unzip operation.ExceptionTrace:\n"+e.getMessage() ).build();
        }

        InvocationRequest request2 = new DefaultInvocationRequest();
        Path pomFilePath = Paths.get(targetDir.toAbsolutePath().toString(), "pom.xml");
        request2.setPomFile(pomFilePath.toFile());
        request2.setGoals(Collections.singletonList("install"));

        Invoker invoker = new DefaultInvoker();

        Path currentWorkingDirectory = Paths.get("").toAbsolutePath();
        String currentPath = currentWorkingDirectory.toString();
        context.getLogger().info("Current working directory: " + currentPath);
        
        Path mvnExecutable = Paths.get(currentPath, "mavenDir", "bin", "mvn");
        invoker.setMavenExecutable(mvnExecutable.toFile());
        try {
            invoker.execute(request2);
        } catch (MavenInvocationException e) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt run maven invoke.ExceptionTrace:\n"+e.getMessage() ).build();
        }

        try {
            zipFolder(targetDir.toAbsolutePath(), context);
        } catch (IOException e1) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt do zip operation.ExceptionTrace:\n"+e1.getMessage() ).build();
        }

        Path zipFileResponse = Paths.get(targetDir.toAbsolutePath().getFileName() + ".zip");
        
        try {
            byte[] bFile = Files.readAllBytes(zipFileResponse);
            return request.createResponseBuilder(HttpStatus.OK).body(bFile).header("Content-Type", "application/zip").build();
        } catch (IOException e) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Something wrong in byte array:\n"+e.getMessage() ).build();
        }
        
        
    }

    public static void zipFolder(Path source, final ExecutionContext context) throws IOException {

        // get folder name as zip file name
        String zipFileName = source.getFileName().toString() + ".zip";

        try (
                ZipOutputStream zos = new ZipOutputStream(
                        new FileOutputStream(zipFileName))
        ) {

            Files.walkFileTree(source, new SimpleFileVisitor<Path>() {
                @Override
                public FileVisitResult visitFile(Path file,
                    BasicFileAttributes attributes) {

                    // only copy files, no symbolic links
                    if (attributes.isSymbolicLink()) {
                        return FileVisitResult.CONTINUE;
                    }

                    try (FileInputStream fis = new FileInputStream(file.toFile())) {

                        Path targetFile = source.relativize(file);
                        zos.putNextEntry(new ZipEntry(targetFile.toString()));

                        byte[] buffer = new byte[1024];
                        int len;
                        while ((len = fis.read(buffer)) > 0) {
                            zos.write(buffer, 0, len);
                        }

                        // if large file, throws out of memory
                        //byte[] bytes = Files.readAllBytes(file);
                        //zos.write(bytes, 0, bytes.length);

                        zos.closeEntry();

                        context.getLogger().info("Zip file : " + file.getFileName().toString());

                    } catch (IOException e) {
                        context.getLogger().info(e.getMessage());
                    }
                    return FileVisitResult.CONTINUE;
                }

                @Override
                public FileVisitResult visitFileFailed(Path file, IOException e) {
                    context.getLogger().info("Unable to zip file " + file.getFileName().toString());
                    return FileVisitResult.CONTINUE;
                }
            });

        }
    }
}
