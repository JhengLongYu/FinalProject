package org.eeit131.group5.service;

import org.eeit131.group5.model.ConsultMail;

public interface ConsultMailService {
	void sendMail(ConsultMail mail);
	
	void sendMailWithAttachments(ConsultMail mail);
}
