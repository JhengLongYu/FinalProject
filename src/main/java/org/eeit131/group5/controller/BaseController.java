package org.eeit131.group5.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BaseController {

	@GetMapping({"/index","first","aa"})
	public String index() {
		return "index";
	}

	// 後台登入頁面 登入後會返回後台首頁
	@GetMapping("/backindex")
	public String backindex() {
		return "/login_Back/management_login";
	}

	// 後台首頁
	@GetMapping("/management")
	public String management() {
		System.out.println("Here!");
		return "/management";
	}

	// 註冊頁面
	@GetMapping("/register")
	public String register() {
		return "/login_Front/register";
	}

	// 後台會員中心頁面
	@GetMapping("/memberManagement")
	public String sendAjaxMemberForm() {
		return "/login_Back/management_member";
	}

	// 登入頁面
	@GetMapping("/login")
	public String login() {
		return "/login_Front/login";
	}


	// 忘記密碼頁面
	@GetMapping("/login/login_forgetPassword")
	public String forgetPassword() {
		return "/login_Front/login_forgetPassword";
	}

	@GetMapping("/memberCenter")
	public String memberCenter() {
		return "/login_Front/memberCenter";
	}

	@GetMapping("/memberCenter_editInfo")
	public String memberCenterEditInfo() {
		return "/login_Front/memberCenter_editInfo";
	}

	@GetMapping("/memberCenter_editPassword")
	public String memberCenterEditPassword() {
		return "/login_Front/memberCenter_editPassword";
	}
	
	@GetMapping("/ordersManagement")
	public String ordersManagement() {
		return "ordersManagement";
	}
	
	@GetMapping("/orderManagementByUser")
	public String orderManagementByUser() {
		return "ODMbyUser";
	}

}
