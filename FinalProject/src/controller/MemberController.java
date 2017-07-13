package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import model.CashRecord;
import model.Member;
import service.MemeberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemeberService memberService;
	
	@RequestMapping("profile.do")
	public ModelAndView profile(String id, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("profile");
//		Member m = new Member(id, "kwi1222", "empty", 0, 0);
		HttpSession session = request.getSession();
		session.setAttribute("member", memberService.selectOne(id));
		
//		mv.addObject("member", memberService.selectOne(id));
		
		return mv;
	}
	
	@RequestMapping("cash.do")
	public void refillCash(HttpServletRequest request, HttpServletResponse response) {
//		ModelAndView mv = new ModelAndView("cash");
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");
		int refillCash = Integer.parseInt(request.getParameter("refillCash").toString());
		String code = request.getParameter("merchant_uid").toString();
		member.setCode(code);
		member.refillCash(refillCash);
		int result = memberService.refillCash(member);
		session.setAttribute("member", memberService.selectOne(member.getId()));
		try {
			if(result==1) {

				memberService.cashRecord(member);	
				
				response.getWriter().write("{\"result\":true, \"cash\":"+member.getBalance()+"}");
			}else {
				response.getWriter().write("{\"result\":false}");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping("cashList.do")
	public void cashList(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		Gson gson = new Gson();
		try {
			PrintWriter printWriter = response.getWriter();
			List<CashRecord> list = memberService.cashList(id);
			System.out.println(list.size());
//			String json = gson.toJson();
//			printWriter.write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		 
		
		
		
	}
	
	

}
