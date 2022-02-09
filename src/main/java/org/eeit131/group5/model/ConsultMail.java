package org.eeit131.group5.model;

import javax.persistence.Transient;

public class ConsultMail {
	private String recipient;
	private String subject;
	private String message;
	@Transient
	private Integer mbId;
	@Transient
	private Integer scheduleNo;
	@Transient
	private Integer reservationId;
	@Transient
	private String action;
	
	public ConsultMail() {
	}

	public ConsultMail(String recipient, String subject, String message) {
		super();
		this.recipient = recipient;
		this.subject = subject;
		this.message = message;
	}

	public String getRecipient() {
		return recipient;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Integer getScheduleNo() {
		return scheduleNo;
	}

	public void setScheduleNo(Integer scheduleNo) {
		this.scheduleNo = scheduleNo;
	}

	public Integer getMbId() {
		return mbId;
	}

	public void setMbId(Integer mbId) {
		this.mbId = mbId;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public Integer getReservationId() {
		return reservationId;
	}

	public void setReservationId(Integer reservationId) {
		this.reservationId = reservationId;
	}
	
	
}
