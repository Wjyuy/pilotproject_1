package com.lgy.ShoFriend.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.ShoFriend.dto.ProductDTO;

public interface ProductDAO {
	public ArrayList<ProductDTO> list();
	public void write(HashMap<String, String> param);
}
