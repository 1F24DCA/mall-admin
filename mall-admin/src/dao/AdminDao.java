package dao;

import java.sql.*;

import commons.DBUtil;
import vo.*;

public class AdminDao {
	public Admin login(Admin paramAdmin) throws Exception {
		Admin returnAdmin = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT admin_email FROM admin WHERE admin_email=? AND admin_pw=?"; 
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramAdmin.getAdminEmail());
		stmt.setString(2, paramAdmin.getAdminPw());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnAdmin = new Admin();
			returnAdmin.setAdminEmail(rs.getString("admin_email"));
		}
		
		conn.close();
		
		return returnAdmin;
	}
}
