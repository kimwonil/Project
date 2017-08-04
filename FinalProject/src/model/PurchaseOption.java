package model;

public class PurchaseOption {
	private int purchase_no;
	private int no;
	private String kind;
	private int price;
	private int amount;
	
	
	
	public PurchaseOption() {
		super();
	}
	public PurchaseOption(int purchase_no, int no, String kind, int price, int amount) {
		super();
		this.purchase_no = purchase_no;
		this.no = no;
		this.kind = kind;
		this.price = price;
		this.amount = amount;
	}
	public int getPurchase_no() {
		return purchase_no;
	}
	public void setPurchase_no(int purchase_no) {
		this.purchase_no = purchase_no;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	@Override
	public String toString() {
		return "purchaseOption [purchase_no=" + purchase_no + ", no=" + no + ", kind=" + kind + ", price=" + price
				+ ", amount=" + amount + "]";
	}
}
