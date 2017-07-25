package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import model.Board;
import model.Member;
import model.Purchase;
import service.DealService;

@Controller
public class DealControll {

	@Autowired
	DealService service;
	
	Gson gson = new Gson();
	
	
	@RequestMapping("sellingList.do")
	public void sellingList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		String id = ((Member)session.getAttribute("member")).getId();
		List<Board> list = service.selectAll(id);
		
		for(Board board : list) {
			board.setCount(service.purchaseCount(board.getNo()));
		}
		
		String json = gson.toJson(list);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	@RequestMapping("purchaseList.do")
	public void purchaseList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setHeader("Content-Type", "application/xml");
		response.setContentType("text/xml;charset=UTF-8");
		
		int no = Integer.parseInt(request.getParameter("no"));
		
		List<Purchase> list = service.purchaseList(no);
		
		for(Purchase purchase:list) {
			purchase.setOptionList(service.purchaseOption(purchase.getNo()));
		}
		
		String json = gson.toJson(list);
		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
}
