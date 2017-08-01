package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.rmi.ssl.SslRMIClientSocketFactory;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import model.Board;
import model.Member;
import model.Purchase;
import model.PurchaseOption;
import service.BoardService;
import service.DealService;

@Controller
public class DealControll {

	@Autowired
	DealService dealService;
	
	@Autowired
	BoardService boardService;
	
	Gson gson = new Gson();
	
	/**
	 * 판매 현황 조회
	 * */
	@RequestMapping("sellingList.do")
	public void sellingList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String id = ((Member)session.getAttribute("member")).getId();
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
		String id = ((Member)session.getAttribute("member")).getId();
		int state = Integer.parseInt(request.getParameter("state"));
		List<Purchase> list = null;
		if(state == 20) {
			list = dealService.purchaseComplete(id);
		}else {
			list = dealService.purchase(id);
		}
		
		for(Purchase purchase : list) {
			Board board = dealService.boardInfo(purchase.getNo());
			purchase.setBoardTitle(board.getTitle());
			purchase.setSeller(board.getWriter());
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
						 @RequestParam(value="purchase_no", required=false) Integer purchase_no, int state,
						 @RequestParam(value="board_no", required=false) int board_no,
						 @RequestParam(value="star", required=false) int star,
						 @RequestParam(value="content", required=false) String content,
						 HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		System.out.println(paramArray+"1번");
//		System.out.println(no+"2번");
//		System.out.println(state);
		
		System.out.println("progress.do");
		System.out.println(star);
		System.out.println(content);
		System.out.println(state);
		System.out.println(purchase_no);
		
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("state", state);
		
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
			map.put("nickname", member.getNickName());
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
		
		String id = ((Member)session.getAttribute("member")).getId();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("page", page);
		
		List<Board> list = dealService.selectAll(map);
		ArrayList<Object> array = new ArrayList<>();
		System.out.println(list);
		for(Board board : list) {
			List<Purchase> purchaseList = dealService.ongoingPurcharse(board.getNo());
			System.out.println(purchaseList);
			for(Purchase purchase : purchaseList) {
				purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
				purchase.setBoardTitle(board.getTitle());
			}
			array.add(purchaseList);
			
		}
//		System.out.println(array);
//		System.out.println(array.get(0));
//		System.out.println(array.get(1));
		map.put("list", array);
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
	 * 판매관리의  완료 거래 조회
	 * */
	@RequestMapping("completion.do")
	public void completion(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		String id = ((Member)session.getAttribute("member")).getId();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("page", page);
		List<Board> list = dealService.selectAll(map);
		System.out.println(list);
		ArrayList<Object> array = new ArrayList<>();
		
		for(Board board : list) {
			List<Purchase> purchaseList = dealService.completionPurcharse(board.getNo());
			System.out.println(purchaseList);
			for(Purchase purchase : purchaseList) {
				purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
				purchase.setBoardTitle(board.getTitle());
				System.out.println(purchase);
			}
			array.add(purchaseList);
			
		}
//		System.out.println(array);
//		System.out.println(array.get(0));
//		System.out.println(array.get(1));
		
		map.put("list", array);
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
	 * 판매관리의  취소된 거래 조회
	 * */
	@RequestMapping("canceledList.do")
	public void canceledList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		String id = ((Member)session.getAttribute("member")).getId();
		int page = Integer.parseInt(request.getParameter("page"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("page", page);
		List<Board> list = dealService.selectAll(map);
		System.out.println(list);
		ArrayList<Object> array = new ArrayList<>();
		
		for(Board board : list) {
			List<Purchase> purchaseList = dealService.completionPurcharse(board.getNo());
			System.out.println(purchaseList);
			for(Purchase purchase : purchaseList) {
				purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
				purchase.setBoardTitle(board.getTitle());
				System.out.println(purchase);
			}
			array.add(purchaseList);
			
		}
//		System.out.println(array);
//		System.out.println(array.get(0));
//		System.out.println(array.get(1));
		
		map.put("list", array);
		map.put("totalPage", dealService.totalPageCompletion(id));		
		String json = gson.toJson(map);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
//	/**
//	 * 구매관리 완료된 거래 조회
//	 * */
//	@RequestMapping("completePurchase.do")
//	public void completePurchase(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		response.setHeader("Content-Type", "application/xml");
//		response.setContentType("text/xml;charset=UTF-8");
//		
//		
//		
//		
//	}
	
	
	
}
