package mvc.model;

import mvc.model.CosmeticsDTO;
import mvc.database.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CosmeticsDAO {
    private static CosmeticsDAO instance;

    private CosmeticsDAO() {
        // DB 연결 처리 없이, 이제 DBConnection을 통해 연결을 사용합니다.
    }

    public static CosmeticsDAO getInstance() {
        if (instance == null) {
            instance = new CosmeticsDAO();
        }
        return instance;
    }

 // DB 연결 메서드에서 예외 발생 시 로그 추가
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            System.out.println("DB 연결 성공");
        } else {
            System.out.println("DB 연결 실패");
        }
        return conn;
    }

 // 1. CREATE: 새 화장품 추가
    public boolean addCosmetic(CosmeticsDTO cosmetic) {
    	String name = (cosmetic.getName() != null) ? cosmetic.getName() : "";
    	String brand = (cosmetic.getBrand() != null) ? cosmetic.getBrand() : "";
    	int price = (cosmetic.getPrice() > 0) ? cosmetic.getPrice() : 0;  // 적절한 기본값 설정
    	
    	
        String sql = "INSERT INTO cosmetics ( name, brand, price, main_ingredient, effect, category, image_file, likes) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cosmetic.getName());
            stmt.setString(2, cosmetic.getBrand());
            stmt.setInt(3, cosmetic.getPrice());
            stmt.setString(4, cosmetic.getMain_ingredient());
            stmt.setString(5, cosmetic.getEffect());
            stmt.setString(6, cosmetic.getCategory());
            stmt.setString(7, cosmetic.getImage_file());
            // 좋아요(likes) 값은 항상 0으로 설정
            stmt.setInt(8, 0); 
            
            
         // 디버깅용: 실행할 SQL 쿼리 출력
            System.out.println("Executing SQL: " + stmt.toString());  // 디버깅용 로그

            // 쿼리 실행
            int rowsAffected = stmt.executeUpdate();
            
            // 디버깅용: 실행된 쿼리 결과 (몇 개의 행이 영향을 받았는지 출력)
            System.out.println("Rows affected: " + rowsAffected);  // 실행된 쿼리 결과 확인
            
           
            
            return rowsAffected > 0; 
           
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 2. READ: 특정 카테고리 화장품 목록 불러오기
    public List<CosmeticsDTO> getCosmeticsByCategory(String category) {
        List<CosmeticsDTO> cosmeticsList = new ArrayList<>();
        String sql = "SELECT * FROM cosmetics WHERE category = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
            	CosmeticsDTO cosmetic = new CosmeticsDTO(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("brand"),
                        rs.getInt("price"),
                        rs.getString("main_ingredient"),
                        rs.getString("effect"),
                        rs.getString("category"),
                        rs.getString("image_file"),
                        rs.getInt("likes")
                );
                cosmeticsList.add(cosmetic);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return cosmeticsList;
    }

    // 3. READ: 특정 ID로 화장품 찾기
    public CosmeticsDTO getCosmeticById(int id) {
        String sql = "SELECT * FROM cosmetics WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new CosmeticsDTO(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("brand"),
                        rs.getInt("price"),
                        rs.getString("main_ingredient"),
                        rs.getString("effect"),
                        rs.getString("category"),
                        rs.getString("image_file"),
                        rs.getInt("likes")
                );
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 4. UPDATE: 화장품 정보 수정
    public boolean updateCosmetic(CosmeticsDTO cosmetic) {
        String sql = "UPDATE cosmetics SET name = ?, brand = ?, price = ?, main_ingredient = ?, effect = ?, category = ?, image_file = ?, likes = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cosmetic.getName());
            stmt.setString(2, cosmetic.getBrand());
            stmt.setInt(3, cosmetic.getPrice());
            stmt.setString(4, cosmetic.getMain_ingredient());
            stmt.setString(5, cosmetic.getEffect());
            stmt.setString(6, cosmetic.getCategory());
            stmt.setString(7, cosmetic.getImage_file());
            stmt.setInt(8, cosmetic.getLikes());
            stmt.setInt(9, cosmetic.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 5. DELETE: 화장품 삭제
    public boolean deleteCosmetic(int id) {
        String sql = "DELETE FROM cosmetics WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            int result = stmt.executeUpdate();
            return result > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 6. 전체 화장품 목록 가져오기 (READ ALL)
    public List<CosmeticsDTO> getAllCosmetics() {
        List<CosmeticsDTO> cosmeticsList = new ArrayList<>();
        String sql = "SELECT * FROM cosmetics";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
            	CosmeticsDTO cosmetic = new CosmeticsDTO(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("brand"),
                        rs.getInt("price"),
                        rs.getString("main_ingredient"),
                        rs.getString("effect"),
                        rs.getString("category"),
                        rs.getString("image_file"),
                        rs.getInt("likes")
                );
                cosmeticsList.add(cosmetic);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return cosmeticsList;
    }
    
    // 7 .같은 카테고리에서 자기 자신(id)을 제외한 상품 최대 limit개 가져오기 (detail사용)
    public List<CosmeticsDTO> getRelatedCosmetics(String category, int excludeId, int limit) {
        List<CosmeticsDTO> related = new ArrayList<>();
        String sql = "SELECT * FROM cosmetics WHERE category = ? AND id != ? LIMIT ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category);
            stmt.setInt(2, excludeId);
            stmt.setInt(3, limit);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
            	CosmeticsDTO cosmetic = new CosmeticsDTO(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("brand"),
                    rs.getInt("price"),
                    rs.getString("main_ingredient"),
                    rs.getString("effect"),
                    rs.getString("category"),
                    rs.getString("image_file"),
                    rs.getInt("likes")
                );
                related.add(cosmetic);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return related;
    }
    // 8 . 화장품 좋아요 버튼
		 	// 8-1. 좋아요 여부 확인
		    public boolean hasUserLiked(int cosmeticId, String userId) {
		        String sql = "SELECT * FROM cosmetic_likes WHERE cosmetic_id = ? AND user_id = ?";
		        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
		            pstmt.setInt(1, cosmeticId);
		            pstmt.setString(2, userId);
		            try (ResultSet rs = pstmt.executeQuery()) {
		                return rs.next();
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        return false;
		    }
		
		    // 8-2. 좋아요 추가
		    public void addLike(int cosmeticId, String userId) {
		        String sql = "INSERT INTO cosmetic_likes (cosmetic_id, user_id) VALUES (?, ?)";
		        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
		            pstmt.setInt(1, cosmeticId);
		            pstmt.setString(2, userId);
		            pstmt.executeUpdate();
		            updateLikeCount(cosmeticId); // 반영
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }
		
		    // 8-3. 좋아요 취소
		    public void removeLike(int cosmeticId, String userId) {
		        String sql = "DELETE FROM cosmetic_likes WHERE cosmetic_id = ? AND user_id = ?";
		        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
		            pstmt.setInt(1, cosmeticId);
		            pstmt.setString(2, userId);
		            pstmt.executeUpdate();
		            updateLikeCount(cosmeticId);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }
		
		    // 8-4. 좋아요 수 조회
		    public int getLikeCount(int cosmeticId) {
		        String sql = "SELECT COUNT(*) FROM cosmetic_likes WHERE cosmetic_id = ?";
		        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
		            pstmt.setInt(1, cosmeticId);
		            try (ResultSet rs = pstmt.executeQuery()) {
		                if (rs.next()) {
		                    return rs.getInt(1);
		                }
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        return 0;
		    }
		
		    // 8-5. cosmetics 테이블 업데이트
		    public void updateLikeCount(int cosmeticId) {
		        int count = getLikeCount(cosmeticId);
		        String sql = "UPDATE cosmetics SET likes = ? WHERE id = ?";
		        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
		            pstmt.setInt(1, count);
		            pstmt.setInt(2, cosmeticId);
		            pstmt.executeUpdate();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }

}
