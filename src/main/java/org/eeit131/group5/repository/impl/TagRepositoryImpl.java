package org.eeit131.group5.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;

import org.eeit131.group5.model.Tag;
import org.eeit131.group5.repository.TagRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TagRepositoryImpl implements TagRepository{
	
	@Autowired
	EntityManager entityManager;
	

	@Override
	public List<Tag> findAll(){
		String hql = "FROM Tag";
		return entityManager.createQuery(hql, Tag.class).getResultList();
	}
	

	@Override
	public Tag findById(Integer tag_id) {
		return entityManager.find(Tag.class, tag_id);
	}
	

	@Override
	public void save(Tag tag) {
		entityManager.persist(tag);
	}
	

	@Override
	public void delete(Integer tag_id) {
		Tag tag = entityManager.find(Tag.class, tag_id);
		entityManager.remove(tag);
	}
	

	@Override
	public void update(Integer tag_id, String tag_name) {
		Tag tag = entityManager.find(Tag.class, tag_id);
		tag.setTag_name(tag_name);
		entityManager.persist(tag);
	}

}
