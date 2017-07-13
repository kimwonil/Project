package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MemberDao;
import model.Member;

@Service
public class MemeberService {

	@Autowired
	private MemberDao memberDao;
	
	public Member selectOne(String id) {
		return memberDao.selectOne(id);
	}
	
}
