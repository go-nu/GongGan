package mvc.controller;

import mvc.model.CosmeticsDAO;

import mvc.model.CosmeticsDTO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.HttpSession;

import java.nio.file.Paths;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.json.simple.JSONObject;

import java.util.ArrayList;


@WebServlet("/cosmetics")
@MultipartConfig
public class CosmeticsController extends HttpServlet {

    private CosmeticsDAO cosmeticsRepo = CosmeticsDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        //doGet은 데이터 조회 용도
        if (action == null || action.equals("list")) {
            // 일반 사용자: 전체 목록 조회 (뷰에서 카테고리별 4개씩 보여줌)
            List<CosmeticsDTO> list = cosmeticsRepo.getAllCosmetics();
            request.setAttribute("cosmeticsList", list);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/beauty.jsp");
            dispatcher.forward(request, response);

        } else if (action.equals("detail")) {
            int id = Integer.parseInt(request.getParameter("id"));
            // 화장품 상세 페이지 
            // 1. 해당 화장품 정보 조회
            CosmeticsDTO cosmetic = cosmeticsRepo.getCosmeticById(id);
            
            // ✅ 1_1. 로그인한 사용자라면 좋아요 여부 확인해서 setLiked
            HttpSession session = request.getSession(false);
            String userId = (session != null) ? (String) session.getAttribute("id") : null;

            if (cosmetic != null && userId != null) {
                boolean liked = cosmeticsRepo.hasUserLiked(cosmetic.getId(), userId);
                cosmetic.setLiked(liked);
            }
            
            request.setAttribute("cosmetic", cosmetic);

            // 2. 관련 상품 12개 가져오기 (같은 카테고리, 자기 자신 제외)
            List<CosmeticsDTO> relatedList = cosmeticsRepo.getRelatedCosmetics(cosmetic.getCategory(), cosmetic.getId(), 12);

            // 3. 4개씩 묶어서 JSP에서 슬라이드로 표현
            List<List<CosmeticsDTO>> grouped = new ArrayList<>();
            for (int i = 0; i < relatedList.size(); i += 4) {
                grouped.add(relatedList.subList(i, Math.min(i + 4, relatedList.size())));
            }
            request.setAttribute("relatedGroups", grouped);

            // 4. 뷰 페이지로 포워딩
            RequestDispatcher dispatcher = request.getRequestDispatcher("/cosmetics_detail.jsp");
            dispatcher.forward(request, response);
        } else if (action.equals("category")) {
        	
            // 특정 카테고리의 전체 제품 출력
            String category = request.getParameter("category");
            List<CosmeticsDTO> list;

            if (category != null && !category.isEmpty()) {
                list = cosmeticsRepo.getCosmeticsByCategory(category);
            } else {
                list = cosmeticsRepo.getAllCosmetics(); // fallback
            }

            request.setAttribute("cosmeticsList", list);
            request.setAttribute("category", category);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/beautyCategory.jsp"); // ✅ 포워딩 수정
            dispatcher.forward(request, response);

        } else if (action.equals("adminlist")) {
            // 관리자: 전체 목록 조회
            List<CosmeticsDTO> list = cosmeticsRepo.getAllCosmetics();
            request.setAttribute("cosmeticsList", list);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin_Cosmetics.jsp");
            dispatcher.forward(request, response);

        } else if (action.equals("view")) {
            // 상세 보기
            int id = Integer.parseInt(request.getParameter("id"));
            CosmeticsDTO cosmetic = cosmeticsRepo.getCosmeticById(id);
            request.setAttribute("cosmetic", cosmetic);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/cosmetic_detail.jsp");
            dispatcher.forward(request, response);

        } else if (action.equals("edit")) {
            // 관리자: 수정 페이지
            int id = Integer.parseInt(request.getParameter("id"));
            CosmeticsDTO cosmetic = cosmeticsRepo.getCosmeticById(id);
            request.setAttribute("cosmetic", cosmetic);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/UpdateCosmetics.jsp");
            dispatcher.forward(request, response);

        } else if (action.equals("deleteform")) {
        	// 관리자: id값 받아서 delete.jsp로 보냄
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    CosmeticsDTO cosmetic = cosmeticsRepo.getCosmeticById(id);
                    request.setAttribute("cosmetic", cosmetic);
                    request.getRequestDispatcher("/DeleteCosmetics.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "유효하지 않은 ID");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID가 없습니다.");
            }
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        //doPost는 데이터변경을 위주(수정,삭제,추가)
        if (action.equals("add")) {
        	
        	// 각 파라미터를 가져와서 디버깅 로그로 출력
            System.out.println("Received name: " + request.getParameter("name"));
            System.out.println("Received brand: " + request.getParameter("brand"));
            System.out.println("Received price: " + request.getParameter("price"));
            System.out.println("Received category: " + request.getParameter("category"));
            System.out.println("Received main_ingredient: " + request.getParameter("main_ingredient"));
            System.out.println("Received effect: " + request.getParameter("effect"));
            
            
            // 화장품 등록
            CosmeticsDTO cosmetic = new CosmeticsDTO();
            cosmetic.setName(request.getParameter("name"));
            cosmetic.setBrand(request.getParameter("brand"));

            String priceStr = request.getParameter("price");
            if (priceStr != null && !priceStr.isEmpty()) {
                cosmetic.setPrice(Integer.parseInt(priceStr));
            } else {
                cosmetic.setPrice(0);
            }

            cosmetic.setMain_ingredient(request.getParameter("main_ingredient"));
            cosmetic.setEffect(request.getParameter("effect"));
            cosmetic.setCategory(request.getParameter("category"));

            // 이미지 파일 처리
            Part filePart = request.getPart("image_file");
            if (filePart != null) {
                // 업로드된 파일의 원래 이름 가져오기
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                
                // 파일이 저장될 디렉토리 경로
                String uploadDir = getServletContext().getRealPath("/resources/img/");  // 업로드 경로

                // 디렉토리 생성 (없으면)
                File uploadFile = new File(uploadDir);
                if (!uploadFile.exists()) {
                    uploadFile.mkdirs();  // 디렉터리 생성
                }

                // 파일 경로 설정
                String filePath = uploadDir + File.separator + fileName;
                
                // 파일 저장
                filePart.write(filePath);

                // DB에 저장할 파일 경로 설정 (상대 경로로 설정)
                cosmetic.setImage_file(fileName);
            }

            // DB에 화장품 정보 추가
            cosmeticsRepo.addCosmetic(cosmetic);
            response.sendRedirect("cosmetics?action=adminlist");
        } else if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            CosmeticsDTO cosmetic = new CosmeticsDTO();
            cosmetic.setId(id);
            cosmetic.setName(request.getParameter("name"));
            cosmetic.setBrand(request.getParameter("brand"));

