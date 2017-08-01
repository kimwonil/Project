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

	public List<Purchase> purchase(String id) {
		return dealDao.purchase(id);
	}

	public Board boardInfo(int no) {
		return dealDao.boardInfo(no);
	}

	public List<Purchase> ongoingPurcharse(HashMap<String, Object> map) {
		return dealDao.ongoingPurcharse(map);
	}

	public List<Purchase> completionPurcharse(HashMap<String, Object> map) {
		return dealDao.completionPurcharse(map);
	}

	public List<Purchase> purchaseComplete(String id) {
		return dealDao.purchaseComplete(id);
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

	public int totalPageSelling(String id) {
		return dealDao.totalPageSelling(id);
	}

	public int totalPageCompletion(String id) {
		return dealDao.totalPageCompletion(id);
	}

	public int totalPageOngoing(String id) {
		return dealDao.totalPageOngoing(id);
	}

	

	public String selectOneBoard(int no) {
		return dealDao.selectOneBoard(no);
	}

	public List<Purchase> canceledPurcharse(HashMap<String, Object> map) {
		return dealDao.canceledPurcharse(map);
	}

	public int totalPageCanceled(String id) {
		return dealDao.totalPageCanceled(id);
	}

	
}
