package org.eeit131.group5.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.eeit131.group5.model.Article;
import org.eeit131.group5.model.Collect;
import org.eeit131.group5.model.Comment;
import org.eeit131.group5.model.Member;
import org.eeit131.group5.model.Tag;
import org.eeit131.group5.service.ArticleService;
import org.eeit131.group5.service.CollectService;
import org.eeit131.group5.service.CommentService;
import org.eeit131.group5.service.MemberService;
import org.eeit131.group5.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class ArticleController {
	
	@Autowired
	ArticleService articleService;
	
	@Autowired
	TagService tagService;
	
	@Autowired
	CommentService commentService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	CollectService collectService;
	
	@Autowired
	ServletContext ctx;
	
	@GetMapping("/article/articleNew")
	public String articleNew() {
		return "/article/articleNew";
	}
	
	@GetMapping("/article/articleManagement")
	public String articleManagement() {
		return "/article/articleManagement";
	}
	
	@GetMapping("/article/allManagement")
	public String articleAllManagement() {
		return "/article/allManagement";
	}
	
	@GetMapping("/article/publishArticle")
	public String articlePublish() {
		return "/article/articleForm";
	}
	
	@GetMapping("/articleCenter_editInfo")
	public String articleCenter() {
		return "/article/articleCenter_editInfo";
	}
	
	@GetMapping("/articleCenter_editPublish")
	public String articleEditPublish() {
		return "/article/articleCenter_editPublish";
	}
	
	@GetMapping("/articleCenter_editMessage")
	public String articleCenterMessage() {
		return "/article/articleCenter_editMessage";
	}
	
	//文章內容
	@GetMapping("/article/articleContent")
	public String articleContent(@RequestParam Integer art_id, Model m) {
		Article article = articleService.findById(art_id);
		article.setArt_view(article.getArt_view() + 1);
		articleService.update(article);
		article.setArt_create_time(article.getArt_create_time().substring(0, 19));
		m.addAttribute("article", article);
		Member member = memberService.findById(article.getArt_user_id());
		m.addAttribute("member", member);
		return "/article/articleContent";
	}
	
	//文章內容的按讚功能
	@GetMapping("/article/articleContent/likeStatusAdd")
	public @ResponseBody Integer articleContentLikeStatusAdd(@RequestParam Integer art_id) {
		Article article = articleService.findById(art_id);
		article.setArt_like_num(article.getArt_like_num() + 1);
		articleService.update(article);
		return article.getArt_like_num();
	}
	
	//文章內容的取消按讚功能
	@GetMapping("/article/articleContent/likeStatusReduce")
	public @ResponseBody Integer articleContentLikeStatusReduce(@RequestParam Integer art_id) {
		Article article = articleService.findById(art_id);
		article.setArt_like_num(article.getArt_like_num() - 1);
		articleService.update(article);
		return article.getArt_like_num();
	}
	
	//文章內容的作者區
	@GetMapping("/article/articleContent/author")
	public @ResponseBody Map<String, String> articleContentAuthor(@RequestParam Integer art_user_id) {
		Map<String, String> map = new HashMap<>();
		List<Article> article = articleService.findArticleByUserId(art_user_id);
		String postNum = Integer.toString(article.size());
		map.put("postNum", postNum);
		Integer view = 0;
		for(int i = 0; i < article.size(); i++) {
			view += article.get(i).getArt_view();
		}
		String viewNum = Integer.toString(view);
		map.put("viewNum", viewNum);
		Integer good = 0;
		for(int i = 0; i < article.size(); i++) {
			good += article.get(i).getArt_like_num();
		}
		String goodNum = Integer.toString(good);
		map.put("goodNum", goodNum);
		Member member = memberService.findById(art_user_id);
		String mbname = member.getMbname();
		map.put("mbname", mbname);
		return map;
	}
	
	//前臺論壇右邊
	@GetMapping("articleForum")

	public String articleForum(Model m) {
		List<Article> artOrderByViewR = articleService.findAllOrderByView();
		List<Article> artOrderByView = new ArrayList<Article>();
		if(artOrderByViewR.size() != 0) {
			if(artOrderByViewR.size() < 5) {
				for(int i = 0; i < artOrderByViewR.size(); i++) {
					articleService.detach(artOrderByViewR.get(i));
					if(artOrderByViewR.get(i).getArt_title().length() > 15) {
						artOrderByViewR.get(i).setArt_title(artOrderByViewR.get(i).getArt_title().substring(0, 15) + "...");	
					}
					artOrderByView.add(artOrderByViewR.get(i));
				}	
			}else {
				for(int i = 0; i < 5; i++) {
					articleService.detach(artOrderByViewR.get(i));
					if(artOrderByViewR.get(i).getArt_title().length() > 15) {
						artOrderByViewR.get(i).setArt_title(artOrderByViewR.get(i).getArt_title().substring(0, 15) + "...");	
					}
					artOrderByView.add(artOrderByViewR.get(i));
				}	
			}
			
		}
		List<Article> artOrderByLikeR = articleService.findAllOrderByLikeNum();
		List<Article> artOrderByLike = new ArrayList<Article>();
		if(artOrderByLikeR.size() != 0) {
			if(artOrderByLikeR.size() < 5) {
				for(int i = 0; i < artOrderByLikeR.size(); i++) {
					articleService.detach(artOrderByLikeR.get(i));
					if(artOrderByLikeR.get(i).getArt_title().length() > 15) {
						artOrderByLikeR.get(i).setArt_title(artOrderByLikeR.get(i).getArt_title().substring(0, 15) + "...");	
					}
					artOrderByLike.add(artOrderByLikeR.get(i));
				}
			}else {
				for(int i = 0; i < 5; i++) {
					articleService.detach(artOrderByLikeR.get(i));
					if(artOrderByLikeR.get(i).getArt_title().length() > 15) {
						artOrderByLikeR.get(i).setArt_title(artOrderByLikeR.get(i).getArt_title().substring(0, 15) + "...");	
					}
					artOrderByLike.add(artOrderByLikeR.get(i));
				}
			}
		}
		m.addAttribute("artOrderByView", artOrderByView);
		m.addAttribute("artOrderByLike", artOrderByLike);
		return "/article/articleForum";
	}

	
	
	//前臺論壇
	@GetMapping("articleForum/findAll")
	public  @ResponseBody List<Article> articleForumFindAll() {
		List<Article> article = articleService.findAll();
		if(article.size() != 0) {

            List<Tag> tag = tagService.findAll();
            List<Comment> comment;
            Member member;
            Map<Integer, String> map = new HashMap<>();
            for(int i = 0; i < tag.size(); i++) {
                map.put(tag.get(i).getTag_id(), tag.get(i).getTag_name());
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
                article.get(i).setTag_name(map.get(article.get(i).getTag_id()));
                comment = commentService.findCommentByArtId(article.get(i).getArt_id());
                article.get(i).setArt_com_num(comment.size());
                if(comment.size() != 0) {
                    article.get(i).setCom_create_time(comment.get(0).getCom_create_time().substring(0, 19));
                }else {
                    article.get(i).setCom_create_time("目前無回覆");
                };
                member = memberService.findById(article.get(i).getArt_user_id());
                article.get(i).setMember(member);
                List<Collect> collect =  collectService.findByArtId(article.get(i).getArt_id());
                article.get(i).setArt_collect_num(collect.size());
            }
        }
        return article;
	}
	
	//會員中心已發表文章
		@GetMapping("/article/findArticleByArtUserId")
		public @ResponseBody List<Article> findArticleByArtUserId(
				@RequestParam Integer art_user_id){
			List<Article> article = articleService.findArticleByUserId(art_user_id);

			List<Tag> tag = tagService.findAll();
			List<Comment> comment;
			Member member;
			Map<Integer, String> map = new HashMap<>();
			for(int i = 0; i < tag.size(); i++) {
				map.put(tag.get(i).getTag_id(), tag.get(i).getTag_name());
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
				article.get(i).setTag_name(map.get(article.get(i).getTag_id()));
				comment = commentService.findCommentByArtId(article.get(i).getArt_id());
				article.get(i).setArt_com_num(comment.size());
				if(comment.size() != 0) {
					article.get(i).setCom_create_time(comment.get(0).getCom_create_time().substring(0, 19));
				}else {
					article.get(i).setCom_create_time("目前無回覆");
				};
				member = memberService.findById(article.get(i).getArt_user_id());
				article.get(i).setMember(member);
				List<Collect> collect =  collectService.findByArtId(article.get(i).getArt_id());
				article.get(i).setArt_collect_num(collect.size());
		}
		return article;
	}
	
	
	
	//會員中心已發表文章-文章編輯
	@GetMapping("/article/articleContentEdit")
	public String articleContentEdit(@RequestParam Integer art_id, Model m) {
		Article article = articleService.findById(art_id);
		m.addAttribute("article", article);
		return "/article/articleContentEdit";
	}
	
	//會員中心已發表文章-文章刪除
	@GetMapping("/article/articleContentDelete")
	public @ResponseBody Map<String,String> articleContentDelete(@RequestParam Integer art_id) {
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			articleService.delete(art_id);
			result="刪除成功";
			map.put("success", result);
			List<Collect> collects = null;
			collects = collectService.findByArtId(art_id);
			if(collects.size() != 0) {
				for(int i = 0; i < collects.size(); i++) {
					collectService.delete(collects.get(i).getCollect_id());    
				}
			}
			List<Comment> comments = null;
			comments = commentService.findCommentByArtId(art_id);
			if(comments.size() != 0) {
				for(int i = 0; i < comments.size(); i++) {
					commentService.delete(comments.get(i).getCom_id());    
				}
			}
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail", result);
		}
		return map;
	}
	
	//會員中心已發表文章-文章編輯-搜尋文章資料
	@GetMapping("/article/articleContentFindByArtId")
	public @ResponseBody Article articleContentFindByArtId(
			@RequestParam Integer art_id) {
		Article article = articleService.findById(art_id);
		return article;
	}

	//會員中心已發表文章-文章編輯-修改文章資料
	@PostMapping(value = "/article/articleContentUpdate", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody void articleContentUpdate(
			@RequestBody Article article){
		if(article.getFileDataUrl()!=null) {
			Integer startIndex = "data:".length();
			Integer endIndex = article.getFileDataUrl().indexOf(";");
			String mimeType = article.getFileDataUrl().substring(startIndex, endIndex);
			String base64 = article.getFileDataUrl().substring(article.getFileDataUrl().indexOf(",") + 1);
			byte[] a = Base64.getDecoder().decode(base64);
			try {
				article.setCoverImage(new SerialBlob(a));
			}catch (SerialException e) {
				e.printStackTrace();
			}catch (SQLException e) {
				e.printStackTrace();
			}
			article.setMimeType(mimeType);
		}else {
			article.setCoverImage(null);
			article.setMimeType(null);
		}
		Article article0 = articleService.findById(article.getArt_id());
		article.setArt_create_time(article0.getArt_create_time());
		article.setArt_like_num(article0.getArt_like_num());
		article.setArt_view(article0.getArt_view());    
		articleService.update(article);		
	}	
	
	//會員中心訊息通知-查詢訊息
	@SuppressWarnings("null")
	@GetMapping("/article/findCommentByArId")
	public @ResponseBody List<Comment> findCommentByArId(
			@RequestParam Integer art_user_id) {
		List<Article> article = articleService.findArticleByUserId(art_user_id);
		List<Comment> comment = new ArrayList<>();
		List<Comment> com = null;
		if(article.size() != 0){
			for(int i = 0; i < article.size(); i++) {	
				com = commentService.findCommentByArtId(article.get(i).getArt_id());
				for(int j = 0; j < com.size(); j ++) {
					Member member = memberService.findById(com.get(j).getUser_id());
					com.get(j).setMbname(member.getMbname());
					if(article.get(i).getArt_title().length() > 20) {
						com.get(j).setArt_title(article.get(i).getArt_title().substring(0, 20) + "...");
					}else {
						com.get(j).setArt_title(article.get(i).getArt_title());
					}
					com.get(j).setCom_create_time(com.get(j).getCom_create_time().substring(0, 19));
					if(com.get(j).getCom_state() == 0) {   //如果狀態為0表示該留言未被讀取 
						comment.add(com.get(j));
					}
				}
			}
		}
		return comment;
	}
		
	//新增文章
	@PostMapping(value = "/article/save", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody void saveData(
			@RequestBody Article article){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String s = sdf.format(new Date());
		article.setArt_create_time(s);
		article.setArt_like_num(0);
		article.setArt_view(0);
		if(article.getFileDataUrl()!=null) {
			int startIndex = "data:".length();
			int endIndex = article.getFileDataUrl().indexOf(";");
			String mimeType = article.getFileDataUrl().substring(startIndex, endIndex);
			String base64 = article.getFileDataUrl().substring(article.getFileDataUrl().indexOf(",") + 1);
			byte[] a = Base64.getDecoder().decode(base64);
			try {
				article.setCoverImage(new SerialBlob(a));
			}catch (SerialException e) {
				e.printStackTrace();
			}catch (SQLException e) {
				e.printStackTrace();
			}
			article.setMimeType(mimeType);
		}else {
			article.setCoverImage(null);
			article.setMimeType(null);
		}
		articleService.save(article);		
	}
	
	
	//後臺管理
	@GetMapping("/article/findAll")
	public @ResponseBody List<Article> findAll(){
		List<Article> article = articleService.findAll();
		List<Tag> tag = tagService.findAll();
		List<Comment> comment;
		Member member;
		Map<Integer, String> map = new HashMap<>();
		for(int i = 0; i < tag.size(); i++) {
			map.put(tag.get(i).getTag_id(), tag.get(i).getTag_name());
		}
		for(int i = 0; i < article.size(); i++) {	
			article.get(i).setArt_create_time(article.get(i).getArt_create_time().substring(0, 19));
			if(article.get(i).getArt_title().length() > 9) {
				article.get(i).setArt_title(article.get(i).getArt_title().substring(0, 9) + "...");
			}
			String strHTML = article.get(i).getArt_content();
			String replaceHTML = strHTML.replaceAll("<[^>]+>","");
			if(replaceHTML.length() > 20) {
				article.get(i).setArt_content(replaceHTML.substring(0, 20) + "...");	
			}else {
				article.get(i).setArt_content(replaceHTML);
			}
			article.get(i).setTag_name(map.get(article.get(i).getTag_id()));
			comment = commentService.findCommentByArtId(article.get(i).getArt_id());
			article.get(i).setArt_com_num(comment.size());
			member = memberService.findById(article.get(i).getArt_user_id());
			article.get(i).setMember(member);
			List<Collect> collect =  collectService.findByArtId(article.get(i).getArt_id());
			article.get(i).setArt_collect_num(collect.size());
		}
		return article;
	}
	
	//後臺管理標籤搜尋
	@GetMapping("/article/findArticleByTag")
	public @ResponseBody List<Article> findArticleByTagId(
			@RequestParam Integer tag_id){
		List<Article> article = articleService.findArticleByTagId(tag_id);
		List<Tag> tag = tagService.findAll();
		List<Comment> comment;
		Member member;
		Map<Integer, String> map = new HashMap<>();
		for(int i = 0; i < tag.size(); i++) {
			map.put(tag.get(i).getTag_id(), tag.get(i).getTag_name());
		}
		for(int i = 0; i < article.size(); i++) {	
			article.get(i).setArt_create_time(article.get(i).getArt_create_time().substring(0, 19));
			if(article.get(i).getArt_title().length() > 9){
				article.get(i).setArt_title(article.get(i).getArt_title().substring(0, 9) + "...");
			}
			article.get(i).setTag_name(map.get(article.get(i).getTag_id()));
			comment = commentService.findCommentByArtId(article.get(i).getArt_id());
			article.get(i).setArt_com_num(comment.size());
			if(comment.size() != 0) {
				article.get(i).setCom_create_time(comment.get(0).getCom_create_time().substring(0, 19));
			}else {
				article.get(i).setCom_create_time("目前無回覆");
			};
			member = memberService.findById(article.get(i).getArt_user_id());
			article.get(i).setMember(member);
			List<Collect> collect =  collectService.findByArtId(article.get(i).getArt_id());
			article.get(i).setArt_collect_num(collect.size());
		}
		return article;
	}
	
	//前臺論壇標籤搜尋
	@GetMapping("/article/findArticleByTag/forum")
	public @ResponseBody List<Article> findArticleByTagIdForum(
			@RequestParam Integer tag_id){
		List<Article> article = articleService.findArticleByTagId(tag_id);
		List<Tag> tag = tagService.findAll();
		List<Comment> comment;
		Member member;
		Map<Integer, String> map = new HashMap<>();
		for(int i = 0; i < tag.size(); i++) {
			map.put(tag.get(i).getTag_id(), tag.get(i).getTag_name());
		}
		for(int i = 0; i < article.size(); i++) {	
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
			article.get(i).setTag_name(map.get(article.get(i).getTag_id()));
			comment = commentService.findCommentByArtId(article.get(i).getArt_id());
			article.get(i).setArt_com_num(comment.size());
			if(comment.size() != 0) {
				article.get(i).setCom_create_time(comment.get(0).getCom_create_time().substring(0, 19));
			}else {
				article.get(i).setCom_create_time("目前無回覆");
			};
			member = memberService.findById(article.get(i).getArt_user_id());
			article.get(i).setMember(member);
			List<Collect> collect =  collectService.findByArtId(article.get(i).getArt_id());
			article.get(i).setArt_collect_num(collect.size());
		}
		return article;
	}
	
	// 前臺論壇關鍵字搜尋
	@GetMapping("/articleForum/searchKeyword")
	public @ResponseBody List<Article> searchKeyword(
			@RequestParam String keyword){
		List<Article> article = articleService.findAllByKeyword(keyword);
		List<Tag> tag = tagService.findAll();	
		List<Comment> comment;
		Member member;
		Map<Integer, String> map = new HashMap<>();
		for(int i = 0; i < tag.size(); i++) {
			map.put(tag.get(i).getTag_id(), tag.get(i).getTag_name());
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
			article.get(i).setTag_name(map.get(article.get(i).getTag_id()));
			comment = commentService.findCommentByArtId(article.get(i).getArt_id());
			article.get(i).setArt_com_num(comment.size());
			if(comment.size() != 0) {
				article.get(i).setCom_create_time(comment.get(0).getCom_create_time().substring(0, 19));
			}else {
				article.get(i).setCom_create_time("目前無回覆");
			};
			member = memberService.findById(article.get(i).getArt_user_id());
			article.get(i).setMember(member);
			List<Collect> collect =  collectService.findByArtId(article.get(i).getArt_id());
			article.get(i).setArt_collect_num(collect.size());
		}
		return article;
	}
	
	 //後臺文章管理關鍵字搜尋
	@GetMapping("/articleManagement/searchKeyword")
	public @ResponseBody List<Article> searchArticleManagementKeyword(
			@RequestParam String keyword){
		List<Article> article = articleService.findAllTitleByKeyword(keyword);
		List<Tag> tag = tagService.findAll();
		List<Comment> comment;
		Member member;
		Map<Integer, String> map = new HashMap<>();
		for(int i = 0; i < tag.size(); i++) {
			map.put(tag.get(i).getTag_id(), tag.get(i).getTag_name());
		}
		for(int i = 0; i < article.size(); i++) {	
			article.get(i).setArt_create_time(article.get(i).getArt_create_time().substring(0, 19));
			if(article.get(i).getArt_title().length() > 9) {
				article.get(i).setArt_title(article.get(i).getArt_title().substring(0, 9) + "...");
			}
			String strHTML = article.get(i).getArt_content();
			String replaceHTML = strHTML.replaceAll("<[^>]+>","");
			if(replaceHTML.length() > 20) {
				article.get(i).setArt_content(replaceHTML.substring(0, 20) + "...");	
			}else {
				article.get(i).setArt_content(replaceHTML);
			}
			article.get(i).setTag_name(map.get(article.get(i).getTag_id()));
			comment = commentService.findCommentByArtId(article.get(i).getArt_id());
			article.get(i).setArt_com_num(comment.size());
			member = memberService.findById(article.get(i).getArt_user_id());
			article.get(i).setMember(member);
			List<Collect> collect =  collectService.findByArtId(article.get(i).getArt_id());
			article.get(i).setArt_collect_num(collect.size());
		}
		return article;
	}
	
			
	//取得照片
	@GetMapping("/article/getCoverImage")
	public ResponseEntity<byte[]> getCoverImage(
			@RequestParam("art_id") Integer art_id){
		ResponseEntity<byte[]> re = null;
		Article article = articleService.findById(art_id);
		HttpHeaders headers = new HttpHeaders();
		
		if(article.getCoverImage()!=null) {
			Blob blob = article.getCoverImage();
			MediaType mediaType = MediaType.valueOf(article.getMimeType());
			
			try {
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				InputStream is = blob.getBinaryStream();
				byte[] b = new byte[81920];
				int len = 0;
				while ((len = is.read(b)) != -1) {
					baos.write(b, 0, len);
				}
				headers.setContentType(mediaType);
				headers.setCacheControl(CacheControl.noCache().getHeaderValue()); //叫瀏覽器不要cache這張圖片
				re = new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.OK);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else {
			String filename="noImage.jpg";
			MediaType mimeType = MediaType.valueOf(ctx.getMimeType(filename));
			Resource resource = new ClassPathResource("static/images/" + filename);
			try (
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					InputStream in = resource.getInputStream();
				){
				byte[] b = new byte[819200];
				int len = 0;
				while ((len= in.read(b)) != -1) {
					baos.write(b, 0, len);
				}
				headers.setContentType(mimeType);
				headers.setCacheControl(CacheControl.noCache().getHeaderValue()); //叫瀏覽器不要cache這張圖片
				re = new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.OK);
			} catch(Exception ex) {
				ex.printStackTrace();
			}System.out.println(article.getArt_id()+"  doesn't have images");
		}
		return re;
	}
	
	@GetMapping("/article/delete")
	public @ResponseBody Map<String,String> delete(
			@RequestParam Integer art_id) {
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			articleService.delete(art_id);
			result="刪除成功";
			map.put("success", result);
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail", result);
		}
		return map;
	}
	

}
