package model;

public class Member {
	private String id;
	private String nickname;
	private String photo;
	private int balance;
	private int admin;
	private String account;
	private String bank;
	private int login;
	private String code;
	private int amount;
	private String introduce;
	
	public void refillCash(int refillCash) {
		this.amount = refillCash;
		this.balance += refillCash;
	}
	
	public Member() {
		super();
	}
	
	public Member(String id, String nickname, String photo, int balance, int admin, int login) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.photo = photo;
		this.balance = balance;
		this.admin = admin;
		this.login = login;
	}
	
	public Member(String id, String nickname, String photo, int balance, int admin) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.photo = photo;
		this.balance = balance;
		this.admin = admin;
	}
	public Member(String id, String nickname, String photo, int balance, int admin, String account, String bank,
			int login, String code, int amount) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.photo = photo;
		this.balance = balance;
		this.admin = admin;
		this.account = account;
		this.bank = bank;
		this.login = login;
		this.code = code;
		this.amount = amount;
	}

	
		
	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
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
				+ admin + ", code=" + code + ", amount=" + amount + ", login=" + login + "]";
	}

	
	
}
