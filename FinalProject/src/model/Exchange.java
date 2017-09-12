package model;

public class Exchange {

	private int no;
	private String date;
	private int request;
	private int balance;
	private int state;
	private String nickname;
	
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
	public int getRequest() {
		return request;
	}
	public void setRequest(int request) {
		this.request = request;
	}
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	@Override
	public String toString() {
		return "Exchange [no=" + no + ", date=" + date + ", request=" + request + ", balance=" + balance + ", state="
				+ state + ", nickname=" + nickname + "]";
	}
	
	
	
}
