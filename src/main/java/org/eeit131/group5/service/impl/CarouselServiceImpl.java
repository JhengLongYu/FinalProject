package org.eeit131.group5.service.impl;

import java.util.List;

import org.eeit131.group5.model.Carousel;
import org.eeit131.group5.repository.CarouselRepository;
import org.eeit131.group5.service.CarouselService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CarouselServiceImpl implements CarouselService {
	
	@Autowired
	CarouselRepository carouselRepository;
	
	@Override
	public List<Carousel> findAll(){
		return carouselRepository.findAll();
	}
	
	@Override
	public void save(Carousel carousel) {
		carouselRepository.save(carousel);
	}
	
	@Override
	public void delete(Integer carousel_id) {
		carouselRepository.delete(carousel_id);
	}

	@Override
	public void detach(Carousel carousel) {
		carouselRepository.detach(carousel);
	}
}
