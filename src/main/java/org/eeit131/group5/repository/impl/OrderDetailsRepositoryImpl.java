package org.eeit131.group5.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.eeit131.group5.model.OrderDetails;
import org.eeit131.group5.repository.OrderDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDetailsRepositoryImpl implements OrderDetailsRepository {
	
	@Autowired
	EntityManager entityManager;

	@Override
	public List<OrderDetails> findAll() {
		String hql = "FROM OrderDetails";
		return entityManager.createQuery(hql, OrderDetails.class).getResultList();
	}
	
	@Override
	public OrderDetails findByOrderNo(Integer orderNo) {
		String hql = "FROM OrderDetails od WHERE od.orderNo = :orderNo";
		OrderDetails orderDetails = null;
		try {
			orderDetails = entityManager
					.createQuery(hql, OrderDetails.class)
					.setParameter("orderNo", orderNo)
					.getSingleResult();
		} catch(NoResultException e) {
			;
		} catch(NonUniqueResultException e) {
			;
		}	
		return orderDetails;	}
	
	@Override
	public void save(OrderDetails orderDetails) {
		entityManager.persist(orderDetails);
	}
	
	@Override
	public List<OrderDetails> findByMemberId(Integer memberId) {
		String hql = "FROM OrderDetails od WHERE od.memberId = :memberId";
		List<OrderDetails> orderDetails = null;
		try {
			orderDetails = entityManager
					.createQuery(hql, OrderDetails.class)
					.setParameter("memberId", memberId)
					.getResultList();
		} catch(NoResultException e) {
			;
		} catch(NonUniqueResultException e) {
			;
		}	
		return orderDetails;
	}
	
	@Override
	public void update(OrderDetails orderDetails) {
		OrderDetails orderDetails0 = findByOrderNo(orderDetails.getOrderNo()); 
		orderDetails.setCreateTime(orderDetails0.getCreateTime());
		entityManager.detach(orderDetails0);
		entityManager.merge(orderDetails);
	}

	@Override
	public void delete(Integer orderNoValue) {
		OrderDetails orderDetails = entityManager.find(OrderDetails.class, orderNoValue);
		entityManager.remove(orderDetails);
	}

	@Override
	public void updateStatus(Integer orderNo) {
		OrderDetails orderDetails = entityManager.find(OrderDetails.class, orderNo);
//		String hql = "FROM OrderDetails od WHERE od.orderNo = :orderNo";
//		OrderDetails orderDetails = entityManager
//				.createQuery(hql, OrderDetails.class)
//				.setParameter("orderNo", orderNo)
//				.getSingleResult();
		OrderDetails od = new OrderDetails();
		od.setPaymentMethod("付款成功");
		od.setOrderNo(orderDetails.getOrderNo());
		od.setMemberId(orderDetails.getMemberId());
		od.setCreateTime(orderDetails.getCreateTime());
		od.setShippingAddress(orderDetails.getShippingAddress());
		od.setAmount(orderDetails.getAmount());
		entityManager.detach(orderDetails);
		entityManager.merge(od);
	}
}
