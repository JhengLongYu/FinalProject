package org.eeit131.group5.service.impl;

import java.util.List;

import org.eeit131.group5.model.HealthCenter;
import org.eeit131.group5.model.Member;
import org.eeit131.group5.model.SportConsume;
import org.eeit131.group5.model.Food;
import org.eeit131.group5.model.FoodCenter;
import org.eeit131.group5.repository.HealthCenterRepository;
import org.eeit131.group5.service.HealthCenterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sun.net.httpserver.Authenticator.Result;

@Service
@Transactional
public class HealthCenterServiceImpl implements HealthCenterService {

	@Autowired
	HealthCenterRepository healthCenterRepository;

//	@Override
//	public int save(HealthCenter member) {
//		Timestamp ts = new Timestamp(System.currentTimeMillis());
//		member.setCreatetime(ts);
//		
//		return 0;
//	}

	@Override
	public HealthCenter findByCenterId(Integer pk) {

		return healthCenterRepository.findByCenterId(pk);
	}

	@Override
	public HealthCenter findById(Integer idfrom) {

		return healthCenterRepository.findById(idfrom);
	}
	
	@Override
	public Member getname(Integer mbid) {
		return healthCenterRepository.getname(mbid);
	}

	@Override
	public String save(HealthCenter healthCenter) {
		return healthCenterRepository.save(healthCenter);

	}

	@Override
	public void update(HealthCenter healthCenter) {
		healthCenterRepository.update(healthCenter);

	}

	@Override
	public void delete(Integer pk) {
		healthCenterRepository.delete( pk);

	}

	@Override
	public List<HealthCenter> findByMemberId(String idfrom) {
		return healthCenterRepository.findByMemberId(idfrom);
		
	}	
	
	@Override
	public List<HealthCenter> findAll() {
		return healthCenterRepository.findAll();
	}

	@Override
	public List<Food> foodAll() {
		return healthCenterRepository.foodAll();
	}

	@Override
	public List<Food> foodbyname(String eat) {
		return healthCenterRepository.foodbyname(eat);
	}

	@Override
	public Food findbyfoodid(Integer id) {
		return healthCenterRepository.findbyfoodid(id);
	}

	@Override
	public String foodidsave(FoodCenter food) {
		return healthCenterRepository.foodidsave(food);
	}

	@Override
	public List<FoodCenter> getfoodCenter(String idfrom) {
		return healthCenterRepository.getfoodCenter(idfrom);
	}

	@Override
	public void removefood(Integer pk) {
		healthCenterRepository.removefood(pk);
		
	}

	@Override
	public SportConsume findconsumebyname(String name) {
		return healthCenterRepository.findconsumebyname(name);
	}

	@Override

	public List<SportConsume> sportAll() {
		return healthCenterRepository.sportAll();
	}




	public void updateCheckform(HealthCenter healthCenter) {
		healthCenterRepository.updateCheckform(healthCenter);
	}

	@Override
	public String sportsave(SportConsume sportConsume) {
		return healthCenterRepository.sportsave(sportConsume);
	}

	@Override
	public void sportdelete(Integer pk) {
		healthCenterRepository.sportdeletee( pk);	
	}

	@Override
	public SportConsume findsportBypk(Integer pk) {
		return healthCenterRepository.findsportBypk(pk);
	}

	@Override
	public String sportmerge(SportConsume sportConsume) {
		return healthCenterRepository.sportmerge(sportConsume);
	}

	@Override
	public String foodsave(Food food) {
		return healthCenterRepository.foodsave(food);
	}

	@Override
	public void fooddelete(Integer foodid) {
		healthCenterRepository.fooddelete( foodid);
	}

	@Override
	public String foodedit(Food food) {
		return healthCenterRepository.foodedit(food);
	}
}
