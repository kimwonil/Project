package controller;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import model.Board;
import model.MapInfo;
import model.Member;
import service.BoardService;


@Controller
public class BoardController{
	
	@Autowired
	private BoardService boardService;
	
	/**
	 * 검색 api
	 * */
	@RequestMapping("searchAddr.do")
	public void mapSearch(HttpServletRequest req, HttpServletResponse resp){
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		try {
			PrintWriter pw = resp.getWriter();
			
			System.out.println("searchAddr 하러 왔어");
			String inputAddr = req.getParameter("inputAddr");
			System.out.println("검색하려는 주소 : " + inputAddr);
			
			//주소검색 시작
			String clientId = "yWnmGXGFAVlHFUidS2ri";//애플리케이션 클라이언트 아이디값";
	        String clientSecret = "x1szaIQMgv";//애플리케이션 클라이언트 시크릿값";
	        
	        
	        String text = URLEncoder.encode(inputAddr, "UTF-8");
            String apiURL = "https://openapi.naver.com/v1/search/local.json?query="+ text; // json 결과
            //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml 결과
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
            System.out.println("테스트  " + response);
           
            pw.println(response);
	        
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	//////////////////////////////////////////////////////////////////////////////////////////////////
	/**
	 * 글쓰기
	 * */
	@RequestMapping("insertBoard.do")
	public void board(@RequestParam HashMap<String, Object> params, HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		
		String id = ((Member)session.getAttribute("member")).getId();
		params.put("id", id);
		
//		System.out.println("id찍어볼거야 = "+ id);
//		System.out.println("major ="+major+" / minor ="+minor);
//		System.out.println("제목" + title);
//		System.out.println("마감일" + end_date);
//		System.out.println("info_title : "+info_title+" / address : "+address+" / address2 : "+ address2 + " / 위도 : "+lat+" / 경도 : "+lng);
		
		boardService.insertBoard(params);
		System.out.println(params.get("no"));
		boardService.insertMap(params);

	}
	
	@RequestMapping("load.do")
	public String load(HttpServletRequest req, HttpServletResponse resp, HttpSession session){
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");

		System.out.println("load.do하러옴");
		session.setAttribute("list", boardService.selectAllBoard());
		return "main";
	}
	
	@RequestMapping("detailOneBoard.do")
	public ModelAndView selectOneBoard(HttpServletRequest req, HttpServletResponse resp, HttpSession session){
		System.out.println("detailOneBoard.do들어옴");
		int no = Integer.parseInt(req.getParameter("no"));
		
		//board 테이블에서 가져온 정보
		ModelAndView mav = new ModelAndView();
		mav.addObject("board", boardService.selectOneBoard(no));
		mav.setViewName("detail");
		
		//map 테이블에서 가져온 정보
		System.out.println(boardService.selectOneMap(no));
		mav.addObject("mapinfo", boardService.selectOneMap(no));
		return mav;
	}


	


}
