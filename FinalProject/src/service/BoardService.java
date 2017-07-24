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
	
	public List<Board>selectAllBoard(){
		return boardDao.selectAllBoard();
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

}
