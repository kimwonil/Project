package service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.NoticeDao;
import model.Board;
import model.Member;
import model.Notice;

@Service
public class NoticeService {
	@Autowired
	private NoticeDao noticeDao;
	
	public boolean insertNotice(HashMap<String, Object> params)
	{
		return noticeDao.insertNotice(params);
	}
	
	public List<Notice> selectAllNotice()
	{
		return noticeDao.selectAllNotice();
	}
	
	public Notice selectOneNotice(int no)
	{
		return noticeDao.selectOneNotice(no);
	}
	
	public boolean updateNotice(HashMap<String, Object> params)
	{
		return noticeDao.updateNotice(params);
	}
	
	public boolean delectNotice(int no)
	{
		return noticeDao.deleteNotice(no);
	}
	
	public boolean updateNoticeCount(int no)
	{
		return noticeDao.updateNoticeCount(no);
	}
	
	public List<Notice> getNoticeListPage(HashMap<String, Object> params,int page) {
		// TODO Auto-generated method stub
		HashMap<String, Object> result = new HashMap<String, Object>();
		
	
		
		params.put("skip", getSkip(page-1));
		params.put("qty", 10);
		System.out.println("서비스에서 파람 : "+params);
		List<Notice> nList= noticeDao.selectNoticePage(params);
//		result.put("noticeList", noticeDao.selectNoticePage(params));
	
		return nList;
	}
	
	public HashMap<String,Object> getNoticePage(HashMap<String, Object> params,int page)
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
		return (noticeDao.getNoticeCount(params)-1)/10+1;
	}

	
	public int getSkip(int num) {
		// TODO Auto-generated method stub
		return num * 10;
	}
	
	public String getHighName(HashMap<String, Object> params)
	{
		return noticeDao.getHighName(params);
	}
	public String getLowName(HashMap<String, Object> params)
	{
		return noticeDao.getLowName(params);
	}
	
	public Member getWriterInfo(String nickname)
	{
		return noticeDao.getWriterInfo(nickname);
	}
	
	public int getWriterCount(String nickname)
	{
		
		return noticeDao.getWriterCount(nickname);
	}
	
	public int getWriterSumStar(String nickname)
	{
		int star = 0;
		String starStr = noticeDao.getWriterSumStar(nickname);
		if(starStr == null){
			star = 0;
		}else{
			star = Integer.parseInt(noticeDao.getWriterSumStar(nickname));
		}
		return star;
	}
	
	public int getWriterSumNum(String nickname)
	{
		int evaluator = 0;
		String starStr = noticeDao.getWriterSumNum(nickname);
		if(starStr == null){
			evaluator = 0;
		}else{
			evaluator = Integer.parseInt(noticeDao.getWriterSumNum(nickname));
		}
		return evaluator;
	}
	
	public List<Board> getListNo(String nickname)
	{
		return noticeDao.getListNo(nickname);
	}
	
	public List<Integer> getBoardState(int no)
	{
		List<Integer> n=noticeDao.getBoardState(no);
		return n;
	}
}
