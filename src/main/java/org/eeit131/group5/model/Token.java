package org.eeit131.group5.model;

import org.springframework.stereotype.Component;

@Component("token")
public class Token {
private String token;

public String getToken() {
	return token;
}

public void setToken(String token) {
	this.token = token;
}

}
