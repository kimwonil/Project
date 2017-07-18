package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.BoardDao;
import model.Board;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	public boolean insertBoard(Board board){
		return boardDao.insertBoard(board);
	}
	
	public boolean updateBoard(Board board){
		return boardDao.updateBoard(board);
	}
	
	public boolean deleteBoard(int no){
		return boardDao.deleteBoard(no);
	}
	
	public Board selectOne(int no){
		return boardDao.selectOne(no);
	}
	
	public List<Board>selectAll(){
		return boardDao.selectAll();
	}
		

}
