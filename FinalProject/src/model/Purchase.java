package model;

import java.util.List;

public class Purchase {
	private int purchase_no;
	private int no;
	private String boardTitle;
	private String purchaser;
	private String seller;
	private int state;
	private String date;
	private List<PurchaseOption> optionList;
	
	
	public Purchase() {
		super();
	}
	public Purchase(int purchase_no, int no, String purchaser, int state, String date) {
		super();
		this.purchase_no = purchase_no;
		this.no = no;
		this.purchaser = purchaser;
		this.state = state;
		this.date = date;
	}
	
	
	public String getSeller() {
		return seller;
	}
	public void setSeller(String seller) {
		this.seller = seller;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
	public String getPurchaser() {
		return purchaser;
	}
	public void setPurchaser(String purchaser) {
		this.purchaser = purchaser;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public List<PurchaseOption> getOptionList() {
		return optionList;
	}
	public void setOptionList(List<PurchaseOption> optionList) {
		this.optionList = optionList;
	}
	@Override
	public String toString() {
		return "Purchase [purchase_no=" + purchase_no + ", no=" + no + ", purchaser=" + purchaser + ", state=" + state
				+ ", date=" + date + ", optionList=" + optionList + "]";
	}
	
	
	
	

}
