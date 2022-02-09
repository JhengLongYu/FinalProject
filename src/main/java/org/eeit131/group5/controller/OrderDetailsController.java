package org.eeit131.group5.controller;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eeit131.group5.model.OrderDetails;
import org.eeit131.group5.model.ShoppingCart;
import org.eeit131.group5.service.CartService;
import org.eeit131.group5.service.MemberService;
import org.eeit131.group5.service.OrderDetailsService;
import org.eeit131.group5.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class OrderDetailsController {
	
	@Autowired
	OrderDetailsService orderDetailsService;
	@Autowired
	CartService cartService;
	@Autowired
	ProductService productService;
	@Autowired
	MemberService memberService;
	
	@GetMapping("/addOrderDetailsForm")
	public String addOrderDetailsForm(OrderDetails orderDetails) {
		return "registerSample";
	}
	
//	@GetMapping("/CheckMemberId")
//	public @ResponseBody Map<String, String> existsByMemberId(
//			@RequestParam("memberId") String memberId) {
//		Map<String, String> map = new HashMap<>();
//		List<OrderDetails> orderDetails = orderDetailsService.findByMemberId(memberId);
//		if (orderDetails == null) {
//			map.put("memberId", "");
//		} else {
//			map.put("memberId", orderDetails.getMemberId());
//		}
//		return map;
//	}

	@PostMapping("/orderInfo")
	public @ResponseBody Map<String, String> save(@RequestBody OrderDetails orderDetails) {
		System.out.println("orderDetails=" + orderDetails);
		
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		orderDetails.setCreateTime(ts);
		
		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
		   orderDetailsService.save(orderDetails);
		   result = "新增成功";
		   map.put("success", result);
		} catch(Exception e) {
		   result = e.getMessage();	
		   map.put("fail", result);
		}
		return map;
	}
	
	@GetMapping("/showAllOrders")
	public String sendOrderDetailsForm() {
		return "showAllSample";
	}
	
	@GetMapping("/findAllOrders")
	public @ResponseBody List<OrderDetails> findAll() {
		return orderDetailsService.findAll();
	}
	
	@GetMapping("/findOrdersByMemberId")
	public @ResponseBody List<OrderDetails> findByMemberId(
			@RequestParam Integer memberId
			) {
		return orderDetailsService.findByMemberId(memberId);
	}
	
//	@GetMapping("/showOrderDetailsByMemberId")
//	public String sendOrderDetailsByMemberId(
//			@RequestParam("memberId") String memberId,
//			Model model) {
//		model.addAttribute("mbmb", memberId);
//		return "orderManagementByUser";
//	}

	@GetMapping("/findOrderNo")
	public @ResponseBody OrderDetails findByOrderNo(
			@RequestParam Integer orderNo
			) {
		return orderDetailsService.findByOrderNo(orderNo);
	}
	
	@GetMapping("/showOrderDetailsByOrderNo")
	public String sendOrderDetailsByOrderNo(
			@RequestParam("orderNo") Integer orderNo,
			Model model) {
		model.addAttribute("onon", orderNo);
		return "ODbyUser";
	}
	
	@GetMapping("/editForm")
	public String sendEditMemberForm(
			@RequestParam("orderNo") Integer orderNo,
			Model model
			) {
		model.addAttribute("idid", orderNo);
		return "ODMedit";
	}
	
	//@PutMapping("/updateOrderDetails/{orderNo}") //因直接回傳整個物件，沒用到路徑變數
	@PutMapping("/updateOrderDetails/")
	public @ResponseBody Map<String, String> update(
			  @RequestBody OrderDetails orderDetails
			  //@PathVariable Integer orderNo //因直接回傳整個物件，沒用到路徑變數
			) {
		System.out.println("update()之 orderDetails=" + orderDetails);
		// 以下敘述為模擬系統產生的訊息，會員不能修改
		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
			orderDetailsService.update(orderDetails);
		   result = "修改成功";
		   map.put("success", result);
		} catch(Exception e) {
		   result = e.getMessage();	
		   map.put("fail", result);
		}
		return map;
	}
	
	@DeleteMapping("/deleteOrderDetails/{orderNoValue}")
	public @ResponseBody Map<String, String> delete(
			  @PathVariable Integer orderNoValue
			) {
		System.out.println("delete()之 orderDetails=" + orderNoValue);
		// 以下敘述為模擬系統產生的訊息，會員不能修改
		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
			orderDetailsService.delete(orderNoValue);
		   result = "刪除成功";
		   map.put("success", result);
		} catch(Exception e) {
		   result = e.getMessage();	
		   map.put("fail", result);
		}
		return map;
	}
	
	@PostMapping("/createOrderWithShoppingCarts") // 將購物車資訊新增至訂單
	public @ResponseBody Map<String, String> createOrderWithShoppingCarts(@RequestBody ShoppingCart sc) {

		Integer memberId = sc.getMemberId();
		Double totalAmount = sc.getTotalAmount();
		Map<String, String> map = new HashMap<>();
		String result = "";
		int r = 0;
		r = (int)(Math.random()*1000)+1;
		List<ShoppingCart> cartList = cartService.findByMemberIdWithoutON(memberId);
		if(cartList.size() > 0) {
			for(int i = 0; i < cartList.size(); i++) {
			ShoppingCart shoppingCart = cartList.get(i);
			shoppingCart.setOrderNo(r);
			cartService.updateOrderNo(shoppingCart);
			System.out.println("====");
			}
			OrderDetails orderDetails = new OrderDetails();
			orderDetails.setOrderNo(r);
			orderDetails.setMemberId(memberId);
			orderDetails.setAmount(totalAmount);
			Timestamp ts = new Timestamp(System.currentTimeMillis());
			orderDetails.setCreateTime(ts);
			orderDetails.setShippingAddress(memberService.findById(memberId).getAddress());
			orderDetails.setPaymentMethod(sc.getPaymentMethod());
			
			try {
				orderDetailsService.save(orderDetails);
			   result = "新增成功";
			   map.put("success", result);
			} catch(Exception e) {
			   result = e.getMessage();	
			   map.put("fail", result);
			}
		} else {
				result = "購物車無商品";
			    map.put("fail", result);
		}
		return map;
	}
}
