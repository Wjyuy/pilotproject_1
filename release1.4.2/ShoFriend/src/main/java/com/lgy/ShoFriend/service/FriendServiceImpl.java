package com.lgy.ShoFriend.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.ShoFriend.dao.FriendDAO;
import com.lgy.ShoFriend.dto.CustomerDTO;

@Service("FriendService")
public class FriendServiceImpl implements FriendService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public CustomerDTO findByEmail(String email) {
		FriendDAO dao = sqlSession.getMapper(FriendDAO.class);
		return dao.findByEmail(email);
	}

	@Override
	public void insertFriend(int id1, int id2, String status) {
		FriendDAO dao = sqlSession.getMapper(FriendDAO.class);
	    Map<String, Object> map = new HashMap<>();
	    map.put("customer_id1", id1);
	    map.put("customer_id2", id2);
	    map.put("status", status);
	    dao.insertFriend(map);

	}
}
