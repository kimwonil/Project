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
import org.springframework.social.connect.Connection;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.plus.Person;
import org.springframework.social.google.api.plus.PlusOperations;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
import service.BoardService;
import service.MemeberService;
import service.NoticeService;

@Controller
public class MemberController {
	
	@Autowired
	private MemeberService memberService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	@Autowired
	private NoticeService noticeService;
	
	Gson gson = new Gson();
	
	
	
//	public void setGoogleConnectionFactory(GoogleConnectionFactory googleConnectionFactory) {
//		this.googleConnectionFactory = googleConnectionFactory;
//	}
//
//
//	public void setGoogleOAuth2Parameters(OAuth2Parameters googleOAuth2Parameters) {
//		this.googleOAuth2Parameters = googleOAuth2Parameters;
//	}

	
	/**
	 * 로그인 요청
	 * */
//	@RequestMapping(value = "/member/googleSignIn", method = RequestMethod.POST)
//	public void doGoogleSignInActionPage(HttpServletResponse response) {
//		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
//		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
//		System.out.println("/member/googleSignIn, url : " + url);
//		
//		PrintWriter out;
//		try {
//			out = response.getWriter();
//			out.write(url);
//			out.flush();
//			out.close();
//		} catch (IOException e) {
//			throw new RuntimeException(e.getMessage(), e);
//		}
//		
//	}
//	
//	
//	@RequestMapping("/member/googleSignInCallback")
//	public String doSessionAssignActionPage(HttpServletRequest request){
//		System.out.println("/member/googleSignInCallback");
//		String code = request.getParameter("code");
//		
//		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
//		AccessGrant accessGrant = oauthOperations.exchangeForAccess(code , googleOAuth2Parameters.getRedirectUri(),
//				null);
//		
//		String accessToken = accessGrant.getAccessToken();
//		Long expireTime = accessGrant.getExpireTime();
//		if (expireTime != null && expireTime < System.currentTimeMillis()) {
//			accessToken = accessGrant.getRefreshToken();
//			System.out.printf("accessToken is expired. refresh token = {}", accessToken);
//		}
//		Connection<Google> connection = googleConnectionFactory.createConnection(accessGrant);
//		Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi();
//		
//		PlusOperations plusOperations = google.plusOperations();
//		Person person = plusOperations.getGoogleProfile();
//		
//		
//		System.out.println(person.getAccountEmail());
//		System.out.println(person.getAboutMe());
//		System.out.println(person.getDisplayName());
//		System.out.println(person.getEtag());
//		System.out.println(person.getFamilyName());
//		System.out.println(person.getGender());
//		
////		MemberVO member = new MemberVO();
////		member.setNickName(person.get);
////		member.setAuth("USR");
//
////		HttpSession session = request.getSession();
////		session.setAttribute("_MEMBER_", member );
//		
//		System.out.println(person.getDisplayName());
//		
//		return "redirect:/";
//		/*System.out.println(person.getAccountEmail());
//		System.out.println(person.getAboutMe());
//		System.out.println(person.getDisplayName());
//		System.out.println(person.getEtag());
//		System.out.println(person.getFamilyName());
//		System.out.println(person.getGender());
//		*/
//		
//	}
	
	/**
	 * 로그인 폼 요청
	 * */
	@RequestMapping("loginForm.do")
	public String loginForm() {
		return "login";
	}
	
	
	
