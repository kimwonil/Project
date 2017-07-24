package dao;

import java.util.HashMap;
import java.util.List;

import model.QnA;

public interface QnADao {
	public boolean insertQnA(HashMap<String , Object> params);
	public List<QnA> selectAllQnA();
	public QnA selectOneQnA(int no);
	public boolean updateQnA(HashMap<String , Object> params);
	public boolean deleteQnA(int no);
	public boolean updateQnACount(HashMap<String , Object> params);
	public boolean updateQnAAnswer(HashMap<String , Object> params);
}
