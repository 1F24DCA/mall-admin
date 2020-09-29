package dao;

import java.util.*;
import java.sql.*;

import commons.*;
import vo.*;

public class OrdersDao {
	public ArrayList<OrdersAndProduct> selectOrdersListWithPageDesc(ListPage listPage) throws Exception {
		ArrayList<OrdersAndProduct> returnList = new ArrayList<OrdersAndProduct>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT orders.orders_id, orders.orders_date, orders.product_id, product.product_name, orders.orders_amount, orders.orders_price, orders.member_email, orders.orders_addr, orders.orders_state "
					+"FROM orders INNER JOIN product ON orders.product_id=product.product_id ORDER BY orders.orders_id DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, listPage.getQueryIndex());
		stmt.setInt(2, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			OrdersAndProduct ordersAndProduct = new OrdersAndProduct();
			ordersAndProduct.setOrders(new Orders());
			ordersAndProduct.setProduct(new Product());
			
			ordersAndProduct.getOrders().setOrdersId(rs.getInt("orders.orders_id"));
			ordersAndProduct.getOrders().setOrdersDate(rs.getString("orders.orders_date"));
			ordersAndProduct.getOrders().setProductId(rs.getInt("orders.product_id"));
			ordersAndProduct.getProduct().setProductName(rs.getString("product.product_name"));
			ordersAndProduct.getOrders().setOrdersAmount(rs.getInt("orders.orders_amount"));
			ordersAndProduct.getOrders().setOrdersPrice(rs.getInt("orders.orders_price"));
			ordersAndProduct.getOrders().setMemberEmail(rs.getString("orders.member_email"));
			ordersAndProduct.getOrders().setOrdersAddr(rs.getString("orders.orders_addr"));
			ordersAndProduct.getOrders().setOrdersState(rs.getString("orders.orders_state"));
			
			returnList.add(ordersAndProduct);
		}
		
		conn.close();
		
		return returnList;
	}

	public int selectOrdersCount() throws Exception {
		int returnCount = 0;

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM orders";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}

	public ArrayList<OrdersAndProduct> selectOrdersListWithPageDescSearchByOrdersState(ListPage listPage, Orders paramOrders) throws Exception {
		ArrayList<OrdersAndProduct> returnList = new ArrayList<OrdersAndProduct>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT orders.orders_id, orders.orders_date, orders.product_id, product.product_name, orders.orders_amount, orders.orders_price, orders.member_email, orders.orders_addr "
					+"FROM orders INNER JOIN product ON orders.product_id=product.product_id WHERE orders_state=? ORDER BY orders.orders_id DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramOrders.getOrdersState());
		stmt.setInt(2, listPage.getQueryIndex());
		stmt.setInt(3, listPage.getRowPerPage());
		System.out.println(stmt+"<-stmt");

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			OrdersAndProduct ordersAndProduct = new OrdersAndProduct();
			ordersAndProduct.setOrders(new Orders());
			ordersAndProduct.setProduct(new Product());
			
			ordersAndProduct.getOrders().setOrdersId(rs.getInt("orders.orders_id"));
			ordersAndProduct.getOrders().setOrdersDate(rs.getString("orders.orders_date"));
			ordersAndProduct.getOrders().setProductId(rs.getInt("orders.product_id"));
			ordersAndProduct.getProduct().setProductName(rs.getString("product.product_name"));
			ordersAndProduct.getOrders().setOrdersAmount(rs.getInt("orders.orders_amount"));
			ordersAndProduct.getOrders().setOrdersPrice(rs.getInt("orders.orders_price"));
			ordersAndProduct.getOrders().setMemberEmail(rs.getString("orders.member_email"));
			ordersAndProduct.getOrders().setOrdersAddr(rs.getString("orders.orders_addr"));
			ordersAndProduct.getOrders().setOrdersState(paramOrders.getOrdersState());
			
			returnList.add(ordersAndProduct);
		}
		
		conn.close();
		
		return returnList;
	}

