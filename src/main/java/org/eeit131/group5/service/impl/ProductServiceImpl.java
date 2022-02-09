package org.eeit131.group5.service.impl;


import java.util.List;

import org.eeit131.group5.model.Product;
import org.eeit131.group5.repository.ProductRepository;
import org.eeit131.group5.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	ProductRepository  productRepository;

	@Override
	public List<Product> findAll() {
		return productRepository.findAll();
	}
    
	@Override
	public Product findByProductId(Integer id) {
		return productRepository.findByProductId(id);
	}
	
	@Override
	public List<Product> findByProductcategory(String category) {
		return productRepository.findByProductcategory(category);
	}

	@Override
	public void save(Product product) {
		productRepository.save(product);
	}



	@Override
	public void update(Product product) {
		productRepository.update(product);
		
	}
	
	@Override
	public void delete(Integer idValue) {
		productRepository.delete(idValue);
		
	}



}
