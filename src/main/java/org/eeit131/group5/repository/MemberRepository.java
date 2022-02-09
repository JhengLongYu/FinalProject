package org.eeit131.group5.repository;

import java.util.List;

import org.eeit131.group5.model.Member;

public interface MemberRepository {
	
	public Member findById(Integer mbid);

	public Member findByEmail(String mbemail);

	public List<Member> findAll();

	public void save(Member member);

	public void update(Member member);

	public boolean delete(Integer mbid);
	
	public Member findByVerifycode(String verifycode);
	
	public List<Member> findbyNameOrEmail(String keyword);
}
