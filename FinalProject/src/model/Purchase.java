package model;

import java.util.List;

public class Purchase {
	private int purchase_no;
	private int no;
	private String purchaser;
	private int state;
	private List<PurchaseOption> optionList;
	
	
	public Purchase() {
		super();
	}
	public Purchase(int purchase_no, int no, String purchaser, int state, List<PurchaseOption> optionList) {
		super();
		this.purchase_no = purchase_no;
		this.no = no;
		this.purchaser = purchaser;
		this.state = state;
		this.optionList = optionList;
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
				+ ", optionList=" + optionList + "]";
	}
	
	

}
