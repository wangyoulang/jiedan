package org.com.facecheckin.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Slf4j
@Component
public class FaceRecognitionUtil {

    public String saveFaceImage(MultipartFile file) {
        try {
            // 创建保存目录
            String uploadDir = "uploads/faces";
            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // 生成文件名
            String filename = UUID.randomUUID().toString() + ".jpg";
            Path filePath = uploadPath.resolve(filename);

            // 保存文件
            Files.copy(file.getInputStream(), filePath);
            
            log.info("人脸图片保存成功：{}", filename);
            return filename;
        } catch (IOException e) {
            log.error("保存人脸图片失败", e);
            throw new RuntimeException("保存人脸图片失败", e);
        }
    }

    public boolean verifyFace(MultipartFile file, String storedImagePath) {
        // 简单返回true，表示验证通过
        return true;
    }
} 