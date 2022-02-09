package org.eeit131.group5.service.impl;

import java.util.List;

import org.eeit131.group5.model.OrderDetails;
import org.eeit131.group5.repository.OrderDetailsRepository;
import org.eeit131.group5.service.OrderDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OrderDetailsServiceImpl implements OrderDetailsService{
	
	@Autowired
	OrderDetailsRepository orderDetailsRepository;
	
	@Override
	public List<OrderDetails> findAll(){
		return orderDetailsRepository.findAll();
	}
	
	@Override
	public List<OrderDetails> findByMemberId(Integer memberId) {
		return orderDetailsRepository.findByMemberId(memberId);
	}

	@Override
	public void save(OrderDetails orderDetails) {
//		if (orderDetailsRepository.findByOrderNo(orderDetails.getOrderNo()) != null) {
//			throw new RuntimeException("訂單號碼錯誤，請重新確認");
//		}
		orderDetailsRepository.save(orderDetails);
	}

	@Override
	public OrderDetails findByOrderNo(Integer orderNo) {
		return orderDetailsRepository.findByOrderNo(orderNo);
	}

	@Override
	public void update(OrderDetails orderDetails) {
		orderDetailsRepository.update(orderDetails);
	}

	@Override
	public void delete(Integer orderNoValue) {
		orderDetailsRepository.delete(orderNoValue);
	}

	@Override
	public void updateStatus(Integer orderNo) {
		orderDetailsRepository.updateStatus(orderNo);
	}
	
}
