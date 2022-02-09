package org.eeit131.group5.repository.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

import org.eeit131.group5.model.Instructors;
import org.eeit131.group5.repository.InstructorRepository;
import org.eeit131.group5.service.InstructorTypeService;
import org.hibernate.NonUniqueResultException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class InstructorRepositoryImpl implements InstructorRepository {
	
	@Autowired
	EntityManager entityManager;
	@Autowired
	InstructorTypeService instructorTypeService;
	
	@Override
	public List<Instructors> findAll() {
		String hql= "FROM Instructors";
		List<Instructors> all=entityManager.createQuery(hql, Instructors.class)
							.getResultList();
		List<Instructors> allInstructors= new ArrayList<>();
		for(Instructors instructor:all) {
			String type=instructorTypeService.findByTypeId(instructor.getTypeId())
											.getTypeName();
			instructor.setType(type);
			allInstructors.add(instructor);
		}
		return allInstructors;
	}

	@Override
	public Instructors findByInstructorname(String instructorName) {
		String hql= "FROM Instructors where instructorName=:instructorName";
		Instructors instructor=null;
		try {
			instructor= entityManager.createQuery(hql,Instructors.class)
									 .setParameter("instructorName", instructorName)
									 .getSingleResult();
			String type=instructorTypeService.findByTypeId(instructor.getTypeId())
											.getTypeName();
			instructor.setType(type);
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return instructor;
	}
	
	@Override //確認是否為講師
	public Instructors findByMemberId(Integer memberId) {
		String hql= "FROM Instructors where memberId=:memberId";
		Instructors instructor=null;
		try {
			instructor= entityManager.createQuery(hql,Instructors.class)
									 .setParameter("memberId", memberId)
									 .getSingleResult();
			if(instructor!=null) {
				String type=instructorTypeService.findByTypeId(instructor.getTypeId())
												 .getTypeName();
				instructor.setType(type);
			}
			
		}catch(NoResultException e) {
			instructor=null;
//			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return instructor;
	}
	
	@Override
	public void save(Instructors instructor) {
		instructor.setInsStatus("待審核");
		entityManager.persist(instructor);
	}

	@Override
	public Instructors findById(Integer instructorId) {
		Instructors instructor=entityManager.find(Instructors.class, instructorId);
		String type=instructorTypeService.findByTypeId(instructor.getTypeId())
										.getTypeName();
		instructor.setType(type);
		return instructor;
	}

	@Override
	public void update(Instructors instructor) {
		Instructors instructor0=findById(instructor.getInstructorId());
		if(instructor.getCoverImage()==null &&instructor.getMimeType()==null) {
			instructor.setCoverImage(instructor0.getCoverImage());
			instructor.setMimeType(instructor0.getMimeType());
		}
		instructor.setMemberId(instructor0.getMemberId());
		entityManager.detach(instructor0);
		entityManager.merge(instructor);
	}

	@Override
	public void remove(Integer instructorId) {
		Instructors instructor=entityManager.find(Instructors.class, instructorId);
		entityManager.remove(instructor);
		
	}
	
	@Override
	public List<Instructors> findbyNameLike(String name){
		String insStatus="已審核";
		String hql= "FROM Instructors WHERE (insStatus=:insStatus) AND (CONCAT(instructorName, ' ', brief, ' ',"
				+"speciality1, ' ', speciality2"
				+ ") LIKE '%"+name+"%' )";
		
		List<Instructors> all=entityManager.createQuery(hql, Instructors.class)
											.setParameter("insStatus", insStatus)
											.getResultList();
		if(all.size()!=0) {
			List<Instructors> allInstructors= new ArrayList<>();
			for(Instructors instructor:all) {
				String type=instructorTypeService.findByTypeId(instructor.getTypeId())
									.getTypeName();
				instructor.setType(type);
				allInstructors.add(instructor);
			}
			return allInstructors;
		}else {
			return null;
		}
		
	}
	@Override
	public List<Instructors> findbyTypeId(Integer typeId){
		String hql= "FROM Instructors where typeId=:typeId and insStatus=:insStatus";
		String insStatus="已審核";
		List<Instructors> all=entityManager.createQuery(hql, Instructors.class)
											.setParameter("typeId", typeId)
											.setParameter("insStatus", insStatus)
											.getResultList();
		if(all.size()!=0) {
			List<Instructors> allInstructors= new ArrayList<>();
			for(Instructors instructor:all) {
				String type=instructorTypeService.findByTypeId(instructor.getTypeId())
												.getTypeName();
				instructor.setType(type);
				allInstructors.add(instructor);
			}
			return allInstructors;
		}else {
			return null;
		}
	}
}
