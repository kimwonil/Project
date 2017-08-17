package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.DealDao;
import model.Board;
import model.Purchase;
import model.PurchaseOption;

@Service
public class DealService {

	@Autowired
	DealDao dealDao;
	
	public List<Board> selectAll(HashMap<String, Object> map){
		return dealDao.selectAll(map);
	}
	
	public int purchaseCount(int no) {
		return dealDao.purchaseCount(no);
	}

	public List<Purchase> purchaseList(int no) {
		return dealDao.purchaseList(no);
	}

	public List<PurchaseOption> purchaseOption(int no) {
		return dealDao.purchaseOption(no);
	}

	public int progressState(HashMap<String, Object> map) {
		return dealDao.progressState(map);
	}

	public List<Purchase> purchase(HashMap<String, Object> map) {
		return dealDao.purchase(map);
	}
	
	public List<Purchase> purchaseManager(HashMap<String, Object> map) {
		return dealDao.purchaseManager(map);
	}

	public Board boardInfo(int no) {
		return dealDao.boardInfo(no);
	}

	public List<Purchase> ongoingPurcharse(HashMap<String, Object> map) {
		return dealDao.ongoingPurcharse(map);
	}
	
	public List<Purchase> ongoingPurcharseManager(HashMap<String, Object> map) {
		return dealDao.ongoingPurcharseManager(map);
	}

	public List<Purchase> completionPurcharse(HashMap<String, Object> map) {
		return dealDao.completionPurcharse(map);
	}

	public List<Purchase> purchaseComplete(HashMap<String, Object> map) {
		return dealDao.purchaseComplete(map);
	}
	
	
	/**
	 * table명 : purchase
	 * */
	public void insertPurchase(Purchase purchase) {
		dealDao.insertPurchase(purchase);
	}

	
	/**
	 * table명 : purchase_option
	 * */
	public boolean insertPurchaseOption(PurchaseOption option) {
		return dealDao.insertPurchaseOption(option);
	}

	public boolean minusCash(HashMap<String, Object> params) {
		return dealDao.minusCash(params);
	}

	public boolean insertStar_point(HashMap<String, Object> map) {
		return dealDao.insertStar_point(map);
	}

	public int totalPageSelling(String nickname) {
		return dealDao.totalPageSelling(nickname);
	}

	public int totalPageCompletion(String nickname) {
		return dealDao.totalPageCompletion(nickname);
	}

	public int totalPageOngoing(String nickname) {
		return dealDao.totalPageOngoing(nickname);
	}

	

	public String selectOneBoard(int no) {
		return dealDao.selectOneBoard(no);
	}

	public List<Purchase> canceledPurcharse(HashMap<String, Object> map) {
		return dealDao.canceledPurcharse(map);
	}

	public int totalPageCanceled(String nickname) {
		return dealDao.totalPageCanceled(nickname);
	}

	public int calculate(HashMap<String, Object> map) {
		return dealDao.calculate(map);
	}

	public int recordCash(HashMap<String, Object> map) {
		return dealDao.recordCash(map);
	}

	public int recordCashInfo(HashMap<String, Object> map) {
		return dealDao.recordCashInfo(map);
	}

	public List<Board> selectAllManager(HashMap<String, Object> map) {
		return dealDao.selectAllManager(map);
	}

	public int totalPageSellingManager() {
		return dealDao.totalPageSellingManager();
	}

	public int totalPageOngoingManager() {
		return dealDao.totalPageOngoingManager();
	}

	public List<Purchase> completionPurcharseManager(HashMap<String, Object> map) {
		return dealDao.completionPurcharseManager(map);
	}

	public int totalPageCompletionManager() {
		return dealDao.totalPageOngoingManager();
	}

	public List<Purchase> canceledPurcharseManager(HashMap<String, Object> map) {
		return dealDao.canceledPurcharseManager(map);
	}
	
	public int totalPageCanceledManager() {
		return dealDao.totalPageCanceledManager();
	}

	public int totalPagePurchase(String nickname) {
		return dealDao.totalPagePurchase(nickname);
	}

	public int totalPagePurchaseComplete(String nickname) {
		return dealDao.totalPagePurchaseComplete(nickname);
	}

	public int totalPagePurchaseCompleteManager() {
		return dealDao.totalPagePurchaseCompleteManager();
	}

	public int totalPagePurchaseManager() {
		return dealDao.totalPagePurchaseManager();
	}

	public List<Purchase> purchaseCompleteManager(HashMap<String, Object> map) {
		return dealDao.purchaseCompleteManager(map);
	}

	
	
	
	public List<Purchase> purchaseCanceled(HashMap<String, Object> map) {
		return dealDao.purchaseCanceled(map);
	}
	
	public int totalPagePurchaseCanceled(String nickname) {
		return dealDao.totalPagePurchaseCanceled(nickname);
	}
	
	
	
	
	public List<Purchase> purchaseCanceledManager(HashMap<String, Object> map) {
		return dealDao.purchaseCanceledManager(map);
	}

	public int totalPagePurchaseCanceledManager() {
		return dealDao.totalPagePurchaseCanceledManager();
	}

	public int optionTotal(Integer no) {
		return dealDao.optionTotal(no);
	}

	public String purchaseName(Integer no) {
		return dealDao.purchaseName(no);
	}

	public int stopBoard(HashMap<String, Object> map) {
		return dealDao.stopBoard(map);
	}

	public int getAmount(String purchaseNo) {
		return dealDao.getAmount(purchaseNo);
	}



	
}
