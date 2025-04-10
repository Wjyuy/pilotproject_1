package com.lgy.ShoFriend.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.web.multipart.MultipartFile;

import com.lgy.ShoFriend.dto.CategoryDTO;
import com.lgy.ShoFriend.dto.ProductDTO;

public interface ProductDAO {
	/*
	* (메소드 동작 방식 기재)
	* 작성일      작성자   개발내용,수정내용
	* 25/04/10    우주연   메소드 9개 제작
	*/
	public ArrayList<ProductDTO> product_list();
	public void product_write(HashMap<String, String> param);
	public String saveImage(MultipartFile picture);
	public ArrayList<CategoryDTO> categorylist();
	public ProductDTO getProductById(int product_id);
	public ArrayList<ProductDTO> selectFlashSaleItems();
	public void product_modify(HashMap<String, String> param);
	public String modifyImage(HashMap<String, String> param, MultipartFile picture);
	public void product_delete(int id);
}
