package org.eeit131.group5.controller;

import org.eeit131.group5.model.Order;
import org.eeit131.group5.service.OrderDetailsService;
import org.eeit131.group5.service.PaypalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;

@Controller
@SessionAttributes("orderNo")
public class PaypalController {

	@Autowired
	PaypalService service;
	@Autowired
	OrderDetailsService orderDetailsService;

	public static final String SUCCESS_URL = "pay/success";
	public static final String CANCEL_URL = "pay/cancel";

	@GetMapping("/paypal/{orderNo}")
	public String home(@PathVariable Integer orderNo, Model model) {
		model.addAttribute("orderNo", orderNo);
		return "home";
	}

//	@PostMapping("/pay")
//	public String payment(@ModelAttribute("order") Order order) {
//		try {
//			Payment payment = service.createPayment(order.getPrice(), order.getCurrency(), order.getMethod(),
//					order.getIntent(), order.getDescription(), "http://eeit131health.southeastasia.cloudapp.azure.com:8080/FinalProject/" + CANCEL_URL,
//					"http://eeit131health.southeastasia.cloudapp.azure.com:8080/FinalProject/" + SUCCESS_URL);
//			for(Links link:payment.getLinks()) {
//				if(link.getRel().equals("approval_url")) {
//					return "redirect:"+link.getHref();
//				}
//			}
//			
//		} catch (PayPalRESTException e) {
//		
//			e.printStackTrace();
//		}
//		return "redirect:/";
//	}
	
	@PostMapping("/pay")
	public String payment(@ModelAttribute("order") Order order) {
		try {
			Payment payment = service.createPayment(order.getPrice(), order.getCurrency(), order.getMethod(),
					order.getIntent(), order.getDescription(), "http://eeit131health.southeastasia.cloudapp.azure.com:8080/FinalProject/" + CANCEL_URL,
					"http://eeit131health.southeastasia.cloudapp.azure.com:8080/FinalProject/" + SUCCESS_URL);
			for(Links link:payment.getLinks()) {
				if(link.getRel().equals("approval_url")) {
					return "redirect:"+link.getHref();
				}
			}
			
		} catch (PayPalRESTException e) {
		
			e.printStackTrace();
		}
		return "redirect:/";
	}
	
	 @GetMapping(value = CANCEL_URL)
	    public String cancelPay() {
	        return "cancel";
	    }

	    @GetMapping(value = SUCCESS_URL)
	    public String successPay(@RequestParam("paymentId") String paymentId, @RequestParam("PayerID") String payerId, Model model) {
	        try {
	            Payment payment = service.executePayment(paymentId, payerId);
	            System.out.println(payment.toJSON());
	            if (payment.getState().equals("approved")) {
	                model.addAttribute("paymentSuccess", "paymentSuccess");
	            	return "ODMbyUser";
	            }
	        } catch (PayPalRESTException e) {
	         System.out.println(e.getMessage());
	        }
	        model.addAttribute("paymentSuccess", "paymentSuccess");
	         System.out.println("=======");
        	return "ODMbyUser";	    
        	} 
	    
	    @GetMapping("/paymentComplete")
	    public @ResponseBody String paymentComplete(@RequestParam("orderNo") Integer orderNo) {
	    	System.out.println("==");
	    	orderDetailsService.updateStatus(orderNo);
	    	return "success";
	    }
}