            String priceStr = request.getParameter("price");
            if (priceStr != null && !priceStr.isEmpty()) {
                cosmetic.setPrice(Integer.parseInt(priceStr));
            } else {
                cosmetic.setPrice(0);
            }

            cosmetic.setMain_ingredient(request.getParameter("main_ingredient"));
            cosmetic.setEffect(request.getParameter("effect"));
            cosmetic.setCategory(request.getParameter("category"));

            // 이미지 처리
            Part filePart = request.getPart("image_file_upload");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadDir = getServletContext().getRealPath("/resources/img/");
                File uploadFile = new File(uploadDir);
                if (!uploadFile.exists()) uploadFile.mkdirs();

                filePart.write(uploadDir + File.separator + fileName);
                cosmetic.setImage_file(fileName);
            } else {
                // 새 이미지 업로드 안 했으면 기존 이미지 유지
                cosmetic.setImage_file(request.getParameter("image_file"));
            }

            // 좋아요는 수정하지 않음 → 기본값 0 유지하거나 DB 값 그대로 유지할 수 있음
            cosmetic.setLikes(0); // 또는 생략 가능

            // 업데이트 실행
            boolean result = cosmeticsRepo.updateCosmetic(cosmetic);
            if (result) {
                response.sendRedirect("cosmetics?action=adminlist");
            } else {
                request.setAttribute("error", "수정 실패");
                request.getRequestDispatcher("/cosmetics_adminError.jsp").forward(request, response);
            }
        } else if (action.equals("delete")) {
        	// 화장품 삭제
            String idParam = request.getParameter("id");
            System.out.println("삭제 요청 받은 ID: " + idParam);  // ✅ 로그 추가

            try {
                int id = Integer.parseInt(idParam);
                boolean result = cosmeticsRepo.deleteCosmetic(id);

                if (result) {
                    System.out.println("삭제 성공 → 관리자 리스트로 리디렉션");
                    response.sendRedirect("cosmetics?action=adminlist");
                } else {
                    System.out.println("삭제 실패");
                    request.setAttribute("error", "삭제 실패");
                    request.getRequestDispatcher("/cosmetics_adminError.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                System.out.println("유효하지 않은 ID 형식");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 ID");
            }
        } else if ("likeToggle".equals(action)) {
        	// 좋아요 기능
            // 세션에서 사용자 ID 가져오기
            HttpSession session = request.getSession(false);
            String userId = (session != null) ? (String) session.getAttribute("id") : null;

            // JSON 응답 준비
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject json = new JSONObject();

            if (userId == null) {
                // 로그인 안 된 경우
                json.put("success", false);
                json.put("message", "로그인이 필요합니다.");
                out.print(json.toJSONString());
                out.flush();
                return;
            }

            try {
                int cosmeticId = Integer.parseInt(request.getParameter("id"));
                boolean alreadyLiked = cosmeticsRepo.hasUserLiked(cosmeticId, userId);

                if (alreadyLiked) {
                    cosmeticsRepo.removeLike(cosmeticId, userId);
                    json.put("liked", false);
                } else {
                    cosmeticsRepo.addLike(cosmeticId, userId);
                    json.put("liked", true);
                }

                int likeCount = cosmeticsRepo.getLikeCount(cosmeticId);
                json.put("likeCount", likeCount);
                json.put("success", true);

            } catch (Exception e) {
                json.put("success", false);
                json.put("message", "서버 오류: " + e.getMessage());
                e.printStackTrace();
            }

            out.print(json.toJSONString());
            out.flush();
        }
    }
}
