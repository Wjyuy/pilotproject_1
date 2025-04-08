package com.lgy.ShoFriend.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.ShoFriend.dto.ProductDTO;
import com.lgy.ShoFriend.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MainController {
/*
* (메소드 동작 방식 기재)
* 작성일      작성자   개발내용,수정내용
* 25/04/07 
*/
	
	@Autowired
	private ProductService service;
	
	@RequestMapping("/login")
	public String login() {
		log.info("login()");
		return ("login");
	}
	@RequestMapping("/mypage")
	public String mypage() {
		log.info("mypage()");
		return ("mypage");
	}
	@RequestMapping("/register")
	public String register() {
		log.info("register()");
		return ("register");
	}
	@RequestMapping("/main")
	public String main(Model model) {
		log.info("main()");
		ArrayList<ProductDTO> list = service.list();
		model.addAttribute("list", list);
		return ("main");
	}
	@RequestMapping("/insert")
	public String insert() {
		log.info("insert()");
		return ("insert");
	}
	//테스트용
	@RequestMapping("/write")
	public String insert(@RequestParam HashMap<String, String> param) {
		log.info("write()");
		service.write(param);
		return ("insert");
	}
}
