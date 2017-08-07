package controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.rmi.ssl.SslRMIClientSocketFactory;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.DateFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import model.Board;
import model.Member;
import model.Premium;
import model.Purchase;
import model.PurchaseOption;
import service.BoardService;
import service.DealService;
import service.MemeberService;

@Controller
public class DealControll {

	@Autowired
	DealService dealService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	MemeberService memberService;
	
	Gson gson = new Gson();
	
	/**
	 * 판매관리 페이지 이동
	 * */
	@RequestMapping("selling.do")
	public String selling(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int admin = ((Member)session.getAttribute("member")).getAdmin();
		
		if(admin == 1) {
			return "sellingManager";
		}else {
			return "selling";
		}
	}
	
	/**
	 * 구매관리 페이지 이동
	 * */
	@RequestMapping("purchasing.do")
	public String purchasing(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		int admin = ((Member)session.getAttribute("member")).getAdmin();
		
		if(admin == 1) {
			return "purchasingManager";
		}else {
			return "purchasing";
		}
	}
	
	/**
	 * 판매 현황 조회
	 * */
	@RequestMapping("sellingList.do")
	public void sellingList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String id = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("page", page);
		
		List<Board> list = dealService.selectAll(map);
		System.out.println(list);
		for(Board board : list) {
			board.setCount(dealService.purchaseCount(board.getNo()));
		}
		map.put("list", list);
		map.put("totalPage", dealService.totalPageSelling(id));
		
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 판매 현황 조회(관리자)
	 * */
	@RequestMapping("sellingListManager.do")
	public void sellingListManager(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String id = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("page", page);
		
		List<Board> list = dealService.selectAllManager(map);
		for(Board board : list) {
			board.setCount(dealService.purchaseCount(board.getNo()));
		}
		map.put("list", list);
		map.put("totalPage", dealService.totalPageSellingManager());
		
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
	
	/**
	 * 판매글에 등록된 구매자 현황 조회
	 * */
	@RequestMapping("purchaseList.do")
	public void purchaseList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		int no = Integer.parseInt(request.getParameter("no"));
		
		List<Purchase> list = dealService.purchaseList(no);
		
		for(Purchase purchase:list) {
			purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
		}
		
		String json = gson.toJson(list);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 구매 현황 조회
	 * */
	@RequestMapping("purchase.do")
	public void purchase(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String id = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		int state = Integer.parseInt(request.getParameter("state"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("page", page);
		List<Purchase> list = null;
		if(state == 20) {
			list = dealService.purchaseComplete(map);
			map.put("totalPage", dealService.totalPagePurchaseComplete(id));
		}else if(state == 40) {
			list = dealService.purchaseCanceled(map);
			map.put("totalPage", dealService.totalPagePurchaseCanceled(id));
		}else {
			list = dealService.purchase(map);
			map.put("totalPage", dealService.totalPagePurchase(id));
		}
		
		for(Purchase purchase : list) {
			Board board = dealService.boardInfo(purchase.getNo());
			purchase.setBoardTitle(board.getTitle());
			purchase.setSeller(board.getWriter());
			purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
		}
		map.put("list", list);
		
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 구매 현황 조회
	 * */
	@RequestMapping("purchaseManager.do")
	public void purchaseManager(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
//		String id = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		int state = Integer.parseInt(request.getParameter("state"));
		HashMap<String, Object> map = new HashMap<>();
//		map.put("id", id);
		map.put("page", page);
		List<Purchase> list = null;
		if(state == 20) {
			list = dealService.purchaseCompleteManager(map);
			map.put("totalPage", dealService.totalPagePurchaseCompleteManager());
		}else if(state == 40) {
			list = dealService.purchaseCanceledManager(map);
			map.put("totalPage", dealService.totalPagePurchaseCanceledManager());
		}else {
			list = dealService.purchaseManager(map);
			map.put("totalPage", dealService.totalPagePurchaseManager());
		}
		
		for(Purchase purchase : list) {
			Board board = dealService.boardInfo(purchase.getNo());
			purchase.setBoardTitle(board.getTitle());
			purchase.setSeller(board.getWriter());
			purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
		}
		map.put("list", list);
		
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 구매 관리 옵션 조회
	 * */
	@RequestMapping("purchaseOption.do")
	public void purchaseOption(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		int no = Integer.parseInt(request.getParameter("no"));
		
		List<PurchaseOption> list = dealService.purchaseOption(no);
		
		String json = gson.toJson(list);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 판매글에 등록된 구매자 상태 변환
	 * */
	@RequestMapping("progress.do")
	public void progress(@RequestParam(value="list", required=false) List<String> paramArray,
						 @RequestParam(value="purchase_no", required=false) Integer purchase_no, 
						 int state,
						 @RequestParam(value="no", required=false) Integer no,
						 @RequestParam(value="amount", required=false) Integer amount,
						 @RequestParam(value="board_no", required=false) Integer board_no,
						 @RequestParam(value="star", required=false) Integer star,
						 @RequestParam(value="content", required=false) String content,
						 HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("state", state);
		map.put("id", ((Member)session.getAttribute("member")).getNickname());
		if(no != null) {
			map.put("purchase_no", no);
			dealService.progressState(map);
			if(state==42) {
				int total = dealService.optionTotal(no);
				String purchaser = dealService.purchaseName(no);
				map.put("total", total);
				map.put("purchaser", purchaser);
				memberService.returnBalance(map);
			}
		}
		
		if(amount != null) {
			map.put("amount", amount);
			map.put("purchase_no", no);
			
			dealService.progressState(map);
			
			dealService.calculate(map);
			
			map.put("title", dealService.selectOneBoard(dealService.recordCashInfo(map)));
			Member member = memberService.selectOne(map.get("id").toString());
			map.put("balance", member.getBalance());
			map.put("state", 4);
			dealService.recordCash(map);
			
			session.setAttribute("member", member);
			
			try {
				DecimalFormat number = new DecimalFormat("#,###");
				String balance = number.format(member.getBalance());
				map.put("balanceResult", balance);
				String json = gson.toJson(map);
				response.getWriter().write(json);
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
		
		if(paramArray != null) { //판매자
			for(String purchase:paramArray) {
				map.put("purchase_no", purchase);
				dealService.progressState(map);
			}
		}
		
		if(purchase_no != null) { //구매자
			map.put("purchase_no", purchase_no);
			dealService.progressState(map);
			
			//star_point에 insert
			Member member = (Member)session.getAttribute("member");
			map.put("nickname", member.getNickname());
			map.put("board_no", board_no);
			map.put("purchase", purchase_no);
			map.put("content", content);
			map.put("star", star);
			dealService.insertStar_point(map);
			
			//board에 total_star와 num_evaluator 누적
			HashMap<String, Object> boardMap = new HashMap<>();
			boardMap.put("board_no", board_no);
			boardMap.put("star", star);
			boardService.updateStar(boardMap);
		}
		
		
	}
	
	
	/**
	 * 판매관리의 진행중 거래 조회
	 * */
	@RequestMapping("ongoing.do")
	public void ongoing(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		String id = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("page", page);
		
		List<Purchase> purchaseList = dealService.ongoingPurcharse(map);
		for(Purchase purchase : purchaseList) {
			purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
			purchase.setBoardTitle(dealService.selectOneBoard(purchase.getNo()));
		}
		
		
		map.put("list", purchaseList);
		map.put("totalPage", dealService.totalPageOngoing(id));
		
		
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 판매관리의 진행중 거래 조회(관리자)
	 * */
	@RequestMapping("ongoingManager.do")
	public void ongoingManager(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
//		String id = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
//		map.put("id", id);
		map.put("page", page);
		
		List<Purchase> purchaseList = dealService.ongoingPurcharseManager(map);
		for(Purchase purchase : purchaseList) {
			purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
			purchase.setBoardTitle(dealService.selectOneBoard(purchase.getNo()));
		}
		
		
		map.put("list", purchaseList);
		map.put("totalPage", dealService.totalPageOngoingManager());
		
		
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 판매관리의  완료 거래 조회
	 * */
	@RequestMapping("completion.do")
	public void completion(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		String id = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("page", page);
		
		List<Purchase> purchaseList = dealService.completionPurcharse(map);
		for(Purchase purchase : purchaseList) {
			purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
			purchase.setBoardTitle(dealService.selectOneBoard(purchase.getNo()));
		}
		
		
		map.put("list", purchaseList);
		map.put("totalPage", dealService.totalPageCompletion(id));
		
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 판매관리의  완료 거래 조회(관리자)
	 * */
	@RequestMapping("completionManager.do")
	public void completionManager(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
//		String id = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
//		map.put("id", id);
		map.put("page", page);
		
		List<Purchase> purchaseList = dealService.completionPurcharseManager(map);
		for(Purchase purchase : purchaseList) {
			purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
			purchase.setBoardTitle(dealService.selectOneBoard(purchase.getNo()));
		}
		
		
		map.put("list", purchaseList);
		map.put("totalPage", dealService.totalPageCompletionManager());
		
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 판매관리의  취소된 거래 조회
	 * */
	@RequestMapping("canceledList.do")
	public void canceledList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		String id = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("page", page);
		
		List<Purchase> purchaseList = dealService.canceledPurcharse(map);
		for(Purchase purchase : purchaseList) {
			purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
			purchase.setBoardTitle(dealService.selectOneBoard(purchase.getNo()));
		}
		
		
		map.put("list", purchaseList);
		map.put("totalPage", dealService.totalPageCanceled(id));
		
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 판매관리의  취소된 거래 조회(관리자)
	 * */
	@RequestMapping("canceledListManager.do")
	public void canceledListManager(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
//		String id = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
//		map.put("id", id);
		map.put("page", page);
		
		List<Purchase> purchaseList = dealService.canceledPurcharseManager(map);
		for(Purchase purchase : purchaseList) {
			purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
			purchase.setBoardTitle(dealService.selectOneBoard(purchase.getNo()));
		}
		
		
		map.put("list", purchaseList);
		map.put("totalPage", dealService.totalPageCanceledManager());
		
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 프리미엄 내역 조회
	 * */
	@RequestMapping("premiumList.do")
	public void premiumList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String nickname = ((Member)session.getAttribute("member")).getNickname();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("nickname", nickname);
		map.put("page", page);
		List<Premium> list = boardService.premiumList(map);
		
		for(Premium premium : list) {
			premium.setTitle(boardService.selectOneBoard(premium.getBoard_no()).getTitle());
			DecimalFormat number = new DecimalFormat("#,###");
			String formatPrice = number.format(premium.getPrice());
			premium.setFormatPrice(formatPrice);
			premium.strDate();
		}
		
		map.put("list", list);
		map.put("totalPage", boardService.totalPagePremium(nickname));
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 프리미엄 신청
	 * */
	@RequestMapping("premiumSelect.do")
	public void premiumSelect(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		int no = Integer.parseInt(request.getParameter("no"));
		Board board = boardService.selectOneBoard(no);
		
		String msg="";
		System.out.println(board.getPremium());
		if(board.getPremium() == 0) {
			msg = "{\"result\":false}";
		}else {
			msg = "{\"result\":true, \"title\":\""+board.getTitle()+"\"}";
		}
		
		System.out.println(msg);
		
		try {
			response.getWriter().write(msg);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 프리미엄 등록
	 * */
	@RequestMapping("premiumUpdate.do")
	public void premiumUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session){
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		HashMap<String, Object> map = new HashMap<>();
		String nickname = ((Member)session.getAttribute("member")).getNickname();
		int premium = Integer.parseInt(request.getParameter("premium"));
		int no = Integer.parseInt(request.getParameter("no"));
		int time = Integer.parseInt(request.getParameter("time"));
		int price = 0;
		
		if(time == 7) {
			price = 10000;
		}else if(time == 14) {
			price = 20000;
		}else if(time == 30) {
			price = 40000;
		}else {
			price = 60000;
		}
		map.put("nickname", nickname);
		map.put("premium", premium);
		map.put("no", no);
		map.put("time", time);
		map.put("price", price);
		
		
		
		
		
		
		try {
			if(boardService.premiumCount()>=20) {
				map.put("state", 1);
				
				Calendar cal = Calendar.getInstance();
				//가장 짧은 종료 날짜 조회하여 현재 날짜로 세팅
				cal.setTime(boardService.premiumEndDate());
				//그 다음날로 해서 시작 날짜 설정
				cal.add(cal.DATE, 1);
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				map.put("start", format.format(cal.getTime()));
				//내가 신청한 날짜 만큼 증가 후 종료 날짜 설정
				cal.add(cal.DATE, time);
				map.put("end", format.format(cal.getTime()));
				
				//기존 등록 여부 확인
				if(boardService.newPremium(no).getBoard_no() != no) {
					//대기열 등록
					boardService.premiumWaitting(map);
				}else {
					//기존 등록 수정
					boardService.premiumUpdate(map);
				}
				response.getWriter().write("프리미엄 대기에 등록 되었습니다.");
				
			}else {
				Calendar cal = Calendar.getInstance();
				map.put("state", 2);
				map.put("start", cal.getTime());
				cal.add(cal.DATE, time);
				map.put("end", cal.getTime());
				
				
				boardService.premiumWaitting(map);
				boardService.premium(map);
				response.getWriter().write("프리미엄이 등록 되었습니다.");
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}
