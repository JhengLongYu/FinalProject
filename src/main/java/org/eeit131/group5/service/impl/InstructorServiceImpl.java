package org.eeit131.group5.service.impl;

import java.util.List;

import org.eeit131.group5.model.Instructors;
import org.eeit131.group5.repository.InstructorRepository;
import org.eeit131.group5.service.InstructorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class InstructorServiceImpl implements InstructorService {
	
	@Autowired
	InstructorRepository instructorRepository;
	
	@Override
	public List<Instructors> findAll() {
		return instructorRepository.findAll();
	}

	@Override
	public Instructors findByInstructorname(String instructorName) {
		return instructorRepository.findByInstructorname(instructorName);
	}

	@Override
	public void save(Instructors instructor) {
		instructorRepository.save(instructor);

	}

	@Override
	public Instructors findById(Integer instructorId) {
		return instructorRepository.findById(instructorId);
	}

	@Override
	public void update(Instructors instructor) {
		instructorRepository.update(instructor);
	}

	@Override
	public void remove(Integer instructorId) {
		instructorRepository.remove(instructorId);
	}

	@Override
	public List<Instructors> findbyNameLike(String name) {
		return instructorRepository.findbyNameLike(name);
	}

	@Override
	public List<Instructors> findbyTypeId(Integer typeId) {
		return instructorRepository.findbyTypeId(typeId);
	}

	@Override
	public Instructors findByMemberId(Integer memberId) {
		return instructorRepository.findByMemberId(memberId);
	}
	

}
