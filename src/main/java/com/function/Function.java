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
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Collections;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

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
     * This function listens at endpoint "/api/HttpExample". Two ways to invoke it using "curl" command in bash:
     * 1. curl -d "HTTP Body" {your host}/api/HttpExample
     * 2. curl "{your host}/api/HttpExample?name=HTTP%20Query"
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

        String folder = "./tmp";
        boolean dirCreated = new File(folder).mkdir();

        if (!dirCreated) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt create folder" + folder).build();
        }

        String folder2 = "./tmp2";
        boolean dirCreated2 = new File(folder2).mkdir();

        if (!dirCreated2) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt create folder" + folder2).build();
        }

        Path targetDir = Paths.get(folder2);

        File file = new File(folder + "/input.zip");

        try (FileOutputStream fos = new FileOutputStream(file.getAbsoluteFile())){
            fos.write(request.getBody());
        } catch (FileNotFoundException e1) {
            e1.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        try (ZipInputStream zis = new ZipInputStream(new FileInputStream(file))) {
            ZipEntry zipEntry = zis.getNextEntry();
            if (zipEntry == null) {
                context.getLogger().info("Uh oh!!!!");
            }
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
            e.printStackTrace();
        }

        InvocationRequest request2 = new DefaultInvocationRequest();
        request2.setPomFile(new File(folder2 + "/pom.xml"));
        request2.setGoals(Collections.singletonList("clean"));

        Invoker invoker = new DefaultInvoker();
        invoker.setMavenHome(new File("C:/Program Files/apache-maven-3.8.6/bin/mvn"));
        try {
            invoker.execute(request2);
        } catch (MavenInvocationException e) {
            e.printStackTrace();
        }

        
        return request.createResponseBuilder(HttpStatus.OK).body("Job done!").build();
        
    }
}
