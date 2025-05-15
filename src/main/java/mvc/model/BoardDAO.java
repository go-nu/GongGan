package mvc.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
		            sql = "SELECT COUNT(*) FROM boardf";
		            pstmt = conn.prepareStatement(sql);
		        } else {
		            // 유효한 컬럼만 허용
		            List<String> validColumns = Arrays.asList("subject", "content", "id");
		            if (!validColumns.contains(items)) {
		                throw new IllegalArgumentException("검색 항목이 잘못되었습니다: " + items);
		            }

		            sql = "SELECT COUNT(*) FROM boardf WHERE " + items + " LIKE ?";
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
		            sql = "SELECT * FROM boardf ORDER BY num DESC";
		            pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		        } else {
		            // 허용된 컬럼 목록
		            List<String> validColumns = Arrays.asList("subject", "content", "id");
		            if (!validColumns.contains(items)) {
		                throw new IllegalArgumentException("검색 항목이 잘못되었습니다: " + items);
		            }

		            sql = "SELECT * FROM boardf WHERE " + items + " LIKE ? ORDER BY num DESC";
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

    
    //member 테이블에서 인증된 id의 사용자명 가져오기
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

          String sql = "INSERT INTO boardf (id, subject, content, regist_day, hit, ip, liking, file_name, original_file_name, file_size) "
          		+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

          pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, board.getId());
          pstmt.setString(2, board.getSubject());
          pstmt.setString(3, board.getContent());
          pstmt.setString(4, board.getRegist_day());
          pstmt.setInt(5, board.getHit());
          pstmt.setString(6, board.getIp());
          pstmt.setInt(7, board.getLiking());
          pstmt.setString(8, board.getFileName());
          pstmt.setString(9, board.getOriginalFileName());
          pstmt.setLong(10, board.getFileSize());

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

          String sql = "select hit from boardf where num = ? ";
          pstmt = conn.prepareStatement(sql);
          pstmt.setInt(1, num);
          rs = pstmt.executeQuery();
          int hit = 0;

          if (rs.next())
             hit = rs.getInt("hit") + 1;
       

          sql = "update boardf set hit=? where num=?";
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
    public BoardDTO getBoardByNum(int num, int pageNum) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardDTO board = null;
        
        updateHit(num);
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT b.*, m.name FROM boardf b, users m " +
                        "WHERE b.id = m.id AND b.num = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                board = new BoardDTO();
                board.setNum(rs.getInt("num"));
                board.setId(rs.getString("id"));
                board.setName(rs.getString("name"));
                board.setSubject(rs.getString("subject"));
                board.setContent(rs.getString("content"));
                board.setRegist_day(rs.getString("regist_day"));
                board.setHit(rs.getInt("hit"));
                board.setIp(rs.getString("ip"));
                board.setLiking(rs.getInt("liking"));
                
                // 첨부파일 정보 설정
                board.setFileName(rs.getString("file_name"));
                board.setOriginalFileName(rs.getString("original_file_name"));
                board.setFileSize(rs.getLong("file_size"));
            }
            
            return board;
        } catch (Exception ex) {
            System.out.println("getBoardByNum() 예외 발생 : " + ex);
            return null;
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

    // 조회수 증가 없이 게시글을 가져오는 오버로딩 메서드
    public BoardDTO getBoardByNum(int num, boolean increaseHit) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardDTO board = null;
        
        // 조회수 증가 여부 확인
        if (increaseHit) {
            updateHit(num);
        }
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT b.*, m.name FROM boardf b, users m " +
                        "WHERE b.id = m.id AND b.num = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                board = new BoardDTO();
                board.setNum(rs.getInt("num"));
                board.setId(rs.getString("id"));
                board.setName(rs.getString("name"));
                board.setSubject(rs.getString("subject"));
                board.setContent(rs.getString("content"));
                board.setRegist_day(rs.getString("regist_day"));
                board.setHit(rs.getInt("hit"));
                board.setIp(rs.getString("ip"));
                board.setLiking(rs.getInt("liking"));
                
                // 첨부파일 정보 설정
                board.setFileName(rs.getString("file_name"));
                board.setOriginalFileName(rs.getString("original_file_name"));
                board.setFileSize(rs.getLong("file_size"));
            }
            
            return board;
        } catch (Exception ex) {
            System.out.println("getBoardByNum() 예외 발생 : " + ex);
            return null;
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

    //선택된 글 내용 수정하기
    public void updateBoard(BoardDTO board) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "UPDATE boardf SET subject=?, content=?, regist_day=?, ip=?, " +
                        "file_name=?, original_file_name=?, file_size=? " +
                        "WHERE num=?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, board.getSubject());
            pstmt.setString(2, board.getContent());
            pstmt.setString(3, board.getRegist_day());
            pstmt.setString(4, board.getIp());
            pstmt.setString(5, board.getFileName());
            pstmt.setString(6, board.getOriginalFileName());
            pstmt.setLong(7, board.getFileSize());
            pstmt.setInt(8, board.getNum());
            
            pstmt.executeUpdate();
        } catch (Exception ex) {
            System.out.println("updateBoard() 예외 발생: " + ex.getMessage());
            ex.printStackTrace();
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

       String sql = "delete from boardf where num=?";   

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
    

    
 // 좋아요 테이블 확인 (사용자가 해당 게시글에 좋아요를 눌렀는지 확인)
    public boolean checkAlreadyLiked(int boardNum, String userId) {
    	
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean alreadyLiked = false;
        
        try {
            conn = DBConnection.getConnection();
            
            // 좋아요 테이블(board_likes)에서 조회
            String sql = "SELECT COUNT(*) FROM board_likes WHERE board_num = ? AND user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, boardNum);
            pstmt.setString(2, userId);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                if (rs.getInt(1) > 0) {
                    alreadyLiked = true;
                }
            }
        } catch (Exception ex) {
            System.out.println("checkAlreadyLiked() 에러 : " + ex);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
        
        return alreadyLiked;
    }
    
    // 좋아요 추가
    public void likeBoard(int boardNum, String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작
            
            // 1. 좋아요 테이블에 추가
            String insertLikeSql = "INSERT INTO board_likes (board_num, user_id) VALUES (?, ?)";
            pstmt = conn.prepareStatement(insertLikeSql);
            pstmt.setInt(1, boardNum);
            pstmt.setString(2, userId);
            pstmt.executeUpdate();
            pstmt.close();
            
            // 2. board 테이블의 liking 컬럼 +1 업데이트
            String updateBoardSql = "UPDATE boardf SET liking = liking + 1 WHERE num = ?";
            pstmt = conn.prepareStatement(updateBoardSql);
            pstmt.setInt(1, boardNum);
            pstmt.executeUpdate();
            
            conn.commit(); // 트랜잭션 커밋
        } catch (Exception ex) {
            try {
                conn.rollback(); // 오류 발생 시 롤백
            } catch (SQLException e) {
                e.printStackTrace();
            }
            System.out.println("likeBoard() 에러 : " + ex);
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // 원래 상태로 복구
                    conn.close();
                }
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
    }
    
    // 좋아요 취소
    public void unlikeBoard(int boardNum, String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작
            
            // 1. 좋아요 테이블에서 삭제
            String deleteLikeSql = "DELETE FROM board_likes WHERE board_num = ? AND user_id = ?";
            pstmt = conn.prepareStatement(deleteLikeSql);
            pstmt.setInt(1, boardNum);
            pstmt.setString(2, userId);
            pstmt.executeUpdate();
            pstmt.close();
            
            // 2. board 테이블의 liking 컬럼 -1 업데이트 (0보다 작아지지 않도록)
            String updateBoardSql = "UPDATE boardf SET liking = GREATEST(0, liking - 1) WHERE num = ?";
            pstmt = conn.prepareStatement(updateBoardSql);
            pstmt.setInt(1, boardNum);
            pstmt.executeUpdate();
            
            conn.commit(); // 트랜잭션 커밋
        } catch (Exception ex) {
            try {
                conn.rollback(); // 오류 발생 시 롤백
            } catch (SQLException e) {
                e.printStackTrace();
            }
            System.out.println("unlikeBoard() 에러 : " + ex);
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // 원래 상태로 복구
                    conn.close();
                }
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
    }
    
    // 게시글의 현재 좋아요 수 조회
    public int getBoardLikeCount(int boardNum) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int likeCount = 0;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT liking FROM boardf WHERE num = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, boardNum);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                likeCount = rs.getInt("liking");
            }
        } catch (Exception ex) {
            System.out.println("getBoardLikeCount() 에러 : " + ex);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
        
        return likeCount;
    }
    
    // 사용자별 좋아요 상태 확인 (좋아요 아이콘 표시를 위해)
    public boolean getLikeStatus(int boardNum, String userId) {
        return checkAlreadyLiked(boardNum, userId);
    }
}
    

