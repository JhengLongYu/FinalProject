package org.eeit131.group5.repository;

import java.util.List;

import org.eeit131.group5.model.Product;
import org.eeit131.group5.model.ShoppingCart;

public interface CartRepository {
	List<ShoppingCart> findAll();
	
    ShoppingCart findBySeqNo(Integer SeqNo) ;
    
    void save(ShoppingCart shoppingCart);
    
    void update(ShoppingCart shoppingCart);
    
    void delete(Integer seqNoValue);
    
    List<ShoppingCart> findByMemberId(Integer memberId);
    
    ShoppingCart findByItemId(Integer itemId);

	void updateOrderNo(ShoppingCart sc);

	List<ShoppingCart> findByOrderNo(Integer orderNo);
	
    List<ShoppingCart> findByMemberIdWithoutON(Integer memberId);

    


}
