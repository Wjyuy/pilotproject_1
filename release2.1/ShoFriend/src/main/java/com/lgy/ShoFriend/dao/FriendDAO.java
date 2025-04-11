package com.lgy.ShoFriend.dao;

import java.util.List;
import java.util.Map;

import com.lgy.ShoFriend.dto.CustomerDTO;

public interface FriendDAO {
	public CustomerDTO findByEmail(String email);
	public void insertFriend(Map<String, Object> map);
	public String getFriendStatus(int customerId1, int customerId2);
	public String getFriendName(int id);
	public List<CustomerDTO> getMyFriends(int customerId);
}
