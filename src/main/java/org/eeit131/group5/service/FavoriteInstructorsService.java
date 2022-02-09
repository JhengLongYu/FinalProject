package org.eeit131.group5.service;

import java.util.List;

import org.eeit131.group5.model.FavoriteInstructors;

public interface FavoriteInstructorsService {
	public List<FavoriteInstructors> findAll();
	
	public List<FavoriteInstructors> findByMemberId(Integer memberId);
	
	public void save(FavoriteInstructors favoriteIns);
	
	public FavoriteInstructors findById(Integer favNo);
	
	public void update (FavoriteInstructors favoriteIns);

	public void remove(Integer favNo);

	public int findByInsId(Integer instructorId);
}
