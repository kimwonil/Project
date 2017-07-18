package dao;

import java.util.List;

import model.Board;
import model.Map;

public interface BoardDao {
	//테이블명 : board
	public boolean insertBoard(Board board);
	public boolean updateBoard(Board board);
	public boolean deleteBoard(int no);
	public Board selectOne(int no);
	public List<Board> selectAll();
	
	//테이블명 : map
	public int insertMap(Map map);
	public int updateMap(Map map);
	public int deleteMap(int no);
	
	
	//테이블명 : file
	
	

}
