package dao;

import java.util.*;
import java.sql.*;

import commons.DBUtil;
import commons.ListPage;
import vo.*;

public class ProductDao {
	public ArrayList<ProductAndCategory> selectProductListWithPageDesc(ListPage listPage) throws Exception {
		ArrayList<ProductAndCategory> returnList = new ArrayList<ProductAndCategory>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT product.product_id, product.category_id, category.category_name, product.product_name, product.product_price, product.product_soldout "
					+"FROM product INNER JOIN category ON product.category_id=category.category_id ORDER BY product.product_id DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, listPage.getQueryIndex());
		stmt.setInt(2, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			ProductAndCategory productAndCategory = new ProductAndCategory();
			productAndCategory.setProduct(new Product());
			productAndCategory.setCategory(new Category());
			productAndCategory.getProduct().setProductId(rs.getInt("product.product_id"));
			productAndCategory.getProduct().setCategoryId(rs.getInt("product.category_id"));
			productAndCategory.getCategory().setCategoryName(rs.getString("category.category_name"));
			productAndCategory.getProduct().setProductName(rs.getString("product.product_name"));
			productAndCategory.getProduct().setProductPrice(rs.getInt("product.product_price"));
			productAndCategory.getProduct().setProductSoldout(rs.getString("product.product_soldout"));
			
			returnList.add(productAndCategory);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectProductCount() throws Exception {
		int returnCount = 0;

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM product";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<ProductAndCategory> selectProductListWithPageDescAndSearch(ListPage listPage, Product paramProduct) throws Exception {
		if (paramProduct.getCategoryId() == -1 && paramProduct.getProductName().equals("") && paramProduct.getProductSoldout().equals("")) {
			return selectProductListWithPageDesc(listPage);
		} else if (paramProduct.getCategoryId() != -1 && paramProduct.getProductName().equals("") && paramProduct.getProductSoldout().equals("")) {
			return selectProductListWithPageDescSearchByCategoryId(listPage, paramProduct);
		} else if (paramProduct.getCategoryId() == -1 && !paramProduct.getProductName().equals("") && paramProduct.getProductSoldout().equals("")) {
			return selectProductListWithPageDescSearchByProductName(listPage, paramProduct);
		} else if (paramProduct.getCategoryId() == -1 && paramProduct.getProductName().equals("") && !paramProduct.getProductSoldout().equals("")) {
			return selectProductListWithPageDescSearchByProductSoldout(listPage, paramProduct);
		} else if (paramProduct.getCategoryId() != -1 && !paramProduct.getProductName().equals("") && paramProduct.getProductSoldout().equals("")) {
			return selectProductListWithPageDescSearchByCategoryIdAndProductName(listPage, paramProduct);
		} else if (paramProduct.getCategoryId() != -1 && paramProduct.getProductName().equals("") && !paramProduct.getProductSoldout().equals("")) {
			return selectProductListWithPageDescSearchByCategoryIdAndProductSoldout(listPage, paramProduct);
		} else if (paramProduct.getCategoryId() == -1 && !paramProduct.getProductName().equals("") && !paramProduct.getProductSoldout().equals("")) {
			return selectProductListWithPageDescSearchByProductNameAndProductSoldout(listPage, paramProduct);
		} else if (paramProduct.getCategoryId() != -1 && !paramProduct.getProductName().equals("") && !paramProduct.getProductSoldout().equals("")) {
			return selectProductListWithPageDescSearchByCategoryIdAndProductNameAndProductSoldout(listPage, paramProduct);
		} else {
			return null;
		}
	}

	public int selectProductCountWithSearch(Product paramProduct) throws Exception {
		if (paramProduct.getCategoryId() == -1 && paramProduct.getProductName().equals("") && paramProduct.getProductSoldout().equals("")) {
			return selectProductCount();
		} else if (paramProduct.getCategoryId() != -1 && paramProduct.getProductName().equals("") && paramProduct.getProductSoldout().equals("")) {
			return selectProductCountSearchByCategoryId(paramProduct);
		} else if (paramProduct.getCategoryId() == -1 && !paramProduct.getProductName().equals("") && paramProduct.getProductSoldout().equals("")) {
			return selectProductCountSearchByProductName(paramProduct);
		} else if (paramProduct.getCategoryId() == -1 && paramProduct.getProductName().equals("") && !paramProduct.getProductSoldout().equals("")) {
			return selectProductCountSearchByProductSoldout(paramProduct);
		} else if (paramProduct.getCategoryId() != -1 && !paramProduct.getProductName().equals("") && paramProduct.getProductSoldout().equals("")) {
			return selectProductCountSearchByCategoryIdAndProductName(paramProduct);
		} else if (paramProduct.getCategoryId() != -1 && paramProduct.getProductName().equals("") && !paramProduct.getProductSoldout().equals("")) {
			return selectProductCountSearchByCategoryIdAndProductSoldout(paramProduct);
		} else if (paramProduct.getCategoryId() == -1 && !paramProduct.getProductName().equals("") && !paramProduct.getProductSoldout().equals("")) {
			return selectProductCountSearchByProductNameAndProductSoldout(paramProduct);
		} else if (paramProduct.getCategoryId() != -1 && !paramProduct.getProductName().equals("") && !paramProduct.getProductSoldout().equals("")) {
			return selectProductCountSearchByCategoryIdAndProductNameAndProductSoldout(paramProduct);
		} else {
			return -1;
		}
	}
	
	public ArrayList<ProductAndCategory> selectProductListWithPageDescSearchByCategoryId(ListPage listPage, Product paramProduct) throws Exception {
		ArrayList<ProductAndCategory> returnList = new ArrayList<ProductAndCategory>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT product.product_id, category.category_name, product.product_name, product.product_price, product.product_soldout "
					+"FROM product INNER JOIN category ON product.category_id=category.category_id WHERE product.category_id=? ORDER BY product.product_id DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getCategoryId());
		stmt.setInt(2, listPage.getQueryIndex());
		stmt.setInt(3, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			ProductAndCategory productAndCategory = new ProductAndCategory();
			productAndCategory.setProduct(new Product());
			productAndCategory.setCategory(new Category());
			productAndCategory.getProduct().setProductId(rs.getInt("product.product_id"));
			productAndCategory.getProduct().setCategoryId(paramProduct.getCategoryId());
			productAndCategory.getCategory().setCategoryName(rs.getString("category.category_name"));
			productAndCategory.getProduct().setProductName(rs.getString("product.product_name"));
			productAndCategory.getProduct().setProductPrice(rs.getInt("product.product_price"));
			productAndCategory.getProduct().setProductSoldout(rs.getString("product.product_soldout"));
			
			returnList.add(productAndCategory);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectProductCountSearchByCategoryId(Product paramProduct) throws Exception {
		int returnCount = 0;

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM product WHERE category_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getCategoryId());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<ProductAndCategory> selectProductListWithPageDescSearchByProductName(ListPage listPage, Product paramProduct) throws Exception {
		ArrayList<ProductAndCategory> returnList = new ArrayList<ProductAndCategory>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT product.product_id, product.category_id, category.category_name, product.product_name, product.product_price, product.product_soldout "
					+"FROM product INNER JOIN category ON product.category_id=category.category_id WHERE product.product_name LIKE ? ORDER BY product.product_id DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramProduct.getProductName()+"%");
		stmt.setInt(2, listPage.getQueryIndex());
		stmt.setInt(3, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			ProductAndCategory productAndCategory = new ProductAndCategory();
			productAndCategory.setProduct(new Product());
			productAndCategory.setCategory(new Category());
			productAndCategory.getProduct().setProductId(rs.getInt("product.product_id"));
			productAndCategory.getProduct().setCategoryId(rs.getInt("product.category_id"));
			productAndCategory.getCategory().setCategoryName(rs.getString("category.category_name"));
			productAndCategory.getProduct().setProductName(rs.getString("product.product_name"));
			productAndCategory.getProduct().setProductPrice(rs.getInt("product.product_price"));
			productAndCategory.getProduct().setProductSoldout(rs.getString("product.product_soldout"));
			
			returnList.add(productAndCategory);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectProductCountSearchByProductName(Product paramProduct) throws Exception {
		int returnCount = 0;

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM product WHERE product_name LIKE ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramProduct.getProductName()+"%");
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<ProductAndCategory> selectProductListWithPageDescSearchByProductSoldout(ListPage listPage, Product paramProduct) throws Exception {
		ArrayList<ProductAndCategory> returnList = new ArrayList<ProductAndCategory>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT product.product_id, product.category_id, category.category_name, product.product_name, product.product_price "
					+"FROM product INNER JOIN category ON product.category_id=category.category_id WHERE product.product_soldout=? ORDER BY product.product_id DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramProduct.getProductSoldout());
		stmt.setInt(2, listPage.getQueryIndex());
		stmt.setInt(3, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			ProductAndCategory productAndCategory = new ProductAndCategory();
			productAndCategory.setProduct(new Product());
			productAndCategory.setCategory(new Category());
			productAndCategory.getProduct().setProductId(rs.getInt("product.product_id"));
			productAndCategory.getProduct().setCategoryId(rs.getInt("product.category_id"));
			productAndCategory.getCategory().setCategoryName(rs.getString("category.category_name"));
			productAndCategory.getProduct().setProductName(rs.getString("product.product_name"));
			productAndCategory.getProduct().setProductPrice(rs.getInt("product.product_price"));
			productAndCategory.getProduct().setProductSoldout(paramProduct.getProductSoldout());
			
			returnList.add(productAndCategory);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectProductCountSearchByProductSoldout(Product paramProduct) throws Exception {
		int returnCount = 0;

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM product WHERE product_soldout=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramProduct.getProductSoldout());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<ProductAndCategory> selectProductListWithPageDescSearchByCategoryIdAndProductName(ListPage listPage, Product paramProduct) throws Exception {
		ArrayList<ProductAndCategory> returnList = new ArrayList<ProductAndCategory>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT product.product_id, category.category_name, product.product_price, product.product_name, product.product_soldout "
					+"FROM product INNER JOIN category ON product.category_id=category.category_id "
					+"WHERE product.category_id=? AND product.product_name LIKE ? ORDER BY product.product_id DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getCategoryId());
		stmt.setString(2, "%"+paramProduct.getProductName()+"%");
		stmt.setInt(3, listPage.getQueryIndex());
		stmt.setInt(4, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			ProductAndCategory productAndCategory = new ProductAndCategory();
			productAndCategory.setProduct(new Product());
			productAndCategory.setCategory(new Category());
			productAndCategory.getProduct().setProductId(rs.getInt("product.product_id"));
			productAndCategory.getProduct().setCategoryId(paramProduct.getCategoryId());
			productAndCategory.getCategory().setCategoryName(rs.getString("category.category_name"));
			productAndCategory.getProduct().setProductName(rs.getString("product.product_name"));
			productAndCategory.getProduct().setProductPrice(rs.getInt("product.product_price"));
			productAndCategory.getProduct().setProductSoldout(rs.getString("product.product_soldout"));
			
			returnList.add(productAndCategory);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectProductCountSearchByCategoryIdAndProductName(Product paramProduct) throws Exception {
		int returnCount = 0;

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM product WHERE category_id=? AND product_name LIKE ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getCategoryId());
		stmt.setString(2, "%"+paramProduct.getProductName()+"%");
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<ProductAndCategory> selectProductListWithPageDescSearchByCategoryIdAndProductSoldout(ListPage listPage, Product paramProduct) throws Exception {
		ArrayList<ProductAndCategory> returnList = new ArrayList<ProductAndCategory>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT product.product_id, category.category_name, product.product_name, product.product_price "
					+"FROM product INNER JOIN category ON product.category_id=category.category_id "
					+"WHERE product.category_id=? AND product.product_soldout=? ORDER BY product.product_id DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getCategoryId());
		stmt.setString(2, paramProduct.getProductSoldout());
		stmt.setInt(3, listPage.getQueryIndex());
		stmt.setInt(4, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			ProductAndCategory productAndCategory = new ProductAndCategory();
			productAndCategory.setProduct(new Product());
			productAndCategory.setCategory(new Category());
			productAndCategory.getProduct().setProductId(rs.getInt("product.product_id"));
			productAndCategory.getProduct().setCategoryId(paramProduct.getCategoryId());
			productAndCategory.getCategory().setCategoryName(rs.getString("category.category_name"));
			productAndCategory.getProduct().setProductName(rs.getString("product.product_name"));
			productAndCategory.getProduct().setProductPrice(rs.getInt("product.product_price"));
			productAndCategory.getProduct().setProductSoldout(paramProduct.getProductSoldout());
			
			returnList.add(productAndCategory);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectProductCountSearchByCategoryIdAndProductSoldout(Product paramProduct) throws Exception {
		int returnCount = 0;

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM product WHERE category_id=? AND product_soldout=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getCategoryId());
		stmt.setString(2, paramProduct.getProductSoldout());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<ProductAndCategory> selectProductListWithPageDescSearchByProductNameAndProductSoldout(ListPage listPage, Product paramProduct) throws Exception {
		ArrayList<ProductAndCategory> returnList = new ArrayList<ProductAndCategory>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT product.product_id, product.category_id, category.category_name, product.product_name, product.product_price "
					+"FROM product INNER JOIN category ON product.category_id=category.category_id "
					+"WHERE product.product_name LIKE ? AND product.product_soldout=? ORDER BY product.product_id DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramProduct.getProductName()+"%");
		stmt.setString(2, paramProduct.getProductSoldout());
		stmt.setInt(3, listPage.getQueryIndex());
		stmt.setInt(4, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			ProductAndCategory productAndCategory = new ProductAndCategory();
			productAndCategory.setProduct(new Product());
			productAndCategory.setCategory(new Category());
			productAndCategory.getProduct().setProductId(rs.getInt("product.product_id"));
			productAndCategory.getProduct().setCategoryId(rs.getInt("product.category_id"));
			productAndCategory.getCategory().setCategoryName(rs.getString("category.category_name"));
			productAndCategory.getProduct().setProductName(rs.getString("product.product_name"));
			productAndCategory.getProduct().setProductPrice(rs.getInt("product.product_price"));
			productAndCategory.getProduct().setProductSoldout(paramProduct.getProductSoldout());
			
			returnList.add(productAndCategory);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectProductCountSearchByProductNameAndProductSoldout(Product paramProduct) throws Exception {
		int returnCount = 0;

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM product WHERE product_name LIKE ? AND product_soldout=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+paramProduct.getProductName()+"%");
		stmt.setString(2, paramProduct.getProductSoldout());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<ProductAndCategory> selectProductListWithPageDescSearchByCategoryIdAndProductNameAndProductSoldout(ListPage listPage, Product paramProduct) throws Exception {
		ArrayList<ProductAndCategory> returnList = new ArrayList<ProductAndCategory>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT product.product_id, category.category_name, product.product_name, product.product_price "
					+"FROM product INNER JOIN category ON product.category_id=category.category_id "
					+"WHERE product.category_id=? AND product.product_name LIKE ? AND product.product_soldout=? ORDER BY product.product_id DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getCategoryId());
		stmt.setString(2, "%"+paramProduct.getProductName()+"%");
		stmt.setString(3, paramProduct.getProductSoldout());
		stmt.setInt(4, listPage.getQueryIndex());
		stmt.setInt(5, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			ProductAndCategory productAndCategory = new ProductAndCategory();
			productAndCategory.setProduct(new Product());
			productAndCategory.setCategory(new Category());
			productAndCategory.getProduct().setProductId(rs.getInt("product.product_id"));
			productAndCategory.getProduct().setCategoryId(paramProduct.getCategoryId());
			productAndCategory.getCategory().setCategoryName(rs.getString("category.category_name"));
			productAndCategory.getProduct().setProductName(rs.getString("product.product_name"));
			productAndCategory.getProduct().setProductPrice(rs.getInt("product.product_price"));
			productAndCategory.getProduct().setProductSoldout(paramProduct.getProductSoldout());
			
			returnList.add(productAndCategory);
		}
		
		conn.close();
		
		return returnList;
	}
	
	public int selectProductCountSearchByCategoryIdAndProductNameAndProductSoldout(Product paramProduct) throws Exception {
		int returnCount = 0;

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM product WHERE category_id=? AND product_name LIKE ? AND product_soldout=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getCategoryId());
		stmt.setString(2, "%"+paramProduct.getProductName()+"%");
		stmt.setString(3, paramProduct.getProductSoldout());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public Product selectProductOne(Product paramProduct) throws Exception {
		Product returnProduct = null;

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT category_id, product_name, product_price, product_content, product_soldout, product_pic FROM product WHERE product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getProductId());

		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			returnProduct = new Product();
			returnProduct.setProductId(paramProduct.getProductId());
			returnProduct.setCategoryId(rs.getInt("category_id"));
			returnProduct.setProductName(rs.getString("product_name"));
			returnProduct.setProductPrice(rs.getInt("product_price"));
			returnProduct.setProductContent(rs.getString("product_content"));
			returnProduct.setProductSoldout(rs.getString("product_soldout"));
		}
		
		conn.close();
		
		return returnProduct;
	}
	
	public ProductAndCategory selectProductAndCategoryOne(Product paramProduct) throws Exception {
		ProductAndCategory returnProductAndCategory = new ProductAndCategory();
		returnProductAndCategory.setProduct(new Product());
		returnProductAndCategory.setCategory(new Category());

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT product.category_id, category.category_name, product.product_name, product.product_price, product.product_content, product.product_soldout, product.product_pic "
					+"FROM product INNER JOIN category ON product.category_id=category.category_id WHERE product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getProductId());

		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			returnProductAndCategory.getProduct().setProductId(paramProduct.getProductId());
			returnProductAndCategory.getProduct().setCategoryId(rs.getInt("product.category_id"));
			returnProductAndCategory.getCategory().setCategoryName(rs.getString("category.category_name"));
			returnProductAndCategory.getProduct().setProductName(rs.getString("product.product_name"));
			returnProductAndCategory.getProduct().setProductPrice(rs.getInt("product.product_price"));
			returnProductAndCategory.getProduct().setProductContent(rs.getString("product.product_content"));
			returnProductAndCategory.getProduct().setProductSoldout(rs.getString("product.product_soldout"));
			returnProductAndCategory.getProduct().setProductPic(rs.getString("product.product_pic"));
		}
		
		conn.close();
		
		return returnProductAndCategory;
	}
	
	public void insertProduct(Product paramProduct) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO product(category_id, product_name, product_price, product_content, product_soldout, product_pic) VALUES(?, ?, ?, ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getCategoryId());
		stmt.setString(2, paramProduct.getProductName());
		stmt.setInt(3, paramProduct.getProductPrice());
		stmt.setString(4, paramProduct.getProductContent());
		stmt.setString(5, paramProduct.getProductSoldout());
		stmt.setString(6, paramProduct.getProductPic());
		System.out.println(stmt+"<-stmt");
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public void updateProduct(Product paramProduct) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE product SET category_id=?, product_name=?, product_price=?, product_content=? WHERE product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getCategoryId());
		stmt.setString(2, paramProduct.getProductName());
		stmt.setInt(3, paramProduct.getProductPrice());
		stmt.setString(4, paramProduct.getProductContent());
		stmt.setInt(5, paramProduct.getProductId());
		System.out.println(stmt+"<-stmt");
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public void updateProductSoldout(Product paramProduct) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE product SET product_soldout=? WHERE product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramProduct.getProductSoldout());
		stmt.setInt(2, paramProduct.getProductId());
		System.out.println(stmt+"<-stmt");
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public void updateProductPic(Product paramProduct) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE product SET product_pic=? WHERE product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramProduct.getProductPic());
		stmt.setInt(2, paramProduct.getProductId());
		System.out.println(stmt+"<-stmt");
		
		stmt.executeUpdate();
		
		conn.close();
	}

	public void deleteProduct(Product paramProduct) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM product WHERE product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramProduct.getProductId());
		System.out.println(stmt+"<-stmt");
		
		stmt.executeUpdate();
		
		conn.close();
	}
}
