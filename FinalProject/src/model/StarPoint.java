package model;

public class StarPoint {
	
	
	private int no;
	private int board_no;
	private int purchase;
	private String content;
	private int star;
	private String date;
	private String nickname;
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getPurchase() {
		return purchase;
	}
	public void setPurchase(int purchase) {
		this.purchase = purchase;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	@Override
	public String toString() {
		return "StarPoint [no=" + no + ", board_no=" + board_no + ", purchase=" + purchase + ", content=" + content
				+ ", star=" + star + ", date=" + date + ", nickname=" + nickname + "]";
	}
	
	

}
