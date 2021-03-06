package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.SystemEnvironmentPropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import model.Answer;
import model.Board;
import model.Category;
import model.Member;
import model.Message;
import model.Notice;
import model.QnA;
import model.Report;
import service.AnswerService;
import service.BoardService;
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

	@Autowired
	private BoardService BoardService;

	
	@RequestMapping("getWriterInfo.do")
	public void getWriterInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String nickname = request.getParameter("nickname");
		Member member=noticeService.getWriterInfo(nickname);
		System.out.println("글쓴이 닉네임으로 profile 테이블 검색해서 가져옴"+member);
		float star=0;
		int count=noticeService.getWriterCount(nickname);
		float totalStar=noticeService.getWriterSumStar(nickname);
		float totalNum=noticeService.getWriterSumNum(nickname);
		System.out.println("글수 "+count);
		System.out.println(totalStar+"  "+totalNum);
		List<Board> nolist=noticeService.getListNo(nickname);
		int countState=0;
		for(int i=0;i<nolist.size();i++)
		{
			List<Integer> stateList=noticeService.getBoardState(nolist.get(i).getNo());
			for(int j=0;j<stateList.size();j++)
			{
				if(stateList.get(j)==20 || stateList.get(j)==30)
				{
					countState++;
				}
			}
		}
