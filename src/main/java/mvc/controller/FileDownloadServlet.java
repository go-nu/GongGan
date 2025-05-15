package mvc.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

@WebServlet("/FileDownloadServlet")
public class FileDownloadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 게시글 번호 가져오기
        int boardNum = Integer.parseInt(request.getParameter("num"));
        
        // 게시글 정보 조회
        BoardDAO dao = BoardDAO.getInstance();
        BoardDTO board = dao.getBoardByNum(boardNum, false); // 조회수 증가 없이 조회
        
        // 파일 정보 확인
        if (board.getFileName() == null || board.getFileName().isEmpty()) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('첨부 파일이 없습니다.'); history.back();</script>");
            return;
        }
        
        // 파일 경로 설정
        String uploadPath = request.getServletContext().getRealPath("/uploads");
        String filePath = uploadPath + File.separator + board.getFileName();
        File downloadFile = new File(filePath);
        
        // 파일이 존재하는지 확인
        if (!downloadFile.exists()) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('파일을 찾을 수 없습니다.'); history.back();</script>");
            return;
        }
        
        // 다운로드를 위한 헤더 설정
        String mimeType = getServletContext().getMimeType(filePath);
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }
        response.setContentType(mimeType);
        
        // 브라우저별 인코딩 처리
        String userAgent = request.getHeader("User-Agent");
        String encodedFileName = "";
        
        if (userAgent.contains("MSIE") || userAgent.contains("Trident")) {
            // IE
            encodedFileName = URLEncoder.encode(board.getOriginalFileName(), "UTF-8").replaceAll("\\+", "%20");
        } else {
            // 크롬, 파이어폭스 등
            encodedFileName = new String(board.getOriginalFileName().getBytes("UTF-8"), "ISO-8859-1");
        }
        
        // 다운로드 헤더 설정
        response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");
        response.setHeader("Content-Length", String.valueOf(downloadFile.length()));
        
        // 파일 전송
        try (FileInputStream in = new FileInputStream(downloadFile);
             OutputStream out = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}