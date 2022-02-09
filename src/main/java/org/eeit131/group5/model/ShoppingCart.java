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
@Table(name ="ShoppingCart")
public class ShoppingCart {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	Integer seqNo;
	Integer orderNo;
	Integer itemId;
	String description;
	Integer unitPrice;
	Integer qty;
	Integer memberId;
	@Transient
	Double totalAmount;
	@Transient
	String paymentMethod;
	
	@Transient
	private String fileDataUrl;
	
	private String mimeType;
	
	@JsonIgnore
	private Blob image;
	
	
	
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
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	
	
	public Integer getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(Integer seqNo) {
		this.seqNo = seqNo;
	}
	public Integer getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}
	public Integer getItemId() {
		return itemId;
	}
	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}
	public Integer getQty() {
		return qty;
	}
	public void setQty(Integer qty) {
		this.qty = qty;
	}
	public Double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ShoppingCart [seqNo=");
		builder.append(seqNo);
		builder.append(", orderNo=");
		builder.append(orderNo);
		builder.append(", itemId=");
		builder.append(itemId);
		builder.append(", description=");
		builder.append(description);
		builder.append(", unitPrice=");
		builder.append(unitPrice);
		builder.append(", qty=");
		builder.append(qty);
		builder.append(", memberId=");
		builder.append(memberId);
		builder.append("]");
		return builder.toString();
	}
	

	
	
	
}
