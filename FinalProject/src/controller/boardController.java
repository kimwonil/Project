package controller;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class boardController{
	
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
	


//	@Override
//	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		doGet(req, resp);
//	}
//	
//	@Override
//	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		String url1 = req.getRequestURI();
//		String context = req.getContextPath();
//		resp.setCharacterEncoding("UTF-8");
//		resp.setContentType("text/html; charset=UTF-8");
//		PrintWriter pw = resp.getWriter();
//		
//		if(url1.equals(context + "/searchAddr.do")){
//			System.out.println("searchAddr 하러 왔어");
//			String inputAddr = req.getParameter("inputAddr");
//			System.out.println("검색하려는 주소 : " + inputAddr);
//			
//			//주소검색 시작
//			String clientId = "yWnmGXGFAVlHFUidS2ri";//애플리케이션 클라이언트 아이디값";
//	        String clientSecret = "x1szaIQMgv";//애플리케이션 클라이언트 시크릿값";
//	        try {
//	            String text = URLEncoder.encode(inputAddr, "UTF-8");
//	            String apiURL = "https://openapi.naver.com/v1/search/local.json?query="+ text; // json 결과
//	            //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml 결과
//	            URL url = new URL(apiURL);
//	            HttpURLConnection con = (HttpURLConnection)url.openConnection();
//	            con.setRequestMethod("GET");
//	            con.setRequestProperty("X-Naver-Client-Id", clientId);
//	            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
//	            int responseCode = con.getResponseCode();
//	            BufferedReader br;
//	            if(responseCode==200) { // 정상 호출
//	                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
//	            } else {  // 에러 발생
//	                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
//	            }
//	            String inputLine;
//	            StringBuffer response = new StringBuffer();
//	            while ((inputLine = br.readLine()) != null) {
//	                response.append(inputLine);
//	            }
//	            br.close();
//	            System.out.println(response.toString());
//	            System.out.println("테스트  " + response);
//	           
//	            pw.println(response);
//	        } catch (Exception e) {
//	            System.out.println(e);
//	        }finally {
//				pw.close();
//			}
//		}
//	}
	


}
