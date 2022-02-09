package org.eeit131.group5.repository;

import java.util.List;

import org.eeit131.group5.model.RewardPoints;


public interface RewardPointsRepository {
	public List<RewardPoints> findAll();
	
	public void save(RewardPoints rewardPoints);
	
	public void update (RewardPoints rewardPoints);

	public RewardPoints rpFindById(Integer memberId);

}
