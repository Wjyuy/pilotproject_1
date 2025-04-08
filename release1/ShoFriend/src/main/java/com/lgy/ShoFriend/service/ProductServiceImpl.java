package com.lgy.ShoFriend.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.ShoFriend.dao.ProductDAO;
import com.lgy.ShoFriend.dto.ProductDTO;

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

}
