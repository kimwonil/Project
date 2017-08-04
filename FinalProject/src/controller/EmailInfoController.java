//package controller;
//
//import java.util.HashMap;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import model.EmailInfo;
//import service.EmailInfoService;
//
//@Controller
//public class EmailInfoController {
//	
//	@Autowired
//	private EmailInfoService emailinfoservice;
//
//	@RequestMapping("loginsuccess.do")
//	public void EmailAndNick(HttpServletRequest req, HttpServletResponse resp, HttpSession session){
//
//				//((EmailInfo) session.getAttribute("emailinfo")).getEmail();
//		String id = ((EmailInfo) session.getAttribute("emailinfo")).getEmail();
//		String nickname = ((EmailInfo) session.getAttribute("emailinfo")).getNickName() ;
//		int admin = 0; //관리자 권한여부 : 기본값 0
//
//
//		if(email==null && req.getParameter("EmailK")!=null){
//			email = req.getParameter("EmailK");
//			}
//		else if(email==null && req.getParameter("EmailG")!=null){
//			email = req.getParameter("EmailG");
//			}
//		else if(email==null && req.getParameter("EmailN")!=null){
//			email = req.getParameter("EmailN");
//		}
//
//		if(nickname==null)
//			nickname = email;		
//		
//		HashMap<String, Object> params = new HashMap<String, Object>();
//		
//		params.put("emailno", emailno);
//		params.put("id", email);
//		params.put("nickname", nickname);
//		params.put("admin", admin);
//		
//
//		private String id;
//		private String nickName;
//		private String photo;
//		private int balance;
//		private int admin;
//		private String code;
//		private int amount;
//		
//		emailinfoservice.insertEmailInfo(params);
//	}
//}
