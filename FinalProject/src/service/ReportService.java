package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ReportDao;
import model.Notice;
import model.QnA;
import model.Report;



@Service
public class ReportService {
	@Autowired
	private ReportDao reportDao;
	
	public boolean insertReport(HashMap<String, Object> params)
	{
		return reportDao.insertReport(params);
	}
	
	public List<Report> selectAllReport()
	{
		return reportDao.selectAllReport();
	}
	
	public Report selectOneReport(int no)
	{
		return reportDao.selectOneReport(no);
	}
	
	public boolean updateReport(HashMap<String, Object> params)
	{
		return reportDao.updateReport(params);
	}
	
	public boolean updateReportCount(HashMap<String, Object> params)
	{
		return reportDao.updateReportCount(params);
	}
	
	public boolean updateReportAnswer(HashMap<String, Object> params)
	{
		return reportDao.updateReportAnswer(params);
	}
	
	public boolean deleteReport(int no)
	{
		return reportDao.deleteReport(no);
	}
	
	public List<Report> getReportListPage(HashMap<String, Object> params,int page) {
		// TODO Auto-generated method stub
		HashMap<String, Object> result = new HashMap<String, Object>();
		
	
		
		params.put("skip", getSkip(page-1));
		params.put("qty", 10);
		System.out.println("서비스에서 파람 : "+params);
		List<Report> pList= reportDao.selectReportPage(params);
//		result.put("noticeList", noticeDao.selectNoticePage(params));
	
		return pList;
	}
	
	public HashMap<String,Object> getReportPage(HashMap<String, Object> params,int page)
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
		return (reportDao.getReportCount(params)-1)/10+1;
	}

	
	public int getSkip(int num) {
		// TODO Auto-generated method stub
		return num * 10;
	}
	
}
