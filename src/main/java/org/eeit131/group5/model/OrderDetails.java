package org.eeit131.group5.model;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name="OrderDetails")
public class OrderDetails {
	@Id
	Integer orderNo;
	Integer memberId;
	Double amount;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone="Asia/Taipei")
	Timestamp createTime;
	String paymentMethod;
	String	shippingAddress; 

	
	public OrderDetails() {
	}
	
	public OrderDetails( 
			Integer orderNo,
			Integer memberId, 
			Double amount, 
			Timestamp createTime,
			String paymentMethod,
			String	shippingAddress) {
		super();
		this.orderNo = orderNo;
		this.memberId = memberId;
		this.amount = amount;
		this.createTime = createTime;
		this.paymentMethod = paymentMethod;
		this.shippingAddress = shippingAddress;
	}
	
	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	
	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	
	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}

	@Override
	public String toString() {
		return "OrderDetails [orderNo=" + orderNo + ", paymentMethod=" + paymentMethod + ", shippingAddress=" + shippingAddress + ", memberId="
				+ memberId + ", amount=" + amount + "]";
	}
		
}
