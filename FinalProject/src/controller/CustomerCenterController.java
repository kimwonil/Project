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

import model.Member;
import model.Notice;
import service.NoticeService;

@Controller
public class CustomerCenterController {

	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("customerCenterCall.do")
	public ModelAndView All()
	{
		List<Notice> noticeList=noticeService.selectAllNotice();
		ModelAndView mav = new ModelAndView();
		mav.addObject("noticeList", noticeList);
		mav.setViewName("customerCenter");
		
		return mav;
	}
	
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
	
	@RequestMapping("deleteNotice.do")
	public String deleteNotice(int no)
	{
		noticeService.delectNotice(no);
		return "redirect:customerCenterCall.do";
	}
}
