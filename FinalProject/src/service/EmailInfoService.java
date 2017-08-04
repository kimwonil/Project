package service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.EmailInfoDao;
import model.EmailInfo;

@Service
public class EmailInfoService {
	
	private EmailInfoDao emailinfodao;
	
	public int insertEmailInfo(HashMap<String, Object> params){
		return emailinfodao.insertEmailInfo(params);
	}

	public int updateEmailInfo (HashMap<String, Object> params){
		return emailinfodao.updateEmailInfo(params);
	}
	
}
