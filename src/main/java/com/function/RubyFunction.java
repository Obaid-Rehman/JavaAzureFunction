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
import java.nio.file.StandardCopyOption;
import java.util.stream.Stream;

import org.apache.commons.io.input.NullInputStream;
import org.apache.maven.shared.utils.cli.CommandLineException;
import org.apache.maven.shared.utils.cli.CommandLineUtils;
import org.apache.maven.shared.utils.cli.Commandline;

public class RubyFunction {
    /**
     * This function listens at endpoint "/api/ruby". To invoke it using "curl" command in bash:
     * curl -X POST --data-binary "@pq-api-v2-ruby_generic_lib.zip" -H 'Content-Type: application/octet-stream' http://localhost:7071/api/ruby
     * @throws FileNotFoundException
     */

    @FunctionName("RubyAzureFunction")
    public HttpResponseMessage run(
            @HttpTrigger(
                name = "req",
                route = "ruby",
                methods = {HttpMethod.POST},
                dataType = "binary",
                authLevel = AuthorizationLevel.FUNCTION)
                HttpRequestMessage<byte[]> request,
            final ExecutionContext context) {
        context.getLogger().info("Ruby Endpoint HTTP trigger processed a request.");

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
        try {
            exception = InvokeRuby(context, targetDir);
        } catch (IOException e1) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Ruby commandline exception encountered.ExceptionTrace:\n"+e1.getMessage()).build();
        }

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

    private static CommandLineException InvokeRuby(ExecutionContext context, Path targetDir) throws IOException {
        Path rubyInstallationDirPath = Files.createTempDirectory("ruby");
        String rubyInstallationDirPathString = rubyInstallationDirPath.toAbsolutePath().toString();

        Path rubyInstallerPath = Paths.get(System.getenv("HOME"),"site","wwwroot","rubyDir", "rubyinstaller-3.1.2-1-x64.exe");

        /* Path rubyInstallerPath = Paths.get(Paths.get("").toAbsolutePath().toString(), "rubyDir", "rubyinstaller-3.1.2-1-x64.exe"); */

        Path rubyInstallerPathCopy = Paths.get(Paths.get("").toAbsolutePath().toString(),"rubyInstaller.exe");

        Files.copy(rubyInstallerPath, rubyInstallerPathCopy, StandardCopyOption.REPLACE_EXISTING);

        try (Stream<Path> paths = Files.walk(Paths.get("").toAbsolutePath())) {
            paths.filter(Files::isRegularFile)
            .forEach(path -> {
                context.getLogger().info(
                    "File Name: " + path.toAbsolutePath().toString() + "\nSize: " + path.toFile().length() + " bytes"
                );
            });
        } 

        boolean success = rubyInstallerPathCopy.toFile().setExecutable(true);

        if (!success) {
            context.getLogger().info("Cant make copy executable");
        }

        ContextInvocationHandler invocationHandler = new ContextInvocationHandler(context);
        NullInputStream nullInputStream = new NullInputStream(0);
        try {
            Commandline commandLine = new Commandline();
            commandLine.setExecutable(rubyInstallerPathCopy.toAbsolutePath().toString());
            commandLine.createArg().setLine("/silent /dir=\"" + rubyInstallationDirPathString + "\" /tasks=\"nomodpath\"");

            context.getLogger().info("Invoking installer executable");
            CommandLineUtils.executeCommandLine(commandLine, nullInputStream, invocationHandler, invocationHandler, 120);

            context.getLogger().info("Verifying ruby installation");
            Files.list(rubyInstallationDirPath)
            .forEach(path -> {
                context.getLogger().info(path.toString());
            });

            context.getLogger().info("Now to the rake command");

            commandLine = new Commandline();
            commandLine.addEnvironment("PATH", Paths.get(rubyInstallationDirPathString, "bin").toAbsolutePath().toString());
            commandLine.setExecutable(Paths.get(rubyInstallationDirPathString, "bin", "rake").toAbsolutePath().toString());
            commandLine.createArg().setLine("--help");
            CommandLineUtils.executeCommandLine(commandLine, nullInputStream, invocationHandler, invocationHandler);
        } catch (CommandLineException e) {
            return e;
        }

        return null;
    }

 
}
