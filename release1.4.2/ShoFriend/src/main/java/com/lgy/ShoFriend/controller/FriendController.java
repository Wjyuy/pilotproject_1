package com.lgy.ShoFriend.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.lgy.ShoFriend.dto.CustomerDTO;
import com.lgy.ShoFriend.service.FriendService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class FriendController {
/*
* (메소드 동작 방식 기재)
* 작성일      작성자   개발내용,수정내용
* 25/04/10    우주연   친구
*/
	@Autowired
	private FriendService service;
	
	@GetMapping("/checkFriend")
	@ResponseBody
	public Map<String, Object> checkFriendByEmail(@RequestParam("email") String email) {
	    Map<String, Object> response = new HashMap<>();

	    CustomerDTO customer = service.findByEmail(email);
	    if (customer != null) {
	        response.put("id", customer.getId());
	        response.put("email", customer.getEmail());
	        response.put("name", customer.getName());
	    }

	    return response;
	}
	
	@PostMapping("/addFriend")
	@ResponseBody
	public Map<String, Object> addFriend(@RequestBody Map<String, Object> req, HttpSession session) {
	    Map<String, Object> result = new HashMap<>();

	    try {
	        int customerId1 = (int) session.getAttribute("customer_id"); // 세션에서 로그인한 사용자 ID
	        int customerId2 = (int) req.get("customer_id2");

	        // 작은 ID를 customer_id1, 큰 ID를 customer_id2로 (조건 맞추기 위해)
	        int smaller = Math.min(customerId1, customerId2);
	        int larger = Math.max(customerId1, customerId2);

	        service.insertFriend(smaller, larger, "pending");

	        result.put("success", true);
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("success", false);
	        result.put("message", e.getMessage());
	    }

	    return result;
	}

}
