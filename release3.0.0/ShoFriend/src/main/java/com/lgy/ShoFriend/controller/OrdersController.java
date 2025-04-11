package com.lgy.ShoFriend.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lgy.ShoFriend.dto.CustomerDTO;
import com.lgy.ShoFriend.dto.OrdersDTO;
import com.lgy.ShoFriend.service.OrdersService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class OrdersController {

	@Autowired
	private OrdersService service;

	@RequestMapping("/order_view")
	public String orderView(HttpSession session, Model model) {
		CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");

		log.info("@# order_view_start()");
		
		if (loginCustomer == null)
			return "redirect:login";

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("customer_id", String.valueOf(loginCustomer.getId()));

		List<OrdersDTO> orderList = service.getOrdersByCustomer(param);
		model.addAttribute("orderList", orderList);
		
		log.info("@# order_view_end()");

		return "order_view";
	}
}
