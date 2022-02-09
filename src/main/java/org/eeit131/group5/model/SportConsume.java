package org.eeit131.group5.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "SportConsume")
public class SportConsume {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "pk")
	Integer pk;

	@Column(name = "name")
	String name;
	@Column(name = "consume")
	Double consume;

	@Override
	public String toString() {
		return "Sports [pk=" + pk +
				", name=" + name +
				", consume=" + consume 
				+ "]";
	}

	public Integer getPk() {
		return pk;
	}

	public void setPk(Integer pk) {
		this.pk = pk;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Double getConsume() {
		return consume;
	}

	public void setConsume(Double consume) {
		this.consume = consume;
	}


}
