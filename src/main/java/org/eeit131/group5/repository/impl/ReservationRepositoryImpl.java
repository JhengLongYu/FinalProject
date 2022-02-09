package org.eeit131.group5.repository.impl;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

import org.eeit131.group5.model.InsSchedule;
import org.eeit131.group5.model.Instructors;
import org.eeit131.group5.model.Member;
import org.eeit131.group5.model.Reservation;
import org.eeit131.group5.repository.ReservationRepository;
import org.eeit131.group5.service.InsScheduleService;
import org.eeit131.group5.service.InstructorService;
import org.eeit131.group5.service.MemberService;
import org.eeit131.group5.service.ReservationService;
import org.hibernate.NonUniqueResultException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class ReservationRepositoryImpl implements ReservationRepository {
	
	@Autowired
	EntityManager entityManager;
	@Autowired
	InsScheduleService insScheduleService;
	@Autowired
	InstructorService instructorService ;
	@Autowired
	MemberService memberService;
	@Override
	public List<Reservation> findAll() {
		String hql= "FROM Reservation";
		List<Reservation> all=entityManager.createQuery(hql, Reservation.class)
											.getResultList();
		List<Reservation> allReservations=new ArrayList<>();
		for(Reservation res:all) {
			InsSchedule schedule=insScheduleService.findByScheduleNo(res.getScheduleNo());
			Integer instructorId=schedule.getInstructorId();
			Timestamp consultTime=schedule.getStartTime();
			Timestamp endTime=schedule.getEndTime();
			res.setInstructorId(instructorId);
			res.setConsultTime(consultTime);
			long start=consultTime.getTime();
			long end= endTime.getTime();
			Integer duration=(int) ((end-start)/(1000*60*60));
			res.setDuration(duration);
			Member mb=memberService.findById(res.getMemberId());
			res.setMbname(mb.getMbname());
			Instructors ins=instructorService.findById(instructorId);
			res.setInstructorName(ins.getInstructorName());;
			allReservations.add(res);
		}
		return allReservations;
	}
	
	@Override
	public List<Reservation> findAllOrderbymemberId() {
		String hql= "FROM Reservation ORDER BY memberId DESC";
		List<Reservation> all=entityManager.createQuery(hql, Reservation.class)
											.getResultList();
		List<Reservation> allReservations=new ArrayList<>();
		for(Reservation res:all) {
			InsSchedule schedule=insScheduleService.findByScheduleNo(res.getScheduleNo());
			Integer instructorId=schedule.getInstructorId();
			Instructors instructor=instructorService.findById(instructorId);
			String instructorName=instructor.getInstructorName();
			
			Timestamp consultTime=schedule.getStartTime();
			Timestamp endTime=schedule.getEndTime();
			res.setInstructorId(instructorId);
			res.setInstructorName(instructorName);
			res.setConsultTime(consultTime);
			long start=consultTime.getTime();
			long end= endTime.getTime();
			Integer duration=(int) ((end-start)/(1000*60*60));
			res.setDuration(duration);
			
			allReservations.add(res);
		}
		return allReservations;
	}

	@Override
	public Reservation findByReservationId(Integer reservationId) {
		Reservation res=null;
		try {
		res= entityManager.find(Reservation.class, reservationId);
		InsSchedule insSchedule=insScheduleService.findByScheduleNo(res.getScheduleNo());
		res.setInstructorId(insSchedule.getInstructorId());
		res.setConsultTime(insSchedule.getStartTime());
		res.setDuration(insSchedule.getDuration());
		
		}catch(NoResultException e) {
			res=null;
//			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<Reservation> findByMemberId(Integer memberId) {
		String hql= "FROM Reservation where memberId=:memberId";
		List<Reservation> reservations=null;
		List<Reservation> allReservations=new ArrayList<>();
		
		try {
			reservations= entityManager.createQuery(hql,Reservation.class)
									  .setParameter("memberId", memberId)
									  .getResultList();
			
			for(Reservation reservation: reservations) {
				
				InsSchedule schedule=insScheduleService.findByScheduleNo(reservation.getScheduleNo());
				long milliseconds= schedule.getStartTime().getTime();
				reservation.setMilliseconds(milliseconds);
				Integer instructorId=schedule.getInstructorId();
				Instructors instructor=instructorService.findById(instructorId);
				String instructorName=instructor.getInstructorName();
				Timestamp consultTime=schedule.getStartTime();
				Timestamp endTime=schedule.getEndTime();
				reservation.setInstructorId(instructorId);
				reservation.setInstructorName(instructorName);
				reservation.setConsultTime(consultTime);
				long start=consultTime.getTime();
				long end= endTime.getTime();
				Integer duration=(int) ((end-start)/(1000*60*60));
				reservation.setDuration(duration);
				allReservations.add(reservation);
				
			}
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return allReservations;
	}

	@Override
	public List<Reservation> findByInstructorId(Integer instructorId) {
		String hql= "FROM InsSchedule where instructorId=:instructorId";
		List<InsSchedule> insSchedule=null;
		List<Reservation> allReservations=new ArrayList<>();
		try {
			insSchedule= entityManager.createQuery(hql,InsSchedule.class)
									  .setParameter("instructorId", instructorId)
									  .getResultList();
			
			for(InsSchedule insSche:insSchedule) {
				Reservation res=findbyscheduleNo(insSche.getScheduleNo());
				
				if(res!=null) {
					res.setInstructorId(insSche.getInstructorId());
					Timestamp consultTime=insSche.getStartTime();
					Timestamp endTime=insSche.getEndTime();
					res.setConsultTime(consultTime);
					long start=consultTime.getTime();
					long end= endTime.getTime();
					Integer duration=(int) ((end-start)/(1000*60*60));
					res.setDuration(duration);
					String mbName=memberService.findById(res.getMemberId()).getMbname();
					res.setMbname(mbName);
//					System.out.println("new res"+res);
					allReservations.add(res);
				}
				
			}
		}catch(NoResultException e) {
			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return allReservations;
	}
	public Reservation findbyscheduleNo(Integer scheduleNo) {
		String hql= "FROM Reservation where scheduleNo=:scheduleNo";
		Reservation res=null;
		try {
		res= entityManager.createQuery(hql,Reservation.class)
				  					.setParameter("scheduleNo", scheduleNo)
				  					.getSingleResult();
//		System.out.println("res"+res);
		
			InsSchedule insSchedule=insScheduleService.findByScheduleNo(scheduleNo);
			res.setInstructorId(insSchedule.getInstructorId());
			res.setConsultTime(insSchedule.getStartTime());
			res.setDuration(insSchedule.getDuration());
			return res;
		}catch(NoResultException e) {
			res=null;
//			e.printStackTrace();
		}catch(NonUniqueResultException e) {
			e.printStackTrace();
		}
		return res;
	}
//	@Override
//	public List<Reservation> findByInsAndStatus(Integer instructorId,String status) {
//		String hql= "FROM Reservation where instructorId=:instructorId and status=:status";
//		List<Reservation> reservation=null;
//		List<Reservation> allReservations=new ArrayList<>();
//		try {
//			reservation= entityManager.createQuery(hql,Reservation.class)
//									  .setParameter("instructorId", instructorId)
//									  .setParameter("status", status)
//									  .getResultList();
//			
//			for(Reservation res:reservation) {
//				InsSchedule schedule=insScheduleService.findByScheduleNo(res.getScheduleNo());
//				Integer insId=schedule.getInstructorId();
//				Timestamp consultTime=schedule.getStartTime();
//				Timestamp endTime=schedule.getEndTime();
//				res.setInstructorId(insId);
//				res.setConsultTime(consultTime);
//				long start=consultTime.getTime();
//				long end= endTime.getTime();
//				Integer duration=(int) ((end-start)/(1000*60*60));
//				res.setDuration(duration);
//				allReservations.add(res);
//			}
//		}catch(NoResultException e) {
//			e.printStackTrace();
//		}catch(NonUniqueResultException e) {
//			e.printStackTrace();
//		}
//		return allReservations;
//	}
//	
	@Override
	public void save(Reservation reservation) {
		String roomCode=getRandomString(6);
		reservation.setRoomCode(roomCode);
		entityManager.persist(reservation);
	}

	@Override
	public void update(Reservation reservation) {
		Reservation reservation0=entityManager.find(Reservation.class, reservation.getReservationId());
		reservation.setCreateTime(reservation0.getCreateTime());
		entityManager.detach(reservation0);
		entityManager.merge(reservation);

	}

	@Override
	public void remove(Integer reservationId) {
		Reservation reservation = entityManager.find(Reservation.class, reservationId);
		entityManager.remove(reservation);

	}
	
	static String getRandomString(int i) {
		{ 
	        String theAlphaNumericS;
	        StringBuilder builder;
	        
	        theAlphaNumericS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	                                    + "0123456789"; 

	        //create the StringBuffer
	        builder = new StringBuilder(i); 

	        for (int m = 0; m < i; m++) { 

	            // generate numeric
	            int myindex 
	                = (int)(theAlphaNumericS.length() 
	                        * Math.random()); 

	            // add the characters
	            builder.append(theAlphaNumericS 
	                        .charAt(myindex)); 
	        } 

	        return builder.toString(); 
	    } 
	}
}
