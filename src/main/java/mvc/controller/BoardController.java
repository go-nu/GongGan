package mvc.controller;

import java.io.IOException;
import java.io.InputStreamReader;

import jakarta.servlet.http.Part;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import java.io.PrintWriter;
import java.util.ArrayList;

import org.json.simple.JSONObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mvc.model.BoardDAO;
import mvc.model.BoardDTO;
import mvc.model.CommentDAO;
import mvc.model.CommentDTO;

import mvc.util.FileUtil;

@WebServlet("/BoardWriteAction.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50 // 50MB
)


public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 5;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());

		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		if (command.equals("/BoardListAction.do")) {// 등록된 글 목록 페이지 출력하기 1
			requestBoardList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./boardF/list.jsp");
			rd.forward(request, response);
		} else if (command.equals("/BoardListActionF.do")) {// 등록된 글 목록 페이지 각 서브사이트 섹션에 출력하기
			requestBoardList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./food.jsp");
			rd.forward(request, response);	
		}else if (command.equals("/BoardListActionF.do")) {// 등록된 글 목록 페이지 출력하기
			requestBoardList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./food.jsp");
			rd.forward(request, response);
		}else if (command.equals("/BoardListActionL.do")) {// 등록된 글 목록 페이지 출력하기
			requestBoardList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./location.jsp");
			rd.forward(request, response);	
		} else if (command.equals("/MyPage.do")) { // 마이페이지
	        requestLoginName(request);       // 로그인한 사용자 이름 가져오기
	        requestMyBoard(request);         // 내가 쓴 게시글 목록 가져오기
	        RequestDispatcher rd = request.getRequestDispatcher("./mypage.jsp");
	        rd.forward(request, response);	
		} else if (command.equals("/BoardWriteForm.do")) { // 글 등록 페이지 출력
			requestLoginName(request);
			RequestDispatcher rd = request.getRequestDispatcher("./boardF/writeForm.jsp");
			rd.forward(request, response);
		} else if (command.equals("/BoardWriteAction.do")) { // 새로운 글 등록
			try {
				requestBoardWrite(request);
				response.sendRedirect("BoardListAction.do");
			} catch (Exception e) {
				System.out.println("BoardWriteAction 처리 중 오류: " + e.getMessage());
				e.printStackTrace();
				request.setAttribute("errorMessage", "게시글 등록 중 오류가 발생했습니다: " + e.getMessage());
				RequestDispatcher rd = request.getRequestDispatcher("./error.jsp");
				rd.forward(request, response);

			}
		} else if (command.equals("/BoardViewAction.do")) { // 선택된 글 상자 페이지 가져오기
			try {
				// 파라미터 검증
				String numParam = request.getParameter("num");
				String pageNumParam = request.getParameter("pageNum");

				if (numParam == null || pageNumParam == null) {
					System.out.println("필수 파라미터 누락: num=" + numParam + ", pageNum=" + pageNumParam);
					response.sendRedirect("BoardListAction.do");
					return;
				}

				// 게시글 상세 정보 가져오기
				requestBoardView(request, response);

				// board 객체 확인
				BoardDTO board = (BoardDTO) request.getAttribute("board");
				if (board == null) {
					System.out.println("게시글 정보를 찾을 수 없음: num=" + numParam);
					response.sendRedirect("BoardListAction.do");
					return;
				}
				// forward 전에 이미 응답이 커밋되었는지 확인
				if (!response.isCommitted()) {
					// 직접 view.jsp로 포워딩 (BoardView.do로 가지 않고)
					// 정상적으로 게시글 정보가 있으면 뷰 페이지로 포워딩
					RequestDispatcher rd = request.getRequestDispatcher("./boardF/view.jsp");
					rd.forward(request, response);
				}
			} catch (Exception e) {
				System.out.println("BoardViewAction.do 처리 중 오류: " + e);
				e.printStackTrace();
				response.sendRedirect("BoardListAction.do");
			}
		} else if (command.equals("/BoardView.do")) { // 글 상세 페이지 출력
			response.sendRedirect("BoardListAction.do");
		} else if (command.equals("/BoardUpdateForm.do")) { // 글 수정 폼 출력 250512 수정
			requestBoardView(request, response); // 기존 게시글 정보 가져오기
			requestLoginName(request); // 로그인 사용자 정보 가져오기
			RequestDispatcher rd = request.getRequestDispatcher("./boardF/updateForm.jsp");
			rd.forward(request, response);
		} else if (command.equals("/BoardUpdateAction.do")) { // 글 수정 처리
			System.out.println("request.getParameter(\"num\") : " + request.getParameter("num"));
			requestBoardUpdate(request);
			String num = request.getParameter("num");
			String pageNum = request.getParameter("pageNum");
			response.sendRedirect("BoardViewAction.do?num=" + num + "&pageNum=" + pageNum);

		} else if (command.equals("/BoardDeleteAction.do")) { // 선택된 글 삭제하기
			requestBoardDelete(request);
			RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
			rd.forward(request, response);
		} else if (command.equals("/BoardLikeAction.do")) { // 좋아요 기능 처리
			requestBoardLike(request, response);
			// 이 메서드는 AJAX 요청을 처리하므로 여기서 JSON 응답을 직접 반환함
		} else if (command.equals("/CommentWriteAction.do")) {
			requestCommentWrite(request, response);
			return;
		} else if (command.equals("/CommentUpdateAction.do")) { // 수정 후 해당 게시글 상세 페이지로 리다이렉트
            requestCommentUpdate(request);
            int boardNum = Integer.parseInt(request.getParameter("boardNum"));
            int pageNum = Integer.parseInt(request.getParameter("pageNum"));
            int commentPage = Integer.parseInt(request.getParameter("commentPage"));
            response.sendRedirect("BoardViewAction.do?num=" + boardNum 
                                + "&pageNum=" + pageNum 
                                + "&commentPage=" + commentPage); 
		} else if (command.equals("/CommentDeleteAction.do")) { // 댓글 삭제 처리 추가
            requestCommentDelete(request);
            // 삭제 후 해당 게시글 상세 페이지로 리다이렉트
            int boardNum = Integer.parseInt(request.getParameter("boardNum"));
            int pageNum = Integer.parseInt(request.getParameter("pageNum"));
            int commentPage = Integer.parseInt(request.getParameter("commentPage"));
            response.sendRedirect("BoardViewAction.do?num=" + boardNum 
                                + "&pageNum=" + pageNum 
                                + "&commentPage=" + commentPage);
        }

	}
	

	// 등록된 글 목록 가져오기
	public void requestBoardList(HttpServletRequest request) {

		BoardDAO dao = BoardDAO.getInstance();
		ArrayList<BoardDTO> boardlist = new ArrayList<BoardDTO>();
		
		// 페이지 번호 처리 (기본값 1)
		int pageNum = 1;
		int limit = LISTCOUNT; // 페이지당 게시글 개수 설정

		if (request.getParameter("pageNum") != null)
			pageNum = Integer.parseInt(request.getParameter("pageNum"));

		// 검색 조건 처리
		String items = request.getParameter("items");
		String text = request.getParameter("text");
		
		// ✅ category 파라미터도 받아오기 250516 11시 추가
	    String category = request.getParameter("category");
	    if (category == null || category.trim().isEmpty()) {
	        category = "food";  // 기본값
	    }

		// Fix: null인 items와 text 파라미터 처리
	    if (items == null || items.trim().equals("")) items = null;
	    if (text == null || text.trim().equals("")) text = null;
		
		// 전체 게시글 수와 해당 카테고리의 게시글 수 계산
		int total_record = dao.getListCount(items, text, category);
	    boardlist = dao.getBoardList(pageNum, limit, items, text, category);
		
		

		// 페이지네이션을 위한 검색 파라미터 보존
		request.setAttribute("items", items);
		request.setAttribute("text", text);
		request.setAttribute("category", category);

		// 삼항연산자를 사용해 총 페이지 수 계산 250516 11시
	    int total_page = (total_record % limit == 0)
	            ? total_record / limit
	            : total_record / limit + 1;

	    // 현재 페이지와 총 페이지 수를 request에 저장
		request.setAttribute("currentPage", pageNum);
		request.setAttribute("totalPage", total_page);
		request.setAttribute("totalPosts", total_record);
		request.setAttribute("boardList", boardlist);

		// 페이지네이션에 필요한 경우 다음 항목 추가
		int startPage = ((pageNum - 1) / 10) * 10 + 1;
		int endPage = startPage + 9;
		if (endPage > total_page)
			endPage = total_page;

		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);

	}
	
	// 마이페이지 가져오기
		public void requestMyBoard(HttpServletRequest request) {

		    BoardDAO dao = BoardDAO.getInstance();
		    ArrayList<BoardDTO> boardlist = new ArrayList<>();

		    int pageNum = 1;
		    int limit = LISTCOUNT;

		    if (request.getParameter("pageNum") != null) {
		        pageNum = Integer.parseInt(request.getParameter("pageNum"));
		    }

		    // ✅ 세션에서 로그인된 사용자 ID 가져오기
		    HttpSession session = request.getSession();
		    String id = (String) session.getAttribute("id");

		    // ✅ 글 개수 및 목록 조회
		    int total_record = dao.getMyListCount(id);
		    boardlist = dao.getMyBoardList(pageNum, limit, id);

		    // ✅ 페이지 수 계산 (올림)
		    int total_page = (total_record + limit - 1) / limit;

		    request.setAttribute("currentPage", pageNum);
		    request.setAttribute("totalPage", total_page);
		    request.setAttribute("totalPosts", total_record);
		    request.setAttribute("boardList", boardlist);

		    // ✅ 페이지네이션 범위 계산
		    int startPage = ((pageNum - 1) / 10) * 10 + 1;
		    int endPage = startPage + 9;
		    if (endPage > total_page) endPage = total_page;

		    request.setAttribute("startPage", startPage);
		    request.setAttribute("endPage", endPage);
		}

	// 인증된 사용자명 가져오기
	public void requestLoginName(HttpServletRequest request) {

		String id = (String) request.getSession().getAttribute("sessionId");

		BoardDAO dao = BoardDAO.getInstance();
		String name = dao.getLoginNameById(id);

		request.setAttribute("id", id); // ← 추가
		request.setAttribute("name", name);

	}

	// 새로운 글 등록하기
	// BoardController.java의 requestBoardWrite 메서드 수정
	public void requestBoardWrite(HttpServletRequest request) throws ServletException, IOException {
		// 파일 업로드를 위한 설정

		String uploadPath = request.getServletContext().getRealPath("/uploads");
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			boolean created = uploadDir.mkdir();
			if (!created) {
				throw new ServletException("업로드 디렉토리를 생성할 수 없습니다: " + uploadPath);
			}
			System.out.println("업로드 디렉토리 생성됨: " + uploadPath);
		}

		// 최대 파일 크기 (10MB)
		int maxFileSize = 10 * 1024 * 1024;

		BoardDAO dao = BoardDAO.getInstance();
		BoardDTO board = new BoardDTO();

		// 세션에서 사용자 ID 가져오기 (보안 강화)
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("sessionId");

		// 로그인 확인
		if (id == null || id.isEmpty()) {
			id = (String) session.getAttribute("id");
		}

		board.setId(id);
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));

		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date());

		board.setLiking(0);// 좋아요 수 초기화
		board.setHit(0);
		board.setRegist_day(regist_day);
		board.setIp(request.getRemoteAddr());
		
		// ✅ 카테고리 받기 (food, beauty, location) 250516 12시 20분 추가
	    String category = request.getParameter("category");
	    if (category == null || category.trim().isEmpty()) {
	        category = "food";  // 기본값으로 설정
	    }
	    board.setCategory(category);  // BoardDTO에 카테고리 설정
		

		// 첨부 파일 처리
		try {
			Part filePart = request.getPart("attachment");
			System.out.println("파일 파트: " + (filePart != null ? "존재함" : "없음"));
			// 파일이 선택되었는지 확인 (널 체크와 사이즈 체크 둘 다 필요)
			if (filePart != null && filePart.getSize() > 0 && !getFileName(filePart).isEmpty()) {
				// 파일 크기 확인
				if (filePart.getSize() > maxFileSize) {
					throw new IllegalStateException("파일 크기가 10MB를 초과합니다.");
				}

				// 원본 파일명 가져오기
				String originalFileName = getFileName(filePart);

				// 저장할 파일명 생성 (중복 방지를 위해 타임스탬프 추가)
				String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
				String savedFileName = System.currentTimeMillis() + extension;

				// 파일 저장
				String filePath = uploadPath + File.separator + savedFileName;
				filePart.write(filePath);

				// BoardDTO에 파일 정보 설정
				board.setOriginalFileName(originalFileName);
				board.setFileName(savedFileName);
				board.setFileSize(filePart.getSize());
			} else {
				// 파일이 없는 경우 null로 설정
				board.setOriginalFileName(null);
				board.setFileName(null);
				board.setFileSize(0);
			}

			// 게시글 DB 저장
			dao.insertBoard(board);

		} catch (IllegalStateException e) {
			request.setAttribute("errorMessage", e.getMessage());
			throw new ServletException("파일 업로드 오류: " + e.getMessage(), e);
		} catch (Exception e) {
			System.out.println("게시글 작성 중 오류 발생: " + e.getMessage());
			e.printStackTrace();
			request.setAttribute("errorMessage", "게시글 작성 중 오류가 발생했습니다.");
			throw new ServletException("게시글 작성 오류", e);
		}

		System.out.println("=== requestBoardWrite 시작 ===");
		System.out.println("ID: " + request.getParameter("id"));
		System.out.println("Subject: " + request.getParameter("subject"));
		System.out.println("Content: " + request.getParameter("content"));
		if (board.getFileName() != null) {
			System.out.println("File: " + board.getOriginalFileName() + " (" + board.getFileSize() + " bytes)");
		}
	}

	// Part에서 파일명을 추출하는 헬퍼 메서드
	private String getFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String item : items) {
			if (item.trim().startsWith("filename")) {
				return item.substring(item.indexOf("=") + 2, item.length() - 1);
			}
		}
		return "";
	}

	// 선택된 글 상세 페이지 가져오기
	public void requestBoardView(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		BoardDAO dao = BoardDAO.getInstance();
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		BoardDTO board = new BoardDTO();
		board = dao.getBoardByNum(num, pageNum);
		// board = dao.getBoardByNum(num, true); // 조회수 증가

		// 댓글 목록 가져오기 (추가된 부분)
		CommentDAO commentDAO = CommentDAO.getInstance();
		ArrayList<CommentDTO> commentList = commentDAO.getCommentList(num);

		// request에 속성 설정
		request.setAttribute("num", num);
		request.setAttribute("page", pageNum);
		request.setAttribute("board", board);
		request.setAttribute("commentList", commentList); // 댓글 목록 추가

	}

	// 선택된 글 내용 수정하기
	
	public void requestBoardUpdate(HttpServletRequest request) throws ServletException, IOException {
		System.out.println("request22 : " + request);
		// 파라미터 검증 및 기본값 설정 수정 250514 오후추가
		/*
		 * String numParam = request.getParameter("num"); String pageNumParam =
		 * request.getParameter("pageNum");
		 */

	    String numParam = getValueFromPart(request.getPart("num"));
	    String pageNumParam = getValueFromPart(request.getPart("pageNum"));
	    System.out.println("request.getParameter(\"pageNum\") : " + request.getParameter("pageNum"));
	    System.out.println("request.getParameter(\"num\") : " + request.getParameter("num"));
	    if (numParam == null || numParam.isEmpty()) {
	        throw new ServletException("게시글 번호(num)가 누락되었습니다.");
	    }
	    
	    int num = Integer.parseInt(numParam);
	    int pageNum = 1; // 기본값 설정
	    
	    if (pageNumParam != null && !pageNumParam.isEmpty()) {
	        pageNum = Integer.parseInt(pageNumParam);
	    }
		
		// 파일 업로드를 위한 설정
	    String uploadPath = request.getServletContext().getRealPath("/uploads");
	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdir();
	    }
	    
	    // 최대 파일 크기 (10MB)
	    int maxFileSize = 10 * 1024 * 1024;
	     
	    
	    BoardDAO dao = BoardDAO.getInstance();    
	    BoardDTO board = dao.getBoardByNum(num, false); // 기존 게시글 정보 가져오기 (조회수 증가 없이)
	    
	    // 기존 게시글 정보 유지
	    board.setNum(num);

	    // 🔒 id는 세션에서 꺼내는 것이 안전함
	    HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id"); // 로그인 시 저장해둔 속성명
	    board.setId(id);

	    board.setSubject(request.getParameter("subject"));
	    board.setContent(request.getParameter("content"));    
	    
	    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
	    String regist_day = formatter.format(new java.util.Date()); 
	    
	    board.setRegist_day(regist_day);
	    board.setIp(request.getRemoteAddr());       
	    
	    // ✅ 카테고리 받기 (food, beauty, location)
	    String category = request.getParameter("category");
	    if (category == null || category.trim().isEmpty()) {
	        category = "food";  // 기본값
	    }
	    board.setCategory(category);
	    
	    // 첨부 파일 처리
	    try {
	        // 파일 삭제 여부 확인
	    	String deleteFile = request.getParameter("deleteFile");
	    	if (deleteFile != null && deleteFile.equals("1")) {
	    	    // 기존 파일이 있으면 삭제
	    	    if (board.getFileName() != null && !board.getFileName().isEmpty()) {
	    	        File oldFile = new File(uploadPath + File.separator + board.getFileName());
	    	        if (oldFile.exists()) {
	    	            oldFile.delete();
	    	        }
	    	        // 파일 정보 초기화
	    	        board.setFileName(null);
	    	        board.setOriginalFileName(null);
	    	        board.setFileSize(0);
	    	    }
	    	}
	        
	        // 새 파일 업로드 확인
	    	Part filePart = request.getPart("attachment");
	    	if (filePart != null && filePart.getSize() > 0) {
	    	    // 파일 크기 확인
	    	    if (filePart.getSize() > maxFileSize) {
	    	        throw new IllegalStateException("파일 크기가 10MB를 초과합니다.");
	    	    }

	    	    // 기존 파일이 있으면 삭제
	    	    if (board.getFileName() != null && !board.getFileName().isEmpty()) {
	    	        File oldFile = new File(uploadPath + File.separator + board.getFileName());
	    	        if (oldFile.exists()) {
	    	            oldFile.delete();
	    	        }
	    	    }
	            
	            // 원본 파일명 가져오기
	            String originalFileName = getFileName(filePart);
	            
	            // 저장할 파일명 생성 (중복 방지를 위해 타임스탬프 추가)
	            String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
	            String savedFileName = System.currentTimeMillis() + extension;
	            
	            // 파일 저장
	            String filePath = uploadPath + File.separator + savedFileName;
	            filePart.write(filePath);
	            
	            // BoardDTO에 파일 정보 설정
	            board.setOriginalFileName(originalFileName);
	            board.setFileName(savedFileName);
	            board.setFileSize(filePart.getSize());
	        }
	        
	        // 게시글 DB 업데이트
	        dao.updateBoard(board);
	        
	        // 변경된 board 객체를 request에 다시 저장
	        request.setAttribute("board", board);
	        
	    } catch (IllegalStateException e) {
	        request.setAttribute("errorMessage", e.getMessage());
	        throw new ServletException("파일 업로드 오류: " + e.getMessage(), e);
	    } catch (Exception e) {
	        request.setAttribute("errorMessage", "파일 업로드 중 오류가 발생했습니다.");
	        throw new ServletException("파일 업로드 오류", e);
	    }
	}

	// 파일이 포함된 경우 getParameter방식으로는 처리가 안됨 따라서 다음과 같은 getPart 방식을 사용 파일 전송을 위한 객체
	// enctype="multipart/form-data"를 사용하면 part객체에 데이터가 들어오는데 인코딩 형식이 다르기 때문에 UTF-8형식으로 변환
	// line으로 해당 데이터 읽어서 벨류에 넣고 다시 벨류값을 String형식으로 변환
	private String getValueFromPart(Part part) throws IOException {
	    BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8"));
	    StringBuilder value = new StringBuilder();
	    String line;
	    while ((line = reader.readLine()) != null) {
	        value.append(line);
	    }
	    return value.toString();
	}
	
	// 허용된 파일 확장자 확인
	private boolean isAllowedExtension(String fileName) {
	    String[] allowedExtensions = {".jpg", ".jpeg", ".png", ".gif", ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".txt", ".zip"};
	    String extension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
	    
	    for (String allowedExtension : allowedExtensions) {
	        if (extension.equals(allowedExtension)) {
	            return true;
	        }
	    }
	    
	    return false;
	}
	
	

	   


	// 선택된 글 삭제하기
	public void requestBoardDelete(HttpServletRequest request) {
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		BoardDAO dao = BoardDAO.getInstance();

		// 첨부파일 삭제를 위해 게시글 정보 먼저 가져오기
		BoardDTO board = dao.getBoardByNum(num, false);

		// 첨부파일이 있는 경우 파일 삭제
		if (board != null && board.getFileName() != null && !board.getFileName().isEmpty()) {
			String uploadPath = request.getServletContext().getRealPath("/uploads");
			File file = new File(uploadPath + File.separator + board.getFileName());
			if (file.exists()) {
				file.delete();
			}
		}

		// DB에서 게시글 삭제
		dao.deleteBoard(num);
	}

	// 좋아요 기능 처리 메서드
	public void requestBoardLike(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// JSON 응답 설정
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		JSONObject resultObj = new JSONObject();

		try {
			// 세션 확인
			HttpSession session = request.getSession();
			String userId = (String) session.getAttribute("id");

			// 요청에서 userId를 가져오는 것이 아니라 세션에서 가져온 userId 사용
			if (userId == null || userId.trim().equals("")) {
				resultObj.put("status", "error");
				resultObj.put("message", "로그인이 필요합니다.");
				out.print(resultObj.toJSONString());
				return;
			}

			// 파라미터 받기
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));

			// BoardDAO 인스턴스 생성
			BoardDAO dao = BoardDAO.getInstance();

			// 해당 사용자가 이미 좋아요를 눌렀는지 확인
			boolean alreadyLiked = dao.checkAlreadyLiked(boardNum, userId);

			if (alreadyLiked) {
				// 이미 좋아요를 눌렀다면 좋아요 취소
				dao.unlikeBoard(boardNum, userId);
				resultObj.put("liked", false);
			} else {
				// 좋아요가 없다면 좋아요 추가
				dao.likeBoard(boardNum, userId);
				resultObj.put("liked", true);
			}

			// 업데이트된 좋아요 수 가져오기
			int likeCount = dao.getBoardLikeCount(boardNum);

			// 결과 설정
			resultObj.put("status", "success");
			resultObj.put("likeCount", likeCount);

		} catch (Exception e) {
			resultObj.put("status", "error");
			resultObj.put("message", "서버 오류가 발생했습니다.");
			e.printStackTrace();
		}

		// JSON 응답 전송
		out.print(resultObj.toJSONString());
	}

	// 댓글 작성 처리 메서드
	public void requestCommentWrite(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 인코딩 설정
		request.setCharacterEncoding("UTF-8");

		// 세션에서 사용자 ID 가져오기
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("id");

		// 로그인 확인
		if (userId == null || userId.trim().equals("")) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용 가능합니다.');");
			out.println("history.back();");
			out.println("</script>");
			return;
		}

		// 파라미터 가져오기
		int boardNum = Integer.parseInt(request.getParameter("boardNum"));
		String content = request.getParameter("content");
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		// 댓글 데이터 설정
		CommentDTO comment = new CommentDTO();
		comment.setBoardNum(boardNum);
		comment.setId(userId);
		comment.setContent(content);

		// 날짜 설정
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String regist_day = formatter.format(new java.util.Date());
		comment.setRegist_day(regist_day);

		// 댓글 작성 처리
		CommentDAO dao = CommentDAO.getInstance();
		boolean success = dao.insertComment(comment);

		// 결과에 따른 처리
		if (success) {
			// 성공 시 상세 페이지로 리다이렉트
			response.sendRedirect("./BoardViewAction.do?num=" + boardNum + "&pageNum=" + pageNum);
		} else {
			// 실패 시 에러 메시지 출력
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('댓글 등록에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	}
	
	 // 댓글 수정 메서드
    private void requestCommentUpdate(HttpServletRequest request) {
        int commentNum = Integer.parseInt(request.getParameter("num"));
        String content = request.getParameter("content");
        
        HttpSession session = request.getSession();
        String sessionId = (String) session.getAttribute("id");
        
        CommentDAO dao = CommentDAO.getInstance();
        
        CommentDTO comment = new CommentDTO();
        comment.setNum(commentNum);
        comment.setContent(content);
        
        dao.updateComment(comment, sessionId);
    }
    
    // 댓글 삭제 메서드
    private void requestCommentDelete(HttpServletRequest request) {
        int commentNum = Integer.parseInt(request.getParameter("num"));
        
        HttpSession session = request.getSession();
        String sessionId = (String) session.getAttribute("id");
        
        CommentDAO dao = CommentDAO.getInstance();
        dao.deleteComment(commentNum, sessionId);
    }

}