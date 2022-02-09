package org.eeit131.group5.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;

import org.eeit131.group5.model.Comment;
import org.eeit131.group5.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommentRepositoryImpl implements CommentRepository {
	
	@Autowired
	EntityManager entityManager;
	
	@Override
	public List<Comment> findCommentByArtId(Integer art_id){
		String hql = "FROM Comment WHERE art_id=:art_id ORDER BY com_create_time";
		List<Comment> list = entityManager.createQuery(hql, Comment.class)
										  .setParameter("art_id", art_id)
										  .getResultList();
		return list;
	}
	
	@Override
	public void save(Comment comment) {
		entityManager.persist(comment);
	}

	@Override
	public void delete(Integer com_id) {
		Comment comment = entityManager.find(Comment.class, com_id);
		entityManager.remove(comment);
	}

	@Override
	public void update(Comment comment) {
		Comment comment0 = entityManager.find(Comment.class, comment.getCom_id());
		entityManager.detach(comment0);
		entityManager.merge(comment);
	}
}
