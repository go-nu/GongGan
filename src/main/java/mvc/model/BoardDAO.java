package mvc.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import mvc.database.DBConnection;


public class BoardDAO {
	
	// 싱글톤 패턴 적용
	private static BoardDAO instance;
	   
	   private BoardDAO() {
	      
	   }

	   public static BoardDAO getInstance() {
	      if (instance == null)
	         instance = new BoardDAO();
	      return instance;
	   }   
	   
	 //board 테이블의 레코드 개수를 조회하는 메서드, 검색 조건이 있을 때와 없을 때를 구분
	 // items : 검색 조건(ex: 제목, 내용, 전체), text : 검색어
	   public int getListCount(String items, String text) {
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    int total_record = 0;

		    String sql;

		    try {
		        conn = DBConnection.getConnection();

		        // 검색 조건이 없는 경우
		        if (items == null || text == null || items.isEmpty() || text.isEmpty()) {
		            sql = "SELECT COUNT(*) FROM board";
		            pstmt = conn.prepareStatement(sql);
		        } else {
		            // 유효한 컬럼만 허용
		            List<String> validColumns = Arrays.asList("subject", "content", "id");
		            if (!validColumns.contains(items)) {
		                throw new IllegalArgumentException("검색 항목이 잘못되었습니다: " + items);
		            }

		            sql = "SELECT COUNT(*) FROM board WHERE " + items + " LIKE ?";
		            pstmt = conn.prepareStatement(sql);
		            
		            
		            pstmt.setString(1, "%" + text + "%");
		        }

		        rs = pstmt.executeQuery();
		        if (rs.next()) {
		            total_record = rs.getInt(1);
		        }

		    } catch (Exception ex) {
		        System.out.println("getListCount() : " + ex);
		    } finally {
		        try {
		            if (rs != null) rs.close();
		            if (pstmt != null) pstmt.close();
		            if (conn != null) conn.close();
		        } catch (Exception ex) {
		            throw new RuntimeException(ex.getMessage());
		        }
		    }

		    return total_record;
		}

    
    //board 테이블의 레코드 가져오기
    // 입력받은 페이지와 검색조건에 따라 게시글 목록을 조회해 ArrayList로 반환
    // SQL 쿼리문 동적 생성 및 데이터베이스에서 데이터 추출
    // page : 현재 페이지, limit : 한 페이지에 보여줄 레코드 수
    // items : 검색 조건(ex: 제목, 내용, 전체), text : 검색어
    // 게시판에서 검색 조건(items, text)과 페이지 번호(page), 한 페이지당 게시글 수(limit)에 따라 해당 조건의 게시글 목록을 ArrayList<BoardDTO>로 반환합니다.
    
