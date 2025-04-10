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
		
		ArrayList<ProductDTO> flashlist = service.selectFlashSaleItems();
		model.addAttribute("flashlist", flashlist);
		
		return ("main");
	}
	@RequestMapping("/category")
	public String category(Model model) {
		log.info("category()");
		ArrayList<ProductDTO> list = service.list();
		model.addAttribute("list", list);
		
		ArrayList<ProductDTO> flashlist = service.selectFlashSaleItems();
		model.addAttribute("flashlist", flashlist);
		
	    ArrayList<CategoryDTO> categorylist = service.categorylist();
		model.addAttribute("categorylist", categorylist);
		
		return ("category");
	}
	@RequestMapping("/insert")
	public String insert() {
		log.info("insert()");
		return ("insert");
	}
	
	@RequestMapping("/product_modify")
	public String product_modify(@RequestParam("id") int product_id,Model model) {
		log.info("product_modify()");
		
		ProductDTO product = service.getProductById(product_id); 
	    model.addAttribute("product", product); 
	    
		return ("product_modify");
	}
	
	
	@RequestMapping("/product_delete")
	public String product_delete(@RequestParam("id") int id) {
		log.info("product_delete()");
		
		service.product_delete(id);
		return ("redirect:/main");
	}
	
	@RequestMapping("/product_modify_ok")
	public String product_modify_ok(
		    @RequestParam HashMap<String, String> param,
		    @RequestParam("picture") MultipartFile picture
		) {
		log.info("product_modify_ok()");
		
		if (!picture.isEmpty()) {
	        String savedFileName = service.modifyImage(param,picture);
	        param.put("picture", savedFileName);
	    }
		
	    service.product_modify(param);
		return ("product_modify");
	}
	
	@RequestMapping("/content")
	public String content(@RequestParam("id") int product_id, Model model) {
	    ProductDTO product = service.getProductById(product_id); 
	    model.addAttribute("product", product); 
	    
	    ArrayList<CategoryDTO> categorylist = service.categorylist();
		model.addAttribute("categorylist", categorylist);
		
	    return "content"; 
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
	    service.product_write(param);
	    return "insert";
	}
	
}