	public int selectOrdersCountSearchByOrdersState(Orders paramOrders) throws Exception {
		int returnCount = 0;

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM orders WHERE orders_state=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramOrders.getOrdersState());
		System.out.println(stmt+"<-stmt");
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnCount = rs.getInt("COUNT(*)");
		}
		
		conn.close();
		
		return returnCount;
	}
	
	public ArrayList<String> selectOrdersStateListExist() throws Exception {
		ArrayList<String> returnList = new ArrayList<String>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT DISTINCT orders_state FROM orders";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"<-stmt");

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			returnList.add(rs.getString("orders_state"));
		}
		
		conn.close();
		
		return returnList;
	}
	
	public ArrayList<String> selectOrdersStateListAll() throws Exception {
		ArrayList<String> returnList = new ArrayList<String>();

		returnList.add("결제완료");
		returnList.add("배송준비중");
		returnList.add("배송완료");
		returnList.add("주문취소");
		
		return returnList;
	}
	
	public Orders selectOrdersOne(Orders paramOrders) throws Exception {
		Orders returnOrders = new Orders();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT product_id, orders_date, orders_amount, orders_price, member_email, orders_addr, orders_state FROM orders WHERE orders_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramOrders.getOrdersId());
		System.out.println(stmt+"<-stmt");

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnOrders.setOrdersId(paramOrders.getOrdersId());
			returnOrders.setProductId(rs.getInt("product_id"));
			returnOrders.setOrdersDate(rs.getString("orders_date"));
			returnOrders.setOrdersAmount(rs.getInt("orders_amount"));
			returnOrders.setOrdersPrice(rs.getInt("orders_price"));
			returnOrders.setMemberEmail(rs.getString("member_email"));
			returnOrders.setOrdersAddr(rs.getString("orders_addr"));
			returnOrders.setOrdersState(rs.getString("orders_state"));
		}
		
		conn.close();
		
		return returnOrders;
	}
	
	public OrdersAndProduct selectOrdersAndProductOne(Orders paramOrders) throws Exception {
		OrdersAndProduct returnOrdersAndProduct = new OrdersAndProduct();
		returnOrdersAndProduct.setOrders(new Orders());
		returnOrdersAndProduct.setProduct(new Product());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT orders.orders_date, orders.product_id, product.product_name, orders.orders_amount, orders.orders_price, orders.member_email, orders.orders_addr, orders.orders_state "
					+"FROM orders INNER JOIN product ON orders.product_id=product.product_id WHERE orders_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramOrders.getOrdersId());
		System.out.println(stmt+"<-stmt");

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnOrdersAndProduct.getOrders().setOrdersId(paramOrders.getOrdersId());
			returnOrdersAndProduct.getOrders().setOrdersDate(rs.getString("orders.orders_date"));
			returnOrdersAndProduct.getOrders().setProductId(rs.getInt("orders.product_id"));
			returnOrdersAndProduct.getProduct().setProductName(rs.getString("product.product_name"));
			returnOrdersAndProduct.getOrders().setOrdersAmount(rs.getInt("orders.orders_amount"));
			returnOrdersAndProduct.getOrders().setOrdersPrice(rs.getInt("orders.orders_price"));
			returnOrdersAndProduct.getOrders().setMemberEmail(rs.getString("orders.member_email"));
			returnOrdersAndProduct.getOrders().setOrdersAddr(rs.getString("orders.orders_addr"));
			returnOrdersAndProduct.getOrders().setOrdersState(rs.getString("orders.orders_state"));
		}
		
		conn.close();
		
		return returnOrdersAndProduct;
	}
	
	public void updateOrdersState(Orders paramOrders) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE orders SET orders_state=? WHERE orders_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramOrders.getOrdersState());
		stmt.setInt(2, paramOrders.getOrdersId());
		System.out.println(stmt+"<-stmt");

		stmt.executeUpdate();
		
		conn.close();
	}
}
