package vo;

public class Product {
	private int productId;
	private int categoryId;
	private String productName;
	private int productPrice;
	private String productContent;
	private String productSoldout;
	private String productPic;
	
	public int getProductId() {
		return this.productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getCategoryId() {
		return this.categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getProductName() {
		return this.productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductPrice() {
		return this.productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public String getProductContent() {
		return this.productContent;
	}
	public void setProductContent(String productContent) {
		this.productContent = productContent;
	}
	public String getProductSoldout() {
		return this.productSoldout;
	}
	public void setProductSoldout(String productSoldout) {
		this.productSoldout = productSoldout;
	}
	public String getProductPic() {
		return this.productPic;
	}
	public void setProductPic(String productPic) {
		this.productPic = productPic;
	}
}
