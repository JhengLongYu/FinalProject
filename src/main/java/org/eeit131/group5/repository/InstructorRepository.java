package org.eeit131.group5.repository;

import java.util.List;

import org.eeit131.group5.model.Instructors;

public interface InstructorRepository {
	
	public List<Instructors> findAll();
	
	public Instructors findByInstructorname(String instructorName);
	
	public void save(Instructors instructor);
	
	public Instructors findById(Integer instructorId);
	
	public void update (Instructors instructor);

	public void remove(Integer instructorId);

	List<Instructors> findbyNameLike(String name);

	List<Instructors> findbyTypeId(Integer typeId);

	Instructors findByMemberId(Integer memberId);
	
}
