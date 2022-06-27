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
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.apache.commons.io.input.NullInputStream;
import org.apache.maven.shared.invoker.DefaultInvocationRequest;
import org.apache.maven.shared.invoker.DefaultInvoker;
import org.apache.maven.shared.invoker.InvocationOutputHandler;
import org.apache.maven.shared.invoker.InvocationRequest;
import org.apache.maven.shared.invoker.InvocationResult;
import org.apache.maven.shared.invoker.Invoker;
import org.apache.maven.shared.invoker.InvokerLogger;
import org.apache.maven.shared.invoker.MavenInvocationException;
import org.apache.maven.shared.utils.cli.CommandLineException;

/**
 * Azure Functions with HTTP Trigger.
 */
public class Function {
    /**
     * This function listens at endpoint "/api/Tester". To invoke it using "curl" command in bash:
     * curl -X POST --data-binary "@pq-api-v2-java_eclipse_jre_lib.zip" -H 'Content-Type: application/octet-stream' http://localhost:7071/api/Tester
     * @throws FileNotFoundException
     */

    private class MavenLogger implements org.apache.maven.shared.invoker.InvokerLogger {

        public static final int DEBUG = 4;
        public static final int ERROR = 1;
        public static final int FATAL = 0;
        public static final int INFO  = 3;
        public static final int WARN  = 2;

        private ExecutionContext _Context;
        private int _Threshold = FATAL;


        public MavenLogger(ExecutionContext context) {
            _Context = context;
        }

        @Override
        public void debug(String arg0) {
            _Context.getLogger().log(Level.FINEST, arg0);
        }

        @Override
        public void debug(String arg0, Throwable arg1) {
            _Context.getLogger().log(Level.FINEST, arg0, arg1);
        }

        @Override
        public void error(String arg0) {
            _Context.getLogger().log(Level.WARNING, arg0);
        }

        @Override
        public void error(String arg0, Throwable arg1) {
            _Context.getLogger().log(Level.WARNING, arg0, arg1);
        }

        @Override
        public void fatalError(String arg0) {
            _Context.getLogger().log(Level.SEVERE, arg0);
        }

        @Override
        public void fatalError(String arg0, Throwable arg1) {
            _Context.getLogger().log(Level.SEVERE, arg0, arg1);
        }

        @Override
        public int getThreshold() {
            return _Threshold;
        }

        @Override
        public void info(String arg0) {
            _Context.getLogger().log(Level.INFO, arg0);
        }

        @Override
        public void info(String arg0, Throwable arg1) {
            _Context.getLogger().log(Level.INFO, arg0, arg1);
        }

        @Override
        public boolean isDebugEnabled() {
            return _Context.getLogger().isLoggable(Level.FINEST);
        }

        @Override
        public boolean isErrorEnabled() {
            return _Context.getLogger().isLoggable(Level.WARNING);
        }

        @Override
        public boolean isFatalErrorEnabled() {
            return _Context.getLogger().isLoggable(Level.SEVERE);
        }

        @Override
        public boolean isInfoEnabled() {
            return _Context.getLogger().isLoggable(Level.INFO);
        }

        @Override
        public boolean isWarnEnabled() {
            return _Context.getLogger().isLoggable(Level.WARNING);
        }

        @Override
        public void setThreshold(int arg0) {
            if (arg0 == DEBUG ||
                arg0 == FATAL ||
                arg0 == INFO ||
                arg0 == ERROR ||
                arg0 == WARN) {
                    _Threshold = arg0;
                } else {
                    return;
                }
        }

        @Override
        public void warn(String arg0) {
            _Context.getLogger().log(Level.WARNING, arg0);
        }

        @Override
        public void warn(String arg0, Throwable arg1) {
            _Context.getLogger().log(Level.WARNING, arg0, arg1);
        }
    }

    private class MavenInvocationHandler implements org.apache.maven.shared.invoker.InvocationOutputHandler {

        private ExecutionContext _Context;

        public MavenInvocationHandler(ExecutionContext context) {
            _Context = context;
        }
        @Override
        public void consumeLine(String arg0) throws IOException {
            if (arg0 == null) {
                _Context.getLogger().info("");
            } else {
                _Context.getLogger().info(arg0);
            }
        }
        
    }
    
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

        Invoker invoker = new DefaultInvoker();

        InvokerLogger mavenLogger = new MavenLogger(context);
        mavenLogger.setThreshold(MavenLogger.DEBUG);
        invoker.setLogger(mavenLogger);

        InvocationRequest request2 = new DefaultInvocationRequest();
        Path mvnExecutable = Paths.get(System.getenv("HOME"), "site","wwwroot","mavenDir","bin","mvn");
        Path javaDirPath = Paths.get(System.getenv("JAVA_HOME"));
        request2.setJavaHome(javaDirPath.toFile());
        request2.setMavenExecutable(mvnExecutable.toFile());
        List<String> goals = new LinkedList<String>();
        goals.add("clean");
        goals.add("deploy");
        request2.setGoals(goals);
        
        request2.setInputStream(new NullInputStream(0));
        Path pomFilePath = Paths.get(targetDir.toAbsolutePath().toString(), "pom.xml");
        request2.setPomFile(pomFilePath.toFile());
        request2.setDebug(true);
        
        InvocationOutputHandler mavenHandler = new MavenInvocationHandler(context);
        request2.setErrorHandler(mavenHandler);
        request2.setOutputHandler(mavenHandler);
        
        try {
            InvocationResult invocationResult = invoker.execute(request2);
            CommandLineException exception = invocationResult.getExecutionException();

            if (exception != null) {
                return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Maven commandline exception encountered.ExceptionTrace:\n"+exception.getMessage()).build();
            }

            if (invocationResult.getExitCode() != 0) {
                context.getLogger().info("Something went bad during transmission");
            }

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

    private static void zipFolder(Path source, final ExecutionContext context) throws IOException {

        // get folder name as zip file name
        String zipFileName = source.getFileName().toAbsolutePath().toString() + ".zip";

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
