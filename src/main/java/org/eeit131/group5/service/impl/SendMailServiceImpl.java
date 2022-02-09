package org.eeit131.group5.service.impl;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.eeit131.group5.model.Mail;
import org.eeit131.group5.service.SendMailService;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
@Service
public class SendMailServiceImpl implements SendMailService {
	  private final JavaMailSender javaMailSender;	  
	  public SendMailServiceImpl(JavaMailSender javaMailSender) {
	        this.javaMailSender = javaMailSender;
	    }
	  
	@Override
	public void sendMail(Mail mail) {
		 SimpleMailMessage msg = new SimpleMailMessage();
	        msg.setTo(mail.getRecipient());
	        msg.setSubject(mail.getSubject());
	        msg.setText(mail.getMessage());
	        javaMailSender.send(msg);
	}

	@Override
	public void sendMailWithAttachments(Mail mail) throws MessagingException {
		 MimeMessage msg = javaMailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(msg, true);
	        helper.setTo(mail.getRecipient());
	        helper.setSubject("這是一封測試信");
	        helper.setText("Find the attached image", true);
	        helper.addAttachment("images/2.jpg", new ClassPathResource("static/images/2.jpg"));
	        javaMailSender.send(msg);
	}

}
