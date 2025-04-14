package com.lgy.ShoFriend.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lgy.ShoFriend.dto.CustomerDTO;
import com.lgy.ShoFriend.dto.SellerDTO;
import com.lgy.ShoFriend.service.InfoService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class InfoController {
/*
 * 25.04.09 권준우 - 최초작성 : 기본 틀, customer쪽 마이페이지, 정보확인, 비밀번호 변경
 * 25.04.10 권준우 - 추가 : InfoUpdate, seller쪽 구현
 */
	
	@Autowired
	private InfoService service;	
	
	//25.04.09 권준우 - 마이페이지 호출
	@RequestMapping("/my_page")
	public String myPage() {
		log.info("@# my_page()");
		return "my_page";
	}
	
	//25.04.09 권준우 - 구매자 정보 페이지 호출
	@RequestMapping("/customer_info")
	public String customerInfo() {
		log.info("@# customer_info()");
		return "customer_info";
	}
	
	//25.04.09 권준우 - 판매자 정보 페이지 호출
	@RequestMapping("/seller_info")
	public String sellerInfo() {
		log.info("@# seller_info()");
		return "seller_info";
	}
	
	//25.04.09 권준우 - 비밀번호 변경 페이지 호출
	@RequestMapping("/update_pwd")
	public String updatePwd() {
		log.info("@# update_pwd()");
	    return "update_pwd";
	}

//	//25.04.09 권준우 - 비밀번호 변경 메소드 (seller쪽 추가 전)
//	@RequestMapping("/updatePwdOk")	
//	public String updatePwdOk(@RequestParam("new_pwd") String newPwd, HttpSession session) {
//	    CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");
//
//	    if (loginCustomer != null) {
//	        HashMap<String, String> param = new HashMap<String, String>();
//	        param.put("id", Integer.toString(loginCustomer.getId()));
//	        param.put("new_pwd", newPwd);
//
//	        service.updatePwd(param);
//	        loginCustomer.setPassword(newPwd); // 세션의 비밀번호 업데이트
//	        log.info("@# update_pwd()");
//	        
//	        return "redirect:customer_info";
//	    } else {
//	        return "redirect:login";
//	    }
//	}
	
//	25.04.11 권준우 - 비밀번호 변경 메소드 (customer, seller 양쪽 다 적용)
	@RequestMapping("/updatePwdOk")	
	public String updatePwdOk(@RequestParam("new_pwd") String newPwd, HttpSession session) {
		String userType = (String) session.getAttribute("userType");

		if ("customer".equals(userType)) {
			CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");

			if (loginCustomer != null) {
				HashMap<String, String> param = new HashMap<String, String>();
				param.put("id", Integer.toString(loginCustomer.getId()));
				param.put("new_pwd", newPwd);

				service.updatePwd(param);
				loginCustomer.setPassword(newPwd); // 세션 동기화

				log.info("@# updatePwdOk() - customer");
				return "redirect:customer_info";
			}

		} else if ("seller".equals(userType)) {
			SellerDTO loginSeller = (SellerDTO) session.getAttribute("loginSeller");

			if (loginSeller != null) {
				HashMap<String, String> param = new HashMap<String, String>();
				param.put("id", Integer.toString(loginSeller.getId()));
				param.put("new_pwd", newPwd);

				service.updatePwd2(param);
				loginSeller.setPassword(newPwd); // 세션 동기화

				log.info("@# updatePwdOk() - seller");
				return "redirect:seller_info";
			}
		}

		// 로그인 상태가 아니거나 예외 상황
		return "redirect:login";
	}

	

	//25.04.09 권준우 - 로그아웃 메소드
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
	    session.invalidate();  // 현재 로그인된 세션 모두 삭제
	    log.info("@# logout()");
	    return "redirect:login";  // 로그인 페이지로 이동
	}
	
	//25.04.09 권준우 - 비밀번호 확인 페이지 호출
	@RequestMapping("/check_pwd")
	public String checkPwdPage() {
		log.info("@# check_pwd()");
	    return "check_pwd";  //
	}
	
	
/*	
 	seller 쪽 추가하기 전
 	
 	//25.04.09 권준우 - 비밀번호 확인 메소드(customer)
	@RequestMapping("/checkPwdOk")
	public String checkPwdOk(@RequestParam("input_pwd") String inputPwd, HttpSession session) {
	    CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");
	    log.info("@# check_pwdOk()");

	    if (loginCustomer != null && inputPwd.equals(loginCustomer.getPassword())) {
	        return "redirect:customer_info";  // 맞으면 구매자 정보 페이지로
	    } else {
	        return "redirect:check_pwd";  // 틀렸으면 다시 입력
	    }
	}
*/	
	
	//25.04.10 권준우 - 비밀번호 확인 메소드 : seller쪽 추가하면서 session의 userType 정보 토대로 다르게 판별
	@RequestMapping("/checkPwdOk")
	public String checkPwdOk(@RequestParam("input_pwd") String inputPwd, HttpSession session) {
		log.info("@# checkPwdOk()");

		String userType = (String) session.getAttribute("userType");
		
		if ("customer".equals(userType)) {
			CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");

			if (loginCustomer != null && inputPwd.equals(loginCustomer.getPassword())) {
				return "redirect:customer_info";
			} else {
				return "redirect:check_pwd";
			}

		} else if ("seller".equals(userType)) {
			SellerDTO loginSeller = (SellerDTO) session.getAttribute("loginSeller");

			if (loginSeller != null && inputPwd.equals(loginSeller.getPassword())) {
				return "redirect:seller_info";
			} else {
				return "redirect:check_pwd";
			}

		} else {
			return "redirect:main";
		}
	}
	

	//25.04.10 권준우 - customer 정보 변경 메소드
	@RequestMapping("/updateCustomerInfo")
	@ResponseBody
	public String updateCustomerInfo(@RequestParam String field, @RequestParam String value, HttpSession session) {
		log.info("@# updateCustomerInfo_start()");
		
		CustomerDTO loginCustomer = (CustomerDTO) session.getAttribute("loginCustomer");
		
		if (loginCustomer == null) return "fail";

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("id", String.valueOf(loginCustomer.getId()));
		param.put("field", field);
		param.put("value", value);

		service.updateInfo(param);

		log.info("@# updateCustomerInfo_end()");
		
		// 세션 동기화
		if (field.equals("name")) {
			loginCustomer.setName(value);
		} else if (field.equals("phone")) {
			loginCustomer.setPhone(value);
		} else if (field.equals("address")) {
			loginCustomer.setAddress(value);
		}

		return "success";
	}
	
	//25.04.10 권준우 - seller 정보 변경 메소드
	@RequestMapping("/updateSellerInfo")
	@ResponseBody
	public String updateSellerInfo(@RequestParam String field, @RequestParam String value, HttpSession session) {
		log.info("@# updateSellerInfo_start()");
		
		SellerDTO loginSeller = (SellerDTO) session.getAttribute("loginSeller");
		
		if (loginSeller == null) return "fail";
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("id", String.valueOf(loginSeller.getId()));
		param.put("field", field);
		param.put("value", value);
		
		service.updateInfo2(param);
		
		log.info("@# updateSellerInfo_end()");
		
		// 세션 동기화
		if (field.equals("name")) {
			loginSeller.setName(value);
		} else if (field.equals("phone")) {
			loginSeller.setPhone(value);
		}
		
		return "success";
	}
	
	
}