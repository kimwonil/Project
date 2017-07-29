package model;

import java.util.Date;

public class Report {
	private int no;
	private String date;
	private int category_no;	
	private String title;
	private int state;
	private int read_count;
	private String content;
	private String writer;
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
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	@Override
	public String toString() {
		return "Report [no=" + no + ", date=" + date + ", category_no=" + category_no + ", title=" + title + ", state="
				+ state + ", read_count=" + read_count + ", content=" + content + ", writer=" + writer + "]";
	}
	
	
}
