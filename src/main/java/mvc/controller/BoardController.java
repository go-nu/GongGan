package mvc.controller;

import java.io.IOException;
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
		   
		      if (command.equals("/BoardListAction.do")) {//등록된 글 목록 페이지 출력하기
		         requestBoardList(request);
		         RequestDispatcher rd = request.getRequestDispatcher("./board/list.jsp");
		         rd.forward(request, response);
		      } else if (command.equals("/BoardWriteForm.do")) { //글 등록 페이지 출력
		            requestLoginName(request);
		            RequestDispatcher rd = request.getRequestDispatcher("./board/writeForm.jsp");
		            rd.forward(request, response);            
		      } else if (command.equals("/BoardWriteAction.do")) {//새로운 글 등록
		            requestBoardWrite(request);
		            response.sendRedirect("BoardListAction.do"); // 일단 수정
//		            RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
//		            rd.forward(request, response);                  
		      } else if (command.equals("/BoardViewAction.do")) { //선택된 글 상자 페이지 가져오기
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
		    	            RequestDispatcher rd = request.getRequestDispatcher("./board/view.jsp");
		    	            rd.forward(request, response);
		    	        }
		    	    } catch (Exception e) {
		    	        System.out.println("BoardViewAction.do 처리 중 오류: " + e);
		    	        e.printStackTrace();
		    	        response.sendRedirect("BoardListAction.do");
		    	    }              
		      } else if (command.equals("/BoardView.do")) {  //글 상세 페이지 출력
					/*
					 * // 요청 속성에서 게시글 정보 확인 BoardDTO board = (BoardDTO)
					 * request.getAttribute("board"); if (board == null) {
					 * System.out.println("BoardView.do - board 객체가 null입니다");
					 * response.sendRedirect("BoardListAction.do"); return; }
					 * 
					 * // 댓글 정보 로드 (필요한 경우) loadComments(request, board.getNum());
					 * 
					 * RequestDispatcher rd = request.getRequestDispatcher("./board/view.jsp");
					 * rd.forward(request, response);
					 */ 
		    	  	response.sendRedirect("BoardListAction.do");
		      } else if (command.equals("/BoardUpdateForm.do")) { // 글 수정 폼 출력 250512 수정
		    	    requestBoardView(request, response); // 기존 게시글 정보 가져오기 
		    	    requestLoginName(request); // 로그인 사용자 정보 가져오기
		    	    RequestDispatcher rd = request.getRequestDispatcher("./board/updateForm.jsp");
		    	    rd.forward(request, response);
		    	} else if (command.equals("/BoardUpdateAction.do")) { // 글 수정 처리
		    	    requestBoardUpdate(request);
		    	    String num = request.getParameter("num");
		    	    String pageNum = request.getParameter("pageNum");
		    	    response.sendRedirect("BoardViewAction.do?num=" + num + "&pageNum=" + pageNum);
		  
		      }else if (command.equals("/BoardDeleteAction.do")) { //선택된 글 삭제하기
		            requestBoardDelete(request);
		            RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
		            rd.forward(request, response);            
		      } else if (command.equals("/BoardLikeAction.do")) { //좋아요 기능 처리
		            requestBoardLike(request, response);
		            // 이 메서드는 AJAX 요청을 처리하므로 여기서 JSON 응답을 직접 반환함
		      } else if (command.equals("/CommentWriteAction.do")) {
		    	    requestCommentWrite(request, response);
		    	    return;
		    	}
		   }
	   
	   	// 댓글 정보 가져오기
		   private void loadComments(HttpServletRequest request, int num) {
		// TODO Auto-generated method stub 수정해야돼~~
		
		   }

		//등록된 글 목록 가져오기
		   public void requestBoardList(HttpServletRequest request){
		         
		      BoardDAO dao = BoardDAO.getInstance();
		      ArrayList<BoardDTO> boardlist = new ArrayList<BoardDTO>();
		      
		        int pageNum=1;
		      int limit=LISTCOUNT;
		      
		      if(request.getParameter("pageNum")!=null)
		         pageNum=Integer.parseInt(request.getParameter("pageNum"));
		            
		      String items = request.getParameter("items");
		      String text = request.getParameter("text");
		      
		   // Fix: null인 items와 text 파라미터 처리
		      if (items == null) items = "";
		      if (text == null) text = "";
		      
		      int total_record=dao.getListCount(items, text);
		      boardlist = dao.getBoardList(pageNum,limit, items, text); 
		      
		   // 페이지네이션을 위한 검색 파라미터 보존
		      request.setAttribute("items", items);
		      request.setAttribute("text", text);
		      
		      
		      int total_page;
		      
		      if (total_record % limit == 0){     
		           total_page =total_record/limit;
		           Math.floor(total_page);  
		      }
		      else{
		         total_page =total_record/limit;
		         Math.floor(total_page); 
		         total_page =  total_page + 1; 
		      }      
		   
		         request.setAttribute("currentPage", pageNum);        
		         request.setAttribute("totalPage", total_page);   
		      request.setAttribute("totalPosts",total_record); 
		      request.setAttribute("boardList", boardlist);        
		      
		   // 페이지네이션에 필요한 경우 다음 항목 추가
		      int startPage = ((pageNum - 1) / 10) * 10 + 1;
		      int endPage = startPage + 9;
		      if (endPage > total_page) endPage = total_page;
		      
		      request.setAttribute("startPage", startPage);
		      request.setAttribute("endPage", endPage);
		      
		   }
		   //인증된 사용자명 가져오기
		   public void requestLoginName(HttpServletRequest request){
		       
			    String id = (String) request.getSession().getAttribute("sessionId");

			    BoardDAO dao = BoardDAO.getInstance();
			    String name = dao.getLoginNameById(id);

			    request.setAttribute("id", id);     // ← 추가
			    request.setAttribute("name", name);
			                           
		   }
		   //새로운 글 등록하기
		   public void requestBoardWrite(HttpServletRequest request){
		               
		      BoardDAO dao = BoardDAO.getInstance();      
		      
		      BoardDTO board = new BoardDTO();
		      board.setId(request.getParameter("id"));

		      board.setSubject(request.getParameter("subject"));
		      board.setContent(request.getParameter("content"));   
		      
		      System.out.println(request.getParameter("subject"));
		      System.out.println(request.getParameter("content"));
		      java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		      String regist_day = formatter.format(new java.util.Date()); 
		      
		      
		      board.setLiking(0);// 좋아요 수 초기화
		      board.setHit(0);
		      board.setRegist_day(regist_day);
		      board.setIp(request.getRemoteAddr());         
		      
		      dao.insertBoard(board);    
		      
		      System.out.println("=== requestBoardWrite 시작 ===");
		      System.out.println("ID: " + request.getParameter("id"));
		      System.out.println("Subject: " + request.getParameter("subject"));
		      System.out.println("Content: " + request.getParameter("content"));
		      
		   }
		   //선택된 글 상세 페이지 가져오기
		   public void requestBoardView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		               
		      BoardDAO dao = BoardDAO.getInstance();
		      int num = Integer.parseInt(request.getParameter("num"));
		      int pageNum = Integer.parseInt(request.getParameter("pageNum"));   
		      
		      BoardDTO board = new BoardDTO();
		      board = dao.getBoardByNum(num, pageNum);
		      //board = dao.getBoardByNum(num, true);  // 조회수 증가
		      
		      // 댓글 목록 가져오기 (추가된 부분)
		      CommentDAO commentDAO = CommentDAO.getInstance();
		      ArrayList<CommentDTO> commentList = commentDAO.getCommentList(num);
		      
		      // request에 속성 설정
		      request.setAttribute("num", num);
		      request.setAttribute("page", pageNum);
		      request.setAttribute("board", board);
		      request.setAttribute("commentList", commentList);  // 댓글 목록 추가 
		     
		   }
		    //선택된 글 내용 수정하기
		   public void requestBoardUpdate(HttpServletRequest request){
			    
			    int num = Integer.parseInt(request.getParameter("num"));
			    int pageNum = Integer.parseInt(request.getParameter("pageNum"));   
			    
			    BoardDAO dao = BoardDAO.getInstance();    
			    
			    BoardDTO board = new BoardDTO();    
			    board.setNum(num);

			    // 🔒 id는 세션에서 꺼내는 것이 안전함
			    HttpSession session = request.getSession();
			    String id = (String) session.getAttribute("id"); // 로그인 시 저장해둔 속성명
			    board.setId(id);

			    board.setSubject(request.getParameter("subject"));
			    board.setContent(request.getParameter("content"));    
			    
			    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
			    String regist_day = formatter.format(new java.util.Date()); 
			    
			    board.setHit(0);
			    board.setRegist_day(regist_day);
			    board.setIp(request.getRemoteAddr());       
			    
			    dao.updateBoard(board);                        
			}
		   //선택된 글 삭제하기
		   public void requestBoardDelete(HttpServletRequest request){
		               
		      int num = Integer.parseInt(request.getParameter("num"));
		      int pageNum = Integer.parseInt(request.getParameter("pageNum"));   
		      
		      BoardDAO dao = BoardDAO.getInstance();
		      dao.deleteBoard(num);                     
		   }   
		   
		// 좋아요 기능 처리 메서드
		   public void requestBoardLike(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		   public void requestCommentWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
	   
}

