package dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import model.Board;
import model.Category;
import model.File;
import model.FileUpload;
import model.MapInfo;
import model.Premium;
import model.Purchase;

public interface BoardDao {
	//테이블명 : board
	public boolean insertBoard(HashMap<String, Object> params);
	public boolean updateBoard(HashMap<String, Object> params);
	public void updateCount(HashMap<String, Object> map);
	public void updateState(HashMap<String, Object> map);
	public boolean deleteBoard(int no);
	public Board selectOneBoard(int no);
	public List<Board> selectAllBoard(); //사이트에 있는 모든 글
	public List<Board> selectAllPremiumBoard();//프리미엄글 전체 select
	public List<Board> selectAllNormalBoard(HashMap<String, Object> pagingParam);//일반글 전체 select
//	public boolean reduceQuantity(HashMap<String, Object> params);
	public void updateStar(HashMap<String, Object> boardMap);
	public void udpateBoardRead_count(int no);
	public List<Board> searchNickname(HashMap<String, Object> searchMap);//판매자 닉네임으로 검색
	public List<Board> searchExactNickname(HashMap<String, Object> searchMap);//판매자의 다른글 리스트
	public List<Board> selectSearchResult(HashMap<String, Object> searchMap);//카테고리 전체 제목&내용 검색
	public List<Board> searchCategory(HashMap<String, Object> searchMap);//카테고리별 제목&내용 검색
	public int getCount(); //일반글 수 
	public int getCountCategory(HashMap<String, Object> pagingParam);//카테고리별 글 수
	public int getCountForNickname(HashMap<String, Object> searchMap);
	public int getCountExactNickname(HashMap<String, Object> searchMap);//detail에서 판매자의 다른 글목록 클릭하면
	public int getCountForSearch(HashMap<String, Object> countParam); //전체 검색 record 수
	public int getCountForCategorySearch(HashMap<String, Object> searchMap); //카테고리 검색 record 수
	public List<Board> gageocksun(HashMap<String, Object> pagingParam);
	public List<Board> panmaesun(HashMap<String, Object> pagingParam);
	public List<Board> latest(HashMap<String, Object> pagingParam);
	
	
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
	public List<HashMap<String, Object>> selectAllDips(HashMap<String, Object> param);
	public List<HashMap<String, Object>> dipsWithCategory(HashMap<String, Object> params);
	public int getCountDips(String id);
	public int getCountDipsCategory(HashMap<String, Object> params);
	public int dipsHistory(int no);//글번호에 해당하는 찜내역 있나 조회
	
	
	//테이블명 : star_point
	public List<HashMap<String, Object>> selectUserReview(int no);
	
	
	//테이블명 : category_high
	public List<Category> category();
	public List<Category> categoryLow(int high_no);
	public String category_majorName(int no);
	public String category_minorName(HashMap<String, Object> cateMap);
	public Category allowedCategory(int cateNo);

	
	//테이블명 : authority
	public List<Integer> myAuthority(String nickname);
	
	
	//프리미엄 등록
	public int premium(HashMap<String, Object> map);
	//프리미엄 갯수 조회
	public int premiumCount();
	//프리미엄 대기
	public int premiumWaitting(HashMap<String, Object> map);
	//프리미엄 목록 조회
	public List<Premium> premiumList(HashMap<String, Object> map);
	//프리미엄 페이징
	public int totalPagePremium(String nickname);
	//종료 날짜 체크
	public Date premiumEndDate();
	//현재 게시중인 프리미엄 조회
	public List<Premium> currentPremium();
	//대기중인 프리미엄 조회(선착순)
	public Premium convertPremium();
	//대기중인 프리미엄 상태 변환
	public int premiumWaittingUpdate(HashMap<String, Object> map);
	//이미 등록된 프리미엄 대기 조회
	public Premium newPremium(int no);
	//기존 등록된 프리미엄 수정
	public int premiumUpdate(HashMap<String, Object> map);
	
	
	public int purchseHistory(int no);//구매이력 조회

	
	
	

}
