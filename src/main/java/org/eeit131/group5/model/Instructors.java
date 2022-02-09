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

import lombok.Data;

@Entity
@Table(name="instructors")
@Component ("instructors")

public class Instructors implements Serializable{
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer instructorId;
	private String instructorName;
	private Integer typeId;
	@Transient
	private String type;
	private String brief;
	private String experience1;
	private String experience2;
	private String speciality1;
	private String speciality2;
	private String certification1;
	private String certification2;
	private Integer memberId;
	@Transient
	private String fileDataUrl;
	
	private String mimeType;
	@JsonIgnore
	private Blob coverImage;
	private String insStatus;
	public Integer getInstructorId() {
		return instructorId;
	}
	public void setInstructorId(Integer instructorId) {
		this.instructorId = instructorId;
	}
	public String getInstructorName() {
		return instructorName;
	}
	public void setInstructorName(String instructorName) {
		this.instructorName = instructorName;
	}
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getBrief() {
		return brief;
	}
	public void setBrief(String brief) {
		this.brief = brief;
	}
	public String getExperience1() {
		return experience1;
	}
	public void setExperience1(String experience1) {
		this.experience1 = experience1;
	}
	public String getExperience2() {
		return experience2;
	}
	public void setExperience2(String experience2) {
		this.experience2 = experience2;
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
	public String getCertification1() {
		return certification1;
	}
	public void setCertification1(String certification1) {
		this.certification1 = certification1;
	}
	public String getCertification2() {
		return certification2;
	}
	public void setCertification2(String certification2) {
		this.certification2 = certification2;
	}
	public String getFileDataUrl() {
		return fileDataUrl;
	}
	public void setFileDataUrl(String fileDataUrl) {
		this.fileDataUrl = fileDataUrl;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getInsStatus() {
		return insStatus;
	}
	public void setInsStatus(String insStatus) {
		this.insStatus = insStatus;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	

	
}
