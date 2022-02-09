package org.eeit131.group5.service;

import java.util.List;

import org.eeit131.group5.model.Reservation;

public interface ReservationService {
	public List<Reservation> findAll();
	
	public Reservation findByReservationId(Integer reservationId);
	
	public List<Reservation> findByMemberId(Integer memberId);
	
	public List<Reservation> findByInstructorId(Integer instructorId);
	
	public void save(Reservation reservation);
	
	public void update(Reservation reservation);
	
	public void remove(Integer reservationId);
	
	List<Reservation> findAllOrderbymemberId();

	public Reservation findbyscheduleNo(Integer scheduleNo);
	
//	List<Reservation> findByInsAndStatus(Integer instructorId, String status);

}
