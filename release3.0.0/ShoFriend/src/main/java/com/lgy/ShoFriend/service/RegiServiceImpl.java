package com.lgy.ShoFriend.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.ShoFriend.dao.RegiDAO;


@Service("RegiService")
public class RegiServiceImpl implements RegiService{
	@Autowired
	private SqlSession sqlSession;
//	private RegiEmailMapper mapper;
	

	@Override
	public void write(HashMap<String, String> param) {
		RegiDAO dao=sqlSession.getMapper(RegiDAO.class);
		dao.write(param);
	}

	
	@Override
	public void sell_write(HashMap<String, String> param) {
		RegiDAO dao=sqlSession.getMapper(RegiDAO.class);
		dao.sell_write(param);
	}


	@Override
	public int emailCheck(String email) {
		RegiDAO mapper = sqlSession.getMapper(RegiDAO.class);
		int cnt = mapper.emailCheck(email);
		System.out.println("cnt: "+cnt);
		return cnt;
	}
	
	

	

}
