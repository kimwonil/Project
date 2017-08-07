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
import org.springframework.web.bind.annotation.RequestParam;
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
	
	/**
	 * 로그인 성공시 닉네임 자동 설정하기 (닉네임 변경 없을 경우 이메일 주소(id)를 닉네임으로 사용)
	 * */

	@RequestMapping("loginsuccess.do")
	public ModelAndView emailjoin(String id, HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView("member/profile");
		
		//로그인 성공 -> 첫 로그인(id값이 db에 없어 저장해야 할때)
		if(memberService.selectOne(id)==null){
		Member member = new Member();
		member.setId(id);
		member.setNickname(id);
		memberService.memberInsert(member);
		session.setAttribute("member", memberService.selectOne(id));

		// 결과를 보여줄 파일명
		//mv.setViewName("profile.do?id="+id);
		return mv;
	}
		//로그인 성공 -> 첫 로그인이 아님(이미 id값이 db에 저장되어 있음)
	else{
		Member member = (Member)session.getAttribute("member");
//		memberService.selectOne(id);
		session.setAttribute("member", memberService.selectOne(id));

		return mv;
	}
		}

	
//	public String emailjoin (String id, HttpSession session){
//		System.out.println(id);
//		
//		if(memberService.selectOne(id)==null){
//			Member member = new Member();
//			member.setId(id);
//			member.setNickName(id);
//			memberService.memberInsert(member);
//			return "redirect:profile.do?id="+id;
//		}
//		else{
//			Member member = (Member)session.getAttribute("member");
//			memberService.selectOne(id);
//			return "redirect:profile.do?id="+id;
//		}
//
//	}
	
	/**
	 * 프로필 조회
	 * */
	@RequestMapping("profile.do")
	public ModelAndView profile(@RequestParam(value="id", required=false) String id, HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView("member/profile");
		Member member = null;
		if(session.getAttribute("member") != null) {
			member = (Member)session.getAttribute("member");
			session.setAttribute("member", memberService.selectOne(member.getId()));
			//판매중
			session.setAttribute("selling", memberService.countSelling(member.getNickname()));
			//구매중
			session.setAttribute("purchase", memberService.countPurchase(member.getNickname()));
		}
		if(id != null) {
			member = memberService.selectOne(id);
			session.setAttribute("member", member);
			//판매중
			session.setAttribute("selling", memberService.countSelling(member.getNickname()));
			//구매중
			session.setAttribute("purchase", memberService.countPurchase(member.getNickname()));
		}else {
			mv.setViewName("index");
		}
		
		return mv;
	}
	
	/**
	 * 프로필 사진 수정
	 * */
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
		
		
		
		return "member/profile";
	}
	
	
	@RequestMapping("cashPage.do")
	public String cashPage(HttpSession session) {
		int admin = ((Member)session.getAttribute("member")).getAdmin();
		
		if(admin == 1) {
			return "member/cashManager";
		}else {
			return "member/cash";
		}
	}
	
	
	
	/**
	 * 캐시 화면
	 * */
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
	
	/**
	 * 캐시 관리자 화면
	 * */
	@RequestMapping("allCashList.do")
	public void allCashList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		int page = Integer.parseInt(request.getParameter("page").toString());
		HashMap<String, Object> map = new HashMap<>();
		map.put("page", page);
		try {
			PrintWriter printWriter = response.getWriter();
			
			map.put("list", memberService.allCashList(page));
			map.put("totalPage", memberService.allTotalPageCash());
			String json = gson.toJson(map);
			printWriter.write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
	
	/**
	 * 캐시 충전 내역 조회
	 * */
	@RequestMapping("cashList.do")
	public void cashList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		int page = Integer.parseInt(request.getParameter("page").toString());
		String id = ((Member)session.getAttribute("member")).getId();
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("page", page);
		try {
			PrintWriter printWriter = response.getWriter();
			
			map.put("list", memberService.cashList(map));
			map.put("totalPage", memberService.totalPageCash(id));
			String json = gson.toJson(map);
			printWriter.write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 환전 화면
	 * */
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
	
	/**
	 * 캐시 환전 내역 조회
	 * */
	@RequestMapping("exchangeList.do")
	public void exchangeList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		int page = Integer.parseInt(request.getParameter("page").toString());
		String id = ((Member)session.getAttribute("member")).getId();
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("page", page);
		
		try {
			PrintWriter printWriter = response.getWriter();
			
			map.put("list", memberService.exchangeList(map));
			map.put("totalPage", memberService.totalPageExchange(id));
			String json = gson.toJson(map);
			printWriter.write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	
	/**
	 * 전체 캐시 환전 내역 조회
	 * */
	@RequestMapping("allExchangeList.do")
	public void allExchangeList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		int page = Integer.parseInt(request.getParameter("page").toString());
		HashMap<String, Object> map = new HashMap<>();
		map.put("page", page);
		
		try {
			PrintWriter printWriter = response.getWriter();
			
			map.put("list", memberService.allExchangeList(map));
			map.put("totalPage", memberService.allTotalPageExchange());
			String json = gson.toJson(map);
			printWriter.write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	
	
	/**
	 * 캐시 환전 관리자
	 * */
	@RequestMapping("exchangeManager.do")
	public void exchangeManager(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int no = Integer.parseInt(request.getParameter("no"));
		int page = Integer.parseInt(request.getParameter("page"));
		int state=0;
		if(request.getParameter("state").equals("2")) {
			state=2;
		}else {
			state=3;
		}
			
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("no", no);
		map.put("state", state);
		map.put("page", page);
		
		
		try {
			memberService.exchangeManager(map);
			String json = gson.toJson(map);
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 쪽지 화면
	 * */
	@RequestMapping("message.do")
	public String message() {
		return "member/message";
	}
	
	
	/**
	 * 쪽지 리스트 조회
	 * */
	@RequestMapping("messageList.do")
	public void message(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		Member member = (Member)session.getAttribute("member");
		List<Message> list = memberService.messageList(member.getNickname());
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
	
	
	/**
	 * 쪽찌 상세 보기
	 * */
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
	
	/**
	 * 쪽지 보내기
	 * */
	@RequestMapping("messageSend.do")
	public void messageSend(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String title = request.getParameter("title");
		String receiver = request.getParameter("receiver");
		String content = request.getParameter("content");
		String sender = ((Member)session.getAttribute("member")).getNickname();
		
		Message message = new Message(sender, receiver, title, content);
		
		memberService.messageSend(message);
	}
	
	/**
	 * 회원관리 화면
	 * */
	@RequestMapping("memberManager.do")
	public String memeberManager() {
		return "member/memberList";
	}
	
	/**
	 * 회원 리스트 조회
	 * */
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
	
	/**
	 * 회원 상세 보기
	 * */
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
	
	
	/**
	 * 회원 정보 수정
	 * */
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
	
	/**
	 * 회원 삭제
	 * */
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
	
	/**
	 * 권한 신청 화면
	 * */
	@RequestMapping("authority.do")
	public String authority(HttpSession session) {
		if(((Member)session.getAttribute("member")) == null) {
			return "index";
		}else if(((Member)session.getAttribute("member")).getAdmin() == 1) {
			return "member/authorityManager";
		}else {
			return "member/authority";	
		}
		
		
		
	}
	
	
	
	/**
	 * 권한 신청 등록
	 * */
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
		params.put("id", ((Member)session.getAttribute("member")).getNickname());
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
		
		return "member/authority";
		
	}

	/**
	 * 권한 신청 현황 조회
	 * */
	@RequestMapping("authorityList.do")
	public void authorityList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String id = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("page", page);
		map.put("list", memberService.authorityList(map));
		map.put("totalPage", memberService.totalPageAuthority(id));
		
		try {
			String json = gson.toJson(map);
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}
	
	/**
	 * 권한 신청 삭제
	 * */
	@RequestMapping("authorityDelete.do")
	public void authorityDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int no = Integer.parseInt(request.getParameter("no"));
		memberService.authorityDelete(no);
	}
	
	/**
	 * 권한 신청 관리자 화면
	 * */
	@RequestMapping("authorityManager.do")
	public void authorityManager(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("page", page);
		map.put("list", memberService.authorityAll(map));
		map.put("totalPage", memberService.allTotalPageAuthority());
		
		
		
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 권한 신청 상태 변환
	 * */
	@RequestMapping("authorityUpdate.do")
	public void authorityUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		
		int no = Integer.parseInt(request.getParameter("no"));
		int state = Integer.parseInt(request.getParameter("state"));
		HashMap<String, Object> params = new HashMap<>();
		params.put("no", no);
		params.put("state", state);
		memberService.authorityUpdate(params);
	}
	
	/**
	 * 권한 신청 상세 보기
	 * */
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
	
	/**
	 * 파일 다운로드(권한 신청)
	 * */
	@RequestMapping("download.do")
	public ModelAndView downLoad(HttpServletRequest request, String no, String name, HttpSession session){
		String path = session.getServletContext().getRealPath("/authority");
//		String path = session.getServletContext().getContextPath()+"/photoFile/";
		File file = new File(path+"/"+no+"/"+name);
		//다운 가능한 뷰 이동
		return new ModelAndView("downLoadCustomView", "file", file);
	}
	
	
	
	

}
