package com.lgy.ShoFriend.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.ShoFriend.dto.CustomerDTO;
import com.lgy.ShoFriend.dto.ProductDTO;
import com.lgy.ShoFriend.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ProductController {
	@Autowired
    private ProductService service;

    @RequestMapping("/product_test")
    public String productTest(Model model) {
        List<ProductDTO> products = service.getAllProducts();
        model.addAttribute("products", products);
        return "product_test";
    }
    
    
	@RequestMapping("/product_list")
	public String productList(Model model) {
		log.info("@# productList()");
		
		List<ProductDTO> products = service.getProductListTop10();
		model.addAttribute("productList", products);
		
		return "product_list";
	}    
	
	
	//25.04.11 권준우 - 제품 주문 메소드 제작
	@RequestMapping(value = "/product_order")
	public String orderProduct(@RequestParam("product_id") int productId, HttpSession session) {
		CustomerDTO customer = (CustomerDTO) session.getAttribute("loginCustomer");
		
		if (customer == null) { //session값 없으면 로그인 화면으로
			return "redirect:login";
		}

		int customerId = customer.getId();
		int totalPrice = service.getPriceByProductId(productId); // product 테이블에서 가격 조회 메서드

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("product_id", String.valueOf(productId));
		param.put("customer_id", String.valueOf(customerId));
		param.put("total_price", String.valueOf(totalPrice));
		param.put("status", "pending");

		service.insertOrder(param);

		return "redirect:main";  // 주문조회 페이지
	}	
	
	
	
	
}
