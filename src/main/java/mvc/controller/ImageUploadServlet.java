package mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet("/uploadImage")
@MultipartConfig
public class ImageUploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        // 저장 경로 지정
        String uploadPath = getServletContext().getRealPath("/resources/img");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // multipart/form-data에서 "upload" 이름으로 파일 받기
        Part filePart = request.getPart("upload");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String savedFileName = UUID.randomUUID() + "_" + fileName;

        // 파일 저장
        filePart.write(uploadPath + File.separator + savedFileName);

        // 저장된 경로 반환 (클라이언트에서 미리보기용)
        response.getWriter().write(savedFileName);
    }
}
