package org.eeit131.group5.repository.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.eeit131.group5.model.Member;
import org.eeit131.group5.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberRepositoryImpl implements MemberRepository {
	@Autowired
	EntityManager entityManager;

	@Override
	public Member findById(Integer mbid) {
		return entityManager.find(Member.class, mbid);
	}

	@Override
	public Member findByEmail(String mbemail) {
		String hql = "FROM Member m WHERE m.mbemail =:mbemail";
		Member member = null;
		try {
			member = entityManager.createQuery(hql, Member.class).setParameter("mbemail", mbemail).getSingleResult();
		} catch (NoResultException e) {
		} catch (NonUniqueResultException e) {
		}
		return member;
	}

	@Override
	public List<Member> findAll() {
		String hql = "FROM Member";
		return entityManager.createQuery(hql, Member.class).getResultList();
	}

	@Override
	public void save(Member member) {
		entityManager.persist(member);

	}

	@Override
	public void update(Member member) {
		Member member0 = findById(member.getMbid());

		if (member.getImage() == null && member.getMimeType() == null) {
			member.setImage(member0.getImage());
			member.setMimeType(member0.getMimeType());
		}
		// 如果帳號欄位為空，表示他在修改基本資料，就需要set給他member0的帳號密碼
		if (member.getMbemail() == null && member.getMbpassword() == null) {
			member.setMbemail(member0.getMbemail());
			member.setMbpassword(member0.getMbpassword());
		}
		// 因性別是一定有值，如果沒有值表示他在修改密碼頁面
		if (member.getGender() == null) {
			System.out.println("有進入判斷");
			member.setMbemail(member0.getMbemail());
			member.setMbname(member0.getMbname());
			member.setBirthday(member0.getBirthday());
			member.setGender(member0.getGender());
			member.setPhone(member0.getPhone());
			member.setAddress(member0.getAddress());
		}
		member.setEnabled(true);
		member.setCreateTime(member0.getCreateTime());

		entityManager.detach(member0);
		entityManager.merge(member);
	}

	@Override
	public boolean delete(Integer mbid) {
		Member member = entityManager.find(Member.class, mbid);
		entityManager.remove(member);
		return true;
	}

	@Override
	public Member findByVerifycode(String verifycode) {
		String hql = "FROM Member m WHERE m.verifycode =:verifycode";
		Member member = null;
		try {
			member = entityManager.createQuery(hql, Member.class).setParameter("verifycode", verifycode)
					.getSingleResult();
		} catch (NoResultException e) {
		} catch (NonUniqueResultException e) {
		}
		return member;
	}

	@Override
	public List<Member> findbyNameOrEmail(String keyword) {
		String hql = "FROM Member WHERE  CONCAT(mbname,'', mbemail) LIKE '%" + keyword + "%' ";
		List<Member> all = null;
		try {
			all=entityManager.createQuery(hql, Member.class).getResultList();
			//System.out.println("全部的東西在這"+all);
		} catch (NoResultException e) {
			e.printStackTrace();
		} catch (NonUniqueResultException e) {
			e.printStackTrace();
		}
		return all;
	}

}
