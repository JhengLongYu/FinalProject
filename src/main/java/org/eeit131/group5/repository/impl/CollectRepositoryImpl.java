package org.eeit131.group5.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

import org.eeit131.group5.model.Article;
import org.eeit131.group5.model.Collect;
import org.eeit131.group5.repository.CollectRepository;
import org.hibernate.NonUniqueResultException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CollectRepositoryImpl implements CollectRepository {
	
	@Autowired
	EntityManager entityManager;
	
	@Override
	public Collect findByArtIdUserId(Integer art_id, Integer collect_user_id) {
		String hql = "FROM Collect WHERE art_id=:art_id AND collect_user_id=:collect_user_id";
		Collect collect = null;
		try {
			collect = entityManager.createQuery(hql,Collect.class)
										   .setParameter("art_id", art_id)
										   .setParameter("collect_user_id", collect_user_id)
										   .getSingleResult();
		}catch(NoResultException e) {
			collect = null;
		}catch(NonUniqueResultException e) {
			collect = null;
		}
		return collect;
	}

	@Override
	public List<Collect> findByArtId(Integer art_id){
		String hql = "FROM Collect WHERE art_id=:art_id";
		List<Collect> list = null;
		try {
			list = entityManager.createQuery(hql, Collect.class)
						 		.setParameter("art_id", art_id)
						 		.getResultList();
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Collect> findByUserId(Integer collect_user_id) {
		String hql = "FROM Collect WHERE collect_user_id=:collect_user_id";
		List<Collect> list = null;
		try {
			list = entityManager.createQuery(hql, Collect.class)
						 		.setParameter("collect_user_id", collect_user_id)
						 		.getResultList();
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void save(Collect collect) {
		entityManager.persist(collect);
	}
	
	@Override
	public void delete(Integer collect_id) {
		Collect collect = entityManager.find(Collect.class, collect_id);
		entityManager.remove(collect);
	}

	@Override
	public void delete(Collect collect) {
		entityManager.remove(collect);
	}

	@Override
	public void merge(Collect collect) {
		entityManager.merge(collect);
	}
	
	
}
