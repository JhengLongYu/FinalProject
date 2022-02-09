package org.eeit131.group5.repository;

import java.util.List;

import org.eeit131.group5.model.Collect;

public interface CollectRepository {

	Collect findByArtIdUserId(Integer art_id, Integer collect_user_id);
	
	List<Collect> findByArtId(Integer art_id);
	
	List<Collect> findByUserId(Integer collect_user_id);

	void save(Collect collect);

	void delete(Integer collect_id);
	
	void delete(Collect collect);
	
	void merge(Collect collect);

}