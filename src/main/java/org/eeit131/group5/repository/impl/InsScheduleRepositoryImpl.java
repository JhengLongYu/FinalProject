package org.eeit131.group5.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

import org.eeit131.group5.model.InsSchedule;
import org.eeit131.group5.repository.InsScheduleRepository;
import org.hibernate.NonUniqueResultException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class InsScheduleRepositoryImpl implements InsScheduleRepository {
	
	@Autowired
	EntityManager entityManager;
	
	@Override
	public List<InsSchedule> findAll() {
		String hql= "FROM InsSchedule";
		List<InsSchedule> all=entityManager.createQuery(hql, InsSchedule.class)
							.getResultList();
		return all;
	}

	@Override
	public List<InsSchedule> findByInstructorId(Integer instructorId) {
		String hql= "FROM InsSchedule where instructorId=:instructorId";
		List<InsSchedule> insSchedule=null;
		try {
			insSchedule= entityManager.createQuery(hql,InsSchedule.class)
									 .setParameter("instructorId", instructorId)
									 .getResultList();
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return insSchedule;
	}
	
	@Override
	public List<InsSchedule> findAvailableByInstructorId(Integer instructorId, String available) {
		String hql= "FROM InsSchedule where instructorId=:instructorId and available=:available";
		List<InsSchedule> insSchedule=null;
		try {
			insSchedule= entityManager.createQuery(hql,InsSchedule.class)
									 .setParameter("instructorId", instructorId)
									 .setParameter("available", available)
									 .getResultList();
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return insSchedule;
	}
	
	@Override
	public void save(InsSchedule insSchedule) {
		insSchedule.setAvailable("可預約");
		entityManager.persist(insSchedule);
	}

	@Override
	public InsSchedule findByScheduleNo(Integer scheduleNo) {
		return entityManager.find(InsSchedule.class, scheduleNo);
	}

	@Override
	public void update(InsSchedule insSchedule) {
		entityManager.merge(insSchedule);

	}

	@Override
	public void remove(Integer instructorId) {
		InsSchedule insSchedule=entityManager.find(InsSchedule.class, instructorId);
		entityManager.remove(insSchedule);
	}

}
