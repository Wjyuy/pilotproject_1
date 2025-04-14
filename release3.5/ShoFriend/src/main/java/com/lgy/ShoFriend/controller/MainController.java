package com.lgy.ShoFriend.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lgy.ShoFriend.dto.CategoryDTO;
import com.lgy.ShoFriend.dto.CustomerDTO;
import com.lgy.ShoFriend.dto.ProductDTO;
import com.lgy.ShoFriend.dto.ProductPopularity;
import com.lgy.ShoFriend.dto.SellerDTO;
import com.lgy.ShoFriend.dto.StoreDTO;
import com.lgy.ShoFriend.service.ProductService;
import com.lgy.ShoFriend.service.StoreService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MainController {
/*
* 작성일      작성자   개발내용,수정내용
* 25/04/07    우주연   main, category, product_insert, product_modify 
* 25/04/10    우주연   product_write, product_delete, product_modify_ok , content
* 25/04/14    우주연   세션 추가
*/
	
	@Autowired
	private ProductService service;
	@Autowired
	private StoreService storeService;
	
	@RequestMapping("/main")
	public String main(Model model) {
		log.info("main()");
		
		List<ProductPopularity> popularlist= service.getPopularProducts();
		model.addAttribute("popularlist", popularlist);
		
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
		List<ProductPopularity> popularlist= service.getPopularProducts();
		model.addAttribute("popularlist", popularlist);
		
		ArrayList<ProductDTO> list = service.product_list();
		model.addAttribute("list", list);
		
		ArrayList<ProductDTO> flashlist = service.selectFlashSaleItems();
		model.addAttribute("flashlist", flashlist);
		
	    ArrayList<CategoryDTO> categorylist = service.categorylist();
		model.addAttribute("categorylist", categorylist);
		
		return ("category");
	}
	@RequestMapping("/product_insert")
	public String productInsert(HttpSession session, Model model,RedirectAttributes redirectAttributes) {
	    SellerDTO seller = (SellerDTO) session.getAttribute("loginSeller");
	    if (seller == null) {
	    	redirectAttributes.addFlashAttribute("msg", "판매자 로그인 후 이용해 주세요 😭");
	    	return "redirect:log/login";
	    }
	    
	    int sellerId = seller.getId();
	    // seller_id로 해당하는 가게 목록 조회
	    List<StoreDTO> stores = storeService.getStoresBySellerId(sellerId);
	    model.addAttribute("stores", stores);
	    log.info("stores"+stores);

	    return "product_insert";
	}

	
	@RequestMapping("/product_modify")
	public String product_modify(@RequestParam("id") int product_id,Model model,HttpSession session,RedirectAttributes redirectAttributes) {
		log.info("product_modify()");
		SellerDTO seller = (SellerDTO) session.getAttribute("loginSeller");
	    if (seller == null) {
	    	redirectAttributes.addFlashAttribute("msg", "판매자 로그인 후 이용해 주세요 😭");
	    	return "redirect:log/login";
	    }
	    
	    int sellerId = seller.getId();
		
		ProductDTO product = service.getProductById(product_id); 
	    model.addAttribute("product", product); 
	    List<StoreDTO> stores = storeService.getStoresBySellerId(sellerId);
	    model.addAttribute("stores", stores);
		return ("product_modify");
	}
	
	
	@RequestMapping("/product_delete")
	public String product_delete(@RequestParam("id") int id,HttpSession session,RedirectAttributes redirectAttributes) {
		log.info("product_delete()");
		SellerDTO seller = (SellerDTO) session.getAttribute("loginSeller");
	    if (seller == null) {
	    	redirectAttributes.addFlashAttribute("msg", "판매자 로그인 후 이용해 주세요 😭");
	    	return "redirect:log/login";
	    }
	    
		service.product_delete(id);
		return ("redirect:/main");
	}
	
	@RequestMapping("/product_modify_ok")
	@ResponseBody
	public String product_modify_ok(
	        @RequestParam HashMap<String, String> param,
	        @RequestParam("picture") MultipartFile picture) {

	    log.info("product_modify_ok()");

	    if (!picture.isEmpty()) {
	        String savedFileName = service.modifyImage(param, picture);
	        param.put("picture", savedFileName);  // 새 이미지 파일명 DB에 저장
	    }

	    log.info("product_modify_okpicture()"+picture);
	    service.product_modify(param);  // DB 업데이트
	    return "ok";
	}

	
	@RequestMapping("/content")
	public String content(@RequestParam("id") int product_id, Model model) {
	    ProductDTO product = service.getProductById(product_id);
	    model.addAttribute("product", product);

	    String storeName = storeService.getStoreNameById(product.getStore_id());
	    model.addAttribute("storeName", storeName); // 추가!

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
