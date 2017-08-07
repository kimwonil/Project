package dao;

import java.util.HashMap;
import java.util.List;

import model.Board;
import model.Purchase;
import model.PurchaseOption;

public interface DealDao {
	public List<Board> selectAll(HashMap<String, Object> map);
	public int purchaseCount(int no);
	public List<Purchase> purchaseList(int no);
	public List<PurchaseOption> purchaseOption(int no);
	public int progressState(HashMap<String, Object> map);
	public List<Purchase> purchaseList(String id);
	
	public List<Purchase> purchase(HashMap<String, Object> map);
	public int totalPagePurchase(String id);

	public List<Purchase> purchaseManager(HashMap<String, Object> map);
	public int totalPagePurchaseManager();
	
	public Board boardInfo(int no);
	public List<Purchase> purchaseComplete(HashMap<String, Object> map);
	public int totalPagePurchaseComplete(String id);
	public List<Purchase> purchaseCompleteManager(HashMap<String, Object> map);
	public int totalPagePurchaseCompleteManager();
	public List<Purchase> purchaseCanceledManager(HashMap<String, Object> map);
	public int totalPagePurchaseCanceledManager();
	
	public List<Purchase> purchaseCanceled(HashMap<String, Object> map);
	public int totalPagePurchaseCanceled(String id);
	
	public int totalPageSelling(String id);
	public int totalPageOngoing(String id);
	public int totalPageCompletion(String id);
	public int totalPageCanceled(String id);
	
	public List<Purchase> ongoingPurcharse(HashMap<String, Object> map);
	public List<Purchase> completionPurcharse(HashMap<String, Object> map);
	public List<Purchase> canceledPurcharse(HashMap<String, Object> map);
	public String selectOneBoard(int no);
	
	public int calculate(HashMap<String, Object> map);
	public int recordCashInfo(HashMap<String, Object> map);
	public int recordCash(HashMap<String, Object> map);

	
	public List<Board> selectAllManager(HashMap<String, Object> map);
	public int totalPageSellingManager();
	public List<Purchase> ongoingPurcharseManager(HashMap<String, Object> map);
	public int totalPageOngoingManager();
	public List<Purchase> completionPurcharseManager(HashMap<String, Object> map);
	public int totalPageCompletionManager();
	public List<Purchase> canceledPurcharseManager(HashMap<String, Object> map);
	public int totalPageCanceledManager();
	
	
	//테이블명 : purchase
	public void insertPurchase(Purchase purchase);
	
	
	//purchase_option
	public boolean insertPurchaseOption(PurchaseOption option);
	
	
	//profile
	public boolean minusCash(HashMap<String, Object> params);
	
	
	//star_point
	public boolean insertStar_point(HashMap<String, Object> map);
	
	
	
	public int optionTotal(Integer no);
	public String purchaseName(Integer no);
	
	
	
	
	
	

}
