package model;

public class MapInfo {
	private int no; //글번호
	private int x; //longitude 경도
	private int y; //latitude 위도
	private String title; //목적지
	private String address; //주소
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public void setY(int y) {
		this.y = y;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	
	@Override
	public String toString() {
		return "Map [no=" + no + ", x=" + x + ", y=" + y + ", title=" + title + ", address=" + address + "]";
	}
	
	
	
	

}