	   public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text) {
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;

		    int total_record = getListCount(items, text);
		    int start = (page - 1) * limit;
		    int index = start + 1;

		    String sql;
		    ArrayList<BoardDTO> list = new ArrayList<>();

		    try {
		        conn = DBConnection.getConnection();

		        // 검색 조건 여부에 따라 SQL 구성
		        if (items == null || text == null || items.isEmpty() || text.isEmpty()) {
		            sql = "SELECT * FROM board ORDER BY num DESC";
		            pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		        } else {
		            // 허용된 컬럼 목록
		            List<String> validColumns = Arrays.asList("subject", "content", "id");
		            if (!validColumns.contains(items)) {
		                throw new IllegalArgumentException("검색 항목이 잘못되었습니다: " + items);
		            }

		            sql = "SELECT * FROM board WHERE " + items + " LIKE ? ORDER BY num DESC";
		            pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		            pstmt.setString(1, "%" + text + "%");
		        }

		        rs = pstmt.executeQuery();

		        while (rs.absolute(index)) {
		            BoardDTO board = new BoardDTO();
		            board.setNum(rs.getInt("num"));
		            board.setId(rs.getString("id"));
		            board.setSubject(rs.getString("subject"));
		            board.setContent(rs.getString("content"));
		            board.setRegist_day(rs.getString("regist_day"));
		            board.setHit(rs.getInt("hit"));
		            board.setIp(rs.getString("ip"));
		            board.setLiking(rs.getInt("liking"));
		            list.add(board);

		            if (index < (start + limit) && index <= total_record)
		                index++;
		            else
		                break;
		        }

		        return list;
		    } catch (Exception ex) {
		        System.out.println("getBoardList() : " + ex);
		    } finally {
		        try {
		            if (rs != null) rs.close();
		            if (pstmt != null) pstmt.close();
		            if (conn != null) conn.close();
		        } catch (Exception ex) {
		            throw new RuntimeException(ex.getMessage());
		        }
		    }

		    return null;
		}

    
    //users 테이블에서 인증된 id의 사용자명 가져오기
    public String getLoginNameById(String id) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;   

       String name=null;
       String sql = "select * from users where id = ? ";

       try {
          conn = DBConnection.getConnection();
          pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, id);
          rs = pstmt.executeQuery();

          if (rs.next()) 
             name = rs.getString("name");   
          
          return name;
       } catch (Exception ex) {
          System.out.println("getBoardByNum()      : " + ex);
       } finally {
          try {            
             if (rs != null) 
                rs.close();                     
             if (pstmt != null) 
                pstmt.close();            
             if (conn != null) 
                conn.close();
          } catch (Exception ex) {
             throw new RuntimeException(ex.getMessage());
          }      
       }
       return null;
    }
    
  //board 테이블에 새로운 글 삽입하기
    public void insertBoard(BoardDTO board)  {
	   // DBConnection.getConnection() 메서드를 사용하여 데이터베이스 연결을 가져옵니다.
       Connection conn = null;
       PreparedStatement pstmt = null;
       try {
          conn = DBConnection.getConnection();      

          String sql = "INSERT INTO board (id, subject, content, regist_day, hit, ip, liking) VALUES (?, ?, ?, ?, ?, ?, ?)";

          pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, board.getId());
          pstmt.setString(2, board.getSubject());
          pstmt.setString(3, board.getContent());
          pstmt.setString(4, board.getRegist_day());
          pstmt.setInt(5, board.getHit());
          pstmt.setString(6, board.getIp());
          pstmt.setInt(7, board.getLiking());

          pstmt.executeUpdate();
       } catch (Exception ex) {
          System.out.println(); //"insertBoard()      : " + ex
       } finally {
          try {                           
             if (pstmt != null) 
                pstmt.close();            
             if (conn != null) 
                conn.close();
          } catch (Exception ex) {
             throw new RuntimeException(ex.getMessage());
          }      
       }      
       System.out.println("== DB INSERT 시작 ==");
       System.out.println("ID: " + board.getId());
       System.out.println("Subject: " + board.getSubject());
       System.out.println("Content: " + board.getContent());
    } 
    
  //선택된 글의 조회 수 증가시키기 (좋아요	수 증가 수정)
    public void updateHit(int num) {

       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       
       try {
          conn = DBConnection.getConnection();

          String sql = "select hit from board where num = ? ";
          pstmt = conn.prepareStatement(sql);
          pstmt.setInt(1, num);
          rs = pstmt.executeQuery();
          int hit = 0;

          if (rs.next())
             hit = rs.getInt("hit") + 1;
       

          sql = "update board set hit=? where num=?";
          pstmt = conn.prepareStatement(sql);      
          pstmt.setInt(1, hit);
          pstmt.setInt(2, num);
          // pstmt.setInt(3, liking);
          pstmt.executeUpdate();
       } catch (Exception ex) {
          System.out.println("updateHit()      : " + ex);
       } finally {
          try {
             if (rs != null) 
                rs.close();                     
             if (pstmt != null) 
                pstmt.close();            
             if (conn != null) 
                conn.close();
          } catch (Exception ex) {
             throw new RuntimeException(ex.getMessage());
          }         
       }
    }
    
  //선택된 글 상세 내용 가져오기
    public BoardDTO getBoardByNum(int num, int page) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardDTO board = null;

        try {
            // 히트 업데이트 및 예외 처리
            try {
                updateHit(num);
            } catch (Exception e) {
                System.out.println("조회수 업데이트 오류: " + e);
                // 조회수 업데이트 실패해도 계속 진행
            }
            
            String sql = "select * from board where num = ?";
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                board = new BoardDTO();
                board.setNum(rs.getInt("num"));
                board.setId(rs.getString("id"));
                board.setLiking(rs.getInt("liking"));
                board.setSubject(rs.getString("subject"));
                board.setContent(rs.getString("content"));
                board.setRegist_day(rs.getString("regist_day"));
                board.setHit(rs.getInt("hit"));
                board.setIp(rs.getString("ip"));
                
                // 디버깅을 위해 콘솔에 출력
                System.out.println("게시글 로드 성공 - 번호: " + board.getNum() + ", 제목: " + board.getSubject());
            } else {
                System.out.println("게시글 로드 실패 - 해당 번호의 게시글이 없음: " + num);
            }
            
            return board;
        } catch (Exception ex) {
            System.out.println("getBoardByNum() 오류: " + ex);
            ex.printStackTrace(); // 자세한 오류 확인을 위해 스택 트레이스 출력
            return null;
        } finally {
            try {
                if (rs != null) rs.close();                     
                if (pstmt != null) pstmt.close();            
                if (conn != null) conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }      
        }
    }

    //선택된 글 내용 수정하기
    public void updateBoard(BoardDTO board) {

       Connection conn = null;
       PreparedStatement pstmt = null;
    
       try {
          String sql = "update board set subject=?, content=? where num=? and id=?";

          conn = DBConnection.getConnection();
          pstmt = conn.prepareStatement(sql);
          
          conn.setAutoCommit(false);

          pstmt.setString(1, board.getSubject());
          pstmt.setString(2, board.getContent());
          pstmt.setInt(3, board.getNum());
          pstmt.setString(4, board.getId());

          pstmt.executeUpdate();         
          conn.commit();

       } catch (Exception ex) {
          System.out.println("updateBoard()      : " + ex);
       } finally {
          try {                              
             if (pstmt != null) 
                pstmt.close();            
             if (conn != null) 
                conn.close();
          } catch (Exception ex) {
             throw new RuntimeException(ex.getMessage());
          }      
       }
    } 

  //선택된 글 삭제하기
    public void deleteBoard(int num) {
       Connection conn = null;
       PreparedStatement pstmt = null;      

       String sql = "delete from board where num=?";   

       try {
          conn = DBConnection.getConnection();
          pstmt = conn.prepareStatement(sql);
          pstmt.setInt(1, num);
          pstmt.executeUpdate();

       } catch (Exception ex) {
          System.out.println("deleteBoard()      : " + ex);
       } finally {
          try {                              
             if (pstmt != null) 
                pstmt.close();            
             if (conn != null) 
                conn.close();
          } catch (Exception ex) {
             throw new RuntimeException(ex.getMessage());
          }      
       }
    }   
    
}
