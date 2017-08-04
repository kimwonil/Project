package dao;

import java.util.HashMap;

import model.Answer;

public interface AnswerDao {
	public boolean insertAnswer(HashMap<String , Object> params);
	public Answer selectOneAnswer(int no);
	public boolean updateAnswer(HashMap<String , Object> params);
	public boolean deleteAnswer(int no);
}
