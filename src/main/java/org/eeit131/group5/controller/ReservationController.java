package org.eeit131.group5.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eeit131.group5.model.InsSchedule;
import org.eeit131.group5.model.Instructors;
import org.eeit131.group5.model.MbEvent;
import org.eeit131.group5.model.Reservation;
import org.eeit131.group5.model.RewardPoints;
import org.eeit131.group5.service.InsScheduleService;
import org.eeit131.group5.service.InstructorService;
import org.eeit131.group5.service.ReservationService;
import org.eeit131.group5.service.RewardPointsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ReservationController {
	@Autowired
	ReservationService reservationService;
	@Autowired
	InstructorService instructorService;
	@Autowired
	InsScheduleService insScheduleService;
	@Autowired
	RewardPointsService rewardPointsService;
	
	@PostMapping("/consultion/addReservation")
	public @ResponseBody Map<String,String> save(
			@RequestBody Reservation reservation
			) {
		LocalDateTime localDateTime = LocalDateTime.now(); 
		reservation.setCreateTime(Timestamp.valueOf(localDateTime));
		reservation.setStatus("未開始");
		
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			RewardPoints rewardPoints = rewardPointsService.rpFindById(reservation.getMemberId());
		    if(rewardPoints!=null) {
		    	Integer points=rewardPoints.getPoints();
		    	if((points-5)<0) {
		    		result="點數不足,請重新儲值";
		    		map.put("fail",result);
		    	}else{
		    		rewardPoints.setPoints(points-5);
		    		rewardPointsService.update(rewardPoints);
		    		reservationService.save(reservation);
				    result="已扣除五點,預約成功! 更多細節請至請至會員諮詢明細頁面查看，謝謝!";
				    map.put("success", result);
				    
				    InsSchedule schedule= insScheduleService.findByScheduleNo(reservation.getScheduleNo());
				    schedule.setAvailable("已被預約");
				    insScheduleService.update(schedule);
		    	}
		    	
		    }else {
		    	RewardPoints rwPoints= new RewardPoints();
		    	rwPoints.setMemberId(reservation.getMemberId());
		    	rwPoints.setPoints(10-5);
		    	rewardPointsService.save(rwPoints);
		    	reservationService.save(reservation);
		    	result="已扣除五點,預約成功! 更多細節請至請至會員諮詢明細頁面查看，謝謝!";
		    	map.put("success", result);
		    	InsSchedule schedule= insScheduleService.findByScheduleNo(reservation.getScheduleNo());
				schedule.setAvailable("已被預約");
				insScheduleService.update(schedule);
		    }
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail",result);
		}
		return map;
	}
	@GetMapping("/consultion/listPage/{mbId}")
	public String findListPage(
			@PathVariable Integer mbId,Model model
			){
		model.addAttribute("mbId", mbId);
		return "/consultion1/memberCenter_listPage";
		
	}
	
	@GetMapping("/consultion/InsListPage")
	public String findInsListPage(
			){
		return "/consultion1/memberCenter_insPage";
		
	}
	
	@GetMapping("/consultion/InsSchedulePage")
	public String findInsSchedulePage(
			){
		return "/consultion1/memberCenter_inscalendar";
		
	}
	@GetMapping("/consultion/findbymbId/{mbId}")
	public @ResponseBody List<Reservation> findbymbId(
			@PathVariable Integer mbId, Model model
			){
		List<Reservation> reservations=reservationService.findByMemberId(mbId);
		return reservations;
		
	}
	@GetMapping("/consultion/rsfindbyinsId/{insId}")
	public @ResponseBody List<Reservation> rsfindbyinsId(
			@PathVariable Integer insId, Model model
			){
		List<Reservation> reservations=reservationService.findByInstructorId(insId);
		return reservations;
		
	}
	
	@GetMapping("/consultion/findComingRt/{mbId}")
	public @ResponseBody List<Reservation> findComingRt(
			@PathVariable Integer mbId
			){
		List<Reservation> reservations=reservationService.findByMemberId(mbId);
		List<Reservation> comingRt=new ArrayList<>();
		LocalDateTime now = LocalDateTime.now(); 
		System.out.println("now"+now);
		for(Reservation rt: reservations) {
			InsSchedule schedule= insScheduleService.findByScheduleNo(rt.getScheduleNo()); 
			LocalDateTime consultTime=schedule.getStartTime().toLocalDateTime();
			 System.out.println(rt.getReservationId()+"consultTime"+consultTime);
			long years = ChronoUnit.YEARS.between(now, consultTime);
			long months = ChronoUnit.MONTHS.between(now, consultTime);
		    long days = ChronoUnit.DAYS.between(now, consultTime);
		    long hours = ChronoUnit.HOURS.between(now, consultTime);
		    long minutes = ChronoUnit.MINUTES.between(now, consultTime);
		    System.out.println(years+"年"+months+"月"+days+"日"+hours+"小時"+minutes+"分");
		    if(years==0&&months==0) {
		    	 if(days==0&&hours==0) {
		    		 if(minutes<=60&&minutes>=0) {
		    			 comingRt.add(rt);
		    		 }else {
		    			 continue;
		    		 }
		    	 }else {
		    		 continue;
		    	 }
		    }else {
		    	continue;
		    }
		}
	
		return comingRt;
		
	}
	
	@GetMapping("/consultion/findComingRtbyInsId/{insId}")
	public @ResponseBody List<Reservation> findComingRtbyInsId(
			@PathVariable Integer insId
			){
		List<Reservation> reservations=reservationService.findByInstructorId(insId);
		List<Reservation> comingRt=new ArrayList<>();
		LocalDateTime now = LocalDateTime.now(); 
		System.out.println("now"+now);
		for(Reservation rt: reservations) {
			InsSchedule schedule= insScheduleService.findByScheduleNo(rt.getScheduleNo()); 
			LocalDateTime consultTime=schedule.getStartTime().toLocalDateTime();
			 System.out.println(rt.getReservationId()+"consultTime"+consultTime);
			long years = ChronoUnit.YEARS.between(now, consultTime);
			long months = ChronoUnit.MONTHS.between(now, consultTime);
		    long days = ChronoUnit.DAYS.between(now, consultTime);
		    long hours = ChronoUnit.HOURS.between(now, consultTime);
		    long minutes = ChronoUnit.MINUTES.between(now, consultTime);
		    System.out.println(years+"年"+months+"月"+days+"日"+hours+"小時"+minutes+"分");
		    if(years==0&&months==0) {
		    	 if(days==0&&hours==0) {
		    		 if(minutes<=60&&minutes>=0) {
		    			 comingRt.add(rt);
		    		 }else {
		    			 continue;
		    		 }
		    	 }else {
		    		 continue;
		    	 }
		    }else {
		    	continue;
		    }
		}
	
		return comingRt;
		
	}
	
	@GetMapping("/consultion/delete/{reservationId}")
	public @ResponseBody Map<String,String> deletebymbId(
			@PathVariable Integer reservationId, Model model
			){
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			Integer scheduleNo=reservationService.findByReservationId(reservationId).getScheduleNo();
			InsSchedule insSchedule=insScheduleService.findByScheduleNo(scheduleNo);
			insSchedule.setAvailable("可預約");
			insScheduleService.update(insSchedule);
			System.out.println("---------------"+insSchedule);
			reservationService.remove(reservationId);
	    	
		    result="刪除成功! 請至您的信箱查收取消通知，感謝!";
		    map.put("success", result);
		    String scheNo=String.valueOf(insSchedule.getScheduleNo());
//		    System.out.println("scheNo+++++++"+scheNo);
		    map.put("scheduleNo", scheNo);
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail",result);
		}
		return map;
		
		
	}
	
	@GetMapping("/consultion/completeConsultion/{reservationId}")
	public @ResponseBody Map<String,String> completeConsultion(
			@PathVariable Integer reservationId, Model model
			){
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			Reservation reservation=reservationService.findByReservationId(reservationId);
			reservation.setStatus("已完成");
			reservationService.update(reservation);
	    	
		    result="諮詢已完成! 感謝!";
		    map.put("success", result);
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail",result);
		}
		return map;
		
		
	}
	
	@GetMapping("/consultion/deleteSchedule/{scheNo}")
	public @ResponseBody Map<String,String> deleteSchedule(
			@PathVariable Integer scheNo, Model model
			){
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			
			insScheduleService.remove(scheNo);
		    result="刪除時段成功!";
		    map.put("success", result);
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail",result);
		}
		return map;
		
		
	}
	
	@GetMapping("/consultion/mglistPage")
	public String mgListPage(){
		return "/consultion/mglistPage";
		
	}
	@GetMapping("/consultion/findAllReservations")
	public @ResponseBody List<Reservation> findAll(){
		List<Reservation> reservations=reservationService.findAll();
//		System.out.println(reservations);
		return reservations;
		
	}
	@GetMapping("/consultion/findAllComingRt")
	public @ResponseBody List<Reservation> findAllComingRt(){
		List<Reservation> reservations=reservationService.findAll();
		List<Reservation> comingRt=new ArrayList<>();
		LocalDateTime now = LocalDateTime.now(); 
		System.out.println("now"+now);
		for(Reservation rt: reservations) {
			LocalDateTime consultTime=rt.getConsultTime().toLocalDateTime();
			 System.out.println(rt.getReservationId()+"consultTime"+consultTime);
			long years = ChronoUnit.YEARS.between(now, consultTime);
			long months = ChronoUnit.MONTHS.between(now, consultTime);
		    long days = ChronoUnit.DAYS.between(now, consultTime);
		    long hours = ChronoUnit.HOURS.between(now, consultTime);
		    long minutes = ChronoUnit.MINUTES.between(now, consultTime);
		    System.out.println(years+"年"+months+"月"+days+"日"+hours+"小時"+minutes+"分");
		    if(years==0&&months==0) {
		    	 if(days==0&&hours==0) {
		    		 if(minutes<=60&&minutes>=0) {
		    			 comingRt.add(rt);
		    		 }else {
		    			 continue;
		    		 }
		    	 }else {
		    		 continue;
		    	 }
		    }else {
		    	continue;
		    }
		}
	
		return comingRt;
		
	}
	@GetMapping("/consultion/insCalendar/{insId}")
	public String inscalendar(@PathVariable Integer insId, Model model) {
		model.addAttribute("insId", insId);
		return "/consultion1/insCalendar";
	}
	@GetMapping("/consultion/eventsbyinsId/{insId}")
	public @ResponseBody List<MbEvent> eventsbyinsId(
			@PathVariable Integer insId, Model model
			){
		
		List<InsSchedule> insSchedules=insScheduleService.findAvailableByInstructorId(insId, "可預約");
		if(insSchedules.size()!=0) {
			List<MbEvent> events= new ArrayList<>();
			for(InsSchedule insSchedule: insSchedules) {
				Long now = System.currentTimeMillis();
				Long consultTime=insSchedule.getStartTime().getTime();
				Long diff=now-consultTime;
				if(diff<0) {
					Map<String,String> props= new HashMap<>();
					MbEvent event= new MbEvent();
					Instructors ins=instructorService.findById(insSchedule.getInstructorId());
					String title="可諮詢時段";
					event.setTitle(title);
					event.setStart(insSchedule.getStartTime());
					event.setEnd(insSchedule.getEndTime());
					
					props.put("instructorName", ins.getInstructorName());
					props.put("scheduleNo", String.valueOf(insSchedule.getScheduleNo()));
					event.setExtendedProps(props);
//					System.out.println(event);
					
					events.add(event);
				}
				
			}
			return events;
		}else {
			return null;
		}
		
		
		
		
	}
	@GetMapping("/consultion/mbcalendar/{mbId}")
	public String mbcalendar(@PathVariable Integer mbId, Model model) {
		model.addAttribute("mbId", mbId);
		return "/consultion1/memberCenter_mbcalendar";
	}
	
	@GetMapping("/consultion/eventsbymbId/{mbId}")
	public @ResponseBody List<MbEvent> eventsbymbId(
			@PathVariable Integer mbId, Model model
			){
		List<Reservation> reservations=reservationService.findByMemberId(mbId);
		List<MbEvent> events= new ArrayList<>();
		for(Reservation reservation: reservations) {
			Map<String,String> props= new HashMap<>();
			MbEvent event= new MbEvent();
			Instructors ins=instructorService.findById(reservation.getInstructorId());
			String title="諮詢 講師:"+ins.getInstructorName();
			event.setTitle(title);
			event.setStart(reservation.getConsultTime());
			LocalDateTime start=reservation.getConsultTime().toLocalDateTime();
			LocalDateTime end=start.plusHours(reservation.getDuration());
			
			props.put("reservationId", String.valueOf(reservation.getReservationId()));
			props.put("instructorId", String.valueOf(reservation.getInstructorId()));
			event.setExtendedProps(props);
			
			event.setEnd(Timestamp.valueOf(end));
			events.add(event);
		}
		
		return events;
		
	}
	
	@GetMapping("/consultion/alleventsbyinsId/{insId}")
	public @ResponseBody List<MbEvent> alleventsbyinsId(
			@PathVariable Integer insId, Model model
			){
		
		List<InsSchedule> insSchedules=insScheduleService.findByInstructorId(insId);
		
		if(insSchedules.size()!=0) {
			List<MbEvent> events= new ArrayList<>();
			for(InsSchedule insSchedule: insSchedules) {
//				System.out.println("insSchedule"+insSchedule);
//				Long now = System.currentTimeMillis();
//				Long consultTime=insSchedule.getStartTime().getTime();
//				Long diff=now-consultTime;
//				if(diff<0) {
					Map<String,String> props= new HashMap<>();
					MbEvent event= new MbEvent();
					Instructors ins=instructorService.findById(insSchedule.getInstructorId());
					Reservation reservation= reservationService.findbyscheduleNo(insSchedule.getScheduleNo());
					if(reservation!=null) {
						Integer reservationId=reservationService.findbyscheduleNo(insSchedule.getScheduleNo()).getReservationId(); 
						props.put("reservationId", String.valueOf(reservationId));
						props.put("scheduleNo","");
					}else {
						props.put("reservationId","" );
						props.put("scheduleNo", String.valueOf(insSchedule.getScheduleNo()));
					}
					
					
					
					String title=insSchedule.getAvailable()+"時段";
					event.setTitle(title);
					event.setStart(insSchedule.getStartTime());
					event.setEnd(insSchedule.getEndTime());
					
					props.put("instructorName", ins.getInstructorName());
					
					event.setExtendedProps(props);
					
					events.add(event);
//				}
				
			}
			return events;
		}else {
			return null;
		}
		
		
		
		
	}
}
