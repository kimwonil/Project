package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import model.Member;
import service.MemeberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemeberService memberService;
	
	@RequestMapping("profile.do")
	public ModelAndView profile(String id) {
		ModelAndView mv = new ModelAndView("profile");
//		Member m = new Member(id, "kwi1222", "empty", 0, 0);
		
		mv.addObject("member", memberService.selectOne(id));
		
		return mv;
	}

}
