package com.function;

import com.function.utils.ContextInvocationHandler;
import com.function.utils.ContextLogger;
import com.function.utils.FileHelper;

import com.microsoft.azure.functions.ExecutionContext;
import com.microsoft.azure.functions.HttpMethod;
import com.microsoft.azure.functions.HttpRequestMessage;
import com.microsoft.azure.functions.HttpResponseMessage;
import com.microsoft.azure.functions.HttpStatus;
import com.microsoft.azure.functions.annotation.AuthorizationLevel;
import com.microsoft.azure.functions.annotation.FunctionName;
import com.microsoft.azure.functions.annotation.HttpTrigger;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;

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
public class JavaFunction {
    /**
     * This function listens at endpoint "/api/java". To invoke it using "curl" command in bash:
     * curl -X POST --data-binary "@pq-api-v2-java_eclipse_jre_lib.zip" -H 'Content-Type: application/octet-stream' http://localhost:7071/api/java
     * @throws FileNotFoundException
     */

    @FunctionName("JavaAzureFunction")
    public HttpResponseMessage run(
            @HttpTrigger(
                name = "req",
                route = "java",
                methods = {HttpMethod.POST},
                dataType = "binary",
                authLevel = AuthorizationLevel.FUNCTION)
                HttpRequestMessage<byte[]> request,
            final ExecutionContext context) {
        context.getLogger().info("Java Endpoint HTTP trigger processed a request.");

        Path targetDir = null;
        try {
            targetDir = FileHelper.createDir(context);
        } catch (IOException e2) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt create TargetDir.ExceptionTrace:\n"+e2.getMessage() ).build();
        }

        Path sourceFilePath = null;
        try {
            sourceFilePath = FileHelper.createZipFile(context, request.getBody());
        } catch (FileNotFoundException e1) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt find sourceFile.ExceptionTrace:\n"+e1.getMessage() ).build();
        } catch (IOException e) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt create SourceFile.ExceptionTrace:\n"+e.getMessage() ).build();
        }
        
        try {
            FileHelper.unzipFolder(sourceFilePath.toAbsolutePath(), targetDir.toAbsolutePath());
        } catch (IOException e1) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt do unzip operation.ExceptionTrace:\n"+e1.getMessage() ).build();
        }

        try {
            CommandLineException exception = InvokeMaven(context, targetDir);

            if (exception != null) {
                return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Maven commandline exception encountered.ExceptionTrace:\n"+exception.getMessage()).build();
            }
        } catch (MavenInvocationException e) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt run maven invoke.ExceptionTrace:\n"+e.getMessage() ).build();
        }

        try {
            FileHelper.zipFolder(targetDir.toAbsolutePath(), context);
        } catch (IOException e1) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Couldnt do zip operation.ExceptionTrace:\n"+e1.getMessage() ).build();
        }

        try {
            Path zipFileResponse = Paths.get(targetDir.getFileName().toAbsolutePath().toString() + ".zip");
            byte[] bFile = Files.readAllBytes(zipFileResponse);
            return request.createResponseBuilder(HttpStatus.OK).body(bFile).header("Content-Type", "application/zip").build();
        } catch (IOException e) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Something wrong in byte array:\n"+e.getMessage() ).build();
        }
    }

    private static CommandLineException InvokeMaven(ExecutionContext context, Path targetDir) throws MavenInvocationException {
        Invoker invoker = new DefaultInvoker();

        InvokerLogger invokerLogger = new ContextLogger(context);
        invokerLogger.setThreshold(ContextLogger.DEBUG);
        invoker.setLogger(invokerLogger);

        InvocationRequest invocationRequest = new DefaultInvocationRequest();
        Path mvnExecutable = Paths.get(System.getenv("HOME"), "site","wwwroot","mavenDir","bin","mvn");
        Path javaDirPath = Paths.get(System.getenv("JAVA_HOME"));
        invocationRequest.setJavaHome(javaDirPath.toFile());
        invocationRequest.setMavenExecutable(mvnExecutable.toFile());
        List<String> goals = new LinkedList<String>();
        goals.add("clean");
        goals.add("deploy");
        invocationRequest.setGoals(goals);
        
        invocationRequest.setInputStream(new NullInputStream(0));
        Path pomFilePath = Paths.get(targetDir.toAbsolutePath().toString(), "pom.xml");
        invocationRequest.setPomFile(pomFilePath.toFile());
        invocationRequest.setDebug(true);
        
        InvocationOutputHandler invocationHandler = new ContextInvocationHandler(context);
        invocationRequest.setErrorHandler(invocationHandler);
        invocationRequest.setOutputHandler(invocationHandler);

        InvocationResult invocationResult = invoker.execute(invocationRequest);
        CommandLineException exception = invocationResult.getExecutionException();

        if (invocationResult.getExitCode() != 0) {
            context.getLogger().info("Something went bad during transmission");
        }

        return exception;
    }

}