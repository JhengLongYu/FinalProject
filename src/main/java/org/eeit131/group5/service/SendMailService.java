package org.eeit131.group5.service;

import javax.mail.MessagingException;

import org.eeit131.group5.model.Mail;

public interface SendMailService {
    void sendMail(Mail mail);

    void sendMailWithAttachments(Mail mail) throws MessagingException;
}
