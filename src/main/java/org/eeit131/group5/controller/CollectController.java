package org.eeit131.group5.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eeit131.group5.model.Article;
import org.eeit131.group5.model.Collect;
import org.eeit131.group5.service.ArticleService;
import org.eeit131.group5.service.CollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CollectController {
	
	@Autowired
	ArticleService articleService;
	
	@Autowired
	CollectService collectService;
	
	
	//文章內容區-文章取消收藏
	@PostMapping("/collect/checkCollect")
	public @ResponseBody Collect checkCollect(
			@RequestBody Collect collect){
		Collect col = collectService.findByArtIdUserId(collect.getArt_id(), collect.getCollect_user_id());
		return col;
	}
	
	//文章內容區-文章收藏文章
	@PostMapping("/collect/saveCollect")
	public @ResponseBody void saveCollect(
			@RequestBody Collect collect){
		collectService.save(collect);
	}
	
	//文章內容區-文章取消收藏
	@PostMapping("/collect/deleteCollect")
	public @ResponseBody void deleteCollect(
			@RequestBody Collect collect){
		Collect col = collectService.findByArtIdUserId(collect.getArt_id(), collect.getCollect_user_id());
		collectService.delete(col.getCollect_id());
	}
	
	
	@SuppressWarnings("null")
	@GetMapping("/collect/findAllCollect")
	public @ResponseBody List<Article> articleCenter(
			@RequestParam Integer collect_user_id) {
		List<Collect> collect = collectService.findByUserId(collect_user_id);
		List<Article> article = new ArrayList<>();
		for(int i =0; i < collect.size(); i++) {
			Article art = articleService.findById(collect.get(i).getArt_id());
			art.setCollect_id(collect.get(i).getCollect_id());
			article.add(art);
		}
		for(int i = 0; i < article.size(); i++) {	
			articleService.detach(article.get(i));
			article.get(i).setArt_create_time(article.get(i).getArt_create_time().substring(0, 19));
			if(article.get(i).getArt_title().length() > 25) {
				article.get(i).setArt_title(article.get(i).getArt_title().substring(0, 25) + "...");	
			}
			String strHTML = article.get(i).getArt_content();
			String replaceHTML = strHTML.replaceAll("<[^>]+>","");
			if(replaceHTML.length() > 70) {
				article.get(i).setArt_content(replaceHTML.substring(0, 70) + "...");	
			}else {
				article.get(i).setArt_content(replaceHTML);
			}
		}
		return article;
	}
	
	//會員中心文章收藏的取消收藏
	@GetMapping("/collect/delete")
	public @ResponseBody Map<String,String> delete(
			@RequestParam Integer collect_id) {
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			collectService.delete(collect_id);
			result="刪除成功";
			map.put("success", result);
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail", result);
		}
		return map;
	}
	
}
