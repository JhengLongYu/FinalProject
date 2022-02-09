package org.eeit131.group5.model;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "FoodCenter")
public class FoodCenter {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "pk")
	Integer pk;

	@Column(name = "idfrom")
	String idfrom;

	@Column(name = "foodid")
	Integer foodid;

	@Override
	public String toString() {
		return "FoodCenter [pk=" + pk + 
				", idfrom=" + idfrom + 
				", foodid=" + foodid +
				", date=" + date + "]";
	}

	public Integer getPk() {
		return pk;
	}

	public void setPk(Integer pk) {
		this.pk = pk;
	}

	public String getIdfrom() {
		return idfrom;
	}

	public void setIdfrom(String idfrom) {
		this.idfrom = idfrom;
	}

	public Integer getFoodid() {
		return foodid;
	}

	public void setFoodid(Integer foodid) {
		this.foodid = foodid;
	}

	public LocalDate getDate() {
		return date;
	}

	public void setDate(LocalDate date) {
		this.date = date;
	}

	@Column(name = "date")
	LocalDate date;

}
