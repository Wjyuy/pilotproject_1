package com.lgy.ShoFriend.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.web.multipart.MultipartFile;

import com.lgy.ShoFriend.dto.ProductDTO;

public interface ProductService {
	public ArrayList<ProductDTO> list();
	public void write(HashMap<String, String> param);
	public String saveImage(MultipartFile picture);
}
