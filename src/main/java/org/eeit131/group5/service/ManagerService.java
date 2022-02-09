package org.eeit131.group5.service;

import org.eeit131.group5.model.Manager;

public interface ManagerService {
	public Manager findById(Integer id);

	public Manager findByName(String name);

}
