package com.lgy.ShoFriend.service;

import java.util.List;

import com.lgy.ShoFriend.dto.CustomerDTO;

public interface FriendService {
	public CustomerDTO findByEmail(String email);
	public void insertFriend(int id1, int id2, String status);
	public String getFriendStatus(int customerId1, int customerId2);
	public String getFriendName(int id);
	public List<CustomerDTO> getMyFriends(int customerId);

}
