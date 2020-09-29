package dao;

import java.util.ArrayList;
import java.sql.*;

import commons.DBUtil;
import commons.ListPage;
import vo.*;

public class CategoryDao {
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> returnList = new ArrayList<Category>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT category_id, category_name, category_pic FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Category category = new Category();
			category.setCategoryId(rs.getInt("category_id"));
			category.setCategoryName(rs.getString("category_name"));
			category.setCategoryPic(rs.getString("category_pic"));
			
			returnList.add(category);
		}
		
		conn.close();
		
		return returnList;
	}

	public ArrayList<Category> selectCategoryListWithPage(ListPage listPage) throws Exception {
		ArrayList<Category> returnList = new ArrayList<Category>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT category_id, category_name, category_pic FROM category LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, listPage.getQueryIndex());
		stmt.setInt(2, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Category category = new Category();
			category.setCategoryId(rs.getInt("category_id"));
			category.setCategoryName(rs.getString("category_name"));
			category.setCategoryPic(rs.getString("category_pic"));
			
			returnList.add(category);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectCategoryCount() throws Exception {
		int returnCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}

	public ArrayList<Category> selectCategoryListSearchByCategoryName(Category paramCategory) throws Exception {
		ArrayList<Category> returnList = new ArrayList<Category>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT category_id, category_name, category_pic FROM category WHERE category_name LIKE ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramCategory.getCategoryName()+"%");
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Category category = new Category();
			category.setCategoryId(rs.getInt("category_id"));
			category.setCategoryName(rs.getString("category_name"));
			category.setCategoryPic(rs.getString("category_pic"));
			
			returnList.add(category);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public ArrayList<Category> selectCategoryListWithPageSearchByCategoryName(ListPage listPage, Category paramCategory) throws Exception {
		ArrayList<Category> returnList = new ArrayList<Category>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT category_id, category_name, category_pic FROM category WHERE category_name LIKE ? LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramCategory.getCategoryName()+"%");
		stmt.setInt(2, listPage.getQueryIndex());
		stmt.setInt(3, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Category category = new Category();
			category.setCategoryId(rs.getInt("category_id"));
			category.setCategoryName(rs.getString("category_name"));
			category.setCategoryPic(rs.getString("category_pic"));
			
			returnList.add(category);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectCategoryCountSearchByCategoryName(Category paramCategory) throws Exception {
		int returnCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM category WHERE category_name LIKE ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramCategory.getCategoryName()+"%");
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public Category selectCategoryOne(Category paramCategory) throws Exception {
		Category returnCategory = new Category();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT category_name, category_pic FROM category WHERE category_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramCategory.getCategoryId());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCategory.setCategoryId(paramCategory.getCategoryId());
			returnCategory.setCategoryName(rs.getString("category_name"));
			returnCategory.setCategoryPic(rs.getString("category_pic"));
		}
		
		conn.close();
		
		return returnCategory;
	}
	
	public void insertCategory(Category paramCategory) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO category(category_name) VALUES(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramCategory.getCategoryName());
		System.out.println(stmt+"<-stmt");
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public void updateCategory(Category paramCategory) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE category SET category_name=? WHERE category_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramCategory.getCategoryName());
		stmt.setInt(2, paramCategory.getCategoryId());
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public void updateCategoryPic(Category paramCategory) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE category SET category_pic=? WHERE category_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramCategory.getCategoryPic());
		stmt.setInt(2, paramCategory.getCategoryId());
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public void deleteCategory(Category paramCategory) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM category WHERE category_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramCategory.getCategoryId());
		System.out.println(stmt+"<-stmt");
		
		stmt.executeUpdate();
		
		conn.close();
	}
}
