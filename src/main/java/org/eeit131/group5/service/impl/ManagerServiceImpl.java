package org.eeit131.group5.service.impl;

import javax.transaction.Transactional;

import org.eeit131.group5.model.Manager;
import org.eeit131.group5.repository.ManagerRepository;
import org.eeit131.group5.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
@Transactional
public class ManagerServiceImpl implements ManagerService {
	@Autowired
	ManagerRepository managerRepository;

	@Override
	public Manager findById(Integer id) {
		return managerRepository.findById(id);
	}

	@Override
	public Manager findByName(String name) {
		return managerRepository.findByName(name);
	}

}
