package dao;

import java.util.HashMap;

import model.EmailInfo;

public interface EmailInfoDao {

	public int insertEmailInfo(HashMap<String, Object> params);
	public int updateEmailInfo(HashMap<String, Object> params);
}
