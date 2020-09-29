package dao;

import java.util.*;
import java.sql.*;

import commons.*;
import vo.*;

public class NoticeDao {
	public ArrayList<Notice> selectNoticeListWithPageDesc(ListPage listPage) throws Exception {
		ArrayList<Notice> returnList = new ArrayList<Notice>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT notice_id, notice_date, notice_title FROM notice ORDER BY notice_id DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, listPage.getQueryIndex());
		stmt.setInt(2, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Notice notice = new Notice();
			notice.setNoticeId(rs.getInt("notice_id"));
			notice.setNoticeDate(rs.getString("notice_date"));
			notice.setNoticeTitle(rs.getString("notice_title"));
			
			returnList.add(notice);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectNoticeCount() throws Exception {
		int returnCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<Notice> selectNoticeListWithPageDescSearchByNoticeTitle(ListPage listPage, Notice paramNotice) throws Exception {
		ArrayList<Notice> returnList = new ArrayList<Notice>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT notice_id, notice_date, notice_title FROM notice WHERE notice_title ORDER BY notice_id DESC LIKE ? LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramNotice.getNoticeTitle()+"%");
		stmt.setInt(2, listPage.getQueryIndex());
		stmt.setInt(3, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Notice notice = new Notice();
			notice.setNoticeId(rs.getInt("notice_id"));
			notice.setNoticeDate(rs.getString("notice_date"));
			notice.setNoticeTitle(rs.getString("notice_title"));
			
			returnList.add(notice);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectNoticeCountSearchByNoticeTitle(Notice paramNotice) throws Exception {
		int returnCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM notice WHERE notice_title LIKE ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramNotice.getNoticeTitle()+"%");
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public Notice selectNoticeOne(Notice paramNotice) throws Exception {
		Notice returnNotice = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT notice_date, notice_title, notice_content FROM notice WHERE notice_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramNotice.getNoticeId());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnNotice = new Notice();
			returnNotice.setNoticeId(paramNotice.getNoticeId());
			returnNotice.setNoticeDate(rs.getString("notice_date"));
			returnNotice.setNoticeTitle(rs.getString("notice_title"));
			returnNotice.setNoticeContent(rs.getString("notice_content"));
		}
		
		conn.close();
		
		return returnNotice;
	}
	
	public void insertNotice(Notice paramNotice) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO notice(notice_title, notice_content, notice_date) VALUES(?, ?, NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramNotice.getNoticeTitle());
		stmt.setString(2, paramNotice.getNoticeContent());
		System.out.println(stmt+"<-stmt");
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public void updateNotice(Notice paramNotice) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE notice SET notice_title=?, notice_content=? WHERE notice_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramNotice.getNoticeTitle());
		stmt.setString(2, paramNotice.getNoticeContent());
		stmt.setInt(3, paramNotice.getNoticeId());
		System.out.println(stmt+"<-stmt");
		
		stmt.executeUpdate();
		
		conn.close();
	}

	public void deleteNotice(Notice paramNotice) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM notice WHERE notice_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramNotice.getNoticeId());
		System.out.println(stmt+"<-stmt");
		
		stmt.executeUpdate();
		
		conn.close();
	}
}
