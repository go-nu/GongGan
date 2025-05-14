package mvc.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class activityDAO {
//	싱글톤
	private static activityDAO instance;
	
	private activityDAO() {}
	
	public static activityDAO getInstance() {
		if(instance == null)
			instance = new activityDAO();
		return instance;
	}
	
//	d-day 계산
	public int dCount(String act_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int d = 0;
		
		String sql = "select act_date from activity where where act_id=" + act_id;
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) 
					rs.close();                     
				if (pstmt != null) 
					pstmt.close();            
				if (conn != null) 
					conn.close(); 
			} catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		
		
		return d;
	}
	

}
