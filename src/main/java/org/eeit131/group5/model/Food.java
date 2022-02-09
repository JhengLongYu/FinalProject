package org.eeit131.group5.model;

import java.sql.Blob;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Food")
@Component("food")
public class Food {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "foodid")
	Integer foodid;

	@Column(name = "category")
	String category;
	@Column(name = "name")
	String name;
	@Column(name = "weight")
	String weight;
	@Column(name = "calorie")
	Integer calorie;
	@Column(name = "carbohydrates")
	Double carbohydrates;
	@Column(name = "fat")
	Double fat;
	@Column(name = "protein")
	Double protein;
	
	@JsonIgnore
	@Column(name = "image")
	private Blob image;
	
	@Transient
	private String fileDataUrl;
	private String mimeType;

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

	public Blob getImage() {
		return image;
	}

	public void setImage(Blob image) {
		this.image = image;
	}

	public Integer getFoodid() {
		return foodid;
	}

	public void setFoodid(Integer foodid) {
		this.foodid = foodid;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	public Integer getCalorie() {
		return calorie;
	}

	public void setCalorie(Integer calorie) {
		this.calorie = calorie;
	}

	public Double getCarbohydrates() {
		return carbohydrates;
	}

	public void setCarbohydrates(Double carbohydrates) {
		this.carbohydrates = carbohydrates;
	}

	public Double getFat() {
		return fat;
	}

	public void setFat(Double fat) {
		this.fat = fat;
	}

	public Double getProtein() {
		return protein;
	}

	public void setProtein(Double protein) {
		this.protein = protein;
	}

	@Override
	public String toString() {
		return "Food [foodid=" + foodid + ", category=" + category + ", name=" + name + ", weight=" + weight
				+ ", calorie=" + calorie + ", carbohydrates=" + carbohydrates + ", fat=" + fat + ", protein=" + protein
				+ ", fileDataUrl=" + fileDataUrl + ", mimeType=" + mimeType + ", image=" + image + "]";
	}

}
