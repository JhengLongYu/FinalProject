package org.eeit131.group5.model;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;
@Entity
@Table(name="insSchedule")
@Component ("insSchedule")
public class InsSchedule implements Serializable{
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer scheduleNo;
	
	private Integer instructorId;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone="Asia/Taipei")
	private Timestamp startTime;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone="Asia/Taipei")
	private Timestamp endTime;
	private String available;
	
	@Transient
	private Integer duration;
	
//	@Transient
//	Long startMilliseconds;
//	@Transient
//	Long endMilliseconds;
	
	public Integer getInstructorId() {
		return instructorId;
	}
	public Integer getScheduleNo() {
		return scheduleNo;
	}
	public void setScheduleNo(Integer scheduleNo) {
		this.scheduleNo = scheduleNo;
	}
	public void setInstructorId(Integer instructorId) {
		this.instructorId = instructorId;
	}
	public Timestamp getStartTime() {
		return startTime;
	}
	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}
	public Timestamp getEndTime() {
		return endTime;
	}
	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}
	public String getAvailable() {
		return available;
	}
	public void setAvailable(String available) {
		this.available = available;
	}
	public Integer getDuration() {
		return duration;
	}
	public void setDuration(Integer duration) {
		this.duration = duration;
	}
	@Override
	public String toString() {
		return "InsSchedule [scheduleNo=" + scheduleNo + ", instructorId=" + instructorId + ", startTime=" + startTime
				+ ", endTime=" + endTime + ", available=" + available + ", duration=" + duration + "]";
	}
	
	
}
