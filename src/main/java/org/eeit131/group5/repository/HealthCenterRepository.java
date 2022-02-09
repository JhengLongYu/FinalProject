package org.eeit131.group5.repository;

import java.util.List;

import org.eeit131.group5.model.HealthCenter;
import org.eeit131.group5.model.Member;
import org.eeit131.group5.model.SportConsume;
import org.eeit131.group5.model.Food;
import org.eeit131.group5.model.FoodCenter;

public interface HealthCenterRepository {

	HealthCenter findByCenterId(Integer pk);

	List<HealthCenter> findAll();
	
	Member getname(Integer mbid);

	String save(HealthCenter healthCenter);

	HealthCenter findById(Integer idfrom);

	void update(HealthCenter healthCenter);

	void delete(Integer pk);

	List<HealthCenter> findByMemberId(String idfrom);

	List<Food> foodAll();

	List<Food> foodbyname(String eat);

	Food findbyfoodid(Integer id);

	String foodidsave(FoodCenter food);

	List<FoodCenter> getfoodCenter(String idfrom);

	void removefood(Integer pk);

	SportConsume findconsumebyname(String name);


	List<SportConsume> sportAll();

	public void updateCheckform(HealthCenter healthCenter);

	String sportsave(SportConsume sportConsume);

	void sportdeletee(Integer pk);

	SportConsume findsportBypk(Integer pk);

	String sportmerge(SportConsume sportConsume);

	String foodsave(Food food);

	void fooddelete(Integer foodid);

	String foodedit(Food food);


	

}
