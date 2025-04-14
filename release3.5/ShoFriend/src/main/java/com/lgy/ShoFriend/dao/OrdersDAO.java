package com.lgy.ShoFriend.dao;

import java.util.HashMap;
import java.util.List;

import com.lgy.ShoFriend.dto.OrdersDTO;

public interface OrdersDAO {
    public List<OrdersDTO> getOrdersByCustomer(HashMap<String, String> param);
    
}
