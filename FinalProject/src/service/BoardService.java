package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.BoardDao;
import model.Board;
import model.MapInfo;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	/**
	 * table명 : board
	 * */
	public boolean insertBoard(Board board){
		return boardDao.insertBoard(board);
	}
	
	public boolean updateBoard(Board board){
		return boardDao.updateBoard(board);
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
	public boolean insertMap(MapInfo map){
		return boardDao.insertMap(map);
	}
	
	public boolean updateMap(MapInfo map){
		return boardDao.updateMap(map);
	}
	
	public boolean deleteMap(int no){
		return boardDao.deleteMap(no);
	}
	
	public MapInfo selectOneMap(int no){
		return boardDao.selectOneMap(no);
	}
		

}
