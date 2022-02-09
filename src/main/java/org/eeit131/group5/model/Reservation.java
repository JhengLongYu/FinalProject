package org.eeit131.group5.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;


@Entity
@Table(name="reservation")
@Component ("reservation")

public class Reservation implements Serializable{
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer reservationId;
	private Integer memberId;
	private Integer scheduleNo;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone="Asia/Taipei")
	private Timestamp createTime;
	private String status;
	private String roomCode;
	
	@Transient
	private Integer instructorId;
	@Transient
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone="Asia/Taipei")
	private Timestamp consultTime;
	@Transient
	private Integer duration;
	@Transient
	private Long milliseconds;
	@Transient
	private String instructorName;
	@Transient
	private String mbname;
	
	public Integer getReservationId() {
		return reservationId;
	}
	public void setReservationId(Integer reservationId) {
		this.reservationId = reservationId;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public Integer getInstructorId() {
		return instructorId;
	}
	public void setInstructorId(Integer instructorId) {
		this.instructorId = instructorId;
	}
	
	
	public Integer getDuration() {
		return duration;
	}
	public void setDuration(Integer duration) {
		this.duration = duration;
	}
	public Timestamp getConsultTime() {
		return consultTime;
	}
	public void setConsultTime(Timestamp consultTime) {
		this.consultTime = consultTime;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Long getMilliseconds() {
		return milliseconds;
	}
	public void setMilliseconds(Long milliseconds) {
		this.milliseconds = milliseconds;
	}
	public Integer getScheduleNo() {
		return scheduleNo;
	}
	public void setScheduleNo(Integer scheduleNo) {
		this.scheduleNo = scheduleNo;
	}
	public String getRoomCode() {
		return roomCode;
	}
	public void setRoomCode(String roomCode) {
		this.roomCode = roomCode;
	}
	public String getInstructorName() {
		return instructorName;
	}
	public void setInstructorName(String instructorName) {
		this.instructorName = instructorName;
	}
	public String getMbname() {
		return mbname;
	}
	public void setMbname(String mbname) {
		this.mbname = mbname;
	}
	@Override
	public String toString() {
		return "Reservation [reservationId=" + reservationId + ", memberId=" + memberId + ", scheduleNo=" + scheduleNo
				+ ", createTime=" + createTime + ", status=" + status + ", roomCode=" + roomCode + ", instructorId="
				+ instructorId + ", consultTime=" + consultTime + ", duration=" + duration + ", milliseconds="
				+ milliseconds + ", instructorName=" + instructorName + ", mbname=" + mbname + "]";
	}
	
	
}
