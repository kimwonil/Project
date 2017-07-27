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
import service.DealService;

@Controller
public class DealControll {

	@Autowired
	DealService dealService;
	
	Gson gson = new Gson();
	
	/**
	 * 판매 현황 조회
	 * */
	@RequestMapping("sellingList.do")
	public void sellingList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String id = ((Member)session.getAttribute("member")).getId();
		List<Board> list = dealService.selectAll(id);
		
		for(Board board : list) {
			board.setCount(dealService.purchaseCount(board.getNo()));
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
		List<Purchase> list = dealService.purchase(id);
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
						 @RequestParam(value="no", required=false) Integer no,	
						 int state, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		System.out.println(paramArray+"1번");
//		System.out.println(no+"2번");
//		System.out.println(state);
		HashMap<String, Object> map = new HashMap<>();
		map.put("state", state);
		if(paramArray != null) {
			for(String purchase:paramArray) {
				map.put("purchase_no", purchase);
				dealService.progressState(map);
			}
		}
		
		if(no != null) {
			map.put("purchase_no", no);
			dealService.progressState(map);
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
		List<Board> list = dealService.selectAll(id);
	
		ArrayList<Object> array = new ArrayList<>();
		
		for(Board board : list) {
			List<Purchase> purchaseList = dealService.ongoingPurcharse(board.getNo());
			for(Purchase purchase : purchaseList) {
				purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
				purchase.setBoardTitle(board.getTitle());
			}
			array.add(purchaseList);
			
		}
//		System.out.println(array);
//		System.out.println(array.get(0));
//		System.out.println(array.get(1));
		
		
		String json = gson.toJson(array);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 판매관리의 진행중 거래 조회
	 * */
	@RequestMapping("completion.do")
	public void completion(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		String id = ((Member)session.getAttribute("member")).getId();
		List<Board> list = dealService.selectAll(id);
	
		ArrayList<Object> array = new ArrayList<>();
		
		for(Board board : list) {
			List<Purchase> purchaseList = dealService.completionPurcharse(board.getNo());
			for(Purchase purchase : purchaseList) {
				purchase.setOptionList(dealService.purchaseOption(purchase.getPurchase_no()));
				purchase.setBoardTitle(board.getTitle());
			}
			array.add(purchaseList);
			
		}
//		System.out.println(array);
//		System.out.println(array.get(0));
//		System.out.println(array.get(1));
		
		
		String json = gson.toJson(array);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}
