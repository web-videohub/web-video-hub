package com.teamrocket.videohub.utils.upload;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
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

        return rootPath + "/" + newFileName;
    }
}

