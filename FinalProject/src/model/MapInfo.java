package model;

public class MapInfo {
<<<<<<< HEAD
	private int no; //글번호
	private int x; //longitude 경도
	private int y; //latitude 위도
	private String title; //목적지
	private String address; //주소
=======
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
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
<<<<<<< HEAD
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
=======
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
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
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
<<<<<<< HEAD
=======
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
	
	
	@Override
	public String toString() {
<<<<<<< HEAD
		return "Map [no=" + no + ", x=" + x + ", y=" + y + ", title=" + title + ", address=" + address + "]";
=======
		return "MapInfo [no=" + no + ", board_no=" + board_no + ", lat=" + lat + ", lng=" + lng + ", title=" + title
				+ ", address=" + address + ", address2=" + address2 + "]";
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
	}
	
	
	
	

<<<<<<< HEAD
=======
	
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
}
