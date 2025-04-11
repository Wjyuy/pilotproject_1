package com.lgy.ShoFriend.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.ShoFriend.dao.RegiDAO;
import com.lgy.ShoFriend.dao.StoreDAO;
import com.lgy.ShoFriend.dto.StoreDTO;

@Service("StoreService")
public class StoreServiceImpl implements StoreService{

	@Autowired
	private SqlSession sqlSession;

	//점포 등록
	@Override
	public void store_write(HashMap<String, String> param) {
		StoreDAO dao=sqlSession.getMapper(StoreDAO.class);
		dao.store_write(param);
		
	}


	//등록한 점포 리스트
	@Override
	public ArrayList<StoreDTO> list() {
		StoreDAO dao=sqlSession.getMapper(StoreDAO.class);
		ArrayList<StoreDTO> list = dao.list();
		return list;
	}


	//점포수정 화면
	@Override
	public StoreDTO contentView(HashMap<String, String> param) {
		StoreDAO dao=sqlSession.getMapper(StoreDAO.class);
		StoreDTO dto = dao.contentView(param);
		
		return dto;
	}

	//점포 수정
	@Override
	public void store_modify(HashMap<String, String> param) {
		StoreDAO dao=sqlSession.getMapper(StoreDAO.class);
		dao.store_modify(param);
		
	}


	//점포 삭제
	@Override
	public void store_delete(HashMap<String, String> param) {
		StoreDAO dao=sqlSession.getMapper(StoreDAO.class);
		dao.store_delete(param);
	}
	
}
