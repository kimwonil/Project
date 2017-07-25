package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ReportDao;
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
}
