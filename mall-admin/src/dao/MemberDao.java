package dao;

import java.util.*;
import java.sql.*;

import commons.*;
import vo.*;

public class MemberDao {
	public ArrayList<Member> selectMemberListWithPage(ListPage listPage) throws Exception {
		ArrayList<Member> returnList = new ArrayList<Member>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_email, member_name, member_date, deleted_by FROM member LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, listPage.getQueryIndex());
		stmt.setInt(2, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Member member = new Member();
			member.setMemberEmail(rs.getString("member_email"));
			member.setMemberName(rs.getString("member_name"));
			member.setMemberDate(rs.getString("member_date"));
			member.setDeletedBy(rs.getString("deleted_by"));
			
			returnList.add(member);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectMemberCount() throws Exception {
		int returnCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM member";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<Member> selectMemberListWithPageAndSearch(ListPage listPage, Member paramMember) throws Exception {
		if ((paramMember.getMemberEmail().equals("") || paramMember.getMemberName().equals("")) && paramMember.getDeletedBy().equals("")) {
			return selectMemberListWithPage(listPage);
		} else if (!(paramMember.getMemberEmail().equals("") || paramMember.getMemberName().equals("")) && paramMember.getDeletedBy().equals("")) {
			return selectMemberListWithPageSearchByMemberEmailOrMemberNameEither(listPage, paramMember);
		} else if ((paramMember.getMemberEmail().equals("") || paramMember.getMemberName().equals("")) && !paramMember.getDeletedBy().equals("")) {
			return selectMemberListWithPageSearchByDeletedBy(listPage, paramMember);
		} else if (!(paramMember.getMemberEmail().equals("") || paramMember.getMemberName().equals("")) && !paramMember.getDeletedBy().equals("")) {
			return selectMemberListWithPageSearchByMemberEmailOrMemberNameEitherAndDeletedBy(listPage, paramMember);
		} else {
			return null;
		}
	}

	public int selectMemberCountWithSearch(Member paramMember) throws Exception {
		if ((paramMember.getMemberEmail().equals("") || paramMember.getMemberName().equals("")) && paramMember.getDeletedBy().equals("")) {
			return selectMemberCount();
		} else if (!(paramMember.getMemberEmail().equals("") || paramMember.getMemberName().equals("")) && paramMember.getDeletedBy().equals("")) {
			return selectMemberCountSearchByMemberEmailOrMemberNameEither(paramMember);
		} else if ((paramMember.getMemberEmail().equals("") || paramMember.getMemberName().equals("")) && !paramMember.getDeletedBy().equals("")) {
			return selectMemberCountSearchByDeletedBy(paramMember);
		} else if (!(paramMember.getMemberEmail().equals("") || paramMember.getMemberName().equals("")) && !paramMember.getDeletedBy().equals("")) {
			return selectMemberCountSearchByMemberEmailOrMemberNameEitherAndDeletedBy(paramMember);
		} else {
			return -1;
		}
	}
	
	public ArrayList<Member> selectMemberListWithPageSearchByMemberEmailOrMemberNameEither(ListPage listPage, Member paramMember) throws Exception {
		ArrayList<Member> returnList = new ArrayList<Member>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_email, member_name, member_date, deleted_by FROM member WHERE (member_email LIKE ? OR member_name LIKE ?) LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramMember.getMemberEmail()+"%");
		stmt.setString(2, "%"+paramMember.getMemberName()+"%");
		stmt.setInt(3, listPage.getQueryIndex());
		stmt.setInt(4, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Member member = new Member();
			member.setMemberEmail(rs.getString("member_email"));
			member.setMemberName(rs.getString("member_name"));
			member.setMemberDate(rs.getString("member_date"));
			member.setDeletedBy(rs.getString("deleted_by"));
			
			returnList.add(member);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectMemberCountSearchByMemberEmailOrMemberNameEither(Member paramMember) throws Exception {
		int returnCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM member WHERE (member_email LIKE ? OR member_name LIKE ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramMember.getMemberEmail()+"%");
		stmt.setString(2, "%"+paramMember.getMemberName()+"%");
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<Member> selectMemberListWithPageSearchByDeletedBy(ListPage listPage, Member paramMember) throws Exception {
		ArrayList<Member> returnList = new ArrayList<Member>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_email, member_name, member_date, deleted_by FROM member WHERE deleted_by=? LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getDeletedBy());
		stmt.setInt(2, listPage.getQueryIndex());
		stmt.setInt(3, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Member member = new Member();
			member.setMemberEmail(rs.getString("member_email"));
			member.setMemberName(rs.getString("member_name"));
			member.setMemberDate(rs.getString("member_date"));
			member.setDeletedBy(rs.getString("deleted_by"));
			
			returnList.add(member);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectMemberCountSearchByDeletedBy(Member paramMember) throws Exception {
		int returnCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM member WHERE deleted_by=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getDeletedBy());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<Member> selectMemberListWithPageSearchByMemberEmailOrMemberNameEitherAndDeletedBy(ListPage listPage, Member paramMember) throws Exception {
		ArrayList<Member> returnList = new ArrayList<Member>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_email, member_name, member_date, deleted_by FROM member WHERE (member_email LIKE ? OR member_name LIKE ?) AND deleted_by=? LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramMember.getMemberEmail()+"%");
		stmt.setString(2, "%"+paramMember.getMemberName()+"%");
		stmt.setString(3, paramMember.getDeletedBy());
		stmt.setInt(4, listPage.getQueryIndex());
		stmt.setInt(5, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Member member = new Member();
			member.setMemberEmail(rs.getString("member_email"));
			member.setMemberName(rs.getString("member_name"));
			member.setMemberDate(rs.getString("member_date"));
			member.setDeletedBy(rs.getString("deleted_by"));
			
			returnList.add(member);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectMemberCountSearchByMemberEmailOrMemberNameEitherAndDeletedBy(Member paramMember) throws Exception {
		int returnCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM member WHERE (member_email LIKE ? OR member_name LIKE ?) AND deleted_by=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramMember.getMemberEmail()+"%");
		stmt.setString(2, "%"+paramMember.getMemberName()+"%");
		stmt.setString(3, paramMember.getDeletedBy());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<String> selectDeletedByListAll() throws Exception {
		ArrayList<String> returnList = new ArrayList<String>();

		returnList.add("활동중");
		returnList.add("탈퇴");
		returnList.add("강퇴");
		
		return returnList;
	}
	
	public Member selectMemberOne(Member paramMember) throws Exception {
		Member returnMember = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_email, member_name, member_date, deleted_by FROM member WHERE member_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberEmail());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnMember = new Member();
			returnMember.setMemberEmail(paramMember.getMemberEmail());
			returnMember.setMemberName(rs.getString("member_name"));
			returnMember.setMemberDate(rs.getString("member_date"));
			returnMember.setDeletedBy(rs.getString("deleted_by"));
		}
		
		conn.close();
		
		return returnMember;
	}
	
	public void deleteMember(Member paramMember) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE member SET member_pw=?, deleted_by=? WHERE member_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "");
		stmt.setString(2, "강퇴");
		stmt.setString(3, paramMember.getMemberEmail());
		System.out.println(stmt+"<-stmt");
		
		stmt.executeUpdate();
		
		conn.close();
	}
}
