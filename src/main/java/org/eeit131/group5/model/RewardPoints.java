package org.eeit131.group5.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;
@Entity
@Table(name="rewardPoints")
@Component ("rewardPoints")
public class RewardPoints implements Serializable{
	private static final long serialVersionUID = 1L;
	@Id
	private Integer memberId;
	private Integer points;
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public Integer getPoints() {
		return points;
	}
	public void setPoints(Integer points) {
		this.points = points;
	}
	
	
}
