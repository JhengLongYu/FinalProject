package org.eeit131.group5.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eeit131.group5.model.Article;
import org.eeit131.group5.model.Tag;
import org.eeit131.group5.service.ArticleService;
import org.eeit131.group5.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TagController {
	
	@Autowired
	TagService tagService;
	
	@Autowired
	ArticleService articleService;
	
	@GetMapping("/tag/tagmanagement")
	public String articleManagement() {
		return "/article/tagmanagement";
	}
	
	@GetMapping("/tag/findAll")
	public @ResponseBody List<Tag> findAll(){
		List<Tag> tag = tagService.findAll();
		if(tag.size() != 0) {
			for(int i = 0; i < tag.size(); i++) {
				List<Article> article = articleService.findArticleByTagId(tag.get(i).getTag_id());
				tag.get(i).setArt_num(article.size());
				tag.get(i).setTag_create_time(tag.get(i).getTag_create_time().substring(0, 19));
			}
		}
		return tag;
	}
	
	@GetMapping("/tag/delete")
	public @ResponseBody Map<String,String> delete(
			@RequestParam Integer tag_id) {
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			tagService.delete(tag_id);
			result="刪除成功";
			map.put("success", result);
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail", result);
		}
		return map;
	}
	
	@PostMapping("/tag/update")
	public @ResponseBody Map<String,String> updateTag(
			@RequestBody Tag tag){
		Map<String, String> map = new HashMap<>();
		try {
			tagService.update(tag.getTag_id(), tag.getTag_name());
			map.put("success", "更新成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("fail", "更新失敗");
		}
		return map;	
	}
	
	@GetMapping("/tag/add")
	public @ResponseBody Map<String,String> add(
			@RequestParam String tag_name) {
		Tag tag = new Tag();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String s = sdf.format(new Date());
        tag.setTag_name(tag_name);
		tag.setTag_create_time(s);
		System.out.println(s);
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			tagService.save(tag);
			result="新增成功";
			map.put("success", result);
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail", result);
		}
		return map;
	}
}
