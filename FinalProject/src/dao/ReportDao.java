package dao;

import java.util.HashMap;
import java.util.List;

import model.Notice;
import model.Report;



public interface ReportDao {
	public boolean insertReport(HashMap<String , Object> params);
	public List<Report> selectAllReport();
	public Report selectOneReport(int no);
	public boolean updateReport(HashMap<String , Object> params);
	public boolean deleteReport(int no);
	public boolean updateReportCount(HashMap<String , Object> params);
	public boolean updateReportAnswer(HashMap<String , Object> params);

	public List<Report> selectReportPage(HashMap<String, Object> params);
	public int getReportCount(HashMap<String, Object> params);

}
