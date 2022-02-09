package org.eeit131.group5.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

import org.eeit131.group5.model.InstructorType;
import org.eeit131.group5.repository.InstructorTypeRepository;
import org.hibernate.NonUniqueResultException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class InstructorTypeRepositoryImpl implements InstructorTypeRepository {
	
	@Autowired
	EntityManager entityManager;
	
	@Override
	public List<InstructorType> findAll() {
		String hql= "FROM InstructorType";
		List<InstructorType> all=entityManager.createQuery(hql, InstructorType.class)
							.getResultList();
		return all;
	}

	@Override
	public InstructorType findByTypeName(String typeName) {
		String hql= "FROM InstructorType where typeName=:typeName";
		InstructorType instructorType=null;
		try {
			instructorType= entityManager.createQuery(hql,InstructorType.class)
									 .setParameter("typeName", typeName)
									 .getSingleResult();
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return instructorType;
	}

	@Override
	public void save(InstructorType instructorType) {
		entityManager.persist(instructorType);

	}

	@Override
	public InstructorType findByTypeId(Integer typeId) {
		
		return entityManager.find(InstructorType.class, typeId);
	}

	@Override
	public void update(InstructorType instructorType) {
		entityManager.merge(instructorType);

	}

	@Override
	public void remove(Integer typeId) {
		InstructorType instructorType=entityManager.find(InstructorType.class, typeId);
		entityManager.remove(instructorType);

	}

}
