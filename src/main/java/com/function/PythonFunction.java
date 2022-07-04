package com.function;

import com.function.utils.ContextInvocationHandler;
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

import org.apache.commons.io.input.NullInputStream;
import org.apache.maven.shared.invoker.InvocationOutputHandler;
import org.apache.maven.shared.utils.cli.CommandLineException;
import org.apache.maven.shared.utils.cli.CommandLineUtils;
import org.apache.maven.shared.utils.cli.Commandline;

public class PythonFunction {
    /**
     * This function listens at endpoint "/api/python". To invoke it using "curl" command in bash:
     * curl -X POST --data-binary "@pq-api-v2-ruby_generic_lib.zip" -H 'Content-Type: application/octet-stream' http://localhost:7071/api/ruby
     * @throws FileNotFoundException
     */

    @FunctionName("PythonAzureFunction")
    public HttpResponseMessage run(
            @HttpTrigger(
                name = "req",
                route = "python",
                methods = {HttpMethod.POST},
                dataType = "binary",
                authLevel = AuthorizationLevel.FUNCTION)
                HttpRequestMessage<byte[]> request,
            final ExecutionContext context) {
        context.getLogger().info("Python Endpoint HTTP trigger processed a request.");

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

        CommandLineException exception = null;
        exception = InvokePython(context, targetDir);

        if (exception != null) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Ruby commandline exception encountered.ExceptionTrace:\n"+exception.getMessage()).build();
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

    private static CommandLineException InvokePython(ExecutionContext context, Path targetDir) {
        String pipPathString = Paths.get(System.getenv("HOME"), "site","wwwroot","pythonDir,Scripts,pip.exe").toAbsolutePath().toString();

        InvocationOutputHandler invocationHandler = new ContextInvocationHandler(context);

        try {
            Commandline commandline = new Commandline();
            commandline.setWorkingDirectory(targetDir.toFile());
            commandline.setExecutable(pipPathString);
            commandline.createArg().setLine("install -r requirements.txt");
            CommandLineUtils.executeCommandLine(commandline, new NullInputStream(0L), invocationHandler, invocationHandler, 300);
        } catch (CommandLineException e) {
            return e;
        }
        return null;
    }
}