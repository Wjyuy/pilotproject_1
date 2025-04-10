package com.lgy.ShoFriend.service;

import com.lgy.ShoFriend.dto.CustomerDTO;

public interface FriendService {
	public CustomerDTO findByEmail(String email);
	public void insertFriend(int id1, int id2, String status);

}
