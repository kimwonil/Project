package dao;

import java.util.HashMap;
import java.util.List;

<<<<<<< HEAD
=======
import model.Authority;
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
import model.CashRecord;
import model.Exchange;
import model.Member;
import model.Message;

public interface MemberDao {
	public Member selectOne(String id);
	public List<Member> selectAll();
<<<<<<< HEAD
=======
	//추가
	public int memberInsert(HashMap<String, Object> params);
	public Member selectmember(String string);
	//추가
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
	public int memberUpdate(Member member);
	public int memberDelete(String id);
	public int refillCash(Member member);
	public int cashRecord(Member member);
<<<<<<< HEAD
	public List<CashRecord> cashList(String id);
	public int exchange(HashMap<String, Object> map);
	public int changeBalance(HashMap<String, Object> map);
	public List<Exchange> exchangeList(String id);
=======
	public List<CashRecord> cashList(HashMap<String, Object> map);
	public int exchange(HashMap<String, Object> map);
	public int changeBalance(HashMap<String, Object> map);
	public List<Exchange> exchangeList(HashMap<String, Object> map);
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
	public int exchangeManager(HashMap<String, Object> map);
	public List<Message> messageList(String id);
	public int messageState(int no);
	public Message messageDetail(int no);
	public int messageSend(Message message);
<<<<<<< HEAD
=======
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

>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
}
