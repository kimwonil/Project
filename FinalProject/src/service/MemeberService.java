package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MemberDao;
import model.CashRecord;
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
	
	
}
