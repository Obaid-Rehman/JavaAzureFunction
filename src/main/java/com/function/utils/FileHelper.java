package com.function.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.StandardCopyOption;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import com.microsoft.azure.functions.ExecutionContext;

public class FileHelper {

   public static void zipFolder(Path source, ExecutionContext context) throws IOException {
      String zipFileName = source.getFileName().toAbsolutePath().toString() + ".zip";

      try (ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(zipFileName))) {
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

                        zos.closeEntry();

                        context.getLogger().info("Zip file: " + file.getFileName().toString());

                    } catch (IOException e) {
                        context.getLogger().info("Zipping Exception: " + e.getMessage());
                    }
                    return FileVisitResult.CONTINUE;
                }

                @Override
                public FileVisitResult visitFileFailed(Path file, IOException exc) {
                    context.getLogger().info("Unable to zip file. file: " + file.getFileName() + " Exception: " + exc.getMessage());
                    return FileVisitResult.CONTINUE;
                }
            });
      } 
   }

   public static void unzipFolder(Path source, Path target) throws IOException {
      try (ZipInputStream zis = new ZipInputStream(new FileInputStream(source.toFile()))) {
         ZipEntry zipEntry = zis.getNextEntry();

            while (zipEntry != null) {

                boolean isDirectory = false;

                if (zipEntry.getName().endsWith(File.separator)) {
                    isDirectory = true;
                }

                Path newPath = zipSlipProtect(zipEntry, target);

                if (isDirectory) {
                    Files.createDirectories(newPath);
                } else {

                    if (newPath.getParent() != null) {
                        if (Files.notExists(newPath.getParent())) {
                            Files.createDirectories(newPath.getParent());
                        }
                    }

                    Files.copy(zis, newPath, StandardCopyOption.REPLACE_EXISTING);
                }

                zipEntry = zis.getNextEntry();

            }
            zis.closeEntry();
      } 
   }

   public static Path zipSlipProtect(ZipEntry zipEntry, Path targetDir)
        throws IOException {

        Path targetDirResolved = targetDir.resolve(zipEntry.getName());
        Path normalizePath = targetDirResolved.normalize();
        if (!normalizePath.startsWith(targetDir)) {
            throw new IOException("Bad zip entry: " + zipEntry.getName());
        }
        return normalizePath;
    }

   public static Path createDir(ExecutionContext context) throws IOException {
        Path Dir = Files.createTempDirectory("temp");
        context.getLogger().info("Directory created: " + Dir.toString());
        return Dir;
    }

   public static Path createZipFile(ExecutionContext context, byte[] data) throws FileNotFoundException,IOException {
        Path sourceFile = Files.createTempFile("temp", "zip");
        context.getLogger().info("File created: " + sourceFile.toFile().getName());

        try (FileOutputStream fos = new FileOutputStream(sourceFile.toAbsolutePath().toString())) {
            fos.write(data);
        } 
        return sourceFile;
    }
}
