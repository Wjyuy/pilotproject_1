package com.lgy.ShoFriend.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
// 25/04/10    우주연
@Service("ProductService")
public class ProductServiceImpl implements ProductService{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<ProductDTO> product_list() {
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
		ArrayList<ProductDTO> dtos=dao.product_list();
		return dtos;
	}

	@Override
	public void product_write(HashMap<String, String> param) {
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
		dao.product_write(param);
	}

	@Override
	public String saveImage(MultipartFile picture) {
	    if (picture.isEmpty()) {
	        return null;
	    }
	    try {
//	    	String uploadDir = "C:/ShoFriend/";
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
	public String modifyImage(HashMap<String, String> param, MultipartFile picture) {
	    if (picture.isEmpty()) {
	        return null;
	    }

	    try {
	        String uploadDir = "C:/develop/spring-tool-suite-3.9.18.RELEASE-e4.21.0-win32-x86_64/work_spring/ShoFriend/src/main/webapp/resources/images/";

	        String oldFileName = param.get("picture");
	        if (oldFileName != null && !oldFileName.isEmpty()) {
	            File oldFile = new File(uploadDir + oldFileName);
	            if (oldFile.exists()) {
	                oldFile.delete(); 
	            }
	        }

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

	@Override
	public ArrayList<ProductDTO> selectFlashSaleItems() {
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
		return dao.selectFlashSaleItems();
	}

	@Override
	public void product_modify(HashMap<String, String> param) {
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
		dao.product_modify(param);
	}

	@Override
	public void product_delete(int id) {
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
		ProductDTO product = dao.getProductById(id);
	    if (product != null) {
	        String picture = product.getPicture();
	        if (picture != null && !picture.isEmpty()) {
	            String uploadDir = "C:/develop/spring-tool-suite-3.9.18.RELEASE-e4.21.0-win32-x86_64/work_spring/ShoFriend/src/main/webapp/resources/images/";
	            File file = new File(uploadDir + picture);
	            if (file.exists()) {
	                if (file.delete()) {
	                    System.out.println("✅ 이미지 삭제 성공: " + file.getName());
	                } else {
	                    System.out.println("⚠️ 이미지 삭제 실패: " + file.getName());
	                }
	            } else {
	                System.out.println("🚫 이미지 파일이 존재하지 않음: " + file.getName());
	            }
	        }
		dao.product_delete(id);
	    }
	}
	
	@Override
    public List<ProductDTO> getAllProducts() {
        ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
        return dao.getAllProducts();
    }
    
	@Override
	public List<ProductDTO> getProductListTop10() {
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
		return dao.getProductListTop10();
	}
	
	@Override
	public void insertOrder(HashMap<String, String> param) {
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
		dao.insertOrder(param);
	}
	
	@Override
	public int getPriceByProductId(int productId) {
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
		return dao.getPriceByProductId(productId);
	}	

}
