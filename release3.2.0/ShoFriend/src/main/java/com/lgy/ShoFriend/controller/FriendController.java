package com.lgy.ShoFriend.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lgy.ShoFriend.dto.CustomerDTO;
import com.lgy.ShoFriend.service.FriendService;

import lombok.extern.slf4j.Slf4j;

@Controller
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
	    	CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");
	        int customerId1 = loginCustomer.getId();  // 로그인한 사람
	        int customerId2 = (int) req.get("customer_id2"); // 검색된 친구

	        // 작은 ID가 customer_id1이 되도록 조정
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
	
	@RequestMapping("/friend")
	public String friend(HttpSession session, Model model) {
		log.info("friend()");
		CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");

        if (loginCustomer != null) {
            String myId = String.valueOf(loginCustomer.getId());

            HashMap<String, String> param = new HashMap<>();
            param.put("id", myId);

            List<CustomerDTO> acceptedFriends = service.getAcceptedFriends(Integer.parseInt(myId));
            model.addAttribute("acceptedFriends", acceptedFriends);
            
            // Pending 친구 요청 목록 조회
            ArrayList<CustomerDTO> pendingList = service.findpending(param);
            model.addAttribute("pendingList", pendingList);
        }
        return "friend";
	}
	@PostMapping("/acceptFriend")
	public String acceptFriend(@RequestParam("customer_id1") int customerId1, HttpSession session) {
		log.info("acceptFriend()");
	    CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");
	    int customerId2 = loginCustomer.getId();  // 수락한 사람의 ID

	    HashMap<String, String> param = new HashMap<>();
	    param.put("customer_id1", String.valueOf(customerId1));
	    param.put("customer_id2", String.valueOf(customerId2));
	    log.info("customer_id1"+ String.valueOf(customerId1));
	    log.info("customer_id2"+ String.valueOf(customerId2));

	    service.updateFriendStatus(param);
	    return "redirect:/friend"; // 수락 후 친구 페이지 리다이렉트
	    
	}
	@PostMapping("/rejectFriend")
	public String rejectFriend(@RequestParam HashMap<String, String> param, HttpSession session) {
		log.info("rejectFriend()");
	    CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");
	    int customerId2 = loginCustomer.getId();  // 나 (거절하는 사람)
	    
	    param.put("customer_id2", String.valueOf(customerId2));
	    
	    service.rejectFriend(param);
	    
	    return "redirect:/friend";  // 거절 후 다시 친구 페이지로
	}
	@PostMapping("/deleteFriend")
	public String deleteFriend(@RequestParam("friend_id") int friendId, HttpSession session) {
		log.info("deleteFriend()");
	    CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");
	    int myId = loginCustomer.getId();

	    service.deleteFriend(myId, friendId); // 로직 넘김

	    return "redirect:/friend";
	}

	


}
