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
@Table(name="article")
@Component("article")
public class Article implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer art_id;
	private Integer art_user_id;
	private String art_title;
	private Integer tag_id;
	private String art_create_time;
	private String art_content;
	private Integer art_view;
	private Integer art_like_num;
	
	@Transient
	private String fileDataUrl;
	
	private String mimeType;
	@JsonIgnore
	private Blob coverImage;
	
	@Transient
	private Integer art_collect_num;
	
	@Transient
	private String tag_name;
	
	@Transient
	private Integer art_com_num;
	
	@Transient
	private String com_create_time; 
	
	@Transient
	private Integer collect_id;
	
	@Transient
	private Member member;
	
	
	public Integer getArt_id() {
		return art_id;
	}
	
	public void setArt_id(Integer art_id) {
		this.art_id = art_id;
	}
	
	public Integer getArt_user_id() {
		return art_user_id;
	}
	
	public void setArt_user_id(Integer art_user_id) {
		this.art_user_id = art_user_id;
	}
	
	public String getArt_title() {
		return art_title;
	}
	
	public void setArt_title(String art_title) {
		this.art_title = art_title;
	}
	
	public Integer getTag_id() {
		return tag_id;
	}
	
	public void setTag_id(Integer tag_id) {
		this.tag_id = tag_id;
	}
	
	public String getArt_create_time() {
		return art_create_time;
	}
	
	public void setArt_create_time(String art_create_time) {
		this.art_create_time = art_create_time;
	}
	
	
	public String getArt_content() {
		return art_content;
	}
	
	public void setArt_content(String art_content) {
		this.art_content = art_content;
	}
	
	public Integer getArt_view() {
		return art_view;
	}
	
	public void setArt_view(Integer art_view) {
		this.art_view = art_view;
	}
	
	public Integer getArt_com_num() {
		return art_com_num;
	}
	
	public void setArt_com_num(Integer art_com_num) {
		this.art_com_num = art_com_num;
	}
	
	public Integer getArt_like_num() {
		return art_like_num;
	}
	
	public void setArt_like_num(Integer art_like_num) {
		this.art_like_num = art_like_num;
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

	public Integer getArt_collect_num() {
		return art_collect_num;
	}

	public void setArt_collect_num(Integer art_collect_num) {
		this.art_collect_num = art_collect_num;
	}
	
	public String getTag_name() {
		return tag_name;
	}

	public void setTag_name(String tag_name) {
		this.tag_name = tag_name;
	}
	
	public String getCom_create_time() {
		return com_create_time;
	}

	public void setCom_create_time(String com_create_time) {
		this.com_create_time = com_create_time;
	}
	
	public Integer getCollect_id() {
		return collect_id;
	}

	public void setCollect_id(Integer collect_id) {
		this.collect_id = collect_id;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
