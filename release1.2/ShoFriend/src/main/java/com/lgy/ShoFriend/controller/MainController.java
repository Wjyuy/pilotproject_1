package com.lgy.ShoFriend.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.lgy.ShoFriend.dto.CategoryDTO;
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
		
		ArrayList<CategoryDTO> categorylist = service.categorylist();
		model.addAttribute("categorylist", categorylist);
		return ("main");
	}
	@RequestMapping("/category")
	public String category(Model model) {
		log.info("category()");
		ArrayList<ProductDTO> list = service.list();
		model.addAttribute("list", list);
		return ("category");
	}
	@RequestMapping("/insert")
	public String insert() {
		log.info("insert()");
		return ("insert");
	}
	
	@RequestMapping("/content")
	public String content(@RequestParam("id") int product_id, Model model) {
	    ProductDTO product = service.getProductById(product_id); // ← 여기서 하나만 조회
	    model.addAttribute("product", product); // ← JSP에서 ${product}로 사용 가능
	    return "content"; // → content.jsp로 이동
	}
	
	@RequestMapping("/write")
	public String insert(
	    @RequestParam HashMap<String, String> param,
	    @RequestParam("picture") MultipartFile picture
	) {
	    log.info("write()");
	    if (!picture.isEmpty()) {
	        String savedFileName = service.saveImage(picture);
	        param.put("picture", savedFileName);
	    }
	    service.write(param);
	    return "insert";
	}
	
}
