package org.eeit131.group5.model;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name="tag")
@Component ("tag")
public class Tag implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer tag_id;
	private String tag_name;
	private String tag_create_time;
	
	@Transient
	private Integer art_num;
	
	public Integer getTag_id() {
		return tag_id;
	}
	
	public void setTag_id(Integer tag_id) {
		this.tag_id = tag_id;
	}
	
	public String getTag_name() {
		return tag_name;
	}
	
	public void setTag_name(String tag_name) {
		this.tag_name = tag_name;
	}
	
	public String getTag_create_time() {
		return tag_create_time;
	}
	
	public void setTag_create_time(String tag_create_time) {
		this.tag_create_time = tag_create_time;
	}
	
	public Integer getArt_num() {
		return art_num;
	}

	public void setArt_num(Integer art_num) {
		this.art_num = art_num;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
