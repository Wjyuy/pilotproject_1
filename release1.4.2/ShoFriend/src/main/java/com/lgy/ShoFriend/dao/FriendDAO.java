package com.lgy.ShoFriend.dao;

import java.util.Map;

import com.lgy.ShoFriend.dto.CustomerDTO;

public interface FriendDAO {
	public CustomerDTO findByEmail(String email);
	public void insertFriend(Map<String, Object> map);

}
