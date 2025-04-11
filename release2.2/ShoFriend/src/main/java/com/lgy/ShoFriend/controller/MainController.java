package com.lgy.ShoFriend.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lgy.ShoFriend.dto.CategoryDTO;
import com.lgy.ShoFriend.dto.CustomerDTO;
import com.lgy.ShoFriend.dto.ProductDTO;
import com.lgy.ShoFriend.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MainController {
/*
* 작성일      작성자   개발내용,수정내용
* 25/04/07    우주연   main, category, product_insert, product_modify 
* 25/04/10    우주연   product_write, product_delete, product_modify_ok , content
*/
	
	@Autowired
	private ProductService service;
	
	@RequestMapping("/main")
	public String main(Model model) {
		log.info("main()");
		ArrayList<ProductDTO> list = service.product_list();
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
		ArrayList<ProductDTO> list = service.product_list();
		model.addAttribute("list", list);
		
		ArrayList<ProductDTO> flashlist = service.selectFlashSaleItems();
		model.addAttribute("flashlist", flashlist);
		
	    ArrayList<CategoryDTO> categorylist = service.categorylist();
		model.addAttribute("categorylist", categorylist);
		
		return ("category");
	}
	@RequestMapping("/product_insert")
	public String product_insert() {
		log.info("product_insert()");
		return ("product_insert");
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
	
	@ResponseBody
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
		return ("ok");
	}
	
	@RequestMapping("/content")
	public String content(@RequestParam("id") int product_id, Model model) {
	    ProductDTO product = service.getProductById(product_id); 
	    model.addAttribute("product", product); 
	    
	    ArrayList<CategoryDTO> categorylist = service.categorylist();
		model.addAttribute("categorylist", categorylist);
		
	    return "content"; 
	}
	
	@RequestMapping("/product_write")
	public String insert(
	    @RequestParam HashMap<String, String> param,
	    @RequestParam("picture") MultipartFile picture
	) {
	    log.info("product_write()");
	    if (!picture.isEmpty()) {
	        String savedFileName = service.saveImage(picture);
	        param.put("picture", savedFileName);
	    }
	    service.product_write(param);
	    return "redirect:/main";
	}
	
}
