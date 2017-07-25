package service;

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
	
	public List<Board> selectAll(String id){
		return dealDao.selectAll(id);
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
	
}
