package org.com.facecheckin.util;

import lombok.extern.slf4j.Slf4j;
import org.opencv.core.*;
import org.opencv.core.Core.MinMaxLocResult;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.opencv.objdetect.CascadeClassifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.util.ResourceUtils;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Slf4j
@Component
public class FaceRecognitionUtil {

    @Value("${face.detection.scale-factor}")
    private double scaleFactor;

    @Value("${face.detection.min-neighbors}")
    private int minNeighbors;

    @Value("${face.detection.min-size}")
    private int minSize;

    @Value("${face.recognition.confidence-threshold}")
    private double confidenceThreshold;

    private final CascadeClassifier faceDetector;

    public FaceRecognitionUtil() {
        try {
            // 加载OpenCV
            System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
            
            // 加载人脸检测器
            File cascadeFile = ResourceUtils.getFile("classpath:haarcascade_frontalface_default.xml");
            faceDetector = new CascadeClassifier(cascadeFile.getAbsolutePath());
            
            if (faceDetector.empty()) {
                throw new RuntimeException("无法加载人脸检测器");
            }
        } catch (Exception e) {
            throw new RuntimeException("初始化人脸识别失败", e);
        }
    }

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

            // 检测人脸
            Mat image = Imgcodecs.imread(filePath.toString());
            MatOfRect faces = new MatOfRect();
            faceDetector.detectMultiScale(
                image,
                faces,
                scaleFactor,
                minNeighbors,
                0,
                new Size(minSize, minSize),
                new Size()
            );

            if (faces.toArray().length == 0) {
                Files.delete(filePath);
                throw new RuntimeException("未检测到人脸");
            }

            if (faces.toArray().length > 1) {
                Files.delete(filePath);
                throw new RuntimeException("检测到多个人脸");
            }

            return filename;
        } catch (IOException e) {
            throw new RuntimeException("保存人脸图片失败", e);
        }
    }

    public boolean verifyFace(MultipartFile file, String storedImagePath) {
        try {
            // 读取存储的人脸图片
            Mat storedImage = Imgcodecs.imread("uploads/faces/" + storedImagePath);
            MatOfRect storedFaces = new MatOfRect();
            faceDetector.detectMultiScale(storedImage, storedFaces);

            // 读取当前上传的图片
            Path tempPath = Files.createTempFile("temp", file.getOriginalFilename());
            file.transferTo(tempPath.toFile());
            Mat currentImage = Imgcodecs.imread(tempPath.toString());
            MatOfRect currentFaces = new MatOfRect();
            faceDetector.detectMultiScale(currentImage, currentFaces);

            // 清理临时文件
            Files.delete(tempPath);

            // 如果任一图片没有检测到人脸，返回false
            if (storedFaces.toArray().length == 0 || currentFaces.toArray().length == 0) {
                return false;
            }

            // 获取人脸区域
            Rect storedFace = storedFaces.toArray()[0];
            Rect currentFace = currentFaces.toArray()[0];

            // 提取人脸区域
            Mat storedFaceMat = new Mat(storedImage, storedFace);
            Mat currentFaceMat = new Mat(currentImage, currentFace);

            // 统一大小
            Mat resizedStoredFace = new Mat();
            Mat resizedCurrentFace = new Mat();
            Size size = new Size(200, 200);
            Imgproc.resize(storedFaceMat, resizedStoredFace, size);
            Imgproc.resize(currentFaceMat, resizedCurrentFace, size);

            // 转换为灰度图
            Mat grayStoredFace = new Mat();
            Mat grayCurrentFace = new Mat();
            Imgproc.cvtColor(resizedStoredFace, grayStoredFace, Imgproc.COLOR_BGR2GRAY);
            Imgproc.cvtColor(resizedCurrentFace, grayCurrentFace, Imgproc.COLOR_BGR2GRAY);

            // 计算相似度（这里使用简单的模板匹配方法）
            Mat result = new Mat();
            Imgproc.matchTemplate(grayStoredFace, grayCurrentFace, result, Imgproc.TM_CCOEFF_NORMED);
            
            // 获取最大相似度值
            MinMaxLocResult mmr = Core.minMaxLoc(result);
            double similarity = mmr.maxVal;

            return similarity >= confidenceThreshold;
        } catch (IOException e) {
            throw new RuntimeException("人脸验证失败", e);
        }
    }
} 