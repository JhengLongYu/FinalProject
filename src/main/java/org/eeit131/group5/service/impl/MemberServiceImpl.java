package org.eeit131.group5.service.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.eeit131.group5.model.Member;
import org.eeit131.group5.repository.MemberRepository;
import org.eeit131.group5.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import net.bytebuddy.utility.RandomString;
@Service
@Transactional
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberRepository memberRepository;
	@Autowired
	private JavaMailSender mailSender;
	@Override
	public Member findById(Integer mbid) {
		return memberRepository.findById(mbid);
	}

	@Override
	public Member findByEmail(String mbemail) {
		return memberRepository.findByEmail(mbemail);
	}

	@Override
	public List<Member> findAll() {
		return memberRepository.findAll();
	}

	@Override
	public void save(Member member) {
		if(findByEmail(member.getMbemail())!=null) {
			throw new RuntimeException("帳號已存在，請更換新帳號");
		}
		member.setEnabled(false);
		String randomCode=RandomString.make(64);
		member.setVerifycode(randomCode);
		memberRepository.save(member);
	}

	@Override
	public void update(Member member) {
		memberRepository.update(member);

	}

	@Override
	public boolean delete(Integer mbid) {
	return	memberRepository.delete(mbid);
		
	}

	@Override
	public boolean verify(String verifycode) {
		Member member =memberRepository.findByVerifycode(verifycode);
		if(member==null||member.isEnabled()) {
			return false;
		}else {
			//設定權限為true
			member.setEnabled(true);
			return true;
		}
		
	}

	@Override
	public Member findByVerifycode(String verifycode) {
		return memberRepository.findByVerifycode(verifycode);
	
	}

	@Override
	public List<Member> findbyNameOrEmail(String keyword) {
		return memberRepository.findbyNameOrEmail(keyword);
	}

	
}
