package com.lgy.ShoFriend.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.web.multipart.MultipartFile;

import com.lgy.ShoFriend.dto.CategoryDTO;
import com.lgy.ShoFriend.dto.ProductDTO;

public interface ProductService {
	public ArrayList<ProductDTO> list();
	public void product_write(HashMap<String, String> param);
	public String saveImage(MultipartFile picture);
	public ArrayList<CategoryDTO> categorylist();
	public ProductDTO getProductById(int product_id);
	public ArrayList<ProductDTO> selectFlashSaleItems();
	public void product_modify(HashMap<String, String> param);
}
