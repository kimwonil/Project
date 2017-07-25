package controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import model.Answer;
import model.Member;
import model.Message;
import model.Notice;
import model.QnA;
import model.Report;
import service.AnswerService;
import service.MemeberService;
import service.NoticeService;
import service.QnAService;
import service.ReportService;

@Controller
public class CustomerCenterController {

	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private QnAService qnaService;
	
	@Autowired
	private AnswerService answerService;
	
	@Autowired
	private ReportService reportService;
	
	@Autowired
	private MemeberService memberService;
	//리스트 호출
	@RequestMapping("customerCenterCall.do")
	public ModelAndView All()
	{
		List<Notice> noticeList=noticeService.selectAllNotice();
		List<QnA> qnaList=qnaService.selectAllQnA();
		List<Report> reportList=reportService.selectAllReport();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("noticeList", noticeList);
		mav.addObject("qnaList", qnaList);
		mav.addObject("reportList", reportList);
		mav.setViewName("customerCenter");
		
		return mav;
	}
	//공지사항 상세
	@RequestMapping("NoticeContent.do")
	public ModelAndView NoticeContent(int no)
	{
		
		System.out.println(no);
		Notice notice=noticeService.selectOneNotice(no);
		int read_count=notice.getRead_count();
		HashMap<String , Object> params = new HashMap<String , Object>();
		params.put("no", no);
		params.put("read_count", read_count+1);
		noticeService.updateNoticeCount(params);
		System.out.println(notice);
		ModelAndView mav = new ModelAndView();
		mav.addObject("notice", notice);
		mav.setViewName("noticeContent");
		
		return mav;
	}
	//공지사항 수정폼 호출
	@RequestMapping("NoticeUpdateForm.do")
	public ModelAndView NoticeUpdateForm(int no)
	{
		
		System.out.println(no);
		Notice notice=noticeService.selectOneNotice(no);
		System.out.println(notice);
		ModelAndView mav = new ModelAndView();
		mav.addObject("notice", notice);
		mav.setViewName("noticeUpdateForm");
		
		return mav;
	}
	//공지사항 수정
	@RequestMapping("NoticeUpdate.do")
	public String NoticeUpdate(@RequestParam HashMap<String, Object> params)
	{
		
		
		int category_no=Integer.parseInt(((String)params.get("major"))+((String)params.get("minor")));
		System.out.println(category_no);
		params.remove("major");
		params.remove("minor");
		params.put("category_no", category_no);
		noticeService.updateNotice(params);
		Notice notice=noticeService.selectOneNotice(Integer.parseInt((String) params.get("no")));
		int read_count=notice.getRead_count();
		params.put("read_count", read_count-1);
		noticeService.updateNoticeCount(params);
	
		
		return "redirect:NoticeContent.do?no=" + params.get("no");
	}
	
	//공지사항 등록
	@RequestMapping("insertNotice.do")
	public String insertNotice(@RequestParam HashMap<String, Object> params, HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		
		String id = ((Member)session.getAttribute("member")).getId();
		params.put("writer", id);
		int category_no=Integer.parseInt(((String)params.get("major"))+((String)params.get("minor")));
		params.remove("major");
		params.remove("minor");
		params.put("category_no", category_no);
		noticeService.insertNotice(params);
		return "redirect:customerCenterCall.do";
	}
	
	//공지사항 삭제
	@RequestMapping("deleteNotice.do")
	public String deleteNotice(int no)
	{
		noticeService.delectNotice(no);
		return "redirect:customerCenterCall.do";
	}
	
	@RequestMapping("insertQuestion.do")
	public String insertQuestion(@RequestParam HashMap<String, Object> params, HttpSession session){
		String id = ((Member)session.getAttribute("member")).getId();
		params.put("writer", id);
		int category_no=Integer.parseInt(((String)params.get("major"))+((String)params.get("minor")));
		params.remove("major");
		params.remove("minor");
		params.put("category_no", category_no);
		System.out.println("질문 인설트");
		System.out.println(params);
		qnaService.insertQnA(params);
		return "redirect:customerCenterCall.do";
	}
	
	@RequestMapping("insertAnswer.do")
	public String insertAnswer(@RequestParam HashMap<String, Object> params, HttpSession session){
		String id = ((Member)session.getAttribute("member")).getId();
		params.put("writer", id);

		System.out.println("답변 인설트");
		System.out.println(params);
		answerService.insertAnswer(params);
		params.put("state", 1);
		params.put("no", params.get("qna_no"));
		qnaService.updateQnAAnswer(params);
		QnA qna=qnaService.selectOneQnA(Integer.parseInt((String) params.get("no")));
		int read_count=qna.getRead_count();
		params.put("read_count", read_count-1);
		qnaService.updateQnACount(params);
		return "redirect:qnaContent.do?no=" + params.get("qna_no");
	}
	
