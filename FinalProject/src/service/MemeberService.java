package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MemberDao;
import model.CashRecord;
import model.Exchange;
import model.Member;

@Service
public class MemeberService {

	@Autowired
	private MemberDao memberDao;
	
	public Member selectOne(String id) {
		return memberDao.selectOne(id);
	}
	
	public int refillCash(Member member) {
		return memberDao.refillCash(member);
	}
	
	public int cashRecord(Member member) {
		
		return memberDao.cashRecord(member);
	}
	
	public List<CashRecord> cashList(String id){
		
		return memberDao.cashList(id);
	}
	
	public int exchange(HashMap<String, Object> map){
		int result = memberDao.exchange(map);
		if(result>=1) {
			changeBalance(map);
		}
		
		return result;
	}
	
	public int changeBalance(HashMap<String, Object> map) {
		return memberDao.changeBalance(map);
	}
	
	public List<Exchange> exchangeList(String id) {
		return memberDao.exchangeList(id);
	}
	
	public int exchangeManager(HashMap<String, Object> map) {
		System.out.println(map+"//서비스");
		return memberDao.exchangeManager(map);
	}
	
}
