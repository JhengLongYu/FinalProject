package org.eeit131.group5.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.eeit131.group5.model.ConsultMail;
import org.eeit131.group5.model.InsSchedule;
import org.eeit131.group5.model.Instructors;
import org.eeit131.group5.model.Member;
import org.eeit131.group5.model.Reservation;
import org.eeit131.group5.service.ConsultMailService;
import org.eeit131.group5.service.InsScheduleService;
import org.eeit131.group5.service.InstructorService;
import org.eeit131.group5.service.MemberService;
import org.eeit131.group5.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ConsultMailController {
	@Autowired
	ConsultMailService mailService;
	@Autowired
	InstructorService instructorService;
	@Autowired
	InsScheduleService insScheduleService;
	@Autowired
	MemberService memberService;
	@Autowired
	ReservationService reservationService;
	public ConsultMailController(ConsultMailService mailService) {
		this.mailService=mailService;
	}
	
	@GetMapping("/test1")
	public String test() {
		System.out.println("=============");
		return "aa";
	}
	
	@PostMapping("/consultion/send")
	public @ResponseBody Map<String,String> sendMail(@RequestBody ConsultMail mail) {
//		String link="請點選網址以利啟動帳號 "+"http://localhost:8080/health/test1";
		Map<String,String> map = new HashMap<>();
		String result="";
		Integer mbId=mail.getMbId(); 
		String action=mail.getAction();
		Integer scheduleNo=mail.getScheduleNo();
		Reservation reservation=null;
		reservation= reservationService.findbyscheduleNo(scheduleNo);
		Timestamp consultime=null;
		Integer insId=null;
		//取消預約
		if(reservation==null) {
			InsSchedule insSchedule=insScheduleService.findByScheduleNo(scheduleNo);
			insId=insSchedule.getInstructorId();
			consultime=insSchedule.getStartTime();
		//新增預約
		}else {
			insId=reservation.getInstructorId();
			consultime=reservation.getConsultTime();
		}
		//因Azure時區 須加八小時
//		 System.out.println("原始consultime "+consultime);
//		Calendar cal = Calendar.getInstance();
//	    cal.setTimeInMillis(consultime.getTime());
//	    cal.add(Calendar.HOUR, 8);
//	    consultime = new Timestamp(cal.getTime().getTime());
//	    System.out.println("增加八小時consultime "+consultime);
		Instructors ins=instructorService.findById(insId);
		Integer insMbId=ins.getMemberId();
		String insEmail=memberService.findById(insMbId).getMbemail();
		String insName=ins.getInstructorName();
		Member mb=memberService.findById(mbId);
		String mbName=mb.getMbname();
		String mbEmail=mb.getMbemail();
		System.out.println("insMbId"+insMbId+"insEmail"+insEmail);
		System.out.println("mbName"+mbName+"mbEmail"+mbEmail);
//		System.out.println("consultime "+consultime+"---insMbId "+insMbId+"--insEmail "+insEmail);
		mail.setRecipient(insEmail);
		String subject=null;
		String messageToIns=null;
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy 年 MM 月 dd 日 HH 時 mm 分 ");
        String sd2 = sdf2.format(new Date(Long.parseLong(String.valueOf(consultime.getTime()))));
        System.out.println("格式化结果：" + sd2);
		if("新增預約".equals(action)) {
//			System.out.println("新增預約寄信-----------------------------");
			subject="諮詢預約通知信";
			messageToIns="親愛的講師"+insName+"您好: \n會員"+mbName+"已和您預約"+sd2+"諮詢時段";
			result="新增預約寄信成功! ";
			map.put("success", result);
		}else {
//			System.out.println("會員取消預約寄信-----------------------------");
			subject="諮詢預約取消通知信";
			messageToIns="親愛的講師"+insName+"您好: \n會員"+mbName+" 已取消和您預約"+sd2+"諮詢時段";
			result="取消預約寄信成功! ";
			map.put("fail", result);
			
		}
		mail.setSubject(subject);
		mail.setMessage(messageToIns);
	
		mailService.sendMail(mail);
		return map;
	
	}
	
	@PostMapping("/consultion/attachment")
	public @ResponseBody String sendAttachmentMail(@RequestBody ConsultMail mail) {
		mailService.sendMailWithAttachments(mail);;
		return "success";
	
	}
}
