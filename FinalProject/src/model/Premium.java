package model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Premium {
	private int no;
	private int board_no;
	private String title;
	private int time;
	private int price;
	private String formatPrice;
	private String nickname;
	private int state;
	private String date;
	private Date start_date;
	private Date end_date;
	private String start;
	private String end;
	
	
	public void strDate() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		start = format.format(start_date);
		end = format.format(end_date);
	}
	
	
	
	
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	
	
	public String getFormatPrice() {
		return formatPrice;
	}
	public void setFormatPrice(String formatPrice) {
		this.formatPrice = formatPrice;
	}
	@Override
	public String toString() {
		return "Premium [no=" + no + ", board_no=" + board_no + ", title=" + title + ", time=" + time + ", price="
				+ price + ", nickname=" + nickname + ", state=" + state + ", date=" + date + "]";
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Premium() {
		super();
	}
	public Premium(int no, int board_no, int time, int price, String nickname, int state, String date) {
		super();
		this.no = no;
		this.board_no = board_no;
		this.time = time;
		this.price = price;
		this.nickname = nickname;
		this.state = state;
		this.date = date;
	}
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
	public int getTime() {
		return time;
	}
	public void setTime(int time) {
		this.time = time;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
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
	
	
}
