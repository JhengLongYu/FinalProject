package org.eeit131.group5.repository;

import org.eeit131.group5.model.Manager;

public interface ManagerRepository {
	Manager findByName(String name);

	Manager findById(Integer id);

}
