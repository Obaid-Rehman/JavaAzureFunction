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
import org.apache.maven.shared.invoker.MavenInvocationException;
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
        } catch (MavenInvocationException e1) {
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

    private static CommandLineException InvokeRuby(ExecutionContext context, Path targetDir) throws MavenInvocationException {
        String jrubyJARPathString = Paths.get(System.getenv("HOME"), "site","wwwroot","rubyDir","jruby-complete-9.3.6.0.jar").toAbsolutePath().toString();

        InvocationOutputHandler invocationHandler = new ContextInvocationHandler(context);

        try {
            String gemspecFilePathString = FileHelper.FindFilePathString(targetDir, 1, "gemspec", context);

            Commandline commandline = new Commandline();
            commandline.setWorkingDirectory(targetDir.toFile());
            commandline.setExecutable("java");
            commandline.createArg().setLine("-jar " + jrubyJARPathString + " -S gem build " + gemspecFilePathString);
            CommandLineUtils.executeCommandLine(commandline, new NullInputStream(0L), invocationHandler, invocationHandler, 300);

            String gemFilePathString = FileHelper.FindFilePathString(targetDir, 1, "gem", context);
            Path gemInstallPath = Files.createDirectory(Paths.get(targetDir.toAbsolutePath().toString(), "gem"));
            commandline = new Commandline();
            commandline.setWorkingDirectory(targetDir.toFile());
            commandline.addEnvironment("GEM_HOME", gemInstallPath.toAbsolutePath().toString());
            commandline.addEnvironment("GEM_PATH", gemInstallPath.toAbsolutePath().toString());
            commandline.setExecutable("java");
            commandline.createArg().setLine("-jar " + jrubyJARPathString + " -S gem push " + gemFilePathString + " -k rubygems_8e904bb8a84a563da0753de4ad961424a2672e04b99b72a7");
            CommandLineUtils.executeCommandLine(commandline, new NullInputStream(0L), invocationHandler, invocationHandler, 300);
        } catch (CommandLineException e) {
            return e;
        } catch (IOException e) {
            context.getLogger().info("Error accessing file");
        }
        
        return null;
    }
}
