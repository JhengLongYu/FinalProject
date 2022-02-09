package org.eeit131.group5.model;

import org.springframework.stereotype.Component;

@Component("healthCalculate")
public class HealthCalculate {
	
	Long daytime ;
	Integer bmi  ;
	Integer bmr  ;
	Integer kg  ;
	Integer checkfrom  ;
	
	public Integer getKg() {
		return kg;
	}
	public void setKg(Integer kg) {
		this.kg = kg;
	}
	public Integer getCheckfrom() {
		return checkfrom;
	}
	public void setCheckfrom(Integer checkfrom) {
		this.checkfrom = checkfrom;
	}
	public Integer getBmr() {
		return bmr;
	}
	public void setBmr(Integer bmr) {
		this.bmr = bmr;
	}
	public Long getDaytime() {
		return daytime;
	}
	public void setDaytime(Long daytime) {
		this.daytime = daytime;
	}
	public Integer getBmi() {
		return bmi;
	}
	public void setBmi(Integer bmi) {
		this.bmi = bmi;
	} 
	
	
}
