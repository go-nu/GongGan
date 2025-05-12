package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

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
		      
		      response.setContentType("text/html; charset=utf-8");
		      request.setCharacterEncoding("utf-8");
		   
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
		    	        requestBoardView(request);
		    	        
		    	        // board 객체 확인
		    	        BoardDTO board = (BoardDTO) request.getAttribute("board");
		    	        if (board == null) {
		    	            System.out.println("게시글 정보를 찾을 수 없음: num=" + numParam);
		    	            response.sendRedirect("BoardListAction.do");
		    	            return;
		    	        }
		    	        
		    	        // 정상적으로 게시글 정보가 있으면 뷰 페이지로 포워딩
		    	        RequestDispatcher rd = request.getRequestDispatcher("/BoardView.do");
		    	        rd.forward(request, response);
		    	    } catch (Exception e) {
		    	        System.out.println("BoardViewAction.do 처리 중 오류: " + e);
		    	        e.printStackTrace();
		    	        response.sendRedirect("BoardListAction.do");
		    	    }              
		      } else if (command.equals("/BoardView.do")) {  //글 상세 페이지 출력
		    	    // 요청 속성에서 게시글 정보 확인
		    	    BoardDTO board = (BoardDTO) request.getAttribute("board");
		    	    if (board == null) {
		    	        System.out.println("BoardView.do - board 객체가 null입니다");
		    	        response.sendRedirect("BoardListAction.do");
		    	        return;
		    	    }
		    	    
		    	    // 댓글 정보 로드 (필요한 경우)
		    	    // loadComments(request, board.getNum());
		    	    
		    	    RequestDispatcher rd = request.getRequestDispatcher("./board/view.jsp");
		    	    rd.forward(request, response);   
		      } else if (command.equals("/BoardUpdateForm.do")) { // 글 수정 폼 출력 250512 수정
		    	    requestBoardView(request); // 기존 게시글 정보 가져오기 
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
		      } 
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
			   
//		      String id = request.getParameter("id");
//		      
//		      BoardDAO  dao = BoardDAO.getInstance();
//		      
//		      String name = dao.getLoginNameById(id);      
//		      
//		      request.setAttribute("name", name);                           
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
		   public void requestBoardView(HttpServletRequest request){
		               
		      BoardDAO dao = BoardDAO.getInstance();
		      int num = Integer.parseInt(request.getParameter("num"));
		      int pageNum = Integer.parseInt(request.getParameter("pageNum"));   
		      
		      BoardDTO board = new BoardDTO();
		      board = dao.getBoardByNum(num, pageNum);      
		      
		      request.setAttribute("num", num);       
		         request.setAttribute("page", pageNum); 
		         request.setAttribute("board", board);                              
		   }
		    //선택된 글 내용 수정하기
		   public void requestBoardUpdate(HttpServletRequest request){
		               
		      int num = Integer.parseInt(request.getParameter("num"));
		      int pageNum = Integer.parseInt(request.getParameter("pageNum"));   
		      
		      BoardDAO dao = BoardDAO.getInstance();      
		      
		      BoardDTO board = new BoardDTO();      
		      board.setNum(num);
		      board.setId(request.getParameter("id")); // name -> id
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
	   
}

