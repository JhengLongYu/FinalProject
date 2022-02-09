package org.eeit131.group5.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "Manager")
@Component("manager")
public class Manager {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Integer id;
	@Column(name = "NAME")
	private String name;
	@Column(name = "PASSWORD")
	private String password;
	public Integer getId() {
		return id;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Manager(String name, String password) {
		super();
		this.name = name;
		this.password = password;
	}
	public Manager(Integer id, String name, String password) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
	}
	public Manager() {
		super();
	}
	@Override
	public String toString() {
		return "Manager [id=" + id + ", name=" + name + ", password=" + password + "]";
	}
	
}
