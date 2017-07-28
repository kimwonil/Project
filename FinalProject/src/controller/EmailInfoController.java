package controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import model.EmailInfo;
import service.EmailInfoService;

@Controller
public class EmailInfoController {
	
	@Autowired
	private EmailInfoService emailinfoservice;

	@RequestMapping("loginsuccess.do")
	public void EmailAndNick(HttpServletRequest req, HttpServletResponse resp, HttpSession session){
		
		int emailno = ((EmailInfo) session.getAttribute("emailno")).getEmailno();
		String email = null;
				//((EmailInfo) session.getAttribute("emailinfo")).getEmail();
		String nickname = null;
		int admin = 0; //관리자 권한여부 : 기본값 0
		
		
		if(req.getParameter("EmailK")!=null){
			email = req.getParameter("EmailK");
			}
		else if(req.getParameter("EmailG")!=null){
			email = req.getParameter("EmailG");
			}
		else if(req.getParameter("EmailN")!=null){
			email = req.getParameter("EmailN");
		}
		
		if(nickname==null)
			nickname = email;		

		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("emailno", emailno);
		params.put("email", email);
		params.put("nickname", nickname);
		params.put("admin", admin);
		
		emailinfoservice.insertEmailInfo(params);
	}
}
