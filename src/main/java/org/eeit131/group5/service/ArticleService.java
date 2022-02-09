package org.eeit131.group5.service;

import java.util.List;

import org.eeit131.group5.model.Article;

public interface ArticleService {

	List<Article> findAll();
	
	List<Article> findAllOrderByView();
	
	List<Article> findAllOrderByLikeNum();
	
	List<Article> findAllByKeyword(String keyword);
	
	List<Article> findAllTitleByKeyword(String keyword);
	
	List<Article> findArticleByTagId(Integer tag_id);
	
	List<Article> findArticleByUserId(Integer art_user_id);

	Article findById(Integer art_id);

	void save(Article article);

	void delete(Integer art_id);
	
	void update(Article article);
	
	void detach(Article article);
	
	void merge(Article article);
	
}