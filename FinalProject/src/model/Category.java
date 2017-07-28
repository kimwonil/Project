package model;

public class Category {

	private int no;
	private String category_name;
	
	public Category() {
		super();
	}
	public Category(int no, String category_name) {
		super();
		this.no = no;
		this.category_name = category_name;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	@Override
	public String toString() {
		return "Category [no=" + no + ", category_name=" + category_name + "]";
	}
	
	
}
