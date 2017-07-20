package dao;

import java.util.HashMap;
import java.util.List;

import model.Board;
import model.MapInfo;

public interface BoardDao {
	//테이블명 : board
	public boolean insertBoard(HashMap<String, Object> params);
	public boolean updateBoard(Board board);
	public boolean deleteBoard(int no);
	public Board selectOneBoard(int no);
	public List<Board> selectAllBoard();
	
	//테이블명 : map
	public boolean insertMap(HashMap<String, Object> params);
	public boolean updateMap(MapInfo map);
	public boolean deleteMap(int no);
	public MapInfo selectOneMap(int board_no);
	
	
	//테이블명 : file
	
	

}
