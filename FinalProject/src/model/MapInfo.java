package model;

public class MapInfo {
	private int no; //번호
	private int board_no; //글번호
	private String lat; //latitude 위도
	private String lng; //longitude 경도
	private String title; //목적지
	private String address; //주소
	private String address2; //주소2
	
	
	
	public MapInfo() {
		super();
	}
	
	
	public MapInfo(int no, int board_no, String lat, String lng, String title, String address, String address2) {
		super();
		this.no = no;
		this.board_no = board_no;
		this.lat = lat;
		this.lng = lng;
		this.title = title;
		this.address = address;
		this.address2 = address2;
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
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
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
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	
	
	@Override
	public String toString() {
		return "MapInfo [no=" + no + ", board_no=" + board_no + ", lat=" + lat + ", lng=" + lng + ", title=" + title
				+ ", address=" + address + ", address2=" + address2 + "]";
	}
	
	
	
	

	
}
