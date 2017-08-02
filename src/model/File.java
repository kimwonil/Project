package model;

public class File {
	private int file_no;
	private int no;//글번호
	private String file_name1;
	private String file_name2;
	private String file_name3;
	private String file_name4;
	
	
	
	
	public File() {
		super();
	}
	
	
	public File(int file_no, int no, String file_name1, String file_name2, String file_name3, String file_name4) {
		super();
		this.file_no = file_no;
		this.no = no;
		this.file_name1 = file_name1;
		this.file_name2 = file_name2;
		this.file_name3 = file_name3;
		this.file_name4 = file_name4;
	}
	
	
	public int getFile_no() {
		return file_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getFile_name1() {
		return file_name1;
	}
	public void setFile_name1(String file_name1) {
		this.file_name1 = file_name1;
	}
	public String getFile_name2() {
		return file_name2;
	}
	public void setFile_name2(String file_name2) {
		this.file_name2 = file_name2;
	}
	public String getFile_name3() {
		return file_name3;
	}
	public void setFile_name3(String file_name3) {
		this.file_name3 = file_name3;
	}
	public String getFile_name4() {
		return file_name4;
	}
	public void setFile_name4(String file_name4) {
		this.file_name4 = file_name4;
	}
	
	
	@Override
	public String toString() {
		return "File [file_no=" + file_no + ", no=" + no + ", file_name1=" + file_name1 + ", file_name2=" + file_name2
				+ ", file_name3=" + file_name3 + ", file_name4=" + file_name4 + "]";
	}
	
	
	

}
