package service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.BoardDao;
import model.Board;
import model.Category;
import model.File;
import model.FileUpload;
import model.MapInfo;
import model.Premium;
import model.Purchase;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	/**
	 * table명 : board
	 * */
	public boolean insertBoard(HashMap<String, Object> params){
		return boardDao.insertBoard(params);
	}
	
	public boolean updateBoard(HashMap<String, Object> params){
		return boardDao.updateBoard(params);
	}
	
	public void updateCount(HashMap<String, Object> map) {
		boardDao.updateCount(map);
	}
	
	public void updateState(HashMap<String, Object> map) {
		boardDao.updateState(map);
	}
	
	public boolean deleteBoard(int no){
		return boardDao.deleteBoard(no);
	}
	
	public Board selectOneBoard(int no){
		return boardDao.selectOneBoard(no);
	}
	
	public List<Board>selectAllBoard(){
		return boardDao.selectAllBoard();
	}
	
	public List<Board>selectAllPremiumBoard(){
		return boardDao.selectAllPremiumBoard();
	}
	
	public List<Board>selectAllNormalBoard(HashMap<String, Object> pagingParam){
		return boardDao.selectAllNormalBoard(pagingParam);
	}
	
//	public boolean reduceQuantity(HashMap<String, Object> params) {
//		return boardDao.reduceQuantity(params);
//	}
	
	public void updateStar(HashMap<String, Object> boardMap) {
		boardDao.updateStar(boardMap);
	}
	
	public void udpateBoardRead_count(int no) {
		boardDao.udpateBoardRead_count(no);
	}

	public List<Board> searchNickname(HashMap<String, Object> searchMap) {
		return boardDao.searchNickname(searchMap);
	}

	public List<Board> searchExactNickname(HashMap<String, Object> searchMap) {
		return boardDao.searchExactNickname(searchMap);
	}
	
	public List<Board> selectSearchResult(HashMap<String, Object> searchMap) {
		return boardDao.selectSearchResult(searchMap);
	}
	
	public List<Board> searchCategory(HashMap<String, Object> searchMap) {
		return boardDao.searchCategory(searchMap);//카테고리랑 키워드로 board 검색
	}
	
	public int getCount() {
		return boardDao.getCount();
	}

	public int getCountCategory(HashMap<String, Object> pagingParam) {
		return boardDao.getCountCategory(pagingParam);
	}
	
	public int getCountForNickname(HashMap<String, Object> searchMap) {
		return boardDao.getCountForNickname(searchMap);
	}

	public int getCountExactNickname(HashMap<String, Object> searchMap) {
		return boardDao.getCountExactNickname(searchMap);
	}
	
	public int getCountForSearch(HashMap<String, Object> countParam){
		return boardDao.getCountForSearch(countParam);
	}
	
	public int getCountForCategorySearch(HashMap<String, Object> searchMap) {
		return boardDao.getCountForCategorySearch(searchMap);
	}

	public List<Board> gageocksun(HashMap<String, Object>pagingParam) {
		return boardDao.gageocksun(pagingParam);
	}
	
	public List<Board> panmaesun(HashMap<String, Object>pagingParam) {
		return boardDao.panmaesun(pagingParam);
	}
	
	public List<Board> latest(HashMap<String, Object> pagingParam) {
		return boardDao.latest(pagingParam);
	}
	

	
	/**
	 * table명 : map
	 * */
	public boolean insertMap(HashMap<String, Object>parmas){
		return boardDao.insertMap(parmas);
	}
	
	public boolean updateMap(HashMap<String, Object>parmas){
		return boardDao.updateMap(parmas);
	}
	
	public boolean deleteMap(int no){
		return boardDao.deleteMap(no);
	}
	
	public MapInfo selectOneMap(int board_no){
		return boardDao.selectOneMap(board_no);
	}

	
	/**
	 * table명 : file
	 * */
	public boolean insertFile(HashMap<String, Object> params) {
		return boardDao.insertFile(params);
	}
	
	public boolean updateFile(HashMap<String, Object> params){
		return boardDao.updateFile(params);
	}
	
	public boolean deleteFile(int no){
		return boardDao.deleteFile(no);
	}
		
	public File selectOneFromFile(int no){
		return boardDao.selectOneFromFile(no);
	}
	
	public String selectThumbnail(int no){
		return boardDao.selectThumbnail(no);
	}//글번호로 해당글의 썸네일들만 가져와서 메인에 같이 뿌릴거야
	
	
	/**
	 * table명 : board_option
	 * */
	public boolean insertBoard_option(HashMap<String, Object> board_option) {
		return boardDao.insertBoard_option(board_option);
	}

	public void deleteBoard_option(int no) {
		boardDao.deleteBoard_option(no);
	}

	public List<HashMap<String, Object>> selectBoard_option(int no) {
		System.out.println("서비스 selectBoard_option하러 왔엉");
		System.out.println(boardDao.selectBoard_option(no));
		return boardDao.selectBoard_option(no);
	}
	
	public HashMap<String, Object> selectKind(HashMap<String, Object> params){
		return boardDao.selectKind(params);
	}

	
	/**
	 * table명 : interest
	 * */
	public boolean insertInterest(HashMap<String, Object> params) {
		return boardDao.insertInterest(params);
	}

	public HashMap<String, Object> selectOneInterest(HashMap<String, Object> params) {
		return boardDao.selectOneInterest(params);
	}

	public List<HashMap<String, Object>> selectAllDips(HashMap<String, Object> param) {
		return boardDao.selectAllDips(param);
	}

	public List<HashMap<String, Object>> dipsWithCategory(HashMap<String, Object> params) {
		return boardDao.dipsWithCategory(params);
	}
	
	public int getCountDips(String id) {
		return boardDao.getCountDips(id);
	}
	
	public int getCountDipsCategory(HashMap<String, Object> params) {
		return boardDao.getCountDipsCategory(params);
	}

	public int dipsHistory(int no) {
		return boardDao.dipsHistory(no);
	}
	

	/**
	 * table명 : star_point
	 * */
	public List<HashMap<String, Object>> selectUserReview(int no){
		return boardDao.selectUserReview(no);
	}
	
	
	/**
	 * 카테고리 조회(대분류)
	 * */
	public List<Category> category() {
		return boardDao.category();
	}

	public List<Category> categoryLow(int high_no) {
		return boardDao.categoryLow(high_no);
	}
	
	public String category_majorName(int no){
		return boardDao.category_majorName(no);
	}

	public String category_minorName(HashMap<String, Object> cateMap) {
		return boardDao.category_minorName(cateMap);
	}

	public Category allowedCategory(int cateNo) {
		return boardDao.allowedCategory(cateNo);
	}
	
	
	/**
	 * 판매자한테 허용된 카테고리만(table : authority)
	 * */
	public List<Integer> myAuthority(String nickname) {
		return boardDao.myAuthority(nickname);
	}




	/**
	 * 프리미엄 등록
	 * */
	public int premium(HashMap<String, Object> map) {
		return boardDao.premium(map);
	}
	
	/**
	 * 프리미엄 현재 갯수 조회
	 * */
	public int premiumCount() {
		return boardDao.premiumCount();
	}
	
	/**
	 * 프리미엄 대기
	 * */
	public int premiumWaitting(HashMap<String, Object> map) {
		return boardDao.premiumWaitting(map);
	}
	
	/**
	 * 프리미엄 목록 조회
	 * */
	public List<Premium> premiumList(HashMap<String, Object> map) {
		return boardDao.premiumList(map);
	}

	public int totalPagePremium(String nickname) {
		return boardDao.totalPagePremium(nickname);
	}
	
	
	public Date premiumEndDate() {
		return boardDao.premiumEndDate();
	}

	public List<Premium> currentPremium() {
		return boardDao.currentPremium();
	}

	public Premium convertPremium() {
		return boardDao.convertPremium();	
	}

	public int premiumWaittingUpdate(HashMap<String, Object> map) {
		return boardDao.premiumWaittingUpdate(map);
	}

	public Premium newPremium(int no) {
		return boardDao.newPremium(no);
	}

	public int premiumUpdate(HashMap<String, Object> map) {
		return boardDao.premiumUpdate(map);
	}


	public int purchseHistory(int no) {
		return boardDao.purchseHistory(no);
	}







	

	

	


	


}
