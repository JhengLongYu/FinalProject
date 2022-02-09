package org.eeit131.group5.service;

import java.util.List;

import org.eeit131.group5.model.Comment;

public interface CommentService {

	List<Comment> findCommentByArtId(Integer art_id);

	void save(Comment comment);
	
	void delete(Integer com_id);
	
	void update(Comment comment);
}