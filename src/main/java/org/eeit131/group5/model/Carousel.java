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
@Table(name="carousel")
@Component("carousel")
public class Carousel implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer carousel_id;
	private Integer art_id;
	private String art_title;
	private String art_create_time;
	
	@Transient
	private String fileDataUrl;
	
	private String mimeType;
	@JsonIgnore
	private Blob coverImage;
	
	public Integer getCarousel_id() {
		return carousel_id;
	}
	
	public void setCarousel_id(Integer carousel_id) {
		this.carousel_id = carousel_id;
	}
	
	public Integer getArt_id() {
		return art_id;
	}
	
	public void setArt_id(Integer art_id) {
		this.art_id = art_id;
	}
	
	public String getArt_title() {
		return art_title;
	}
	
	public void setArt_title(String art_title) {
		this.art_title = art_title;
	}
	
	public String getArt_create_time() {
		return art_create_time;
	}
	
	public void setArt_create_time(String art_create_time) {
		this.art_create_time = art_create_time;
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
}
