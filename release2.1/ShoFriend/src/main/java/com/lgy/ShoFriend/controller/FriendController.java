package com.lgy.ShoFriend.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
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
	
	@GetMapping("/friend_status")
	public String friendStatus(@RequestParam("targetId") int targetId, HttpSession session, Model model) {
	    CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");

	    if (loginCustomer == null) {
	        model.addAttribute("friendStatus", null);
	        return "friend_status";
	    }

	    int myId = loginCustomer.getId();

	    // 친구 상태 가져오기
	    String status = service.getFriendStatus(myId, targetId); // → pending, accepted, blocked
	    String name = service.getFriendName(targetId); // 친구 이름

	    model.addAttribute("friendStatus", status);
	    model.addAttribute("friendName", name);

	    return "friend"; // 이 jsp에 위에 제시한 <c:choose> 코드가 들어가면 됨
	}
	
	@GetMapping("/friend_list")
	public String friendList(HttpSession session, Model model) {
	    CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");

	    if (loginCustomer == null) {
	        return "redirect:/login";  // 로그인 안된 경우 로그인 페이지로
	    }
	    int myId = loginCustomer.getId();
	    List<CustomerDTO> friendList = service.getMyFriends(myId);
	    model.addAttribute("friendList", friendList);

	    log.info("친구 수: " + friendList.size());
	    for (CustomerDTO dto : friendList) {
	    	log.info("친구 이름: " + dto.getName());
	    }
	    return "friend_list"; // → friend_list.jsp로 이동
	}
	
	@GetMapping("/friend_list_json")
	@ResponseBody
	public List<CustomerDTO> friendListJson(HttpSession session) {
	    CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");
	    if (loginCustomer == null) {
	        return new ArrayList<>();
	    }

	    int myId = loginCustomer.getId();
	    return service.getMyFriends(myId); // 친구 리스트 반환 (JSON)
	}


}
