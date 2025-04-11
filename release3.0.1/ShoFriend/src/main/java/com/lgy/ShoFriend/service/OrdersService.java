package com.lgy.ShoFriend.service;

import java.util.List;
import java.util.HashMap;

import com.lgy.ShoFriend.dto.OrdersDTO;

public interface OrdersService {
    public List<OrdersDTO> getOrdersByCustomer(HashMap<String, String> param);
}
