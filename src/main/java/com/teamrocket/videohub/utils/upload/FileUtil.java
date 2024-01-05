package com.teamrocket.videohub.utils.upload;

import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;


public class FileUtil {

    public static String uploadFile(MultipartFile file, String rootPath) {

        // 원본 파일을 중복이 없는 랜덤 이름으로 변경
        String newFileName = UUID.randomUUID() + "_" + file.getOriginalFilename();


        // 파일 업로드 수행
        try {
            file.transferTo(new File(rootPath, newFileName));
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("/" + newFileName);
        return "/" + newFileName;
    }

    public static Map<String, String> uploadVideo(MultipartFile video, MultipartFile thumbnail, String rootVideoPath, String rootThumbnailPath) {
        Map<String, String> uploadedPaths = new HashMap<>();

        // 원본 파일을 중복이 없는 랜덤 이름으로 변경
        String newVideoName = UUID.randomUUID() + "_" + video.getOriginalFilename();
        String newThumbnailName = UUID.randomUUID() + "_" + thumbnail.getOriginalFilename();

        // 이 파일을 날짜별로 관리하기 위해 날짜별 폴더를 생성
        String newVideoPath = makeDateFormatDirectory(rootVideoPath);
        String newThumbnailPath = makeDateFormatDirectory(rootThumbnailPath);

        // 파일의 풀 경로를 생성
        String fullVideoPath = newVideoPath + "/" + newVideoName;
        String fullThumbnailPath = newThumbnailPath + "/" + newThumbnailName;

        // 파일 업로드 수행
        try {
            video.transferTo(new File(newVideoPath, newVideoName));
            thumbnail.transferTo(new File(newThumbnailPath, newThumbnailName));
        } catch (IOException e) {
            e.printStackTrace();
        }
        // full-path : D:/abc/upload/2024/01/02/dwdqwdqqw-dwdq-frww_고양이.jpg

        uploadedPaths.put("videoPath", fullVideoPath.substring(rootVideoPath.length()));
        uploadedPaths.put("thumbnailPath", fullThumbnailPath.substring(rootThumbnailPath.length()));

        return uploadedPaths;
    }

    private static String makeDateFormatDirectory(String rootPath) {

        // 오늘 날짜정보 추출
        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();

        String[] dateInfo = {year + "", len2(month), len2(day)};

        String directoryPath = rootPath;
        for (String s : dateInfo) {
            directoryPath += "/" + s;
            File f = new File(directoryPath);
            if(!f.exists()) f.mkdirs();
        }

        return directoryPath;
    }

    private static String len2(int n) {
        return new DecimalFormat("00").format(n);
    }
}

