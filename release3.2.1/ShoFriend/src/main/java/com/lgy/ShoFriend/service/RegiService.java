package com.lgy.ShoFriend.service;

import java.util.HashMap;

public interface RegiService {
	public int emailCheck(String email);
	public void write(HashMap<String, String> param);
	public void sell_write(HashMap<String, String> param);
}
