package org.eeit131.group5.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.eeit131.group5.model.OrderDetails;
import org.eeit131.group5.model.Product;
import org.eeit131.group5.model.ShoppingCart;
import org.eeit131.group5.repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class CartRepositoryImpl implements CartRepository{
	
	@Autowired
	EntityManager entityManager;
	
	public List<ShoppingCart>  findAll(){
		String hql = "FROM   ShoppingCart";
		List<ShoppingCart> all = entityManager.createQuery(hql, ShoppingCart.class)
				            .getResultList();
		return all;
	}
	
	
	
	public ShoppingCart findBySeqNo(Integer SeqNo) {
		String hql = "FROM ShoppingCart s WHERE s.seqNo = :seqNo";
		ShoppingCart shoppingCart = null;
		try {
			shoppingCart = entityManager.createQuery(hql, ShoppingCart.class)
		                          .setParameter("seqNo", SeqNo)
		                          .getSingleResult();
		} catch(NoResultException e) {
			;
		} catch(NonUniqueResultException e) {
			;
		}	
		return shoppingCart;
	}
	
	public List<ShoppingCart> findByMemberId(Integer memberId) {
		String hql = "FROM ShoppingCart s WHERE s.memberId = :memberId";
		List<ShoppingCart> shoppingCart = null;
		try {
			shoppingCart = entityManager.createQuery(hql, ShoppingCart.class)
		                          .setParameter("memberId", memberId)
		                          .getResultList();
		} catch(NoResultException e) {
			;
		} catch(NonUniqueResultException e) {
			;
		}	
		return shoppingCart;
	}
	public ShoppingCart findByItemId(Integer itemId) {
		String hql = "FROM ShoppingCart s WHERE s.itemId = :itemId";
		ShoppingCart shoppingCart = null;
		try {
			shoppingCart = entityManager.createQuery(hql, ShoppingCart.class)
		                          .setParameter("itemId", itemId)
		                          .getSingleResult();
		} catch(NoResultException e) {
			;
		} catch(NonUniqueResultException e) {
			;
		}	
		return shoppingCart;
	}
	
	@Override
	public void save(ShoppingCart shoppingCart) {
		entityManager.persist(shoppingCart);
		
	}
	
	@Override
	public void update(ShoppingCart shoppingCart) { 
		ShoppingCart ssss = entityManager.find(ShoppingCart.class,shoppingCart.getSeqNo());
		ssss.setQty(shoppingCart.getQty());
		entityManager.detach(shoppingCart);
		entityManager.merge(ssss);
	}

	@Override
	public void delete(Integer seqNoValue) {
		ShoppingCart shoppingCart = entityManager.find(ShoppingCart.class,seqNoValue);
		entityManager.remove(shoppingCart);		
	}

	@Override
	public void updateOrderNo(ShoppingCart sc) {
		ShoppingCart shoppingCart = entityManager.find(ShoppingCart.class,sc.getSeqNo());
		shoppingCart.setOrderNo(sc.getOrderNo());
		entityManager.detach(sc);
		entityManager.merge(shoppingCart);
	}



	@Override
	public List<ShoppingCart> findByOrderNo(Integer orderNo) {
		String hql = "FROM ShoppingCart sc WHERE sc.orderNo = :orderNo";
		List<ShoppingCart> shoppingCart = null;
		try {
			shoppingCart = entityManager
					.createQuery(hql, ShoppingCart.class)
					.setParameter("orderNo", orderNo)
					.getResultList();
		} catch(NoResultException e) {
			;
		} catch(NonUniqueResultException e) {
			;
		}	
		return shoppingCart;
	}
	
	public List<ShoppingCart> findByMemberIdWithoutON(Integer memberId) {
		String hql = "FROM ShoppingCart s WHERE s.memberId=:memberId AND s.orderNo=null";
		List<ShoppingCart> shoppingCart = null;
		try {
			shoppingCart = entityManager.createQuery(hql, ShoppingCart.class)
		                          .setParameter("memberId", memberId)
//		                          .setParameter("orderNo", null)
		                          .getResultList();
			System.out.println(shoppingCart.size());
		} catch(NoResultException e) {
			;
		} catch(NonUniqueResultException e) {
			;
		}	
		return shoppingCart;
	}
}