//		System.out.println("완료갯수 "+ countState);
//		nolist.get(0)
		
		if(totalNum!=0)
		{
			star=totalStar/totalNum;
		}
		HashMap<String, Object> params=new HashMap<String, Object>();
		params.put("id",member.getId());
		params.put("nickname",member.getNickname());
		params.put("introduce",member.getIntroduce());
		params.put("photo",member.getPhoto());
		params.put("login", member.getLogin());
		params.put("star", star);
		params.put("count", countState);
		try {

			String json = gson.toJson(params);
			System.out.println(json);
			response.getWriter().write(json);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	
	// 확인하지않은 메세지수
	@RequestMapping("getMessageCount.do")
	public void getMessageCount(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String id = "";
//		System.out.println("메세지 카운터들어옴");
		if (((Member) session.getAttribute("member")).getNickname() != null) {
			id = ((Member) session.getAttribute("member")).getNickname();
			int num = memberService.getMessageCount(id);
			try {

				String json = gson.toJson(num);
//				System.out.println(json);
				response.getWriter().write(json);

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	// 확인하지않은 메세지 리스트
	@RequestMapping("getMessage.do")
	public void getMessage(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String id = "";
//		System.out.println("메세지 카운터들어옴");
		if (((Member) session.getAttribute("member")).getNickname() != null) {
			id = ((Member) session.getAttribute("member")).getNickname();
			System.out.println(id);
			List<Message> Mlist = memberService.getMessage(id);
			try {

				String json = gson.toJson(Mlist);
//				System.out.println(json);
				response.getWriter().write(json);

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

//	// 리스트 호출
//	@RequestMapping("customerCenterCall.do")
//	public ModelAndView All() {
//		List<Notice> noticeList = noticeService.selectAllNotice();
//		List<QnA> qnaList = qnaService.selectAllQnA();
//		List<Report> reportList = reportService.selectAllReport();
//
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("noticeList", noticeList);
//		mav.addObject("qnaList", qnaList);
//		mav.addObject("reportList", reportList);
//		mav.setViewName("customerCenter");
//
//		return mav;
//	}

	// 공지 리스트
	@RequestMapping("noticeList.do")
	public void noticeList(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(required = false) String keyword, @RequestParam(defaultValue = "0") int type) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		System.out.println("공지 리스트 들어옴");
		int page = Integer.parseInt(request.getParameter("page"));

		HashMap<String, Object> params = new HashMap<String, Object>();
		System.out.println(request.getParameter("start"));
		System.out.println(request.getParameter("page"));
		if (request.getParameter("start") != null && request.getParameter("end") != null) {
			System.out.println("날짜 들어와라");

			params.put("startdate", request.getParameter("start"));
			params.put("enddate", request.getParameter("end"));

		}

		System.out.println("현재 페이지 : " + page);
		params.put("type", type);
		params.put("keyword", keyword);

		if (type == 1) {
			params.put("writer", keyword);
		} else if (type == 2) {
			params.put("title", keyword);
		} else if (type == 3) {
			params.put("date", keyword);
		}
		if (request.getParameter("start") == null || request.getParameter("start").equals("")
				|| request.getParameter("start").equals("undefined") || request.getParameter("start").equals("null")) {
			System.out.println("널 들어옴");
			params.remove("startdate");
			params.remove("enddate");

		}
		System.out.println("파람 : " + params);
		List<Notice> list = noticeService.getNoticeListPage(params, page);
		System.out.println(list);
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

	// 공지 페이지
	@RequestMapping("noticePage.do")
	public void noticePage(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(required = false) String keyword, @RequestParam(defaultValue = "0") int type)
			throws ParseException {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		System.out.println("공지 페이지 들어옴");
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> params = new HashMap<String, Object>();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println("페이지에서" + request.getParameter("start"));
		if (request.getParameter("start") != null && request.getParameter("end") != null) {
			System.out.println("날짜 들어와라");
			params.put("startdate", request.getParameter("start"));
			params.put("enddate", request.getParameter("end"));

		}
		System.out.println("현재 페이지 : " + page);
		params.put("type", type);
		params.put("keyword", keyword);

		if (type == 1) {
			params.put("writer", keyword);
		} else if (type == 2) {
			params.put("title", keyword);
		} else if (type == 3) {
			params.put("date", keyword);
		}
		if (request.getParameter("start") == null || request.getParameter("start").equals("")
				|| request.getParameter("start").equals("undefined") || request.getParameter("start").equals("null")) {
			System.out.println("널 들어옴");
			params.remove("startdate");
			params.remove("enddate");

		}
		HashMap<String, Object> results = noticeService.getNoticePage(params, page);
		System.out.println(results);
		// Gson gson = new Gson();
		try {
			if (results != null) {
				String json = gson.toJson(results);
				System.out.println(json);
				response.getWriter().write(json);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 질문 리스트
	@RequestMapping("qnaList.do")
	public void qnaList(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(required = false) String keyword, @RequestParam(defaultValue = "0") int type) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> params = new HashMap<String, Object>();
		System.out.println(request.getParameter("start"));
		System.out.println(request.getParameter("page"));
		if (request.getParameter("start") != null && request.getParameter("end") != null) {
			System.out.println("날짜 들어와라");

			params.put("startdate", request.getParameter("start"));
			params.put("enddate", request.getParameter("end"));

		}
		System.out.println("현재 페이지 : " + page);
		params.put("type", type);
		params.put("keyword", keyword);

		if (type == 1) {
			params.put("writer", keyword);
		} else if (type == 2) {
			params.put("title", keyword);
		} else if (type == 3) {
			params.put("date", keyword);
		}
		if (request.getParameter("start") == null || request.getParameter("start").equals("")
				|| request.getParameter("start").equals("undefined") || request.getParameter("start").equals("null")) {
			System.out.println("널 들어옴");
			params.remove("startdate");
			params.remove("enddate");

		}
		System.out.println("파람 : " + params);
		List<QnA> list = qnaService.getQnAListPage(params, page);

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

	// 질문 페이징
	@RequestMapping("qnaPage.do")
	public void qnaPage(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(required = false) String keyword, @RequestParam(defaultValue = "0") int type) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		System.out.println("질문 페이지 들어옴");
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> params = new HashMap<String, Object>();

		System.out.println("페이지에서" + request.getParameter("start"));
		if (request.getParameter("start") != null && request.getParameter("end") != null) {
			System.out.println("날짜 들어와라");
			params.put("startdate", request.getParameter("start"));
			params.put("enddate", request.getParameter("end"));

		}
		System.out.println("현재 페이지 : " + page);
		params.put("type", type);
		params.put("keyword", keyword);

		if (type == 1) {
			params.put("writer", keyword);
		} else if (type == 2) {
			params.put("title", keyword);
		} else if (type == 3) {
			params.put("date", keyword);
		}
		if (request.getParameter("start") == null || request.getParameter("start").equals("")
				|| request.getParameter("start").equals("undefined") || request.getParameter("start").equals("null")) {
			System.out.println("널 들어옴");
			params.remove("startdate");
			params.remove("enddate");

		}
		HashMap<String, Object> results = qnaService.getQnAPage(params, page);
		System.out.println(results);
		// Gson gson = new Gson();
		try {
			if (results != null) {
				String json = gson.toJson(results);
				System.out.println(json);
				response.getWriter().write(json);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 신고 리스트
	@RequestMapping("reportList.do")
	public void reportList(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(required = false) String keyword, @RequestParam(defaultValue = "0") int type) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");

		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> params = new HashMap<String, Object>();
		System.out.println(request.getParameter("start"));
		System.out.println(request.getParameter("page"));
		if (request.getParameter("start") != null && request.getParameter("end") != null) {
			System.out.println("날짜 들어와라");

			params.put("startdate", request.getParameter("start"));
			params.put("enddate", request.getParameter("end"));

		}
		System.out.println("현재 페이지 : " + page);
		params.put("type", type);
		params.put("keyword", keyword);

		if (type == 1) {
			params.put("writer", keyword);
		} else if (type == 2) {
			params.put("title", keyword);
		} else if (type == 3) {
			params.put("date", keyword);
		}
		if (request.getParameter("start") == null || request.getParameter("start").equals("")
				|| request.getParameter("start").equals("undefined") || request.getParameter("start").equals("null")) {
			System.out.println("널 들어옴");
			params.remove("startdate");
			params.remove("enddate");

		}
		System.out.println("파람 : " + params);
		List<Report> list = reportService.getReportListPage(params, page);
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

	// 신고 페이징
	@RequestMapping("reportPage.do")
	public void reportPage(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(required = false) String keyword, @RequestParam(defaultValue = "0") int type) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		System.out.println("신고 페이지 들어옴");
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> params = new HashMap<String, Object>();

		System.out.println("페이지에서" + request.getParameter("start"));
		if (request.getParameter("start") != null && request.getParameter("end") != null) {
			System.out.println("날짜 들어와라");
			params.put("startdate", request.getParameter("start"));
			params.put("enddate", request.getParameter("end"));

		}
		System.out.println("현재 페이지 : " + page);
		params.put("type", type);
		params.put("keyword", keyword);

		if (type == 1) {
			params.put("writer", keyword);
		} else if (type == 2) {
			params.put("title", keyword);
		} else if (type == 3) {
			params.put("date", keyword);
		}
		if (request.getParameter("start") == null || request.getParameter("start").equals("")
				|| request.getParameter("start").equals("undefined") || request.getParameter("start").equals("null")) {
			System.out.println("널 들어옴");
			params.remove("startdate");
			params.remove("enddate");

		}
		HashMap<String, Object> results = reportService.getReportPage(params, page);
		System.out.println(results);
		// Gson gson = new Gson();
		try {
			if (results != null) {
				String json = gson.toJson(results);
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
		noticeService.updateNoticeCount(no);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("no", notice.getNo());
		result.put("title", notice.getTitle());
		result.put("writer", notice.getWriter());
		result.put("content", notice.getContent());

		System.out.println(result);
		String json = gson.toJson(result);
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
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("no", no);
		
		params.put("title", title);
		params.put("content", content);

		noticeService.updateNotice(params);

	}

	// 카테고리 하이 불러오기
	@RequestMapping("high.do")
	public void categoryLow(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");

		List<Category> highlist = BoardService.category();
		Gson gson = new Gson();
		String json = gson.toJson(highlist);
		try {
			resp.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 카테고리 로우 불러오기
	@RequestMapping("Low.do")
	public void categoryLow(int high_no, HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");

		List<Category> lowlist = BoardService.categoryLow(high_no);
		Gson gson = new Gson();
		String json = gson.toJson(lowlist);
		try {
			resp.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 공지사항 등록
	@RequestMapping("insertNotice.do")
	public void insertNotice(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String nickname = ((Member) session.getAttribute("member")).getNickname();
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("writer", nickname);
		
		params.put("title", title);
		params.put("content", content);

		System.out.println("공지 인설트");
		System.out.println(params);

		noticeService.insertNotice(params);

	}

	// 공지사항 삭제
	@RequestMapping("deleteNotice.do")
	public void deleteNotice(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int no = Integer.parseInt(request.getParameter("no"));
		noticeService.delectNotice(no);

	}

	// 질문 등록
	@RequestMapping("insertQuestion.do")
	public void insertQuestion(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String nickname = ((Member) session.getAttribute("member")).getNickname();
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int open = Integer.parseInt(request.getParameter("open"));
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("writer", nickname);
		
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
		String nickname = ((Member) session.getAttribute("member")).getNickname();
		int qna_no = Integer.parseInt(request.getParameter("qna_no"));
		String content = request.getParameter("content");

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("writer", nickname);

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

		System.out.println("질문 상세");
		String id = "";
		int admin = 0;

		if (session.getAttribute("member") == null) {
			System.out.println("널이네");
		} else {
			id = ((Member) session.getAttribute("member")).getNickname();
			admin = ((Member) session.getAttribute("member")).getAdmin();
		}

		System.out.println("어드민" + admin);

		String json = "";
		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println(no);
		QnA qna = qnaService.selectOneQnA(no);
		
	
		HashMap<String, Object> params = new HashMap<String, Object>();
		int read_count = qna.getRead_count();
		System.out.println("디비에 작성자" + qna.getWriter());
		System.out.println("현재 접속자" + id);
		if (qna.getState() == 0) {
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
				params.put("category_no", qna.getCategory_no());
				params.put("open", qna.getOpen());
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
				params.put("writer", qna.getWriter());
				params.put("content", "비공개");
				params.put("state", qna.getState());
				params.put("category_no", qna.getCategory_no());
				params.put("open", qna.getOpen());
				params.put("answercontent", "비공개");
				json = gson.toJson(params);

			}
		}
		else
		{
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
			params.put("category_no", qna.getCategory_no());
			params.put("open", qna.getOpen());
			params.put("answercontent", answer.getContent());
			json = gson.toJson(params);
		}
		System.out.println(json);
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
	
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int open = Integer.parseInt(request.getParameter("open"));
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("no", no);
	
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
		params.put("no", qna_no);
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
		String nickname = ((Member) session.getAttribute("member")).getNickname();
		String category = request.getParameter("category");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int board_no = 0;
		
		if(request.getParameter("no") != null) {
			board_no = Integer.parseInt(request.getParameter("no"));
		}
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("board_no", board_no);
		params.put("writer", nickname);
		params.put("category", category);
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

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("no", report.getNo());
		result.put("title", report.getTitle());
		result.put("writer", report.getWriter());
		result.put("category", report.getCategory());
		result.put("content", report.getContent());
		result.put("state", report.getState());
		result.put("board_no", report.getBoard_no());
		if(report.getBoard_no() != 0) {
			result.put("board_name", BoardService.selectOneBoard(report.getBoard_no()).getTitle());
		}
		System.out.println(result);
		String json = gson.toJson(result);
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
		String title = report.getTitle() + "신고 상황 해결";
		String receiver = report.getWriter();
		String content = receiver + "님이 접수하신" + report.getTitle() + " 신고상황을 해결했습니다.";
		String sender = ((Member) session.getAttribute("member")).getNickname();

		Message message = new Message(sender, receiver, title, content);

		memberService.messageSend(message);
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("no", no);
		params.put("state", 1);
		reportService.updateReportAnswer(params);

	}
}
