package org.eeit131.group5.repository.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;

import org.eeit131.group5.model.FavoriteInstructors;
import org.eeit131.group5.model.InstructorType;
import org.eeit131.group5.model.Instructors;
import org.eeit131.group5.repository.FavoriteInstructorsRepository;
import org.eeit131.group5.service.InstructorService;
import org.eeit131.group5.service.InstructorTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FavoriteInstructorsRepositoryImpl implements FavoriteInstructorsRepository{
	
	@Autowired
	EntityManager entityManager;
	@Autowired
	InstructorService instructorService;
	
	@Override
	public List<FavoriteInstructors> findAll() {
		String hql= "FROM FavoriteInstructors ";
		List<FavoriteInstructors> favorites= entityManager.createQuery(hql, FavoriteInstructors.class).getResultList();
		List<FavoriteInstructors> efavorites= new ArrayList<>();											
		for( FavoriteInstructors favorite :favorites) {
			Instructors ins=instructorService.findById(favorite.getInstructorId());
			favorite.setInstructorName(ins.getInstructorName());
			favorite.setType(ins.getType());
			favorite.setSpeciality1(ins.getSpeciality1());
			favorite.setSpeciality2(ins.getSpeciality2());
			efavorites.add(favorite);
		}
		return efavorites;
	}

	@Override
	public List<FavoriteInstructors> findByMemberId(Integer memberId) {
		String hql= "FROM FavoriteInstructors where memberId=:memberId";
		List<FavoriteInstructors> favoriteIns=entityManager.createQuery(hql,FavoriteInstructors.class)
														.setParameter("memberId", memberId)
														.getResultList();
		
		
		List<FavoriteInstructors> efavorites= new ArrayList<>();											
		for( FavoriteInstructors favorite :favoriteIns) {
			Instructors ins=instructorService.findById(favorite.getInstructorId());
			favorite.setInstructorName(ins.getInstructorName());
			favorite.setType(ins.getType());
			favorite.setSpeciality1(ins.getSpeciality1());
			favorite.setSpeciality2(ins.getSpeciality2());
			efavorites.add(favorite);
		}
		return efavorites;
	}

	@Override
	public void save(FavoriteInstructors favoriteIns) {
		entityManager.persist(favoriteIns);
		
	}

	@Override
	public FavoriteInstructors findById(Integer favNo) {
		FavoriteInstructors favorite= entityManager.find(FavoriteInstructors.class, favNo);
		Instructors ins=instructorService.findById(favorite.getInstructorId());
		favorite.setInstructorName(ins.getInstructorName());
		favorite.setType(ins.getType());
		favorite.setSpeciality1(ins.getSpeciality1());
		favorite.setSpeciality2(ins.getSpeciality2());
		return favorite;
	}

	@Override
	public void update(FavoriteInstructors favoriteIns) {
		entityManager.merge(favoriteIns);
		
	}

	@Override
	public void remove(Integer favNo) {
		FavoriteInstructors favoriteIns=entityManager.find(FavoriteInstructors.class, favNo);
		entityManager.remove(favoriteIns);
		
	}

	@Override
	public int findByInsId(Integer instructorId) {
		String hql= "FROM FavoriteInstructors where instructorId=:instructorId";
		List<FavoriteInstructors> favoriteIns=entityManager.createQuery(hql,FavoriteInstructors.class)
															.setParameter("instructorId", instructorId)
															.getResultList();
		int count=0;
		if(favoriteIns.size()!=0) {
			for(FavoriteInstructors favor :favoriteIns) {
				count+=1;
			}
			return count;
		}else {
			return count;
		}
		
		
	}

}
