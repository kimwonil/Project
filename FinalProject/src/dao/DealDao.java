package dao;

import java.util.List;

import model.Board;

public interface DealDao {
	public List<Board> selectAll(String id);
}
