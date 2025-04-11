package com.lgy.ShoFriend.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lgy.ShoFriend.dto.CustomerDTO;

public interface FriendDAO {
	public CustomerDTO findByEmail(String email);
	public void insertFriend(Map<String, Object> map);
	public ArrayList<CustomerDTO> findpending(HashMap<String, String> param);
	public void updateFriendStatus(HashMap<String, String> param);
	public List<CustomerDTO> getAcceptedFriends(int id);
	public void rejectFriend(HashMap<String, String> param);
	void deleteFriend(HashMap<String, String> param);

}
