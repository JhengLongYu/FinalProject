package org.eeit131.group5.model;

import java.io.Serializable;
import java.sql.Blob;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;
@Entity
@Table(name="favoriteInstructors")
@Component ("favoriteInstructors")
public class FavoriteInstructors implements Serializable{
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer favNo;
	private Integer instructorId;
	private Integer memberId;
	
	@Transient
	private String mimeType;
	@Transient
	@JsonIgnore
	private Blob coverImage;
	@Transient
	private String instructorName;
	@Transient
	private String type;
	@Transient
	private String speciality1;
	@Transient
	private String speciality2;
	
	public Integer getFavNo() {
		return favNo;
	}
	public void setFavNo(Integer favNo) {
		this.favNo = favNo;
	}
	public Integer getInstructorId() {
		return instructorId;
	}
	public void setInstructorId(Integer instructorId) {
		this.instructorId = instructorId;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public String getMimeType() {
		return mimeType;
	}
	public void setMimeType(String mimeType) {
		this.mimeType = mimeType;
	}
	public Blob getCoverImage() {
		return coverImage;
	}
	public void setCoverImage(Blob coverImage) {
		this.coverImage = coverImage;
	}
	public String getInstructorName() {
		return instructorName;
	}
	public void setInstructorName(String instructorName) {
		this.instructorName = instructorName;
	}
	public String getSpeciality1() {
		return speciality1;
	}
	public void setSpeciality1(String speciality1) {
		this.speciality1 = speciality1;
	}
	public String getSpeciality2() {
		return speciality2;
	}
	public void setSpeciality2(String speciality2) {
		this.speciality2 = speciality2;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
	
}
