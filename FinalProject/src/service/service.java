package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.Idao;

@Service
public class service {
	
	@Autowired
	private Idao dao;

	public void insert(HashMap<String, Object> params){
		dao.insert(params);
	}
	
	
	public List<HashMap<String, Object>> selectAll(){
		return dao.selectAll();
	}
}
