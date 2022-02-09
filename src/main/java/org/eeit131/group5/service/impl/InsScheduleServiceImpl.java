package org.eeit131.group5.service.impl;

import java.util.List;

import org.eeit131.group5.model.InsSchedule;
import org.eeit131.group5.repository.InsScheduleRepository;
import org.eeit131.group5.service.InsScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
@Service
@Transactional
public class InsScheduleServiceImpl implements InsScheduleService {
	
	@Autowired
	InsScheduleRepository insScheduleRepository;
	
	@Override
	public List<InsSchedule> findAll() {
		return insScheduleRepository.findAll();
	}

	@Override
	public List<InsSchedule> findByInstructorId(Integer instructorId) {
		return insScheduleRepository.findByInstructorId(instructorId);
	}

	@Override
	public void save(InsSchedule insSchedule) {
		insScheduleRepository.save(insSchedule);
	}

	@Override
	public InsSchedule findByScheduleNo(Integer scheduleNo) {
		return insScheduleRepository.findByScheduleNo(scheduleNo);
	}

	@Override
	public void update(InsSchedule insSchedule) {
		insScheduleRepository.update(insSchedule);
	}

	@Override
	public void remove(Integer instructorId) {
		insScheduleRepository.remove(instructorId);
	}

	@Override
	public List<InsSchedule> findAvailableByInstructorId(Integer instructorId, String available) {
		return insScheduleRepository.findAvailableByInstructorId(instructorId, available);
	}

}
