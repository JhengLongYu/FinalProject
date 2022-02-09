package org.eeit131.group5.model;

import java.sql.Blob;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="Product")
public class Product {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	Integer id;
	String name;
	Integer price;
	String category;
	
	@Transient
	private String fileDataUrl;
	
	private String mimeType;
	
	@JsonIgnore
	private Blob picture;
	
	public Product() {}
	
	public Product(Integer id, String name, Integer price, String category, Blob picture) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.category = category;
		this.picture = picture;
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

	public Integer getId() {
		return this.id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public Integer getPrice() {
		return price;
	}


	public void setPrice(Integer price) {
		this.price = price;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public Blob getPicture() {
		return picture;
	}


	public void setPicture(Blob picture) {
		this.picture = picture;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Member [id=");
		builder.append(id);
		builder.append(", name=");
		builder.append(name);
		builder.append(", price=");
		builder.append(price);
		builder.append(", category=");
		builder.append(category);
		builder.append(", picture=");
		builder.append(picture);
		builder.append("]");
		return builder.toString();
	}

}
