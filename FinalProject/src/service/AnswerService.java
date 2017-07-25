package service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.AnswerDao;
import model.Answer;

@Service
public class AnswerService {
	@Autowired
	private AnswerDao answerDao;
	
	public boolean insertAnswer(HashMap<String, Object> params)
	{
		return answerDao.insertAnswer(params);
	}
	
	public Answer selectOneAnswer(int no)
	{
		return answerDao.selectOneAnswer(no);
	}
	
	public boolean updateAnswer(HashMap<String, Object> params)
	{
		return answerDao.updateAnswer(params);
	}
	
	public boolean deleteAnswer(int no)
	{
		return answerDao.deleteAnswer(no);
	}
}