	/**
	 * 로그인
	 * */
	@RequestMapping("login.do")
	public void login(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		System.out.println("로그인");
//		System.out.println(request.getParameter("email"));
		String email = request.getParameter("email");
		int login = Integer.parseInt(request.getParameter("login"));
		session.setAttribute("email", email);
		session.setAttribute("login", login);
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", email);
		map.put("login", login);
		Member member = memberService.selectOne(map);
		System.out.println(member);
		session.setAttribute("member", member);///연경추가-0901
		try {
			if(member == null) {
				map.put("result", false);
				String json = gson.toJson(map);
				response.getWriter().write(json);
			}else {
				map.put("result", true);
				String json = gson.toJson(map);
				session.setAttribute("member", member);
				response.getWriter().write(json);
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 로그아웃
	 * */
	@RequestMapping("logout.do")
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		session.invalidate();
		
		
		return "redirect:load.do";
	}
	
	/**
	 * 회원가입 폼 요청
	 * */
	@RequestMapping("insertForm.do")
	public String insertForm() {
		
		return "member/nickname";
	}
	
	
	/**
	 * 회원가입
	 * */
	@RequestMapping("memberInsert.do")
	public String memberInsert(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		System.out.println("회원가입");
		HashMap<String, Object> map = new HashMap<>();
		String id = session.getAttribute("email").toString();
		map.put("id", id);
		int login = Integer.parseInt(session.getAttribute("login").toString());
		map.put("login", login);
		String nickname = request.getParameter("nickname");
		Member member = new Member(id, nickname, null, 0, 0, login);
		memberService.memberInsert(member);
		
		session.setAttribute("member", memberService.selectOne(map));
		return "redirect:load.do";
	}
	
	/**
	 * 닉네임 중복 체크
	 * */
	@RequestMapping("nickname.do")
	public void nickname(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String nickname = request.getParameter("nickname");
		String msg="";
		if(memberService.nickNameCheck(nickname)>=1) {
			msg="{\"result\":false}";
		}else {
			msg="{\"result\":true}";
		}
		try {
			response.getWriter().write(msg);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 프로필 조회
	 * */
	@RequestMapping("profile.do")
	public ModelAndView profile(HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView("member/profile");
		Member member = null;
		HashMap<String, Object> map = new HashMap<>();
		System.out.println("테스트로 프로필조회"+session.getAttribute("member"));
		if(session.getAttribute("member") != null) {
			member = (Member)session.getAttribute("member");
			map.put("id", member.getId());
			map.put("login", member.getLogin());
			member = memberService.selectOne(map);
//			String introduce = member.getIntroduce();
//			System.out.println(introduce+"//확인");
//			if(introduce != null) {
//				introduce = introduce.replaceAll("<br>", "\r\n");
//				introduce = introduce.replaceAll("&nbsp;", "\u0020");
//				member.setIntroduce(introduce);
//			}
			
			//미니별점
			float star=0;
			Integer totalStar=noticeService.getWriterSumStar(member.getNickname());
			System.out.println("totalStar"+totalStar);
			Integer totalNum=noticeService.getWriterSumNum(member.getNickname());
			System.out.println("totalNum"+totalNum);
			if(totalNum!=0 && totalStar != null && totalNum != null)
			{
				star=(float)totalStar/(float)totalNum;
			}
			System.out.println("별점"+star);
			session.setAttribute("star", star);
			session.setAttribute("totalNum", totalNum);
			
			session.setAttribute("member", member);
			//판매중
			session.setAttribute("selling", memberService.countSelling(member.getNickname()));
			//구매중
			session.setAttribute("purchase", memberService.countPurchase(member.getNickname()));
			//은행 리스트
			session.setAttribute("bankList", memberService.bankList());
			//판매 재능 리스트
			List<Authority> authorityList = memberService.myAuthority(member.getNickname());
			for(Authority authority : authorityList) {
				authority.setCategoryName(boardService.category_majorName(authority.getCategory_no()));
			}
			session.setAttribute("authority", authorityList);
		}else {
			mv.setViewName("index");
		}
		
		return mv;
	}
	
	/**
	 * 미니 프로필 조회
	 * */
	@RequestMapping("miniProfile.do")
	public void miniProfile(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		Member member = null;
		try {
			if(session.getAttribute("member") != null) {
				HashMap<String, Object> map = new HashMap<>();
				String id = ((Member)session.getAttribute("member")).getId();
				int login = ((Member)session.getAttribute("member")).getLogin();
				map.put("id", id);
				map.put("login", login);
				member = memberService.selectOne(map);
				DecimalFormat number = new DecimalFormat("#,###");
				String balance = number.format(member.getBalance());
				//세션 업데이트
				session.setAttribute("member",member);
				map.put("member", member);
				//현 잔액
				map.put("balance", balance);
				//판매갯수
				map.put("selling", memberService.countSelling(member.getNickname()));
				//구매갯수
				map.put("purchase", memberService.countPurchase(member.getNickname()));
				//나의재능
				map.put("authority", memberService.countAuthority(member.getNickname()));
				//찜목록
				map.put("dipsList", boardService.getCountDips(member.getNickname()));
				//쪽지
				map.put("message", memberService.getMessageCount(member.getNickname()));
				
				
				
				
				String json = gson.toJson(map);
				
				response.getWriter().write(json);
				
			}else {
				response.sendRedirect("index.jsp");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 프로필 정보 수정
	 * */
	@RequestMapping("profileUpdate.do")
	public String profileUpdate(FileUpload file, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String introduce = request.getParameter("introduce");
		String account = request.getParameter("account");
		String bank = request.getParameter("bank");
		Member member = (Member)session.getAttribute("member");
		String path = session.getServletContext().getRealPath("/user/profile/");
		String id = member.getId();
		int login=member.getLogin();
		MultipartFile photo = file.getFile();
		String fileName = photo.getOriginalFilename();
		System.out.println(path);
		path = path + id + "/" + login;
		File dir = new File(path);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		try {
			if(!fileName.equals("")) {
				photo.transferTo(new File(path+"/"+fileName));
				member.setPhoto(fileName);
			}
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}		
//		introduce = introduce.replaceAll("\r\n", "<br>");
//		introduce = introduce.replaceAll("\u0020", "&nbsp;");
		
		member.setBank(memberService.bankName(bank));
		member.setAccount(account);
		member.setIntroduce(introduce);
		
		memberService.memberUpdate(member);
		session.setAttribute("member", member);
		session.setAttribute("bankList", memberService.bankList());
		
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
	public void refillCash(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
//		ModelAndView mv = new ModelAndView("cash");
		HashMap<String, Object> map = new HashMap<>();
		Member member = (Member) session.getAttribute("member");
		int refillCash = Integer.parseInt(request.getParameter("refillCash"));
		String code = request.getParameter("merchant_uid").toString();
		member.setCode(code);
		member.refillCash(refillCash);
		int result = memberService.refillCash(member);
		map.put("id", member.getId());
		map.put("login", member.getLogin());
		session.setAttribute("member", memberService.selectOne(map));
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
		int page = Integer.parseInt(request.getParameter("page"));
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
		String nickname = ((Member)session.getAttribute("member")).getNickname();
		HashMap<String, Object> map = new HashMap<>();
		map.put("nickname", nickname);
		map.put("page", page);
		try {
			PrintWriter printWriter = response.getWriter();
			
			map.put("list", memberService.cashList(map));
			map.put("totalPage", memberService.totalPageCash(nickname));
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
		map.put("nickname", member.getNickname());
		map.put("id", member.getId());
		map.put("login", member.getLogin());
		int result = memberService.exchange(map);
		
		session.setAttribute("member", memberService.selectOne(map));
		
		
		
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
		String nickname = ((Member)session.getAttribute("member")).getNickname();
		HashMap<String, Object> map = new HashMap<>();
		map.put("nickname", nickname);
		map.put("page", page);
		
		try {
			PrintWriter printWriter = response.getWriter();
			
			map.put("list", memberService.exchangeList(map));
			map.put("totalPage", memberService.totalPageExchange(nickname));
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
	 * 쪽지 상세 보기
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
	 * 쪽지 삭제
	 * */
	@RequestMapping("messageDelete.do")
	public void messageDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		int no = Integer.parseInt(request.getParameter("no"));
		
		memberService.messageDelete(no);
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
		HashMap<String, Object> map = new HashMap<>();
		String nickname = request.getParameter("nickname");
		System.out.println(nickname);
		map.put("nickname", nickname);
		Member member = memberService.selectNickOne(map);
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
		int login = Integer.parseInt(request.getParameter("login"));
		Member member = new Member(id, nickName, photo, balance, admin);
		member.setLogin(login);
		System.out.println("회원수정");
		System.out.println(member);
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
	 * 회원관리에서 개인 권한 조회
	 * */
	@RequestMapping("privateAuthority.do")
	public void privateAuthority(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String nickname = request.getParameter("nickname");
		
		List<Authority> authorityList = memberService.privateAuthority(nickname);
		for(Authority authority : authorityList) {
			authority.setCategoryName(boardService.category_majorName(authority.getCategory_no()));
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("nickname", nickname);
		map.put("authorityList", authorityList);
		try {
			String json = gson.toJson(map);
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 권한 신청 등록
	 * */
	@RequestMapping("authorityReg.do")
	public String authorityReg(FileUpload files, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		
		List<MultipartFile> fileList = files.getFiles();
		
		
		if(fileList.get(0).getOriginalFilename().equals("")) {
			return "member/authority";
		}else if(fileList.get(1).getOriginalFilename().equals("")) {
			System.out.println("비어있음2");
		}else if(fileList.get(2).getOriginalFilename().equals("")) {
			System.out.println("비어있음3");
		}
		
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("nickname", ((Member)session.getAttribute("member")).getNickname());
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
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String nickname = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("nickname", nickname);
		map.put("page", page);
		List<Authority> list = memberService.authorityList(map);
		for(Authority authority : list) {
			authority.setCategoryName(memberService.getCategoryName(authority.getCategory_no()));
		}
		map.put("list", list);
		map.put("totalPage", memberService.totalPageAuthority(nickname));
		
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
		
		List<Authority> list = memberService.authorityAll(map);
		for(Authority authority : list) {
			authority.setCategoryName(memberService.getCategoryName(authority.getCategory_no()));
		}
		map.put("list", list);
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
	
	/**
	 * 권한 취소
	 * */
	@RequestMapping("authorityCancel.do")
	public void authorityCancel(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		HashMap<String, Object> map = new HashMap<>();
		map.put("no", request.getParameter("no"));
		map.put("state", 3);
		memberService.authorityUpdate(map);
		
		String nickname = request.getParameter("nickname");
		try {
			response.getWriter().write(nickname);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 에러페이지
	 * */
	@RequestMapping("errorPage.do")
	public String errorPage() {
		return "errorPage";
	}

}
