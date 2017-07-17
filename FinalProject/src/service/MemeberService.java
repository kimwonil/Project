package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MemberDao;
import model.CashRecord;
import model.Exchange;
import model.Member;
import model.Message;

@Service
public class MemeberService {

	@Autowired
	private MemberDao memberDao;
	
	public Member selectOne(String id) {
		return memberDao.selectOne(id);
	}
	
	public List<Member> selectAll() {
		return memberDao.selectAll();
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
		return memberDao.exchangeManager(map);
	}
	
	public List<Message> messageList(String id) {
		return memberDao.messageList(id);
	}
	
	public Message messageDetail(int no) {
		memberDao.messageState(no);
		return memberDao.messageDetail(no);
	}
	
	public int messageSend(Message message) {
		System.out.println(message);
		return memberDao.messageSend(message);
	}
	
	
	
}
