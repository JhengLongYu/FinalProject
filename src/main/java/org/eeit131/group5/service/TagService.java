package org.eeit131.group5.service;

import java.util.List;

import org.eeit131.group5.model.Tag;

public interface TagService {

	List<Tag> findAll();

	Tag findById(Integer tag_id);

	void save(Tag tag);

	void delete(Integer tag_id);

	void update(Integer tag_id, String tag_name);

}