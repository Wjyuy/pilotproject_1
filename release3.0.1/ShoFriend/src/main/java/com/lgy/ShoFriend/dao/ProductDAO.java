package com.lgy.ShoFriend.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
	public List<ProductDTO> getAllProducts();//목록 불러오는 테스트용 임시 메소드 입니다. 삭제해도됨.-25.04.10 권준우
    public List<ProductDTO> getProductListTop10();//목록 10개 불러오는 테스트용 임시 메소드 입니다. 삭제해도됨.-25.04.11 권준우
    public void insertOrder(HashMap<String, String> param);
    public int getPriceByProductId(int productId);
}
