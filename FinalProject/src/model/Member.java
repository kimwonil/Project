package model;

public class Member {
	private String id;
	private String nickName;
	private String photo;
	private int balance;
	private int admin;
	
	
	public Member() {
		super();
	}

	public Member(String id, String nickName, String photo, int balance, int admin) {
		super();
		this.id = id;
		this.nickName = nickName;
		this.photo = photo;
		this.balance = balance;
		this.admin = admin;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
	public int getAdmin() {
		return admin;
	}
	public void setAdmin(int admin) {
		this.admin = admin;
	}

	@Override
	public String toString() {
		return "member [id=" + id + ", nickName=" + nickName + ", photo=" + photo + ", balance=" + balance + ", admin="
				+ admin + "]";
	}
	
	
}
