package model;

public class EmailInfo {

	private int Emailno;	// PI
	private String Email;	// 이메일주소
	private String nickName; // 닉네임(현재 닉네임, 기본값 : 이메일주소와 동일하게 설정할 예정)
	private int Admin;	// 관리자여부
	
	public EmailInfo(int emailno, String email, String nickName, int admin) {
		super();
		Emailno = emailno;
		Email = email;
		this.nickName = nickName;
		Admin = admin;
	}
	public EmailInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getEmailno() {
		return Emailno;
	}
	public void setEmailno(int emailno) {
		Emailno = emailno;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getAdmin() {
		return Admin;
	}
	public void setAdmin(int admin) {
		Admin = admin;
	}
	@Override
	public String toString() {
		return "EmailInfo [Emailno=" + Emailno + ", Email=" + Email + ", nickName=" + nickName + ", Admin=" + Admin
				+ "]";
	}
	
	
	
}
