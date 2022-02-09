package org.eeit131.group5.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

import org.eeit131.group5.model.Article;
import org.eeit131.group5.repository.ArticleRepository;
import org.hibernate.NonUniqueResultException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ArticleRepositoryImpl implements ArticleRepository {
	
	@Autowired
	EntityManager entityManager;
	
	@Override
	public List<Article> findAll(){
		String hql = "FROM Article ORDER BY art_create_time DESC";
		List<Article> list = entityManager.createQuery(hql, Article.class).getResultList();
		return list;
	}
	
	@Override
	public List<Article> findAllOrderByView() {
		String hql = "FROM Article ORDER BY art_view DESC";
		List<Article> list = entityManager.createQuery(hql, Article.class).getResultList();
		return list; 
	}
	
	@Override
	public List<Article> findAllOrderByLikeNum() {
		String hql = "FROM Article ORDER BY art_like_num DESC";
		List<Article> list = entityManager.createQuery(hql, Article.class).getResultList();
		return list; 
	}
	
	@Override
	public List<Article> findArticleByTagId(Integer tag_id) {
		String hql = "FROM Article WHERE tag_id=:tag_id ORDER BY art_create_time DESC";
		List<Article> list =null;
		try {
			list = entityManager.createQuery(hql,Article.class)
									 .setParameter("tag_id", tag_id)
									 .getResultList();
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Article> findArticleByUserId(Integer art_user_id) {
		String hql = "FROM Article WHERE art_user_id=:art_user_id";
		List<Article> list =null;
		try {
			list = entityManager.createQuery(hql,Article.class)
									 .setParameter("art_user_id", art_user_id)
									 .getResultList();
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Article> findAllByKeyword(String keyword) {
//		String hql = "FROM Article art WHERE art.art_title like'%" + keyword + "%'";
		String hql= "FROM Article WHERE CONCAT(art_title, ' ',art_content) LIKE '%"+keyword+"%' ORDER BY art_create_time DESC";
		List<Article> list =null;
		try {
			list = entityManager.createQuery(hql, Article.class)
								.getResultList();
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Article> findAllTitleByKeyword(String keyword) {
		String hql = "FROM Article art WHERE art.art_title like'%" + keyword + "%'";
		List<Article> list =null;
		try {
			list = entityManager.createQuery(hql, Article.class)
								.getResultList();
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Article findById(Integer art_id) {
		return entityManager.find(Article.class, art_id);
	}
	
	@Override
	public void save(Article article) {
		entityManager.persist(article);
	}
	
	@Override
	public void delete(Integer art_id) {
		Article article = entityManager.find(Article.class, art_id);
		entityManager.remove(article);
	}
	
	@Override
	public void update(Article article) {
		Article article0 = findById(article.getArt_id());
		if(article.getCoverImage()==null && article.getMimeType()==null){
			article.setCoverImage(article0.getCoverImage());
			article.setMimeType(article0.getMimeType());
		}
		entityManager.detach(article0);
		entityManager.merge(article);
	}

	@Override
	public void detach(Article article) {
		entityManager.detach(article);
	}

	@Override
	public void merge(Article article) {
		entityManager.merge(article);
	}
	
	
}
