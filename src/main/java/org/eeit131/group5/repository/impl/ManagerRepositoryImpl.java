package org.eeit131.group5.repository.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.eeit131.group5.model.Manager;
import org.eeit131.group5.repository.ManagerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class ManagerRepositoryImpl implements ManagerRepository {
	@Autowired
	EntityManager entityManager;
	
	@Override
	public Manager findByName(String name) {
		String hql = "FROM Manager m WHERE m.name =:name";
		Manager manager = null;
		try {
			manager = entityManager.createQuery(hql, Manager.class).setParameter("name", name).getSingleResult();
		} catch (NoResultException e) {
		} catch (NonUniqueResultException e) {
		}
		return manager;
	}

	@Override
	public Manager findById(Integer id) {
		return entityManager.find(Manager.class, id);
		
	}

}
