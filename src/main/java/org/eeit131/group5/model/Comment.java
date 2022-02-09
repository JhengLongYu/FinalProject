package org.eeit131.group5.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

@Entity
@Table(name="comment")
@Component("comment")
public class Comment implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer com_id;
	private String com_content;
	private Integer art_id;
	private Integer user_id;
	private String com_create_time;
	private Integer com_state;
	
	@Transient
	private String mbname;
	
	@Transient
	private String art_title;
	
	public Integer getCom_id() {
		return com_id;
	}
	
	public void setCom_id(Integer com_id) {
		this.com_id = com_id;
	}
	
	public String getCom_content() {
		return com_content;
	}
	
	public void setCom_content(String com_content) {
		this.com_content = com_content;
	}
	
	public Integer getArt_id() {
		return art_id;
	}
	
	public void setArt_id(Integer art_id) {
		this.art_id = art_id;
	}
	
	public Integer getUser_id() {
		return user_id;
	}
	
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	
	public String getCom_create_time() {
		return com_create_time;
	}
	
	public void setCom_create_time(String com_create_time) {
		this.com_create_time = com_create_time;
	}

	public Integer getCom_state() {
		return com_state;
	}

	public void setCom_state(Integer com_state) {
		this.com_state = com_state;
	}

	public String getMbname() {
		return mbname;
	}

	public void setMbname(String mbname) {
		this.mbname = mbname;
	}
	
	public String getArt_title() {
		return art_title;
	}

	public void setArt_title(String art_title) {
		this.art_title = art_title;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
