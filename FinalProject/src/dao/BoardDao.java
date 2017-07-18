package dao;

import java.util.List;

import model.Board;
import model.MapInfo;

public interface BoardDao {
	//테이블명 : board
	public boolean insertBoard(Board board);
	public boolean updateBoard(Board board);
	public boolean deleteBoard(int no);
	public Board selectOne(int no);
	public List<Board> selectAll();
	
	//테이블명 : map
	public int insertMap(MapInfo map);
	public int updateMap(MapInfo map);
	public int deleteMap(int no);
	
	
	//테이블명 : file
	
	

}
