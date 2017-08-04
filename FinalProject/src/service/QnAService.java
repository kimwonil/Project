package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.QnADao;
import model.Notice;
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
	
	public boolean deleteQnA(int no)
	{
		return qnaDao.deleteQnA(no);
	}
	
	public List<QnA> getQnAListPage(HashMap<String, Object> params,int page) {
		// TODO Auto-generated method stub
		HashMap<String, Object> result = new HashMap<String, Object>();
		
	
		
		params.put("skip", getSkip(page-1));
		params.put("qty", 10);
		System.out.println("서비스에서 파람 : "+params);
		List<QnA> qList= qnaDao.selectQnAPage(params);

	
		return qList;
	}
	
	public HashMap<String,Object> getQnAPage(HashMap<String, Object> params,int page)
	{
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		result.put("current", page);
		result.put("start", getStartPage(page));
		result.put("end", getEndPage(page));
		result.put("last", getLastPage(params));
		
		return result;
	}
	
	public int getStartPage(int num) {
		// TODO Auto-generated method stub
		
		return (num-1)/5*5+1;
	}

	
	public int getEndPage(int num) {
		// TODO Auto-generated method stub
		return ((num-1)/5+1)*5;	
	}

	
	public int getLastPage(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return (qnaDao.getQnACount(params)-1)/10+1;
	}

	
	public int getSkip(int num) {
		// TODO Auto-generated method stub
		return num * 10;
	}
	
}
