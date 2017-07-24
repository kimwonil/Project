package dao;

import java.util.HashMap;
import java.util.List;

import model.Notice;

public interface NoticeDao {
	public boolean insertNotice(HashMap<String , Object> params);
	public List<Notice> selectAllNotice();
	public Notice selectOneNotice(int no);
	public boolean updateNotice(HashMap<String , Object> params);
	public boolean deleteNotice(int no);
	public boolean updateNoticeCount(HashMap<String , Object> params);
}
