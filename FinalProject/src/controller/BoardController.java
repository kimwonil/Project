package controller;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import model.Board;
import model.FileUpload;
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
	

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/**
	 * main화면 전체글 로드
	 * */
	@RequestMapping("load.do")
	public String load(HttpServletRequest req, HttpServletResponse resp, HttpSession session){
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");
		
		System.out.println("load.do하러옴");
		session.setAttribute("list", boardService.selectAllBoard());
		return "main";
	}

	
	/**
	 * 글쓰기
	 * */
	@RequestMapping("insertBoard.do")
	public ModelAndView board(
			@RequestParam HashMap<String, Object> params, @RequestParam(value="option[]") List<String> paramArray1, 
			@RequestParam(value="optionPrice[]") List<String> paramArray2, FileUpload files, 
			HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		System.out.println("글넣기");
		
		//세션에서 id가져와성 params에 넣자
		String id = ((Member)session.getAttribute("member")).getId();
		params.put("id", id);
		
		//사진을 가져오자
		List<MultipartFile> fileList = files.getFiles();
		int fileNo = 1;
		for(MultipartFile file : fileList){
			System.out.println(file.getOriginalFilename());
			params.put("file_name"+fileNo, file.getOriginalFilename());
			fileNo++;
		}
		//table:board에 넣기
		boardService.insertBoard(params);
		System.out.println(params.get("no"));
		int no = Integer.parseInt(params.get("no").toString());
		
		//info_address가 있으면 table:map에 넣기
		if(params.get("info_address") != null){
			boardService.insertMap(params);
		}

		//files가 있으면 table:file에 넣기
		if(files != null){
			boardService.insertFile(params);
		}
		
		//table : board_option
		if(paramArray1 != null){
			HashMap<String, Object> board_option = new HashMap<>();
			board_option.put("no", no);
			for(int i=0;i<paramArray1.size();i++){
				board_option.put("kind", paramArray1.get(i));
				board_option.put("price", paramArray2.get(i));
				boardService.insertBoard_option(board_option);
			}
			
		}
		
		
		//사진이 저장될 위치 만들어주기
		String path = session.getServletContext().getRealPath("/user/board/");
		System.out.println(path);
		MultipartFile file1 = fileList.get(0); //fileList에 들어있는 파일들을 하나씩 꺼내주고
		MultipartFile file2 = fileList.get(1);
		MultipartFile file3 = fileList.get(2);
		MultipartFile file4 = fileList.get(3);
		
		File dir = new File(path+no);//각각의 글에 해당하는 파일이 들어갈 폴더생성
		if(!dir.isDirectory()){//폴더가 없으면 생성
			dir.mkdirs();
		}
		
			try {
				if(file1 != null){
					file1.transferTo(new File(path+no+"/"+file1.getOriginalFilename()));
				}
				if(file2 != null){
					file2.transferTo(new File(path+no+"/"+file2.getOriginalFilename()));
				}
				if(file3 != null){
					file3.transferTo(new File(path+no+"/"+file3.getOriginalFilename()));
				}
				if(file4 != null){
					file4.transferTo(new File(path+no+"/"+file4.getOriginalFilename()));
				}
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		
		//다시 뽑아서 글상세에서 보여주깅
		ModelAndView mav = new ModelAndView();
		mav.setViewName("detail");
		mav.addObject("board", boardService.selectOneBoard(no));//board 뽑아서 가져오고
		if(boardService.selectOneMap(no) != null){//map 뽑아서 가져오고
			mav.addObject("mapinfo", boardService.selectOneMap(no));
		}
		if(boardService.selectOneFromFile(no) != null){//file뽑아서 가져오고
			mav.addObject("fileinfo", boardService.selectOneFromFile(no));
		}
		if(boardService.selectBoard_option(no) != null){
			mav.addObject("board_option", boardService.selectBoard_option(no));
		}
		
		return mav;
	}
	
	
	/**
	 * 글상세
	 * */
	@RequestMapping("detailOneBoard.do")
	public ModelAndView selectOneBoard(HttpServletRequest req, HttpServletResponse resp, HttpSession session){
		System.out.println("detailOneBoard.do들어옴");
		int no = Integer.parseInt(req.getParameter("no"));
		
		//board 테이블에서 가져온 정보
		ModelAndView mav = new ModelAndView();
		mav.addObject("board", boardService.selectOneBoard(no));
		mav.setViewName("detail2");
		if(boardService.selectOneFromFile(no) != null){//file뽑아서 가져오고
			mav.addObject("fileinfo", boardService.selectOneFromFile(no));
		}
		if(boardService.selectBoard_option(no) != null){
			System.out.println("컨트롤러에 selectOneBoard_option하러왔엉");
			System.out.println(boardService.selectBoard_option(no));
			mav.addObject("board_option", boardService.selectBoard_option(no));
		}
		
		
		return mav;
	}
	
	@RequestMapping("detailOneBoard2.do")
	public ModelAndView selectOneBoard2(HttpServletRequest req, HttpServletResponse resp, HttpSession session){
		System.out.println("detailOneBoard.do들어옴");
		int no = Integer.parseInt(req.getParameter("no"));
		
		//board 테이블에서 가져온 정보
		ModelAndView mav = new ModelAndView();
		mav.addObject("board", boardService.selectOneBoard(no));
		mav.setViewName("detail3");
		if(boardService.selectOneFromFile(no) != null){//file뽑아서 가져오고
			mav.addObject("fileinfo", boardService.selectOneFromFile(no));
		}
		if(boardService.selectBoard_option(no) != null){
			System.out.println("컨트롤러에 selectOneBoard_option하러왔엉");
			System.out.println(boardService.selectBoard_option(no));
			mav.addObject("board_option", boardService.selectBoard_option(no));
		}
		
		
		return mav;
	}
	
	@RequestMapping("selectOneMap.do")
	public void selectOneMap(HttpServletRequest req, HttpServletResponse resp){
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");
		
		System.out.println("mapinfo 가지러 들어왔엉");
		System.out.println(req.getParameter("board_no"));
		int board_no = Integer.parseInt(req.getParameter("board_no"));
		if(boardService.selectOneMap(board_no) == null){
			System.out.println("이거 지도 없다요");
		}else{
			System.out.println(boardService.selectOneMap(board_no));

			Gson gson = new Gson();
			String mapinfo=gson.toJson(boardService.selectOneMap(board_no));
			
			try {
				PrintWriter pw;
				pw = resp.getWriter();
				pw.write(mapinfo);

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	
	/**
	 * 글수정
	 * */
	@RequestMapping("updateBoardForm.do")
	public ModelAndView updateBoardForm(int no){
		System.out.println("updateBoardForm.do");
		ModelAndView mav = new ModelAndView();
		mav.addObject("board", boardService.selectOneBoard(no));
		mav.setViewName("updateBoard");
		
		//map에서 주소 뽑아서 넣어주기
		mav.addObject("mapinfo", boardService.selectOneMap(no));
		
		return mav;
	}
	
	@RequestMapping("updateBoard.do")
	public ModelAndView updateOneBoard(@RequestParam HashMap<String, Object> params, HttpServletRequest req, HttpServletResponse resp, HttpSession session){
		System.out.println("updateBoard.do");
		int no = Integer.parseInt(params.get("no").toString());
		Board board = boardService.selectOneBoard(no);
		params.put("read_count", board.getRead_count());
		params.put("premium", board.getPremium());
		params.put("total_star", board.getTotal_star());
		params.put("num_evaluator", board.getNum_evaluator());
		System.out.println(params);

		//board, map 수정하기
		boardService.updateBoard(params);
		boardService.updateMap(params);
		
		//수정 후 페이지 이동
		ModelAndView mav = new ModelAndView();
		mav.addObject("board", board);
		mav.addObject("mapinfo", boardService.selectOneMap(no));
		mav.setViewName("detail");
		return mav;
	}
	
	
	/**
	 * 옵션추가할 경우
	 * */
	@RequestMapping("searchOption.do")
	public void price(@RequestParam HashMap<String, Object> params, HttpServletRequest req, HttpServletResponse resp){
		System.out.println("searchOption.do");
		String kind = params.get("kind").toString();
		int no = Integer.parseInt(params.get("no").toString());
		System.out.println("글번호 = "+no+" / 옵션종류 = "+kind);
		
		try {
			PrintWriter pw = resp.getWriter();
			Gson gson = new Gson();
			String json = gson.toJson(boardService.selectKind(params));
			pw.write(json);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}


	


}
