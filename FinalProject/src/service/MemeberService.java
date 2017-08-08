package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MemberDao;
<<<<<<< HEAD
=======
import model.Authority;
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
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
	
	//추가된 부분
	public int memberInsert(HashMap<String, Object> params){
		return memberDao.memberInsert(params);
	}

	public Member selectmember(String id) {
		// TODO Auto-generated method stub
		return memberDao.selectmember(id);
	}
	//추가된 부분
	
	public int memberUpdate(Member member) {
		return memberDao.memberUpdate(member);
	}
	
	public int memberDelete(String id) {
		return memberDao.memberDelete(id);
	}
	
	public int refillCash(Member member) {
		return memberDao.refillCash(member);
	}
	
	public int cashRecord(Member member) {
		
		return memberDao.cashRecord(member);
	}
	
<<<<<<< HEAD
	public List<CashRecord> cashList(String id){
		
		return memberDao.cashList(id);
=======
	public List<CashRecord> cashList(HashMap<String, Object> map){
		
		return memberDao.cashList(map);
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
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
	
<<<<<<< HEAD
	public List<Exchange> exchangeList(String id) {
		return memberDao.exchangeList(id);
=======
	public List<Exchange> exchangeList(HashMap<String, Object> map) {
		return memberDao.exchangeList(map);
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
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
<<<<<<< HEAD
		System.out.println(message);
		return memberDao.messageSend(message);
	}
	
	
=======
		return memberDao.messageSend(message);
	}
	
	public int authorityReg(HashMap<String, Object> params) {
		return memberDao.authorityReg(params);
	}
	
	public int authorityFiles(HashMap<String, Object> params) { 
		return memberDao.authorityFiles(params);
	}
	
	public List<Authority> authorityList(HashMap<String, Object> map) {
		return memberDao.authorityList(map);
	}
	
	public List<Authority> authorityAll(HashMap<String, Object> map) {
		return memberDao.authorityAll(map);
	}
	
	public int authorityUpdate(HashMap<String, Object> params) {
		return memberDao.authorityUpdate(params);
	}
	
	public int authorityDelete(int no) {
		return memberDao.authorityDelete(no);
	}
	
	public Authority authorityDetail(int no) {
		return memberDao.authorityDetail(no);
	}

	public int totalPageCash(String id) {
		return memberDao.totalPageCash(id);
	}

	public int totalPageExchange(String id) {
		return memberDao.totalPageExchange(id);
	}

	public List<CashRecord> allCashList(int page) {
		return memberDao.allCashList(page);
	}

	public int allTotalPageCash() {
		return memberDao.allTotalPageCash();
	}

	public List<Exchange> allExchangeList(HashMap<String, Object> map) {
		return memberDao.allExchangeList(map);
	}

	public int allTotalPageExchange() {
		return memberDao.allTotalPageExchange();
	}

	public int totalPageAuthority(String id) {
		return memberDao.totalPageAuthority(id);
	}

	public int allTotalPageAuthority() {
		return memberDao.allTotalPageAuthority();
	}
	
	//알림에 띄울 확인 안한 메시지 수
	public int getMessageCount(String id)
	{
		return memberDao.getMessageCount(id);
	}
	//알림에 띄울 확인 안한 메시지
	public List<Message> getMessage(String id)
	{
		return memberDao.getMessage(id);
	}

}
