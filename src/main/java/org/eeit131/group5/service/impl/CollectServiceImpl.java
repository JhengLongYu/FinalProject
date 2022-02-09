package org.eeit131.group5.service.impl;

import java.util.List;

import org.eeit131.group5.model.Collect;
import org.eeit131.group5.repository.CollectRepository;
import org.eeit131.group5.service.CollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CollectServiceImpl implements CollectService {
	
	@Autowired
	CollectRepository collectRepository;
	
	@Override
	public Collect findByArtIdUserId(Integer art_id, Integer collect_user_id) {
		return collectRepository.findByArtIdUserId(art_id, collect_user_id);
	}

	@Override
	public List<Collect> findByArtId(Integer art_id){
		return collectRepository.findByArtId(art_id);
	}
	
	@Override
	public List<Collect> findByUserId(Integer collect_user_id) {
		return collectRepository.findByUserId(collect_user_id);
	}

	@Override
	public void save(Collect collect) {
		collectRepository.save(collect);
	}
	
	@Override
	public void delete(Integer collect_id) {
		collectRepository.delete(collect_id);
	}

	@Override
	public void delete(Collect collect) {
		collectRepository.delete(collect);
	}

	@Override
	public void merge(Collect collect) {
		collectRepository.merge(collect);
	}
	
}
