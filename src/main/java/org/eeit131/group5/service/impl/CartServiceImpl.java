package org.eeit131.group5.service.impl;

import java.util.List;

import org.eeit131.group5.model.Product;
import org.eeit131.group5.model.ShoppingCart;
import org.eeit131.group5.repository.CartRepository;
import org.eeit131.group5.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CartServiceImpl implements CartService {

	@Autowired
	CartRepository cartrepository;

	@Override
	public List<ShoppingCart> findAll() {
		return cartrepository.findAll();
	}

	@Override
	public ShoppingCart findBySeqNo(Integer seqNo) {
		return cartrepository.findBySeqNo(seqNo);
	}
	
	@Override
	public List<ShoppingCart> findByMemberId(Integer memberId) {
		return cartrepository.findByMemberId(memberId);
	}
	
	@Override
	public ShoppingCart findByItemId(Integer itemId) {
		return cartrepository.findByItemId(itemId);
	}
	
	@Override
	public void save(ShoppingCart shoppingCart) {
		cartrepository.save(shoppingCart);
	}
	
	@Override
	public void update(ShoppingCart shoppingCart) {
		cartrepository.update(shoppingCart);
		
	}
	
	@Override
	public void delete(Integer seqNoValue) {
		cartrepository.delete(seqNoValue);
	}

	@Override
	public void updateOrderNo(ShoppingCart sc) {
		cartrepository.updateOrderNo(sc);
	}

	@Override
	public List<ShoppingCart> findByOrderNo(Integer orderNo) {
		return cartrepository.findByOrderNo(orderNo);
	}

	@Override
	public List<ShoppingCart> findByMemberIdWithoutON(Integer memberId) {
		return cartrepository.findByMemberIdWithoutON(memberId);
	}
	


}