package com.lgy.ShoFriend.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.ShoFriend.dto.StoreDTO;
import com.lgy.ShoFriend.service.InfoService;
import com.lgy.ShoFriend.service.StoreService;

import com.lgy.ShoFriend.dto.StoreDTO;
import com.lgy.ShoFriend.service.StoreService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class StoreController {

/*
 * Store관련 긁어오기만 한 상태임. 제대로 구현되도록 수정 필요.
 */
	
	@Autowired
	private StoreService service;
	
	//(등록된 점포 리스트) 25.04.09 김채윤
		@RequestMapping("/list")
		public String list() {
			log.info("@# list()");
			return "list";
		}
		
	//(점포 보기)25.04.09 김채윤
		@RequestMapping("/store_view")
		public String content_view(@RequestParam HashMap<String, String> param) {
			log.info("@# store_view()");

			StoreDTO dto = service.contentView(param);
			return "store_view";
		}
		
//		(점포 수정) 25.04.09 김채윤
		@RequestMapping("/store_modify")
		public String modify(@RequestParam HashMap<String, String> param) {
			log.info("@# store_modify()");

	//	
			service.store_modify(param);
			return "redirect:list";
		}
		
//		(점포 삭제) 25.04.09 김채윤
		@RequestMapping("/store_delete")
		public String delete(@RequestParam HashMap<String, String> param) {
			log.info("@# store_delete()");

			service.store_delete(param);
			return "redirect:list";
		}
		
//		(점포 등록) 25.04.09 김채윤
		@RequestMapping("/store_register")
		public String store_register() {
			log.info("store_register()");
			return "store_register";
		}
		
		//(점포 등록 완료) 25.04.08 김채윤
		@RequestMapping("/store_registerOk")
			public String store_registerOk(@RequestParam HashMap<String, String> param) {
			log.info("@# store_registerOk()");

			service.store_write(param);
			return "redirect:login";
		}
	}
