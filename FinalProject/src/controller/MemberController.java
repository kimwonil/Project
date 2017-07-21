package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import model.Authority;
import model.CashRecord;
import model.Exchange;
import model.FileUpload;
import model.Member;
import model.Message;
import service.MemeberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemeberService memberService;
	
	Gson gson = new Gson();
	
	@RequestMapping("profile.do")
	public ModelAndView profile(String id, HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView("profile");
		session.setAttribute("member", memberService.selectOne(id));
		
		return mv;
	}
	
	
	@RequestMapping("profileUpdate.do")
	public String profileUpdate(FileUpload file, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		String path = session.getServletContext().getRealPath("/user/profile/");
		String id = ((Member)session.getAttribute("member")).getId();
		MultipartFile photo = file.getFile();
		String fileName = photo.getOriginalFilename();
		System.out.println(path);
		File dir = new File(path+id);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		try {
			photo.transferTo(new File(path+id+"/"+fileName));
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		Member member = (Member)session.getAttribute("member");
		member.setPhoto(fileName);
		
		memberService.memberUpdate(member);
		
		
		
		return "profile";
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
				
				DecimalFormat number = new DecimalFormat("#,###");
				String balance = number.format(member.getBalance());
				
				response.getWriter().write("{\"result\":true, \"cash\":"+balance+"}");
			}else {
				response.getWriter().write("{\"result\":false}");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping("cashList.do")
	public void cashList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		Member member = (Member)session.getAttribute("member");
		String id = member.getId();
//		Gson gson = new Gson();
		try {
			PrintWriter printWriter = response.getWriter();
			List<CashRecord> list = memberService.cashList(id);
			String json = gson.toJson(list);
			printWriter.write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
	@RequestMapping("exchange.do")
	public void exchange(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		int amount = Integer.parseInt(request.getParameter("amount"));
		int currentBalance = member.getBalance()-amount;
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("amount", amount);
		map.put("balance", currentBalance);
		map.put("id", member.getId());
		int result = memberService.exchange(map);
		
		session.setAttribute("member", memberService.selectOne(member.getId()));
		
		
		
		try {
			if(result>=1) {
				DecimalFormat number = new DecimalFormat("#,###");
				String balance = number.format(currentBalance);
				response.getWriter().write("{\"result\":true, \"cash\":\""+balance+"\"}");
			}else {
				response.getWriter().write("{\"result\":false}");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	@RequestMapping("exchangeList.do")
	public void exchangeList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		Member member = (Member)session.getAttribute("member");
		List<Exchange> list = memberService.exchangeList(member.getId());
//		Gson gson = new Gson();
		try {
			PrintWriter printWriter = response.getWriter();
			String json = gson.toJson(list);
			printWriter.write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	@RequestMapping("exchangeManager.do")
	public void exchangeManager(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int no = Integer.parseInt(request.getParameter("no"));
		int state=0;
		if(request.getParameter("state").equals("2")) {
			state=2;
		}else {
			state=3;
		}
			
		System.out.println(no+"//"+state);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("no", no);
		map.put("state", state);
		
		System.out.println(map);
		
		try {
			if(memberService.exchangeManager(map)>=1) {
				response.getWriter().write("{\"result\":true}");
			}else {
				response.getWriter().write("{\"result\":false}");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping("messageList.do")
	public void message(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		Member member = (Member)session.getAttribute("member");
		List<Message> list = memberService.messageList(member.getId());
//		Gson gson = new Gson();
		try {
			if(list != null) {
				String json = gson.toJson(list);
				response.getWriter().write(json);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping("messageDetail.do")
	public void messageDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		int no = Integer.parseInt(request.getParameter("no"));
		
		Message message = memberService.messageDetail(no);
//		Gson gson = new Gson();
		String json = gson.toJson(message);
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping("messageSend.do")
	public void messageSend(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String title = request.getParameter("title");
		String receiver = request.getParameter("receiver");
		String content = request.getParameter("content");
		String sender = ((Member)session.getAttribute("member")).getId();
		
		Message message = new Message(sender, receiver, title, content);
		
		memberService.messageSend(message);
	}
	
	
	@RequestMapping("memberList.do")
	public void memberList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		List<Member> memeberList = memberService.selectAll();
//		Gson gson = new Gson();
		String json = gson.toJson(memeberList);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("memberUpdateForm.do")
	public void memberUpdateForm(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		String id = request.getParameter("id");
		System.out.println(id);
		
		Member member = memberService.selectOne(id);
		String json = gson.toJson(member);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping("memberUpdate.do")
	public void memberUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		String id = request.getParameter("id");
		String nickName = request.getParameter("nickname");
		String photo = request.getParameter("photo");
		int balance = Integer.parseInt(request.getParameter("balance"));
		int admin = Integer.parseInt(request.getParameter("admin"));
		Member member = new Member(id, nickName, photo, balance, admin);
		
		memberService.memberUpdate(member);
		
	}
	
	
	@RequestMapping("memberDelete.do")
	public void memberDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		String id = request.getParameter("id");
		
		int result = memberService.memberDelete(id);
		
		
		try {
			if(result>=1) {
				response.getWriter().write("{\"result\":\""+id+"\"}");
			}else {
				response.getWriter().write("{\"result\":false}");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		
	}
	
	@RequestMapping("authorityReg.do")
	public String authorityReg(FileUpload files, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		
		List<MultipartFile> fileList = files.getFiles();
		
		
		if(fileList.get(0).getOriginalFilename().equals("")) {
			return "authority";
		}else if(fileList.get(1).getOriginalFilename().equals("")) {
			System.out.println("비어있음2");
		}else if(fileList.get(2).getOriginalFilename().equals("")) {
			System.out.println("비어있음3");
		}
		
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("id", ((Member)session.getAttribute("member")).getId());
		params.put("category_no", request.getParameter("category_no"));
		
		memberService.authorityReg(params);
		
		
		
		int fileNo = 1;
		
		for(MultipartFile file : fileList) {
			params.put("file"+fileNo, file.getOriginalFilename());
			fileNo++;
		}
		System.out.println(params);
		memberService.authorityFiles(params);
//		System.out.println(fileList.get(0).getOriginalFilename());
//		System.out.println(fileList.get(1).getOriginalFilename());
//		System.out.println(fileList.get(2).getOriginalFilename());
		
		
		String path = session.getServletContext().getRealPath("/user/authority/");
		int no = Integer.parseInt(params.get("no").toString());
		MultipartFile file1 = fileList.get(0);
		MultipartFile file2 = fileList.get(1);
		MultipartFile file3 = fileList.get(2);
		String fileName1=null, fileName2=null, fileName3=null;
		if(file1 != null) {
			fileName1 = file1.getOriginalFilename();
		}
		
		if(file2 != null) {
			fileName2 = file2.getOriginalFilename();
		}
		
		if(file3 != null) {
			fileName3 = file3.getOriginalFilename();
		}
		System.out.println(path);
		File dir = new File(path+no);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		try {
			
			if(!fileName1.equals("")) {
				file1.transferTo(new File(path+no+"/"+fileName1));
			}
			if(!fileName2.equals("")) {
				file2.transferTo(new File(path+no+"/"+fileName2));
			}
			if(!fileName3.equals("")) {
				file3.transferTo(new File(path+no+"/"+fileName3));
			}
			
			
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "authority";
		
	}

	
	@RequestMapping("authorityList.do")
	public void authorityList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String id = ((Member)session.getAttribute("member")).getId();
		
		List<Authority> list = memberService.authorityList(id);
		
		String json = gson.toJson(list);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}
	
	
	@RequestMapping("authorityDelete.do")
	public void authorityDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int no = Integer.parseInt(request.getParameter("no"));
		memberService.authorityDelete(no);
	}
	
	@RequestMapping("authorityManager.do")
	public void authorityManager(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		HashMap<String, Object> params = new HashMap<>();
		List<Authority> list = memberService.authorityAll();
		
		String json = gson.toJson(list);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("authorityUpdate.do")
	public void authorityUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		
		int no = Integer.parseInt(request.getParameter("no"));
		int state = Integer.parseInt(request.getParameter("state"));
		HashMap<String, Object> params = new HashMap<>();
		params.put("no", no);
		params.put("state", state);
		memberService.authorityUpdate(params);
	}
	
	@RequestMapping("authorityDetail.do")
	public void authorityDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		int no = Integer.parseInt(request.getParameter("no"));
		
		String json = gson.toJson(memberService.authorityDetail(no));
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping("download.do")
	public ModelAndView downLoad(HttpServletRequest request, String no, String name, HttpSession session){
		String path = session.getServletContext().getRealPath("/authority");
//		String path = session.getServletContext().getContextPath()+"/photoFile/";
		File file = new File(path+"/"+no+"/"+name);
		//다운 가능한 뷰 이동
		return new ModelAndView("downLoadCustomView", "file", file);
	}

}
