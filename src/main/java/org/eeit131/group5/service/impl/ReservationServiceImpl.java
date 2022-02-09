package org.eeit131.group5.service.impl;

import java.util.List;

import org.eeit131.group5.model.Reservation;
import org.eeit131.group5.repository.ReservationRepository;
import org.eeit131.group5.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
@Service
@Transactional
public class ReservationServiceImpl implements ReservationService {
	
	@Autowired
	ReservationRepository reservationRepository;
	
	@Override
	public List<Reservation> findAll() {
		return reservationRepository.findAll();
	}

	@Override
	public Reservation findByReservationId(Integer reservationId) {
		return reservationRepository.findByReservationId(reservationId);
	}

	@Override
	public List<Reservation> findByMemberId(Integer memberId) {
		return reservationRepository.findByMemberId(memberId);
	}

	@Override
	public List<Reservation> findByInstructorId(Integer instructorId) {
		return reservationRepository.findByInstructorId(instructorId);
	}

	@Override
	public void save(Reservation reservation) {
		reservationRepository.save(reservation);
	}

	@Override
	public void update(Reservation reservation) {
		reservationRepository.update(reservation);
	}

	@Override
	public void remove(Integer reservationId) {
		reservationRepository.remove(reservationId);
	}

	@Override
	public List<Reservation> findAllOrderbymemberId() {
		return reservationRepository.findAllOrderbymemberId();
	}

	@Override
	public Reservation findbyscheduleNo(Integer scheduleNo) {
		return reservationRepository.findbyscheduleNo(scheduleNo);
	}

//	@Override
//	public List<Reservation> findByInsAndStatus(Integer instructorId, String status) {
//		return reservationRepository.findByInsAndStatus(instructorId, status);
//	}


}
