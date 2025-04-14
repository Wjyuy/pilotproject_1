package com.lgy.ShoFriend.dao;

import java.util.HashMap;

public interface RegiDAO {

	public int emailCheck(String email);
	public void write(HashMap<String, String> param);
	public void sell_write(HashMap<String, String> param);

}
