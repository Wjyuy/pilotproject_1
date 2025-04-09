package com.lgy.ShoFriend.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.lgy.ShoFriend.dao.ProductDAO;
import com.lgy.ShoFriend.dto.CategoryDTO;
import com.lgy.ShoFriend.dto.ProductDTO;
// 상품 출력, 상품 등록, 파일입출력(이미지, 저장날짜+UUID이용)
// 작성일      작성자   개발내용,수정내용 
// 25/04/07    우주연
@Service("ProductService")
public class ProductServiceImpl implements ProductService{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<ProductDTO> list() {
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
		ArrayList<ProductDTO> dtos=dao.list();
		return dtos;
	}

	@Override
	public void write(HashMap<String, String> param) {
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
		dao.write(param);
	}

	@Override
	public String saveImage(MultipartFile picture) {
	    if (picture.isEmpty()) {
	        return null;
	    }
	    try {
	        String uploadDir = "C:/develop/spring-tool-suite-3.9.18.RELEASE-e4.21.0-win32-x86_64/work_spring/ShoFriend/src/main/webapp/resources/images/";
	        String originalFilename = picture.getOriginalFilename();
	        String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
	        String timestamp = new java.text.SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date());
	        String uuidPart = UUID.randomUUID().toString().substring(0, 8); 
	        String newFileName = timestamp + "_" + uuidPart + ext;
	        File saveFile = new File(uploadDir + newFileName);
	        picture.transferTo(saveFile);
	        return newFileName;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}

	@Override
	public ArrayList<CategoryDTO> categorylist() {
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
		ArrayList<CategoryDTO> dtos=dao.categorylist();
		return dtos;
	}
	
	@Override
	public ProductDTO getProductById(int product_id) {
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
	    return dao.getProductById(product_id);
	}


}
