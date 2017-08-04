package model;

public class Member {
	private String id;
	private String nickname;
	private String photo;
	private int balance;
	private int admin;
	private String code;
	private int amount;
	
	public void refillCash(int refillCash) {
		this.amount = refillCash;
		this.balance += refillCash;
	}
	
	public Member() {
		super();
	}

	public Member(String id, String nickname, String photo, int balance, int admin) {
		super();
		this.id = id;
		this.nickname = nickname;
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
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	@Override
	public String toString() {
		return "Member [id=" + id + ", nickname=" + nickname + ", photo=" + photo + ", balance=" + balance + ", admin="
				+ admin + ", code=" + code + ", amount=" + amount + "]";
	}

	
	
}
