package org.eeit131.group5.service;

import java.util.List;

import org.eeit131.group5.model.OrderDetails;

public interface OrderDetailsService {

	List<OrderDetails> findAll();
	
	List<OrderDetails> findByMemberId(Integer memberId);
	
	void save(OrderDetails orderDetails);
	
	OrderDetails findByOrderNo(Integer orderNo);
	
	void update(OrderDetails orderDetails);
	
	void delete(Integer orderNoValue);

	void updateStatus(Integer orderNo);
}
