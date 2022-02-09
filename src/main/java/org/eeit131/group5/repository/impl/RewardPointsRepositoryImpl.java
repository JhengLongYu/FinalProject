package org.eeit131.group5.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

import org.eeit131.group5.model.Instructors;
import org.eeit131.group5.model.RewardPoints;
import org.eeit131.group5.repository.RewardPointsRepository;
import org.hibernate.NonUniqueResultException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class RewardPointsRepositoryImpl implements RewardPointsRepository {
	@Autowired
	EntityManager entityManager;
	
	@Override
	public List<RewardPoints> findAll() {
		String hql= "FROM RewardPoints";
		List<RewardPoints> all=null;
		try {
			all=entityManager.createQuery(hql, RewardPoints.class)
											.getResultList();
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return all;
	}

	@Override
	public void save(RewardPoints rewardPoints) {
		entityManager.persist(rewardPoints);

	}

	@Override
	public RewardPoints rpFindById(Integer memberId) {
		RewardPoints rewardPoints=entityManager.find(RewardPoints.class, memberId);
		return rewardPoints;
	}

	@Override
	public void update(RewardPoints rewardPoints) {
		entityManager.merge(rewardPoints);
		System.out.println("update rewardPoints:"+rewardPoints.getPoints());
	}

}
