package dao;

import java.util.HashMap;
import java.util.List;

import model.Board;
import model.Category;
import model.File;
import model.FileUpload;
import model.MapInfo;
import model.Purchase;

public interface BoardDao {
	//테이블명 : board
	public boolean insertBoard(HashMap<String, Object> params);
	public boolean updateBoard(HashMap<String, Object> params);
	public boolean deleteBoard(int no);
	public Board selectOneBoard(int no);
	public List<Board> selectAllPremiumBoard();//프리미엄글 전체 select
	public List<Board> selectAllNormalBoard();//일반글 전체 select
//	public boolean reduceQuantity(HashMap<String, Object> params);
	public void updateStar(HashMap<String, Object> boardMap);
	public void udpateBoardRead_count(int no);
	public List<Board> selectSearchResult(HashMap<String, Object> searchMap);
	
	//테이블명 : map
	public boolean insertMap(HashMap<String, Object> params);
	public boolean updateMap(HashMap<String, Object> params);
	public boolean deleteMap(int no);
	public MapInfo selectOneMap(int board_no);
	
	
	//테이블명 : file
	public boolean insertFile(HashMap<String, Object> params);
	public boolean updateFile(HashMap<String, Object> params);
	public boolean deleteFile(int no);
	public File selectOneFromFile(int no);
	public String selectThumbnail(int no);//글번호로 해당글의 썸네일들만 가져와서 메인에 같이 뿌릴거야
	
	
	//테이블명 : board_option
	public boolean insertBoard_option(HashMap<String, Object> board_option);
	public void deleteBoard_option(int no);//글번호에 해당하는 옵션들 모두 삭제
	public List<HashMap<String, Object>> selectBoard_option(int no);
	public HashMap<String, Object> selectKind(HashMap<String, Object> params);
	
	
	//테이블명 : interest
	public boolean insertInterest(HashMap<String, Object> params);
	public HashMap<String, Object> selectOneInterest(HashMap<String, Object> params);
	public List<HashMap<String, Object>> selectAllDips(String id);
	
	
	//테이블명 : star_point
	public List<HashMap<String, Object>> selectUserReview(int no);
	
	
	//테이블명 : category_high
	public List<Category> category();
	public List<Category> categoryLow(int high_no);
	

}
