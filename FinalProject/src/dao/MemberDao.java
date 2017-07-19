package dao;

import java.util.HashMap;
import java.util.List;

import model.CashRecord;
import model.Exchange;
import model.Member;
import model.Message;

public interface MemberDao {
	public Member selectOne(String id);
	public List<Member> selectAll();
	public int memberUpdate(Member member);
	public int memberDelete(String id);
	public int refillCash(Member member);
	public int cashRecord(Member member);
	public List<CashRecord> cashList(String id);
	public int exchange(HashMap<String, Object> map);
	public int changeBalance(HashMap<String, Object> map);
	public List<Exchange> exchangeList(String id);
	public int exchangeManager(HashMap<String, Object> map);
	public List<Message> messageList(String id);
	public int messageState(int no);
	public Message messageDetail(int no);
	public int messageSend(Message message);
}