	@RequestMapping("qnaContent.do")
	public ModelAndView QnAContent(int no)
	{
		
		System.out.println(no);
		QnA qna=qnaService.selectOneQnA(no);
		int read_count=qna.getRead_count();
		HashMap<String , Object> params = new HashMap<String , Object>();
		params.put("no", no);
		params.put("read_count", read_count+1);
		qnaService.updateQnACount(params);
		Answer answer=new Answer();
		if(answerService.selectOneAnswer(no)!=null)
		{
		answer=answerService.selectOneAnswer(no);
		}
		System.out.println(qna);
		ModelAndView mav = new ModelAndView();
		mav.addObject("qna", qna);
		mav.addObject("answer", answer);
		mav.setViewName("qnaContent");
		
		return mav;
	}
	
	@RequestMapping("QnAUpdateForm.do")
	public ModelAndView QnAUpdateForm(int no)
	{
		
		System.out.println(no);
		QnA qna=qnaService.selectOneQnA(no);
		System.out.println(qna);
		ModelAndView mav = new ModelAndView();
		mav.addObject("qna", qna);
		mav.setViewName("qnaUpdateForm");
		
		return mav;
	}
	
	@RequestMapping("QnAUpdate.do")
	public String QnAUpdate(@RequestParam HashMap<String, Object> params)
	{
		int category_no=Integer.parseInt(((String)params.get("major"))+((String)params.get("minor")));
		params.remove("major");
		params.remove("minor");
		params.put("category_no", category_no);
		qnaService.updateQnA(params);
		QnA qna=qnaService.selectOneQnA(Integer.parseInt((String) params.get("no")));
		int read_count=qna.getRead_count();
		params.put("read_count", read_count-1);
		qnaService.updateQnACount(params);
		
		return "redirect:qnaContent.do?no=" + params.get("no");
	}
	
	@RequestMapping("deleteQnA.do")
	public String deleteQnA(int no)
	{
		qnaService.deleteQnA(no);
		return "redirect:customerCenterCall.do";
	}
	
	@RequestMapping("updateAnswer.do")
	public String updateAnswer(@RequestParam HashMap<String, Object> params)
	{
		System.out.println(params);
		answerService.updateAnswer(params);
		return "redirect:qnaContent.do?no=" + params.get("qna_no");
	}
	
	@RequestMapping("deleteAnswer.do")
	public String deleteAnswer(int no)
	{
		answerService.deleteAnswer(no);
		HashMap<String, Object> params=new HashMap<String, Object>();
		params.put("state", 0);
		params.put("no", no);
		qnaService.updateQnAAnswer(params);
		return "redirect:qnaContent.do?no="+no;
	}
	
	@RequestMapping("insertReport.do")
	public String insertReport(@RequestParam HashMap<String, Object> params, HttpSession session){
		String id = ((Member)session.getAttribute("member")).getId();
		params.put("writer", id);
		int category_no=Integer.parseInt(((String)params.get("major"))+((String)params.get("minor")));
		params.remove("major");
		params.remove("minor");
		params.put("category_no", category_no);
		System.out.println("신고 인설트");
		System.out.println(params);
		reportService.insertReport(params);
		return "redirect:customerCenterCall.do";
	}
	
	@RequestMapping("ReportContent.do")
	public ModelAndView ReportContent(int no)
	{
		
		System.out.println(no);
		Report report=reportService.selectOneReport(no);
		int read_count=report.getRead_count();
		HashMap<String , Object> params = new HashMap<String , Object>();
		params.put("no", no);
		params.put("read_count", read_count+1);
		reportService.updateReportCount(params);
		System.out.println(report);
		ModelAndView mav = new ModelAndView();
		mav.addObject("report", report);
		mav.setViewName("reportContent");
		
		return mav;
	}
	
	@RequestMapping("ReportClear.do")
	public String ReportClear(String id,int no, HttpSession session) {
		System.out.println(no);
		String title = "신고 상황 해결";
		String receiver = id;
		String content = receiver+"님이 접수하신 신고상황을 해결했습니다." ;
		String sender = ((Member)session.getAttribute("member")).getId();
		
		Message message = new Message(sender, receiver, title, content);
		
		memberService.messageSend(message);
		HashMap<String, Object> params=new HashMap<String, Object>();
		params.put("no", no);
		params.put("state", 1);
		reportService.updateReportAnswer(params);
		return "redirect:ReportContent.do?no="+no;
	}
}
