package model;

import java.util.Date;

public class Notice {
	private int no;
	private String date;
	private int category_no;
	private String title;
	private String writer;
	private int read_count;
	private String content;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getCategory_no() {
		return category_no;
	}
	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getRead_count() {
		return read_count;
	}
	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "Notice [no=" + no + ", date=" + date + ", category_no=" + category_no + ", title=" + title + ", writer="
				+ writer + ", read_count=" + read_count + ", content=" + content + "]";
	}

	
	
}
