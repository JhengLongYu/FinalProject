package org.eeit131.group5.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eeit131.group5.model.Article;
import org.eeit131.group5.model.Carousel;
import org.eeit131.group5.service.ArticleService;
import org.eeit131.group5.service.CarouselService;
import org.eeit131.group5.service.CollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CarouselController {
	
	@Autowired
	ArticleService articleService;
	
	@Autowired
	CollectService collectService;
	
	@Autowired
	CarouselService carouselService;
	
	
	//輪播頁面
	@GetMapping("/carousel/carouselManagement")
	public String carouselManagement() {
		return "/article/carouselManagement";
	}
	
	
	@GetMapping("/carousel/carouselSave")
	public @ResponseBody Map<String,String> carouselSave(
			@RequestParam Integer art_id) {
		List<Carousel> carousels = carouselService.findAll();
		Map<String,String> map = new HashMap<>();
		String result="";
		if(carousels.size() != 0) {
			for(int i =0; i < carousels.size(); i++) {
				if(carousels.get(i).getArt_id() == art_id) {
					result="輪播牆文章重複請重新挑選";
					map.put("fail", result);
					return map;
				}
			}
		}
		Article article = articleService.findById(art_id);
		Carousel carousel = new Carousel();
		carousel.setArt_id(article.getArt_id());
		carousel.setArt_title(article.getArt_title());
		carousel.setArt_create_time(article.getArt_create_time());
		carousel.setMimeType(article.getMimeType());
		carousel.setCoverImage(article.getCoverImage());
		carouselService.save(carousel);
		result = "新增成功";
		map.put("success", result);
		return map;
	}
	
	@GetMapping("/carousel/findAll")
	public @ResponseBody List<Carousel> carouselFindAll(){
		List<Carousel> carousels = carouselService.findAll();
		if(carousels.size() != 0) {
			for(int i =0; i<carousels.size(); i++) {
				carouselService.detach(carousels.get(i));
				carousels.get(i).setArt_create_time(carousels.get(i).getArt_create_time().substring(0, 19));
				if(carousels.get(i).getArt_title().length() > 25) {
					carousels.get(i).setArt_title(carousels.get(i).getArt_title().substring(0, 25) + "...");
                }
			}
		}
		return carousels;
	}
	
	//輪播牆-刪除輪播文章
	@GetMapping("/carousel/deleteCarousel")
	public @ResponseBody Map<String,String> deleteCarousel(
			@RequestParam Integer carousel_id) {
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			carouselService.delete(carousel_id);
			result="刪除成功";
			map.put("success", result);
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail", result);
		}
		return map;
	}
	
}
