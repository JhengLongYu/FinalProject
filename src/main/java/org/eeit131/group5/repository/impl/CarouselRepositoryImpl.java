package org.eeit131.group5.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;

import org.eeit131.group5.model.Carousel;
import org.eeit131.group5.repository.CarouselRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CarouselRepositoryImpl implements CarouselRepository {
	
	@Autowired
	EntityManager entityManager;
	
	@Override
	public List<Carousel> findAll(){
		String hql = "FROM Carousel";
		List<Carousel> list = entityManager.createQuery(hql, Carousel.class).getResultList();
		return list;
	}
	
	@Override
	public void save(Carousel carousel) {
		entityManager.persist(carousel);
	}
	
	@Override
	public void delete(Integer carousel_id) {
		Carousel carousel = entityManager.find(Carousel.class, carousel_id);
		entityManager.remove(carousel);
	}

	@Override
	public void detach(Carousel carousel) {
		entityManager.detach(carousel);
	}
}
