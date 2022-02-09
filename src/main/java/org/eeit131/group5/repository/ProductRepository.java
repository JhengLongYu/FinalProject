package org.eeit131.group5.repository;

import java.util.List;

import org.eeit131.group5.model.Product;



public interface ProductRepository {
	
	List<Product> findAll();

	void save(Product product);

	void update(Product product);
	
	public Product findByProductId(Integer id);

	void delete(Integer idValue);

	List<Product> findByProductcategory(String category);

}
