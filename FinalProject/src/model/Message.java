package model;

public class Message {
	private int no;
	private String sender;
	private String receiver;
	private String title;
	private String content;
	private int state;
	private String date;
	
	
	
	public Message() {
		super();
	}
	public Message(String sender, String receiver, String title, String content) {
		this.sender = sender;
		this.receiver = receiver;
		this.title = title;
		this.content = content;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "Message [no=" + no + ", sender=" + sender + ", receiver=" + receiver + ", title=" + title + ", content="
				+ content + ", state=" + state + ", date=" + date + "]";
	}
	
	
	
	
}
