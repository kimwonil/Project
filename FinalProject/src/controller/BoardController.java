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
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import model.Board;
import model.Category;
import model.FileUpload;
import model.MapInfo;
import model.Member;
import model.Purchase;
import model.PurchaseOption;
import service.BoardService;
import service.DealService;


@Controller
public class BoardController{
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private DealService dealService;
	
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
	public ModelAndView load(HttpServletRequest req, HttpServletResponse resp, HttpSession session){
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");
		ModelAndView mav = new ModelAndView();
		
		//프리미엄 - 메인에 뿌려주러 가기 전에 썸네일들도 가져갈거양
		List<Board> premiumList = new ArrayList<>();
		for(Board board : boardService.selectAllPremiumBoard()){
			int no = board.getNo();//글번호
			String file_name1 = boardService.selectThumbnail(no);
			board.setFile_name1(file_name1);
			premiumList.add(board);
		}//selectAllPremiumBoard에 각각 file_name1 넣기 끝
		
		//일반 - 메인에 뿌려주러 가기 전에 썸네일들도 가져갈거양
		List<Board> normalList = new ArrayList<>();
		for(Board board : boardService.selectAllNormalBoard()){
			int no = board.getNo();//글번호
			String file_name1 = boardService.selectThumbnail(no);
			board.setFile_name1(file_name1);
			normalList.add(board);
		}//selectAllPremiumBoard에 각각 file_name1 넣기 끝
		
		
		mav.addObject("premiumList", premiumList);
		mav.addObject("normalList", normalList);
		mav.setViewName("board/main");
		return mav;
	}
	
	
	/**
	 * 판매등록하러 갈거야
	 * */
	@RequestMapping("boardForm.do")
	public ModelAndView boardForm(){
		ModelAndView mv = new ModelAndView();
		
		List<Category> categoryList = boardService.category();
		
		mv.addObject(categoryList);
		mv.setViewName("board/boardForm");
		
		return mv;
	}
	
