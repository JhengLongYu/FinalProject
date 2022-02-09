package org.eeit131.group5.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "collect")
@Component ("collect")
public class Collect implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer collect_id;
	private Integer art_id;
	private Integer collect_user_id;
	
	public Integer getCollect_id() {
		return collect_id;
	}
	
	public void setCollect_id(Integer collect_id) {
		this.collect_id = collect_id;
	}
	
	public Integer getArt_id() {
		return art_id;
	}
	
	public void setArt_id(Integer art_id) {
		this.art_id = art_id;
	}
	
	public Integer getCollect_user_id() {
		return collect_user_id;
	}
	
	public void setCollect_user_id(Integer collect_user_id) {
		this.collect_user_id = collect_user_id;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
