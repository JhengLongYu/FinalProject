package org.eeit131.group5.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eeit131.group5.model.Article;
import org.eeit131.group5.model.Comment;
import org.eeit131.group5.model.Member;
import org.eeit131.group5.service.ArticleService;
import org.eeit131.group5.service.CommentService;
import org.eeit131.group5.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CommentController {
	
	@Autowired
	CommentService commentService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ArticleService articleService;
	
	@GetMapping("/comment/commentFindAll")
	public @ResponseBody List<Comment> CommentFindAll(
			@RequestParam Integer art_id){
		List<Comment> list = commentService.findCommentByArtId(art_id);
		for(int i = 0; i< list.size(); i++) {
			Member member = memberService.findById(list.get(i).getUser_id());
			list.get(i).setMbname(member.getMbname());
		}
		for(int i = 0; i < list.size(); i++) {	
			list.get(i).setCom_create_time(list.get(i).getCom_create_time().substring(0, 19));
		}
		return list;
	}
	
	
	@PostMapping("/comment/addComment")
	public @ResponseBody List<Comment> Usercomment(
			@RequestBody Comment comment){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String s = sdf.format(new Date());
		comment.setCom_create_time(s);
		commentService.save(comment);
		List<Comment> list = commentService.findCommentByArtId(comment.getArt_id());
		for(int i = 0; i< list.size(); i++) {
			Member member = memberService.findById(list.get(i).getUser_id());
			list.get(i).setMbname(member.getMbname());
		}
		for(int i = 0; i < list.size(); i++) {	
			list.get(i).setCom_create_time(list.get(i).getCom_create_time().substring(0, 19));
		}
		return list;
	}
	
	//文章留言-刪除
	@GetMapping("/comment/deleteComment")
	public @ResponseBody Map<String,String> deleteComment(
			@RequestParam Integer com_id){
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			commentService.delete(com_id);
			result="刪除成功";
			map.put("success", result);
		} catch (Exception e) {
			result=e.getMessage();
			map.put("fail", result);
		}
		return map;
	}
	
	//會員中心訊息通知-全部讀取
	@GetMapping("/comment/changeCommentState")
	public @ResponseBody void changeCommentState(
			@RequestParam Integer art_user_id){
		List<Article> article = articleService.findArticleByUserId(art_user_id);
		List<Comment> comment = new ArrayList<>();
		List<Comment> com = null;
		if(article.size() != 0){
			for(int i = 0; i < article.size(); i++) {	
				com = commentService.findCommentByArtId(article.get(i).getArt_id());
				for(int j = 0; j < com.size(); j ++) {
					if(com.get(j).getCom_state() == 0) {   //如果狀態為0表示該留言未被讀取 
						comment.add(com.get(j));
					}
				}
			}
			for(int i = 0; i < comment.size(); i++) {
				comment.get(i).setCom_state(1);
				commentService.update(comment.get(i));
			}
		}
	}
}
