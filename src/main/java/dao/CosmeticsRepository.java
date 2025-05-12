package dao;

import dto.Cosmetics;

import java.sql.*;
import java.util.ArrayList;

public class CosmeticsRepository {

    private static CosmeticsRepository instance = new CosmeticsRepository();  // Singleton pattern
    public static CosmeticsRepository getInstance() {
        return instance;
    }

    // DB 연결을 위한 메서드 (중복 제거)
    private Connection getConnection() throws SQLException {
    	
		 try {
	         // 명시적으로 MySQL 드라이버 로드
	         Class.forName("com.mysql.cj.jdbc.Driver");  // 최신 MySQL JDBC 드라이버 로드
	     } catch (ClassNotFoundException e) {
	         e.printStackTrace();
	         throw new SQLException("MySQL JDBC 드라이버를 로드할 수 없습니다.");
	     }
		 
        String url = "jdbc:mysql://localhost:3306/fs_semi?serverTimezone=UTC";
        String user = "root";
        String password = "1234";
        return DriverManager.getConnection(url, user, password);
    }

    // 화장품 정보 가져오기 (전체 화장품 목록)
    public ArrayList<Cosmetics> getAllCosmetics() {
        ArrayList<Cosmetics> cosmeticsList = new ArrayList<>();
        String sql = "SELECT id, name, brand, price, main_ingredient, effect, category, image_file, likes FROM cosmetics"; // SQL 쿼리

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Cosmetics cosmetics = new Cosmetics();
                cosmetics.setId(rs.getInt("id"));
                cosmetics.setName(rs.getString("name"));
                cosmetics.setBrand(rs.getString("brand"));
                cosmetics.setPrice(rs.getInt("price"));
                cosmetics.setMain_ingredient(rs.getString("main_ingredient"));
                cosmetics.setEffect(rs.getString("effect"));
                cosmetics.setCategory(rs.getString("category"));
                cosmetics.setImage_file(rs.getString("image_file"));
                cosmetics.setLikes(rs.getInt("likes"));
                cosmeticsList.add(cosmetics);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return cosmeticsList;
    }
    
    // 카테고리별 화장품 리스트 가져오기
    public ArrayList<Cosmetics> getCosmeticsByCategory(String category) {
        ArrayList<Cosmetics> cosmeticsList = new ArrayList<>();
        String sql = "SELECT id, name, brand, price, main_ingredient, effect, category, image_file, likes FROM cosmetics WHERE category = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Cosmetics cosmetics = new Cosmetics();
                cosmetics.setId(rs.getInt("id"));
                cosmetics.setName(rs.getString("name"));
                cosmetics.setBrand(rs.getString("brand"));
                cosmetics.setPrice(rs.getInt("price"));
                cosmetics.setMain_ingredient(rs.getString("main_ingredient"));
                cosmetics.setEffect(rs.getString("effect"));
                cosmetics.setCategory(rs.getString("category"));
                cosmetics.setImage_file(rs.getString("image_file"));
                cosmetics.setLikes(rs.getInt("likes"));
                cosmeticsList.add(cosmetics);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

   
        return cosmeticsList;
    }

    // 화장품 id로 화장품 정보 가져오기
    public Cosmetics getCosmeticsById(int id) {
        Cosmetics cosmetics = null;
        String sql = "SELECT id, name, brand, price, main_ingredient, effect, category, image_file, likes FROM cosmetics WHERE id = ?";  // SQL 쿼리

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                cosmetics = new Cosmetics();
                cosmetics.setId(rs.getInt("id"));
                cosmetics.setName(rs.getString("name"));
                cosmetics.setBrand(rs.getString("brand"));
                cosmetics.setPrice(rs.getInt("price"));
                cosmetics.setMain_ingredient(rs.getString("main_ingredient"));
                cosmetics.setEffect(rs.getString("effect"));
                cosmetics.setCategory(rs.getString("category"));
                cosmetics.setImage_file(rs.getString("image_file"));
                cosmetics.setLikes(rs.getInt("likes"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return cosmetics;
    }

   
    // 화장품 추가 메서드
    public void addCosmetics(Cosmetics cosmetics) {
        String sql = "INSERT INTO cosmetics (name, brand, price, main_ingredient, effect, category, image_file) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, cosmetics.getName());
            pstmt.setString(2, cosmetics.getBrand());
            pstmt.setInt(3, cosmetics.getPrice());
            pstmt.setString(4, cosmetics.getMain_ingredient());
            pstmt.setString(5, cosmetics.getEffect());
            pstmt.setString(6, cosmetics.getCategory());
            pstmt.setString(7, cosmetics.getImage_file());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    // 화장품 삭제 메서드     
    public void deleteCosmetic(int id) {
        String sql = "DELETE FROM cosmetics WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

	 // 화장품 정보 수정 메서드
	 public void updateCosmetic(Cosmetics cosmetic) {
	     String sql = "UPDATE cosmetics SET name = ?, brand = ?, price = ?, main_ingredient = ?, effect = ?, category = ?, image_file = ? WHERE id = ?";
	
	     try (Connection conn = getConnection();
	          PreparedStatement pstmt = conn.prepareStatement(sql)) {
	
	         pstmt.setString(1, cosmetic.getName());
	         pstmt.setString(2, cosmetic.getBrand());
	         pstmt.setInt(3, cosmetic.getPrice());
	         pstmt.setString(4, cosmetic.getMain_ingredient());
	         pstmt.setString(5, cosmetic.getEffect());
	         pstmt.setString(6, cosmetic.getCategory());
	         pstmt.setString(7, cosmetic.getImage_file());
	         pstmt.setInt(8, cosmetic.getId());
	
	         pstmt.executeUpdate();
	     } catch (SQLException ex) {
	         ex.printStackTrace();
	     }
	 }

}