package mvc.util;

import java.io.File;

public class FileUtil {

    /**
     * 파일 크기를 보기 좋게 변환 (KB, MB, GB 등)
     */
    public static String formatFileSize(long size) {
        if (size < 1024) {
            return size + " B";
        } else if (size < 1024 * 1024) {
            return String.format("%.2f KB", size / 1024.0);
        } else if (size < 1024 * 1024 * 1024) {
            return String.format("%.2f MB", size / (1024.0 * 1024));
        } else {
            return String.format("%.2f GB", size / (1024.0 * 1024 * 1024));
        }
    }

    /**
     * 파일 확장자 반환 (예: "jpg", "txt" 등)
     */
    public static String getFileExtension(String fileName) {
        if (fileName == null || !fileName.contains(".")) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
    }

    /**
     * 파일 이름에서 확장자 제외한 순수 이름 반환
     */
    public static String getFileBaseName(String fileName) {
        if (fileName == null || !fileName.contains(".")) {
            return fileName;
        }
        return fileName.substring(0, fileName.lastIndexOf("."));
    }

    /**
     * 파일이 존재하는지 확인
     */
    public static boolean fileExists(String path) {
        File file = new File(path);
        return file.exists() && file.isFile();
    }

    /**
     * 폴더가 존재하지 않으면 생성
     */
    public static void createDirectoryIfNotExists(String path) {
        File dir = new File(path);
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }
    
    // 파일명 보안 처리
 	private String sanitizeFileName(String fileName) {
 	    // 파일명에서 경로 정보 제거
 	    fileName = new File(fileName).getName();
 	    
 	    // 특수문자 제거 (알파벳, 숫자, 점, 대시, 언더스코어만 허용)
 	    return fileName.replaceAll("[^a-zA-Z0-9._-]", "_");
 	}

    /**
     * 중복된 파일명이 있는 경우 새로운 파일명 생성 (예: test.txt → test(1).txt)
     */
    public static String getUniqueFileName(String directoryPath, String fileName) {
        File file = new File(directoryPath, fileName);
        if (!file.exists()) {
            return fileName;
        }

        String baseName = getFileBaseName(fileName);
        String extension = getFileExtension(fileName);
        int count = 1;

        while (true) {
            String newFileName = extension.isEmpty()
                ? String.format("%s(%d)", baseName, count)
                : String.format("%s(%d).%s", baseName, count, extension);
            file = new File(directoryPath, newFileName);
            if (!file.exists()) {
                return newFileName;
            }
            count++;
        }
    }
}
