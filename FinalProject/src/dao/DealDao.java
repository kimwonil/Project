package dao;

import java.util.HashMap;
import java.util.List;

import model.Board;
import model.Purchase;
import model.PurchaseOption;

public interface DealDao {
	public List<Board> selectAll(String id);
	public int purchaseCount(int no);
	public List<Purchase> purchaseList(int no);
	public List<PurchaseOption> purchaseOption(int no);
	public int progressState(HashMap<String, Object> map);
	public List<Purchase> purchaseList(String id);
	public List<Purchase> purchase(String id);
	public Board boardInfo(int no);
	public List<Purchase> ongoingPurcharse(int no);
	public List<Purchase> completionPurcharse(int no);
<<<<<<< HEAD
	

	//테이블명 : purchase
	public void insertPurchase(Purchase purchase);
	
	
	//purchase_option
	public boolean insertPurchaseOption(PurchaseOption option);
	
	
	//profile
	public boolean minusCash(HashMap<String, Object> params);

=======
	public List<Purchase> purchaseComplete(String id);
>>>>>>> wonil
}
