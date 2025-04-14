package com.lgy.ShoFriend.service;

import java.util.List;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.ShoFriend.dao.OrdersDAO;
import com.lgy.ShoFriend.dto.OrdersDTO;

@Service("OrdersService")
public class OrdersServiceImpl implements OrdersService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<OrdersDTO> getOrdersByCustomer(HashMap<String, String> param) {
        OrdersDAO dao = sqlSession.getMapper(OrdersDAO.class);
        return dao.getOrdersByCustomer(param);
    }
}
