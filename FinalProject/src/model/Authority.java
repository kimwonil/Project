package model;

public class Authority {
	private int no;
	private String id;
	private int category_no;
	private String date;
	private int state;
	private String file1;
	private String file2;
	private String file3;
	
	
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
	
	


	public Authority(int no, String id, int category_no, String date, int state, String file1, String file2,
			String file3) {
		super();
		this.no = no;
		this.id = id;
		this.category_no = category_no;
		this.date = date;
		this.state = state;
		this.file1 = file1;
		this.file2 = file2;
		this.file3 = file3;
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

	
	
	
	public String getFile1() {
		return file1;
	}


	public void setFile1(String file1) {
		this.file1 = file1;
	}


	public String getFile2() {
		return file2;
	}


	public void setFile2(String file2) {
		this.file2 = file2;
	}


	public String getFile3() {
		return file3;
	}


	public void setFile3(String file3) {
		this.file3 = file3;
	}


	@Override
	public String toString() {
		return "Authority [no=" + no + ", id=" + id + ", category_no=" + category_no + ", date=" + date + ", state="
				+ state + ", file1=" + file1 + ", file2=" + file2 + ", file3=" + file3 + "]";
	}


	
	
}
