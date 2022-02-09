package org.eeit131.group5.service.impl;

import java.util.List;

import org.eeit131.group5.model.FavoriteInstructors;
import org.eeit131.group5.repository.FavoriteInstructorsRepository;
import org.eeit131.group5.service.FavoriteInstructorsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class FavoriteInstructorsServiceImpl implements FavoriteInstructorsService {
	
	@Autowired
	FavoriteInstructorsRepository  favoriteInstructorsRepository;
	
	@Override
	public List<FavoriteInstructors> findAll() {
		return favoriteInstructorsRepository.findAll();
	}

	@Override
	public List<FavoriteInstructors> findByMemberId(Integer memberId) {
		return favoriteInstructorsRepository.findByMemberId(memberId);
	}

	@Override
	public void save(FavoriteInstructors favoriteIns) {
		favoriteInstructorsRepository.save(favoriteIns);
	}

	@Override
	public FavoriteInstructors findById(Integer favNo) {
		return favoriteInstructorsRepository.findById(favNo);
	}

	@Override
	public void update(FavoriteInstructors favoriteIns) {
		favoriteInstructorsRepository.update(favoriteIns);
	}

	@Override
	public void remove(Integer favNo) {
		favoriteInstructorsRepository.remove(favNo);
	}

	@Override
	public int findByInsId(Integer instructorId) {
		return favoriteInstructorsRepository.findByInsId(instructorId);
	}

}
