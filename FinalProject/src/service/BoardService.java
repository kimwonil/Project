package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.BoardDao;
import model.Board;
import model.File;
import model.FileUpload;
import model.MapInfo;

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
	
	public boolean deleteBoard(int no){
		return boardDao.deleteBoard(no);
	}
	
	public Board selectOneBoard(int no){
		return boardDao.selectOneBoard(no);
	}
	
	public List<Board>selectAllPremiumBoard(){
		return boardDao.selectAllPremiumBoard();
	}
	
	public List<Board>selectAllNormalBoard(){
		return boardDao.selectAllNormalBoard();
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

	public List<HashMap<String, Object>> selectBoard_option(int no) {
		System.out.println("서비스 selectBoard_option하러 왔엉");
		System.out.println(boardDao.selectBoard_option(no));
		return boardDao.selectBoard_option(no);
	}
	
	public HashMap<String, Object> selectKind(HashMap<String, Object> params){
		return boardDao.selectKind(params);
	}

}
