package org.eeit131.group5.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.eeit131.group5.model.InstructorType;
import org.eeit131.group5.repository.InstructorTypeRepository;
import org.eeit131.group5.service.InstructorTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
@Transactional
public class InstructorTypeServiceImpl implements InstructorTypeService {
	@Autowired
	InstructorTypeRepository instructorTypeRepository;
	
	@Override
	public List<InstructorType> findAll() {
		return instructorTypeRepository.findAll();
	}

	@Override
	public InstructorType findByTypeName(String typeName) {
		return instructorTypeRepository.findByTypeName(typeName);
	}

	@Override
	public void save(InstructorType instructorType) {
		instructorTypeRepository.save(instructorType);

	}

	@Override
	public InstructorType findByTypeId(Integer typeId) {
		return instructorTypeRepository.findByTypeId(typeId);
	}

	@Override
	public void update(InstructorType instructorType) {
		instructorTypeRepository.update(instructorType);
	}

	@Override
	public void remove(Integer typeId) {
		instructorTypeRepository.remove(typeId);
	}

}
