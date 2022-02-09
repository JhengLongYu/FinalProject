package org.eeit131.group5.service.impl;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.eeit131.group5.model.ConsultMail;
import org.eeit131.group5.service.ConsultMailService;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class ConsultMailServiceImpl implements ConsultMailService {
	 private final JavaMailSender javaMailSender;
	
	 
	public ConsultMailServiceImpl(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}

	@Override
	public void sendMail(ConsultMail mail) {
		SimpleMailMessage msg = new SimpleMailMessage();
		msg.setTo(mail.getRecipient());
		msg.setSubject(mail.getSubject());
		msg.setText(mail.getMessage());
		
		javaMailSender.send(msg);
	
	
	}

	@Override
	public void sendMailWithAttachments(ConsultMail mail) {
		MimeMessage msg = javaMailSender.createMimeMessage();
		MimeMessageHelper helper;
		try {
			helper = new MimeMessageHelper(msg, true);
			helper.setTo(mail.getRecipient());
			helper.setSubject(mail.getSubject());
			helper.setText(mail.getMessage());
			helper.addAttachment("images/consult.jpg", new ClassPathResource("static/images/consult.jpg"));
			
			javaMailSender.send(msg);
		
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
	
	}

}
