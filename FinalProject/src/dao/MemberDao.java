package dao;

import java.util.HashMap;
import java.util.List;

import model.Authority;
import model.CashRecord;
import model.Exchange;
import model.Member;
import model.Message;

public interface MemberDao {
	public Member selectOne(String id);
	public List<Member> selectAll();
	//추가
	public int memberInsert(Member member);
	//추가
	public int memberUpdate(Member member);
	public int memberDelete(String id);
	public int refillCash(Member member);
	public int cashRecord(Member member);
	public List<CashRecord> cashList(HashMap<String, Object> map);
	public int exchange(HashMap<String, Object> map);
	public int changeBalance(HashMap<String, Object> map);
	public List<Exchange> exchangeList(HashMap<String, Object> map);
	public int exchangeManager(HashMap<String, Object> map);
	public List<Message> messageList(String id);
	public int messageState(int no);
	public Message messageDetail(int no);
	public int messageSend(Message message);
	public int authorityReg(HashMap<String, Object> params);
	public int authorityFiles(HashMap<String, Object> params);
	public List<Authority> authorityList(HashMap<String, Object> map);
	public List<Authority> authorityAll(HashMap<String, Object> map);
	public int authorityUpdate(HashMap<String, Object> params);
	public int authorityDelete(int no);
	public Authority authorityDetail(int no);
	public int totalPageCash(String id);
	public int totalPageExchange(String id);
	public List<CashRecord> allCashList(int page);
	public int allTotalPageCash();
	public List<Exchange> allExchangeList(HashMap<String, Object> map);
	public int allTotalPageExchange();
	public int totalPageAuthority(String id);
	public int allTotalPageAuthority();
	
	//알림에 띄울 확인 안한 메시지 수
	public int getMessageCount(String id);
	//알림에 띄울 확인 안한 메시지 
	public List<Message> getMessage(String id);
	
	//판매 갯수
	public int countSelling(String id);
	//구매 갯수
	public int countPurchase(String id);
	
	public void returnBalance(HashMap<String, Object> map);
}
