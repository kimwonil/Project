package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.model;

public interface Idao {
	
	public int insert (HashMap<String, Object> map);
	public List<HashMap<String, Object>> selectAll();

}
