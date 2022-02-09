package org.eeit131.group5.service.impl;

import java.util.List;

import org.eeit131.group5.model.Comment;
import org.eeit131.group5.repository.CommentRepository;
import org.eeit131.group5.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	CommentRepository commentRepository;
	
	
	@Override
	public List<Comment> findCommentByArtId(Integer art_id){
		return commentRepository.findCommentByArtId(art_id);
	}

	@Override
	public void save(Comment comment) {
		commentRepository.save(comment);
	}

	@Override
	public void delete(Integer com_id) {
		commentRepository.delete(com_id);
	}

	@Override
	public void update(Comment comment) {
		commentRepository.update(comment);
	}
}
