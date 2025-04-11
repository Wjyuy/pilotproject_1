package com.lgy.ShoFriend.service;

import java.util.HashMap;
import java.util.List;
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

	@Override
	public String getFriendStatus(int customerId1, int customerId2) {
		FriendDAO dao = sqlSession.getMapper(FriendDAO.class);
		int smaller = Math.min(customerId1, customerId2);
	    int larger = Math.max(customerId1, customerId2);

	    return dao.getFriendStatus(smaller, larger);
	}

	@Override
	public String getFriendName(int id) {
		FriendDAO dao = sqlSession.getMapper(FriendDAO.class);
		return dao.getFriendName(id);
	}

	@Override
	public List<CustomerDTO> getMyFriends(int customerId) {
		FriendDAO dao = sqlSession.getMapper(FriendDAO.class);
	    return dao.getMyFriends(customerId);
	}
	
	
}
