package controller;

import java.io.IOException;
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

import com.google.gson.Gson;

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

	Gson gson = new Gson();
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

	// 리스트 호출
	@RequestMapping("customerCenterCall.do")
	public ModelAndView All() {
		List<Notice> noticeList = noticeService.selectAllNotice();
		List<QnA> qnaList = qnaService.selectAllQnA();
		List<Report> reportList = reportService.selectAllReport();

		ModelAndView mav = new ModelAndView();
		mav.addObject("noticeList", noticeList);
		mav.addObject("qnaList", qnaList);
		mav.addObject("reportList", reportList);
		mav.setViewName("customerCenter");

		return mav;
	}

	@RequestMapping("noticeList.do")
	public void noticeList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");

		List<Notice> list = noticeService.selectAllNotice();
		// Gson gson = new Gson();
		try {
			if (list != null) {
				String json = gson.toJson(list);
				System.out.println(json);
				response.getWriter().write(json);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping("qnaList.do")
	public void qnaList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");

		List<QnA> list = qnaService.selectAllQnA();
		// Gson gson = new Gson();
		try {
			if (list != null) {
				String json = gson.toJson(list);
				System.out.println(json);
				response.getWriter().write(json);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping("reportList.do")
	public void reportList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");

		List<Report> list = reportService.selectAllReport();
		// Gson gson = new Gson();
		try {
			if (list != null) {
				String json = gson.toJson(list);
				System.out.println(json);
				response.getWriter().write(json);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 공지사항 상세
	@RequestMapping("noticeContent.do")
	public void NoticeContent(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println(no);
		Notice notice = noticeService.selectOneNotice(no);
		int read_count = notice.getRead_count();
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("no", no);
		params.put("read_count", read_count + 1);
		noticeService.updateNoticeCount(params);
		System.out.println(notice);
		String json = gson.toJson(notice);
		System.out.println(json);
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 공지사항 수정폼 호출
	@RequestMapping("NoticeUpdateForm.do")
	public ModelAndView NoticeUpdateForm(int no) {

		System.out.println(no);
		Notice notice = noticeService.selectOneNotice(no);
		System.out.println(notice);
		ModelAndView mav = new ModelAndView();
		mav.addObject("notice", notice);
		mav.setViewName("noticeUpdateForm");

		return mav;
	}

	// 공지사항 수정
	@RequestMapping("NoticeUpdate.do")
	public void NoticeUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		int no = Integer.parseInt(request.getParameter("no"));
		int category_no = Integer.parseInt((request.getParameter("category_no")));
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("no", no);
		params.put("category_no", category_no);
		params.put("title", title);
		params.put("content", content);

		noticeService.updateNotice(params);
		Notice notice = noticeService.selectOneNotice(no);
		int read_count = notice.getRead_count();
		params.put("read_count", read_count - 1);
		noticeService.updateNoticeCount(params);

	}

	// 공지사항 등록
	@RequestMapping("insertNotice.do")
	public String insertNotice(@RequestParam HashMap<String, Object> params, HttpServletRequest req,
			HttpServletResponse resp, HttpSession session) {

		String id = ((Member) session.getAttribute("member")).getId();
		params.put("writer", id);
		int category_no = Integer.parseInt(((String) params.get("major")) + ((String) params.get("minor")));
		params.remove("major");
		params.remove("minor");
		params.put("category_no", category_no);
		noticeService.insertNotice(params);
		return "redirect:customerCenterCall.do";
	}

	// 공지사항 삭제
	@RequestMapping("deleteNotice.do")
	public void deleteNotice(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int no = Integer.parseInt(request.getParameter("no"));
		noticeService.delectNotice(no);

	}

	@RequestMapping("insertQuestion.do")
	public void insertQuestion(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String id = ((Member) session.getAttribute("member")).getId();
		int category_no = Integer.parseInt((request.getParameter("major") + request.getParameter("minor")));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int open = Integer.parseInt(request.getParameter("open"));
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("writer", id);
		params.put("category_no", category_no);
		params.put("title", title);
		params.put("content", content);
		params.put("open", open);

		System.out.println("질문 인설트");
		System.out.println(params);
		qnaService.insertQnA(params);

	}

	// 답변 등록
	@RequestMapping("insertAnswer.do")
	public void insertAnswer(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String id = ((Member) session.getAttribute("member")).getId();
		int qna_no = Integer.parseInt(request.getParameter("qna_no"));
		String content = request.getParameter("content");

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("writer", id);

		params.put("qna_no", qna_no);

		params.put("content", content);

		System.out.println("답변 인설트");
		System.out.println(params);
		answerService.insertAnswer(params);
		params.put("state", 1);
		params.put("no", params.get("qna_no"));
		qnaService.updateQnAAnswer(params);
		QnA qna = qnaService.selectOneQnA(qna_no);
		int read_count = qna.getRead_count();
		params.put("read_count", read_count - 1);
		qnaService.updateQnACount(params);

	}

	// 질문 상세
	@RequestMapping("qnaContent.do")
	public void QnAContent(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String id = ((Member) session.getAttribute("member")).getId();
		int admin = ((Member) session.getAttribute("member")).getAdmin();
		System.out.println("어드민" + admin);

		String json = "";
		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println(no);
		QnA qna = qnaService.selectOneQnA(no);
		HashMap<String, Object> params = new HashMap<String, Object>();
		int read_count = qna.getRead_count();
		System.out.println("디비에 작성자"+qna.getWriter());
		System.out.println("현재 접속자"+id);
		if (admin == 1 || qna.getWriter().equals(id)) {
			System.out.println("조건 맞음");
			params.put("no", no);
			params.put("read_count", read_count + 1);
			qnaService.updateQnACount(params);
			Answer answer = new Answer();
			if (answerService.selectOneAnswer(no) != null) {
				answer = answerService.selectOneAnswer(no);
			}
			params.remove("read_count");
			params.put("title", qna.getTitle());
			params.put("writer", qna.getWriter());
			params.put("content", qna.getContent());
			params.put("state", qna.getState());
			params.put("answercontent", answer.getContent());
			json = gson.toJson(params);

		} else {
			System.out.println("조건 틀림");
			params.put("no", no);
			params.put("read_count", read_count + 1);
			qnaService.updateQnACount(params);
			Answer answer = new Answer();
			if (answerService.selectOneAnswer(no) != null) {
				answer = answerService.selectOneAnswer(no);
			}
			params.remove("read_count");
			params.put("title", "비공개");
			params.put("writer", "비공개");
			params.put("content", "비공개");
			params.put("state", qna.getState());
			params.put("answercontent", "비공개");
			json = gson.toJson(params);

		}

		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 질문 수정
	@RequestMapping("QnAUpdate.do")
	public void QnAUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int no = Integer.parseInt(request.getParameter("no"));
		int category_no = Integer.parseInt((request.getParameter("category_no")));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int open = Integer.parseInt(request.getParameter("open"));
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("no", no);
		params.put("category_no", category_no);
		params.put("title", title);
		params.put("content", content);
		params.put("open", open);
		qnaService.updateQnA(params);
		QnA qna = qnaService.selectOneQnA(no);
		int read_count = qna.getRead_count();
		params.put("read_count", read_count - 1);
		qnaService.updateQnACount(params);

	}

	// 질문 삭제
	@RequestMapping("deleteQnA.do")
	public void deleteQnA(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int no = Integer.parseInt(request.getParameter("no"));
		qnaService.deleteQnA(no);

	}

	// 답변 수정
	@RequestMapping("AnswerUpdate.do")
	public void Answer(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int qna_no = Integer.parseInt(request.getParameter("qna_no"));
		String content = request.getParameter("content");

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("qna_no", qna_no);

		params.put("content", content);

		answerService.updateAnswer(params);
		QnA qna = qnaService.selectOneQnA(qna_no);
		int read_count = qna.getRead_count();
		params.put("read_count", read_count - 1);
		qnaService.updateQnACount(params);

	}

	// 답변 삭제
	@RequestMapping("deleteAnswer.do")
	public String deleteAnswer(int no) {
		answerService.deleteAnswer(no);
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("state", 0);
		params.put("no", no);
		qnaService.updateQnAAnswer(params);
		return "redirect:qnaContent.do?no=" + no;
	}

	// 신고 등록
	@RequestMapping("insertReport.do")
	public void insertReport(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String id = ((Member) session.getAttribute("member")).getId();
		int category_no = Integer.parseInt((request.getParameter("major") + request.getParameter("minor")));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("writer", id);
		params.put("category_no", category_no);
		params.put("title", title);
		params.put("content", content);

		System.out.println("질문 인설트");
		System.out.println(params);
		reportService.insertReport(params);

	}

	// 신고 상세
	@RequestMapping("reportContent.do")
	public void ReportContent(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println(no);
		Report report = reportService.selectOneReport(no);
		int read_count = report.getRead_count();
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("no", no);
		params.put("read_count", read_count + 1);
		reportService.updateReportCount(params);
		System.out.println(report);
		String json = gson.toJson(report);
		System.out.println(json);
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 신고 수정
	@RequestMapping("ReportUpdate.do")
	public void ReportUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		int no = Integer.parseInt(request.getParameter("no"));
		int category_no = Integer.parseInt((request.getParameter("category_no")));
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("no", no);
		params.put("category_no", category_no);
		params.put("title", title);
		params.put("content", content);

		reportService.updateReport(params);
		Report report = reportService.selectOneReport(no);
		int read_count = report.getRead_count();
		params.put("read_count", read_count - 1);
		reportService.updateReportCount(params);

	}

	// 신고 삭제
	@RequestMapping("deleteReport.do")
	public void deleteReport(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int no = Integer.parseInt(request.getParameter("no"));
		reportService.deleteReport(no);

	}

	// 신고 해결 메세지 등록
	@RequestMapping("ReportClear.do")
	public void ReportClear(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int no = Integer.parseInt(request.getParameter("no"));
		Report report = reportService.selectOneReport(no);
		String title = "신고 상황 해결";
		String receiver = report.getWriter();
		String content = receiver + "님이 접수하신" + report.getTitle() + " 신고상황을 해결했습니다.";
		String sender = ((Member) session.getAttribute("member")).getId();

		Message message = new Message(sender, receiver, title, content);

		memberService.messageSend(message);
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("no", no);
		params.put("state", 1);
		reportService.updateReportAnswer(params);

	}
}
