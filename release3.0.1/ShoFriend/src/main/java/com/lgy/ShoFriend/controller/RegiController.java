package com.lgy.ShoFriend.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.ShoFriend.dto.CustomerDTO;
import com.lgy.ShoFriend.service.RegiService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class RegiController {

	@Autowired
	private RegiService service;
	
	//	(일반회원가입) 25.04.08 김채윤
	@RequestMapping("/register")
	public String register() {
		log.info("@# register()");
		return "register";
	}
	
	//	(일반회원가입 완료) 25.04.08 김채윤
	@RequestMapping("/registerOk")
	public String registerOk(@RequestParam HashMap<String, String> param) {
		log.info("@# registerOk()");

		service.write(param);
		return "redirect:login";
	}
	
	//	(판매자 회원가입) 25.04.08 김채윤
	@RequestMapping("/seller_register")
	public String seller_register() {
		log.info("@# seller_register()");
		return "seller_register";
	}
	
	//	(판매자 회원가입 완료) 25.04.08 김채윤
	@RequestMapping("/seller_registerOk")
	public String seller_registerOk(@RequestParam HashMap<String, String> param) {
		log.info("@# seller_registerOk()");

		service.sell_write(param);
		return "redirect:login";
	}	
}
