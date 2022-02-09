package org.eeit131.group5.service.impl;

import java.util.List;

import org.eeit131.group5.model.Tag;
import org.eeit131.group5.repository.TagRepository;
import org.eeit131.group5.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TagServiceImpl implements TagService {
	
	@Autowired
	TagRepository tagRespository;
	
	@Override
	public List<Tag> findAll(){
		return tagRespository.findAll();
	}
	
	@Override
	public Tag findById(Integer tag_id) {
		return tagRespository.findById(tag_id);
	}

	@Override
	public void save(Tag tag) {
		tagRespository.save(tag);
	}

	@Override
	public void delete(Integer tag_id) {
		tagRespository.delete(tag_id);
	}

	@Override
	public void update(Integer tag_id, String tag_name) {
		tagRespository.update(tag_id, tag_name);
	}
}
