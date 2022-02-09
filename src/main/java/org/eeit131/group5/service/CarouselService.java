package org.eeit131.group5.service;

import java.util.List;

import org.eeit131.group5.model.Carousel;

public interface CarouselService {

	List<Carousel> findAll();

	void save(Carousel carousel);

	void delete(Integer carousel_id);
	
	void detach(Carousel carousel);

}