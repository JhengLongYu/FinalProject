package org.eeit131.group5.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.eeit131.group5.model.Product;
import org.eeit131.group5.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping
@Transactional
public class ProductController {

	@Autowired
	ProductService productService;
	
	@GetMapping("/productmart")
	public String productmart() {
		return "/productmart/Product";
	}
	
//	@GetMapping("/categorymeal")
//	public String categorymeal() {
//		return "/productmart/Productmeal";
//	}




	@GetMapping("/editProductForm")
	public String sendEditMemberForm(
			@RequestParam("id") String id, Model model) {
		model.addAttribute("idid", id);
		return "/product/editProductForm";
	}

	@GetMapping("/addForm")
	public String addMemberForm(Model model) {
		return "/product/addProduct";
	}

	@GetMapping("/findproductForm")
	public String sendAjaxProductForm() {
		return "/product/showAllProducts";
	}

	@GetMapping("/findproducts")
	public @ResponseBody List<Product> findAll() {
		List<Product> product = productService.findAll();
		return product;
	}

	@PostMapping("/adds")
	public @ResponseBody Map<String, String> save(@RequestBody Product product) {
		System.out.println("product=" + product);

		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
			productService.save(product);
			result = "新增成功";
			map.put("success", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}

	@PutMapping(value = "/product/update", produces = { "application/json; charset=UTF-8"})
	public @ResponseBody Map<String, String> update
	(@RequestBody Product product) {
		System.out.println("update()之 product=" + product);
		System.out.println(product.getFileDataUrl());
		// 以下敘述為模擬系統產生的訊息，會員不能修改
		Map<String, String> map = new HashMap<>();
		String result = "";
		if(product.getFileDataUrl()!=null) {
			System.out.println("update()之 product=" + product);
			int startIndex = "data:".length();
			int endIndex = product.getFileDataUrl().indexOf(";");
			String mimeType = product.getFileDataUrl().substring(startIndex, endIndex);
			String base64 = product.getFileDataUrl().substring(product.getFileDataUrl().indexOf(",") + 1);
			byte[] a = Base64.getDecoder().decode(base64);
			try {
				product.setPicture(new SerialBlob(a));
			}catch(SerialException e) {
				e.printStackTrace();
			}catch(SQLException e) {
				e.printStackTrace();
			}
			product.setMimeType(mimeType);
		}else {
			product.setPicture(null);
			product.setMimeType(null);
		}
		
		try {
			productService.update(product);
			result = "修改成功";
			map.put("success", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}

	@GetMapping("/ajax/member") // GET單一品項資料
	public @ResponseBody Product findByProductId(
			@RequestParam Integer id) {
		return productService.findByProductId(id);
	}
	
	@GetMapping("/category/{category}")
	public String findByProductcategory(
			@PathVariable String category,
		Model model) {
		model.addAttribute("category", category);
		return "/productmart/Productmeal";
	}
	
	@GetMapping("/category1")
	public @ResponseBody List<Product> findByProductcategory(
			@RequestParam String category) {
		return productService.findByProductcategory(category);
	}

	
	@DeleteMapping("/deletes/{idValue}")
	public @ResponseBody Map<String, String> 
	delete(@PathVariable Integer idValue ) {
		System.out.println("product=" + idValue);

		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
			productService.delete(idValue);
			result = "刪除成功";
			map.put("success", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}
	
	@PostMapping(value = "/product/save", produces = {"application/json; charset=UTF-8"})
	public @ResponseBody List<Product> saveData(
			@RequestBody Product product
			){
		System.out.println(product.getFileDataUrl());
		if(product.getFileDataUrl()!=null) {
			int startIndex = "data:".length();
			int endIndex = product.getFileDataUrl().indexOf(";");
			String mimeType = product.getFileDataUrl().substring(startIndex, endIndex);
			String base64 = product.getFileDataUrl().substring(product.getFileDataUrl().indexOf(",") + 1);
		    byte[] a = Base64.getDecoder().decode(base64);
		    System.out.println(product.getFileDataUrl());
		    System.out.println(mimeType);
		    try {
		    	product.setPicture(new SerialBlob(a));
		    }catch(SerialException e) {
		    	e.printStackTrace();
		    }catch(SQLException e) {
		    	e.printStackTrace();
		    }
		    product.setMimeType(mimeType);		
		}else {
			product.setPicture(null);
			product.setMimeType(null);
		}
		productService.save(product);
		return productService.findAll();
	}
	
	@GetMapping("/product/getPicture")
	public ResponseEntity<byte[]> getPicture(
			@RequestParam("id")Integer id
			){
		ResponseEntity<byte[]> re = null;
		Product product = productService.findByProductId(id);
		HttpHeaders headers = new HttpHeaders();
		
		if(product.getPicture()!=null) {
			Blob blob = product.getPicture();
			MediaType mediaType = MediaType.valueOf(product.getMimeType());
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
			
			System.out.println(product.getId()+ " doesn't have images");
		}
		return re;
	}

}
