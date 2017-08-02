package service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.NoticeDao;
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
	
	public boolean updateNoticeCount(HashMap<String, Object> params)
	{
		return noticeDao.updateNoticeCount(params);
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
}
