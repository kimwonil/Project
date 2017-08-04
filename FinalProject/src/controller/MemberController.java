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
	 * 첫 로그인 성공시 닉네임 자동 설정하기 (닉네임 변경 없을 경우 이메일 주소(id)를 닉네임으로 사용)
	 * */

	@RequestMapping("loginsuccess.do")
	public String emailjoin(@RequestParam HashMap<String, Object> params, HttpSession session, HttpServletRequest request, String id){
		System.out.println("간다 params.toString() 출력 : " + params.toString());
		System.out.println("간다 params.get(따옴표id따옴표).tostring() 출력 : "+params.get("id").toString());
		
		//로그인 성공 -> 첫 로그인(id값이 db에 없어 저장해야 할때)
		if(memberService.selectOne(id)==null){
		Member member = new Member();
		member.setId(id);
		member.setNickname(id);
		memberService.memberInsert(member);
		session.setAttribute("member", memberService.selectOne(id));
		System.out.println("형왜그래요"+memberService.selectmember(id));
		id = request.getParameter("id");
		System.out.println("왜그래"+memberService.selectmember(id));

		if(memberService.selectmember(id)!=null){
			
			System.out.println("아따 험난하다 1  memberService.selectmember(id).toString() 출력 : "+ memberService.selectmember(id).toString());
			
			memberService.selectmember(id);
			
			Member member = (Member)session.getAttribute("member");
			System.out.println("session으로 id값을 가져오는지 ? (첫 로그인 아님) : "+id);
			
			//		session.setAttribute("id", member.getId());
			//		session.setAttribute(id, member.getId());
			session.setAttribute("id", id);
			session.setAttribute("nickName", member.getNickName());

		}
		
		else if(memberService.selectmember(id)==null){
		memberService.memberInsert(params);
		//String id = request.getParameter("id");
		
		System.out.println("아따 험난하다 1  memberService.selectmember(id).toString() 출력 : "+ memberService.selectmember(id).toString());
		
		System.out.println("야이거 나오긴하냐1 = "+id);
	
		Member member = new Member();
		member.setId(id);
		if(member.getNickName()==null){
		//닉네임 초기값을 이메일주소로 설정
		member.setNickName(id);	
		}
		
		System.out.println("member.getId() = "+member.getId());
		
	//	session.setAttribute("id", id);
		session.setAttribute("id", member.getId());
		//닉네임 초기값을 이메일주소로 설정
		session.setAttribute("nickName", member.getNickName());
		
		session.setAttribute(id, member.getId());
		System.out.println("세션 간다 가! : " + session.getAttribute(id));
		}
		
		
		return "redirect:profile.do?id="+session.getAttribute(id);
	}
	
//	@RequestMapping("loginsuccess.do")
//	public ModelAndView emailjoin(@RequestParam("id")String id, HttpServletRequest request, HttpSession session) {
//		ModelAndView mv = new ModelAndView("member/profile");
//		
//		
//		//로그인 성공 -> 첫 로그인(id값이 db에 없어 저장해야 할때)
//		if(memberService.selectOne(id)==null){
//		Member member = new Member();
//		System.out.println("첫단계야 일단 오긴하니?");
//		session.setAttribute("id", id);
//		System.out.println("1.25단계야 id값이 일단 설정은 되니? " + id);
//		member.setId(id);	
//		System.out.println("1.5단계야 setid의 id값이 뭐니? : "+id);
//		
//		id = ((Member)session.getAttribute("member")).getId();
//		System.out.println("session으로 id값을 가져오는지 ? (첫 로그인임) : "+id);
//	
//
//
//		System.out.println("member에서 setid할때 id값을 가져온건지 ? : "+member.getId());
//		
//		member.setNickName(id);
//		memberService.memberInsert(member);
//		session.setAttribute("member", memberService.selectOne(id));
//
//		// 결과를 보여줄 파일명
//		//mv.setViewName("profile.do?id="+id);
//		return mv;
//	}
//		//로그인 성공 -> 첫 로그인이 아님(이미 id값이 db에 저장되어 있음)
//	else{
//		Member member = (Member)session.getAttribute("member");
//		id = ((Member)session.getAttribute("member")).getId();
//		System.out.println("session으로 id값을 가져오는지 ? (첫 로그인 아님) : "+id);
//
////		memberService.selectOne(id);
//		session.setAttribute("member", memberService.selectOne(id));
//
//		return mv;
//	}
//		}

	
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
	public ModelAndView profile(String id, HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView("member/profile");
		session.setAttribute("member", memberService.selectOne(id));
		
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
		
//닉네임 수정(예정) 
//		String nickName = ((Member)session.getAttribute("member")).getNickName();
//		member.setNickName(nickName);
//닉네임 수정(예정) 
		
		member.setPhoto(fileName);
		
		memberService.memberUpdate(member);
		
		
		
		return "member/profile";
	}
	
	@RequestMapping("cashPage.do")
	public String cashPage() {
		return "member/cash";
	}
	
	@RequestMapping("cashManager.do")
	public String cashManager() {
		return "member/cashManager";
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
		String sender = ((Member)session.getAttribute("member")).getId();
		
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
	public String authority() {
		return "member/authority";
	}
	
	/**
	 * 권한 신청 관리자 화면
	 * */
	@RequestMapping("authorityManagerPage.do")
	public String authorityManagerPage() {
		return "member/authorityManager";
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
		
		return "member/authority";
		
	}

	/**
	 * 권한 신청 현황 조회
	 * */
	@RequestMapping("authorityList.do")
	public void authorityList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String id = ((Member)session.getAttribute("member")).getId();
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
