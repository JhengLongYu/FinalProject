package org.eeit131.group5.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.eeit131.group5.model.Product;
import org.eeit131.group5.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


@Repository
public class ProductRepositoryImpl implements ProductRepository{
	
	@Autowired
	EntityManager entityManager;
	private Object Category;
	
	@Override
	public List<Product>  findAll(){
		String hql = "FROM   Product";
		List<Product> all = entityManager.createQuery(hql, Product.class)
				            .getResultList();
		return all;
	}

	@Override
	public Product findByProductId(Integer Id) {
		String hql = "FROM Product p WHERE p.id = :id";
		Product product = null;
		try {
			product = entityManager.createQuery(hql, Product.class)
		                          .setParameter("id", Id)
		                          .getSingleResult();
		} catch(NoResultException e) {
			;
		} catch(NonUniqueResultException e) {
			;
		}	
		return product;
	}
	
	@Override
	public List<Product> findByProductcategory(String category) {
		String hql = "FROM Product p WHERE p.category = :category";
		List<Product> product = null;
		try {
			product = entityManager.createQuery(hql, Product.class)
					               .setParameter("category", category)
					               .getResultList();
		}catch(NoResultException e){
			;
		} catch(NonUniqueResultException e) {
			;
		}	
		return product;	
	}

	@Override
	public void save(Product product) {
		entityManager.persist(product);
		
	}


	@Override
	public void update(Product product) {
		Product product1 = findByProductId(product.getId());
		if(product.getPicture()==null && product.getMimeType()==null) {
			product.setPicture(product1.getPicture());
			product.setMimeType(product1.getMimeType());
		}
		entityManager.detach(product1);
		entityManager.merge(product);
	}

	@Override
	public void delete(Integer idValue) {
		Product product = entityManager.find(Product.class,idValue);
		entityManager.remove(product);
		
	}
	

}
