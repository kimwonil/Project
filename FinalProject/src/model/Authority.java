package model;

public class Authority {
	private int no;
	private String id;
	private int category_no;
	private String date;
	private int state;
	
	
	public Authority() {
		super();
	}


	public Authority(int no, String id, int category_no, String date, int state) {
		super();
		this.no = no;
		this.id = id;
		this.category_no = category_no;
		this.date = date;
		this.state = state;
	}


	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public int getCategory_no() {
		return category_no;
	}


	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public int getState() {
		return state;
	}


	public void setState(int state) {
		this.state = state;
	}


	@Override
	public String toString() {
		return "authority [no=" + no + ", id=" + id + ", category_no=" + category_no + ", date=" + date + ", state="
				+ state + "]";
	}
	
	
}
