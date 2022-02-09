package org.eeit131.group5.repository;

import java.util.List;

import org.eeit131.group5.model.InsSchedule;

public interface InsScheduleRepository {
	public List<InsSchedule> findAll();
	
	public List<InsSchedule> findByInstructorId(Integer instructorId);
	
	public void save(InsSchedule insSchedule);
	
	public InsSchedule findByScheduleNo(Integer scheduleNo);
	
	public void update (InsSchedule insSchedule);

	public void remove(Integer instructorId);

	List<InsSchedule> findAvailableByInstructorId(Integer instructorId, String available);
}
