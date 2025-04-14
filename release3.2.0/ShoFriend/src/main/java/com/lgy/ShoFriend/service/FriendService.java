package com.lgy.ShoFriend.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.lgy.ShoFriend.dto.CustomerDTO;

public interface FriendService {
	public CustomerDTO findByEmail(String email);
	public void insertFriend(int id1, int id2, String status);
	public ArrayList<CustomerDTO> findpending(HashMap<String, String> param);
	public void updateFriendStatus(HashMap<String, String> param);
	public List<CustomerDTO> getAcceptedFriends(int id);
	public void rejectFriend(HashMap<String, String> param);
	void deleteFriend(int myId, int friendId);


}
