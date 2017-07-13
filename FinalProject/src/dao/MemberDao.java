package dao;

import model.Member;

public interface MemberDao {
	public Member selectOne(String id);
}
