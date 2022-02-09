package org.eeit131.group5.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "HealthCenter")
public class HealthCenter {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "pk")
	Integer pk;
	@Column(name = "idfrom")
	String idfrom;
	@Column(name = "name")
	String name;
	@Column(name = "age")
	Integer age;
	@Column(name = "height")
	Double height;
	@Column(name = "kg")
	Double kg;
	@Column(name = "checkform")
	Integer checkform;
	@Column(name = "expect")
	String expect;
	@Column(name = "bloodpressure")
	Double bloodpressure;
	@Column(name = "heartbeat")
	Integer heartbeat;
	@Column(name = "createtime")
	Timestamp createtime;
	@Column(name = "gender")
	String gender;

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("HealthCenter [pk=");
		builder.append(pk);
		builder.append(", idfrom=");
		builder.append(idfrom);
		builder.append(", name=");
		builder.append(name);
		builder.append(", age=");
		builder.append(age);
		builder.append(", height=");
		builder.append(height);
		builder.append(", kg=");
		builder.append(kg);
		builder.append(", expect=");
		builder.append(expect);
		builder.append(", bloodpressure=");
		builder.append(bloodpressure);
		builder.append(", heartbeat=");
		builder.append(heartbeat);
		builder.append(", checkform=");
		builder.append(checkform);
		builder.append(", createtime=");
		builder.append(createtime);
		builder.append("]");
		
		return builder.toString();
	}

	public HealthCenter() {
		super();
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
	
	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Double getHeight() {
		return height;
	}

	public void setHeight(Double height) {
		this.height = height;
	}

	public Double getKg() {
		return kg;
	}

	public void setKg(Double kg) {
		this.kg = kg;
	}

	public Integer getCheckform() {
		return checkform;
	}

	public void setCheckform(Integer checkform) {
		this.checkform = checkform;
	}

	public String getExpect() {
		return expect;
	}

	public void setExpect(String expect) {
		this.expect = expect;
	}

	public Double getBloodpressure() {
		return bloodpressure;
	}

	public void setBloodpressure(Double bloodpressure) {
		this.bloodpressure = bloodpressure;
	}


	public Integer getHeartbeat() {
		return heartbeat;
	}

	public void setHeartbeat(Integer heartbeat) {
		this.heartbeat = heartbeat;
	}

	public Timestamp getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Timestamp createtime) {
		this.createtime = createtime;
	}
}
