package com.lgy.ShoFriend.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.ShoFriend.dto.StoreDTO;

public interface StoreDAO {
	
	public ArrayList<StoreDTO> list();
	public void store_write(HashMap<String, String> param);
	public StoreDTO contentView(HashMap<String, String> param);
	public void store_modify(HashMap<String, String> param);
	public void store_delete(HashMap<String, String> param);
}