	/**
	 * 카테고리 소분류
	 * */
	@RequestMapping("categoryLow.do")
	public void categoryLow(int high_no, HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");
		
		List<Category> list = boardService.categoryLow(high_no);
		Gson gson = new Gson();
		String json = gson.toJson(list);
		try {
			resp.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 글쓰기(판매등록)
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
		mav.setViewName("board/detail");
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
		Board board = boardService.selectOneBoard(no);
		board.setCount(dealService.purchaseCount(no));
		board.rating();
		
		
		mav.addObject("board", board);
		
		mav.setViewName("board/detail");
		
		if(boardService.selectOneFromFile(no) != null){//file뽑아서 가져오고
			mav.addObject("files", boardService.selectOneFromFile(no));
		}
		if(boardService.selectBoard_option(no) != null){
			System.out.println("컨트롤러에 selectOneBoard_option하러왔엉");
			System.out.println(boardService.selectBoard_option(no));
			mav.addObject("board_option", boardService.selectBoard_option(no));
		}
		
		
		return mav;
	}

	
	/**
	 * 글상세에서 ajax로 지도 가져올때 
	 * */
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
	 * 글상세에서 사용자리뷰탭
	 * */
	@RequestMapping("selectUserReview.do")
	public void selectUserReview(HttpServletRequest req, HttpServletResponse resp){
		System.out.println("selectUserReview.do");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");
		int no = Integer.parseInt(req.getParameter("no").toString());
		
		PrintWriter pw;
		Gson gson = new Gson();
		try {
			//star_point에서 글번호로 리스트 뽑고
			pw = resp.getWriter();
			String json = gson.toJson(boardService.selectUserReview(no));
			System.out.println(json);
			pw.write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	/**
	 * 글수정 폼요청
	 * */
	@RequestMapping("updateBoardForm.do")
	public ModelAndView updateBoardForm(int no){
		System.out.println("updateBoardForm.do");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/updateBoard");

		//board 뽑아서 보내기
		mav.addObject("board", boardService.selectOneBoard(no));
		
		//map에서 주소 뽑아서 보내기
		mav.addObject("mapinfo", boardService.selectOneMap(no));
		
		//board_option 뽑아서 보내기
		mav.addObject("board_optionList", boardService.selectBoard_option(no));
		
		mav.addObject("files", boardService.selectOneFromFile(no));
		return mav;
	}
	
	
	/**
	 * 글수정하기
	 * */
	@RequestMapping("updateBoard.do")
	public ModelAndView updateOneBoard(
			HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			@RequestParam HashMap<String, Object> params, 
			@RequestParam(value="option[]", required=false) List<String> paramArray1, 
			@RequestParam(value="optionPrice[]", required=false) List<String> paramArray2, 
			FileUpload files){
		System.out.println("updateBoard.do");
		int no = Integer.parseInt(params.get("no").toString());
		Board board = boardService.selectOneBoard(no);
		String id = board.getWriter();
		params.put("id", id);
		params.put("no", no);
		
		System.out.println(paramArray1);
		System.out.println(paramArray2);

		//board, map, board_option, file 수정하기
		boardService.updateBoard(params);
		boardService.updateMap(params);
		boardService.deleteBoard_option(no);//board_option에서 글번호에 해당하는 옵션을 다 지우고
		if(paramArray1 != null){//입력받은 옵션들로 새로 넣어주는거야
			HashMap<String, Object> board_option = new HashMap<>();
			board_option.put("no", no);
			for(int i=0;i<paramArray1.size();i++){
				board_option.put("kind", paramArray1.get(i));
				board_option.put("price", paramArray2.get(i));
				boardService.insertBoard_option(board_option);
			}
		}
		
		//file수정
		//사진을 가져오자
		List<MultipartFile> fileList = files.getFiles();
		int fileNo = 1;
		for(MultipartFile file : fileList){
			System.out.println(file.getOriginalFilename());
			params.put("file_name"+fileNo, file.getOriginalFilename());
			fileNo++;
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
			
		//files가 있으면 수정하기
		if(files != null){
			boardService.updateFile(params);
		}
		
		//수정 후 페이지 이동
		ModelAndView mav = new ModelAndView();
		mav.addObject("board", boardService.selectOneBoard(no));
		mav.addObject("mapinfo", boardService.selectOneMap(no));
		mav.addObject("board_optionList", boardService.selectBoard_option(no));
		mav.addObject("files", boardService.selectOneFromFile(no));
		mav.setViewName("board/detail");
		return mav;
	}
	
	
	/**
	 * 옵션추가할 경우
	 * */
	@RequestMapping("searchOption.do")
	public void price(@RequestParam HashMap<String, Object> params, HttpServletRequest req, HttpServletResponse resp){
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");
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
	
	
	/**
	 * 찜하기
	 * */
	@RequestMapping("dips.do")
	public void interest(HttpServletRequest req, HttpServletResponse resp, HttpSession session){
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		System.out.println("찜하기  interest.do");
		int board_no = Integer.parseInt(req.getParameter("no").toString());
//		Object member = session.getAttribute("member");
		Member member = (Member)session.getAttribute("member");
		try {
			PrintWriter pw = resp.getWriter();
			if(member == null){
				pw.println("로그인 후에 찜할 수 있습니다");
			}else{
				String id = member.getId();
				HashMap<String, Object> params = new HashMap<>();
				params.put("board_no", board_no);
				params.put("id", id);
				
				if(boardService.selectOneInterest(params) != null){
					pw.println("이미 찜한 글입니다");
				}else{
					//interest table에 글번호 insert
					boardService.insertInterest(params);
					pw.println("성공");
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 찜목록으로 가기
	 * */
	@RequestMapping("dipsList.do")
	public ModelAndView selectMyDips(String id){
		System.out.println("dipsList.do");
		System.out.println(id);
		ModelAndView mav = new ModelAndView();
		
		List<Board> dipsList = new ArrayList<>();
		
		//해당 id가 찜한 글번호들
		for(HashMap<String, Object> dips : boardService.selectAllDips(id)){
			int no = Integer.parseInt(dips.get("board_no").toString());
			Board board = boardService.selectOneBoard(no);
			board.setFile_name1(boardService.selectThumbnail(no));
			dipsList.add(board);
		}
		mav.addObject("dipsList", dipsList);
		
		
		
		mav.setViewName("board/dipsList");
		return mav;
	}


	/**
	 * 구매하기 버튼 누르면!
	 * */
	@RequestMapping("thisIsAllMine.do")
	public void thisIsAllMine(int no, int totalPrice,
			@RequestParam(value="kind") List<String> kindArr,
			@RequestParam(value="price") List<String> priceArr,
			@RequestParam(value="quantity") List<String> quantityArr,
			HttpSession session, HttpServletRequest req, HttpServletResponse resp){
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		System.out.println("thisIsAllMine.do");
		System.out.println(no);
		System.out.println(kindArr);
		System.out.println(priceArr);
		System.out.println(quantityArr);
		System.out.println(totalPrice);
		Member member = (Member)session.getAttribute("member");
		//1. 세션확인
		//2. 구매자 포인트 충분한지 확인
		//3. 정보들 가져와서 purchase, purchase_option, 구매자의 cash테이블 수정, board(quantity에 마이너스 해줘)
		
		try {
			PrintWriter pw = resp.getWriter();
			if(member == null){//로그인이 안된 상태면
				pw.println("{\"result\" : \"로그인 후에 구매할 수 있습니다\", \"state\" : 0}");
			}else if(boardService.selectOneBoard(no).getQuantity() < Integer.parseInt((quantityArr.get(0)).toString())){//판매 잔여량이 기본항목 구매수량 이상이어야 해
				pw.println("{\"result\" : \"잔고 수량이 부족합니다\", \"state\" : 0}");
			}else if(member.getBalance()<totalPrice){//구매자 잔여캐시<금액
				pw.println("{\"result\" : \"캐시가 부족합니다\", \"state\" : 0}");
			}else{//성고옹!
				//purchase
				Purchase purchase = new Purchase(0, no, member.getId(), 0, null);
				dealService.insertPurchase(purchase);
				int purchaseNo = purchase.getPurchase_no();
				
				//purchase_option
				for(int i=0; i<kindArr.size(); i++){
					PurchaseOption option = new PurchaseOption(0, purchaseNo, kindArr.get(i), Integer.parseInt(priceArr.get(i).toString()), Integer.parseInt(quantityArr.get(i).toString()));
					dealService.insertPurchaseOption(option);
				}
				
				//구매자 포인트 제하기
				HashMap<String, Object> params = new HashMap<>();
				params.put("totalPrice", totalPrice);
				params.put("id", member.getId());
				dealService.minusCash(params);
				
//				//board quantity에서 제하기
//				params.put("reduce", Integer.parseInt((quantityArr.get(0)).toString()));//redue가 기본항목 구매량이얌	
//				params.put("no", no);
//				boardService.reduceQuantity(params);
				pw.println("{\"result\" : \"구매성공! 구매관리를 확인하세요\", \"state\" : 1}");
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		

		
	}
	
	


}
