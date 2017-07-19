package controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import service.service;

@Controller
public class controller {
	
	@Autowired
	private service service;
	
	@RequestMapping("insert.do")
	public void insert(@RequestParam HashMap<String, Object> params){
		service.insert(params);

	}
	
	
	@RequestMapping("selectAll.do")
	public ModelAndView selectAll(){
		ModelAndView mav = new ModelAndView();
		
		
		
		mav.addObject("list", service.selectAll());
		mav.setViewName("connectResult");
		
		return mav;
	
	}

	

	

}
