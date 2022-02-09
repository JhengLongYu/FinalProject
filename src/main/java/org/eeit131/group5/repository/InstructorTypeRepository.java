package org.eeit131.group5.repository;

import java.util.List;

import org.eeit131.group5.model.InstructorType;

public interface InstructorTypeRepository {
	public List<InstructorType> findAll();
	
	public InstructorType findByTypeName(String typeName);
	
	public void save(InstructorType instructorType);
	
	public InstructorType findByTypeId(Integer typeId);
	
	public void update (InstructorType instructorType);

	public void remove(Integer typeId);
}
