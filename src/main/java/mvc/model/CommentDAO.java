package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class CommentDAO {
    private static CommentDAO instance;
    
    private CommentDAO() {
        // 기본 생성자
    }
    
    public static CommentDAO getInstance() {
        if (instance == null) {
            instance = new CommentDAO();
        }
        return instance;
    }
    
    // 댓글 목록 가져오기
    public ArrayList<CommentDTO> getCommentList(int boardNum) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<CommentDTO> commentList = new ArrayList<CommentDTO>();
        
        String sql = "SELECT * FROM comments WHERE board_num = ? ORDER BY num DESC";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, boardNum);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                CommentDTO comment = new CommentDTO();
                comment.setNum(rs.getInt("num"));
                comment.setBoardNum(rs.getInt("board_num"));
                comment.setId(rs.getString("id"));
                comment.setContent(rs.getString("content"));
                comment.setRegist_day(rs.getString("regist_day"));
                
                commentList.add(comment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return commentList;
    }
    
    // 댓글 등록하기
    public boolean insertComment(CommentDTO comment) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        String sql = "INSERT INTO comments (board_num, id, content, regist_day) VALUES (?, ?, ?, ?)";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, comment.getBoardNum());
            pstmt.setString(2, comment.getId());
            pstmt.setString(3, comment.getContent());
            pstmt.setString(4, comment.getRegist_day());
            
            int result = pstmt.executeUpdate();
            if (result > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
    
    // 댓글 삭제하기
    public boolean deleteComment(int commentNum, String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        String sql = "DELETE FROM comments WHERE num = ? AND id = ?";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, commentNum);
            pstmt.setString(2, userId);
            
            int result = pstmt.executeUpdate();
            if (result > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
    
    // 댓글 수정하기
    public boolean updateComment(CommentDTO comment, String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        String sql = "UPDATE comments SET content = ? WHERE num = ? AND id = ?";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, comment.getContent());
            pstmt.setInt(2, comment.getNum());
            pstmt.setString(3, userId);
            
            int result = pstmt.executeUpdate();
            if (result > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
    
    // 해당 게시글에 대한 댓글 개수 가져오기
    public int getCommentCount(int boardNum) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        
        String sql = "SELECT COUNT(*) FROM comments WHERE board_num = ?";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, boardNum);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return count;
    }
}