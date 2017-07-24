package service;

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
}
