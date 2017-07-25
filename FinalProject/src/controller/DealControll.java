package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

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
		
		
		
		
		
	}
	
	
}
