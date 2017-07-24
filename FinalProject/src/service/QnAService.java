package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.QnADao;
import model.QnA;

@Service
public class QnAService {
	@Autowired
	private QnADao qnaDao;
	
	public boolean insertQnA(HashMap<String, Object> params)
	{
		return qnaDao.insertQnA(params);
	}
     
	public List<QnA> selectAllQnA()
	{
		return qnaDao.selectAllQnA();
				
	}
	
	public QnA selectOneQnA(int no)
	{
		return qnaDao.selectOneQnA(no);
	}
	
	public boolean updateQnA(HashMap<String, Object> params)
	{
		return qnaDao.updateQnA(params);
	}
	
	public boolean updateQnACount(HashMap<String, Object> params)
	{
		return qnaDao.updateQnACount(params);
	}
	
	public boolean updateQnAAnswer(HashMap<String, Object> params)
	{
		return qnaDao.updateQnAAnswer(params);
	}
	
	public boolean delectQnA(int no)
	{
		return qnaDao.deleteQnA(no);
	}
	
}
