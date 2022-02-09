package org.eeit131.group5.service.impl;

import java.util.List;

import org.eeit131.group5.model.Article;
import org.eeit131.group5.repository.ArticleRepository;
import org.eeit131.group5.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ArticleServiceImpl implements ArticleService {
	
	@Autowired
	ArticleRepository artilceRespository;
	
	@Override
	public List<Article> findAll(){
		return artilceRespository.findAll();
	}
	
	@Override
	public List<Article> findAllOrderByView() {
		return artilceRespository.findAllOrderByView();
	}
	
	@Override
	public List<Article> findAllOrderByLikeNum() {
		return artilceRespository.findAllOrderByLikeNum();
	}
	
	@Override
	public List<Article> findAllByKeyword(String keyword) {
		return artilceRespository.findAllByKeyword(keyword);
	}
	
	@Override
	public List<Article> findAllTitleByKeyword(String keyword) {
		return artilceRespository.findAllTitleByKeyword(keyword);
	}

	@Override
	public List<Article> findArticleByTagId(Integer tag_id) {
		return artilceRespository.findArticleByTagId(tag_id);
	}
	
	@Override
	public List<Article> findArticleByUserId(Integer art_user_id) {
		return artilceRespository.findArticleByUserId(art_user_id);
	}

	@Override
	public Article findById(Integer art_id) {
		return artilceRespository.findById(art_id);
	}
	
	@Override
	public void save(Article article) {
		artilceRespository.save(article);
	}
	
	@Override
	public void delete(Integer art_id) {
		artilceRespository.delete(art_id);
	}
	
	@Override
	public void update(Article article) {
		artilceRespository.update(article);
	}

	@Override
	public void detach(Article article) {
		artilceRespository.detach(article);
	}

	@Override
	public void merge(Article article) {
		artilceRespository.merge(article);
	}
	

}
