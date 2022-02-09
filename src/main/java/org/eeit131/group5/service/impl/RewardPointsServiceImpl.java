package org.eeit131.group5.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.eeit131.group5.model.RewardPoints;
import org.eeit131.group5.repository.InstructorTypeRepository;
import org.eeit131.group5.repository.RewardPointsRepository;
import org.eeit131.group5.service.RewardPointsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
@Transactional
public class RewardPointsServiceImpl implements RewardPointsService {
	@Autowired
	RewardPointsRepository rewardPointsRepository;
	@Override
	public List<RewardPoints> findAll() {
		return rewardPointsRepository.findAll();
	}

	@Override
	public void save(RewardPoints rewardPoints) {
		rewardPointsRepository.save(rewardPoints);
	}

	@Override
	public void update(RewardPoints rewardPoints) {
		rewardPointsRepository.update(rewardPoints);
	}

	@Override
	public RewardPoints rpFindById(Integer memberId) {
		return rewardPointsRepository.rpFindById(memberId);
	}

}
