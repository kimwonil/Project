package model;

import java.util.Date;

public class Answer {
	private int no;
	private int qna_no;
	private String date;
	private String content;
	private String writer;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getQna_no() {
		return qna_no;
	}
	public void setQna_no(int qna_no) {
		this.qna_no = qna_no;
	}
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
		return "Answer [no=" + no + ", qna_no=" + qna_no + ", date=" + date + ", content=" + content + ", writer="
				+ writer + "]";
	}
	
	
}
