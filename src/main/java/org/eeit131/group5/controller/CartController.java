package org.eeit131.group5.controller;


import java.util.ArrayList;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eeit131.group5.model.Product;
import org.eeit131.group5.model.ShoppingCart;
import org.eeit131.group5.service.CartService;
import org.eeit131.group5.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

public class CartController {

	@Autowired
	CartService cartService;

	@Autowired
	ProductService productService;

	@GetMapping("/findAllShoppingCartItem")
	public String sendAjaxShoppingCartForm() {
		return "/productmart/shoppingcart";
	}

	@GetMapping("/findshoppingcarts/{mbid}")
	public @ResponseBody List<ShoppingCart> findAll(
			@PathVariable Integer mbid) {
		List<ShoppingCart> fbmbid = cartService.findByMemberId(mbid);
		List<ShoppingCart> sc = new ArrayList<>();
		for(int i = 0; i < fbmbid.size(); i++) {
			ShoppingCart shoppingCart = fbmbid.get(i);
			Integer orderNo = shoppingCart.getOrderNo();
			if (orderNo == null) {
				sc.add(shoppingCart);
			}
			else {
				continue;
			}
		}
		return sc;
	}
		

	@PostMapping("/addcarts")
	public @ResponseBody Map<String, String> save(@RequestBody ShoppingCart shoppingCart) {
		System.out.println("shoppingCart=" + shoppingCart);

		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
			cartService.save(shoppingCart);
			result = "????????????";
			map.put("success", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}

	@PostMapping("/additemInCart") // ?????????????????????????????????
	public @ResponseBody Map<String, String> addIntoShoppingcart(@RequestBody ShoppingCart sc) {

		Map<String, String> map = new HashMap<>();
		String result = "";

		Integer memberId = sc.getMemberId();
		Integer itemId = sc.getItemId();
		Integer qty = sc.getQty();
		List<ShoppingCart> cartlist = cartService.findByMemberId(memberId);
		System.out.println("==================================="+cartlist);
		if (cartlist.size() == 0) {
			Product p1 = productService.findByProductId(sc.getItemId());// ??????????????????ID????????????????????????itemID
			sc.setDescription(p1.getName());// set????????????????????? (?????????????????????get???)
			sc.setUnitPrice(p1.getPrice());
			sc.setImage(p1.getPicture());
			sc.setMimeType(p1.getMimeType());
			sc.setQty(1);
			System.out.println(sc);
			cartService.save(sc);// ????????????
			result = "???????????????????????????";
			map.put("success", result);
			return map;

		} else {
			for (int i = 0; i < cartlist.size(); i++) {
				ShoppingCart sop = cartlist.get(i);
				Integer id = sop.getItemId();
 
				if (itemId.equals(id)) {
					if(sop.getOrderNo() == null) {
					sop.setQty(sop.getQty() + 1);
					System.out.println(sop);
					cartService.update(sop);
					result = "???????????????????????????";
					map.put("success", result);
					break;
					} else {
						Product p1 = productService.findByProductId(sc.getItemId());
						sc.setDescription(p1.getName());
						sc.setUnitPrice(p1.getPrice());
						sc.setQty(1);
						System.out.println(sc);
						cartService.save(sc);// ????????????
						result = "???????????????????????????";
						map.put("success", result);
						return map;
					}
				} else {
					if (i == (cartlist.size() - 1)) {
						Product p1 = productService.findByProductId(sc.getItemId());// ??????????????????ID????????????????????????itemID
						sc.setImage(p1.getPicture());
						sc.setMimeType(p1.getMimeType());
						sc.setDescription(p1.getName());// set????????????????????? (?????????????????????get???)
						sc.setUnitPrice(p1.getPrice());
						sc.setQty(1);
						System.out.println(sc);
						cartService.save(sc);
						result = "???????????????????????????";
						map.put("success", result);
						break;
					} else {
						continue;
					}
				}
			}
			return map;
		}

	}

	@GetMapping("/addcartsForm")
	public String addShoppingCartForm(Model model) {
		return "/productmart/addshoppingcart";
	}

	@GetMapping("/editShoppingCartForm")
	public String sendEditShoppingCartForm(@RequestParam("seqNo") String seqNo, Model model) {
		model.addAttribute("seqNob", seqNo);
		return "/productmart/editshoppingcart";
	}



	@PutMapping("/updateshoppingcartitem")
	public @ResponseBody Map<String, String> update(@RequestBody ShoppingCart shoppingCart) {
		System.out.println("update()??? shoppingCart=" + shoppingCart);
		// ???????????????????????????????????????????????????????????????
		Map<String, String> map = new HashMap<>();
		String result = "";

		try {
			cartService.update(shoppingCart);
			result = "????????????";
			map.put("success", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}

	@GetMapping("/getshoppingcartitem") // GET??????????????????
	public @ResponseBody ShoppingCart findBySeqNo(@RequestParam Integer seqNo) {
		return cartService.findBySeqNo(seqNo);
	}

	@DeleteMapping("/deleteshoppingcartitem/{seqNoValue}")
	public @ResponseBody Map<String, String> delete(@PathVariable Integer seqNoValue) {
		System.out.println("shoppingCart=" + seqNoValue);

		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
			cartService.delete(seqNoValue);
			result = "????????????";
			map.put("success", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}
	
	@GetMapping("/shoppingCart/getPicture")
	public ResponseEntity<byte[]> getPicture(
			@RequestParam("seqNo")Integer seqNo
			){
		ResponseEntity<byte[]> re = null;
		ShoppingCart shoppingCart =cartService.findBySeqNo(seqNo);
		HttpHeaders headers = new HttpHeaders();
		
		if(shoppingCart.getImage()!=null) {
			Blob blob = shoppingCart.getImage();
			MediaType mediaType = MediaType.valueOf(shoppingCart.getMimeType());
		try {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			InputStream is = blob.getBinaryStream();
			byte[]b = new byte[81920];
			int len = 0;
			while((len = is.read(b))!=-1) {
				baos.write(b,0,len);
			}
			headers.setContentType(mediaType);
			headers.setCacheControl(CacheControl.noCache().getHeaderValue());
		    re = new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
		}
		}else {
			headers.setContentType(null);
			re = null;
			
//			System.out.println(product.getId()+ " doesn't have images");
		}
		return re;
	}

	@GetMapping("/findSCDetailsByOrderNo")
	public @ResponseBody List<ShoppingCart> findByOrderNo(@RequestParam Integer orderNo) {
		return cartService.findByOrderNo(orderNo);
	}
}
