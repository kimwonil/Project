package dao;

import java.util.HashMap;
import java.util.List;

import model.CashRecord;
import model.Member;

public interface MemberDao {
	public Member selectOne(String id);
	public int refillCash(Member member);
	public int cashRecord(Member member);
	public List<CashRecord> cashList(String id);
}
