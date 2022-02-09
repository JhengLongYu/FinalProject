package org.eeit131.group5.repository.impl;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.eeit131.group5.model.Food;
import org.eeit131.group5.model.FoodCenter;
import org.eeit131.group5.model.HealthCenter;
import org.eeit131.group5.model.Instructors;
import org.eeit131.group5.model.Member;
import org.eeit131.group5.model.SportConsume;
import org.eeit131.group5.repository.HealthCenterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HealthCenterRepositoryImpl implements HealthCenterRepository {

	@Autowired
	EntityManager entityManager;

	@Override
	public HealthCenter findByCenterId(Integer pk) {
		String hql = "FROM 	HealthCenter m WHERE m.pk = :id";
		HealthCenter member = null;
		try {
			member = entityManager.createQuery(hql, HealthCenter.class).setParameter("id", pk).getSingleResult();
		} catch (NoResultException e) {
			;
		} catch (NonUniqueResultException e) {
			;
		}
		return member;
	}

	@Override
	public HealthCenter findById(Integer idfrom) {
		String hql = "FROM 	HealthCenter m WHERE m.idfrom =:id ";
		List<HealthCenter> members = new ArrayList<>();
		System.out.println("idfrom = " + idfrom);
		String f = String.valueOf(idfrom);
		HealthCenter memberasd = null;
		try {
			members = entityManager.createQuery(hql, HealthCenter.class).setParameter("id", f).getResultList();
			System.out.println("idfrom = " + idfrom);
			System.out.println("members = " + members);
			if (members.size() > 0) {
				for (int n = 0; n < members.size(); n++) {
					HealthCenter healthmember = members.get(n);
					memberasd = healthmember;

					System.out.println("member =" + memberasd);

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberasd;
	}

	@Override
	public List<HealthCenter> findAll() {
		String hql = "FROM 	HealthCenter";
		return entityManager.createQuery(hql, HealthCenter.class).getResultList();
	}

	// 食物區
	@Override
	public List<Food> foodAll() {
		String hql = "FROM 	Food";
		return entityManager.createQuery(hql, Food.class).getResultList();
	}

	@Override
	public List<Food> foodbyname(String eat) {

		String hql = "FROM Food  WHERE  CONCAT(category, ' ',name, ' ',weight) LIKE '%" + eat + "%'";
		System.out.println("777777777777777777777777");
		List<Food> food = entityManager.createQuery(hql, Food.class).getResultList();
		System.out.println("food  = " + food);
		if (food.size() != 0) {
			return food;
		}
		return null;
	}
	// 食物區

	// 新刪改查區

	@Override
	public Member getname(Integer mbid) {
		return entityManager.find(Member.class, mbid);
	}

	@Override
	public String save(HealthCenter healthCenter) {// 判斷日期區
		String a = healthCenter.getIdfrom();
		Integer b = Integer.parseInt(a);
		Member member1 = entityManager.find(Member.class, b);
		String idfrom = healthCenter.getIdfrom();
		String result = "";
		String hql = "FROM 	HealthCenter m WHERE m.idfrom = :id";
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		List<HealthCenter> member = null;
		member = entityManager.createQuery(hql, HealthCenter.class).setParameter("id", idfrom).getResultList();
		Integer pkstrong = 0;
		if (member.size() > 0) {
			for (int n = 0; n < member.size(); n++) {
				System.out.println(member.get(n));
				pkstrong = member.get(n).getPk();
				System.out.println("x8 8 " + pkstrong);
			}
			
			
			SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
			HealthCenter member0 = findByCenterId(pkstrong);
			Timestamp aday = member0.getCreatetime();
			String toDay1 = sdFormatter.format(aday);
			
			healthCenter.setCreatetime(ts);
			System.out.println(sdFormatter);
			String toDay = sdFormatter.format(ts);
			System.out.println(toDay);
			System.out.println(toDay1);
			System.out.println(toDay1.equals(toDay));

			if (toDay1.equals(toDay)) {
				member0.setAge(healthCenter.getAge());
				member0.setHeight(healthCenter.getHeight());
				member0.setKg(healthCenter.getKg());
				member0.setCheckform(member0.getCheckform());
				member0.setExpect(healthCenter.getExpect());
				member0.setBloodpressure(healthCenter.getBloodpressure());
				member0.setHeartbeat(healthCenter.getHeartbeat());
				member0.setCreatetime(healthCenter.getCreatetime());
				member0.setGender(member0.getGender());

				entityManager.merge(member0);
				System.out.println("member0=" + member0);
				result = "修改成功";
			} else {
				healthCenter.setGender(member0.getGender());
				healthCenter.setCheckform(healthCenter.getCheckform() + member0.getCheckform());
				healthCenter.setCreatetime(ts);
				entityManager.persist(healthCenter);
				result = "更新成功";
			}
		} else {
			healthCenter.setGender(member1.getGender());
			healthCenter.setCheckform(healthCenter.getCheckform());
			healthCenter.setCreatetime(ts);
			entityManager.persist(healthCenter);
			result = "新增成功";
		}
		return result;
	}

	@Override
	public void update(HealthCenter healthCenter) {

		HealthCenter member0 = findById(healthCenter.getPk());
		healthCenter.setCreatetime(member0.getCreatetime());
		healthCenter.setCheckform(member0.getCheckform() + healthCenter.getCheckform());

		entityManager.merge(healthCenter);

	}

	@Override
	public void delete(Integer pk) {
		String hql = "FROM 	HealthCenter m WHERE m.pk = :id";
		HealthCenter member = null;
		try {
			member = entityManager.createQuery(hql, HealthCenter.class).setParameter("id", pk).getSingleResult();
			entityManager.remove(member);
		} catch (NoResultException e) {
			;
		} catch (NonUniqueResultException e) {
			;
		}
	}

	@Override
	public List<HealthCenter> findByMemberId(String idfrom) {
		String hql = "FROM 	HealthCenter m WHERE m.idfrom = :id";
		return entityManager.createQuery(hql, HealthCenter.class).setParameter("id", idfrom).getResultList();
	}

	@Override
	public Food findbyfoodid(Integer id) {
		return entityManager.find(Food.class, id);
	}

	@Override
	public String foodidsave(FoodCenter food) {
		String result = "";
		try {
			entityManager.persist(food);
			result = "新增成功";

		} catch (Exception e) {
			result = "新增失敗";
		}
		return result;
	}

	@Override
	public List<FoodCenter> getfoodCenter(String idfrom) {
		String hql = "FROM FoodCenter m WHERE m.idfrom = :id ";
		return entityManager.createQuery(hql, FoodCenter.class).setParameter("id", idfrom).getResultList();

	}

	@Override
	public void removefood(Integer pk) {
		System.out.println("有近來");
		String hql = "FROM 	FoodCenter m WHERE m.pk =:id";
		FoodCenter foodcenter = null;
		try {

			foodcenter = entityManager.createQuery(hql, FoodCenter.class).setParameter("id", pk).getSingleResult();
			entityManager.remove(foodcenter);
			System.out.println("刪除成功");
		} catch (Exception e) {
			System.out.println("刪除失敗");
		}

	}

	@Override
	public SportConsume findconsumebyname(String name) {
		String hql = "FROM 	SportConsume m WHERE m.name = :name";
		return entityManager.createQuery(hql, SportConsume.class).setParameter("name", name).getSingleResult();
	}

	@Override
	public List<SportConsume> sportAll() {
		String hql = "FROM 	SportConsume";
		return entityManager.createQuery(hql, SportConsume.class).getResultList();
	}

	@Override
	public void updateCheckform(HealthCenter healthCenter) {
		HealthCenter member0 = findByCenterId(healthCenter.getPk());

		healthCenter.setAge(member0.getAge());
		healthCenter.setBloodpressure(member0.getBloodpressure());
//		healthCenter.setCheckform(member0.getCheckform());		
		healthCenter.setCreatetime(member0.getCreatetime());
		healthCenter.setExpect(member0.getExpect());
		healthCenter.setGender(member0.getGender());
		healthCenter.setHeartbeat(member0.getHeartbeat());
		healthCenter.setHeight(member0.getHeight());
		healthCenter.setIdfrom(member0.getIdfrom());
		healthCenter.setKg(member0.getKg());
		healthCenter.setName(member0.getName());
		entityManager.detach(member0);
		entityManager.merge(healthCenter);
	}

	@Override
	public String sportsave(SportConsume sportConsume) {
		String result = "";
		try {
			entityManager.persist(sportConsume);
			result = "新增成功";

		} catch (Exception e) {
			result = "新增失敗";
		}
		return result;
	}

	@Override
	public void sportdeletee(Integer pk) {
		String hql = "FROM 	SportConsume m WHERE m.pk = :id";
		SportConsume member = null;
		try {
			member = entityManager.createQuery(hql, SportConsume.class).setParameter("id", pk).getSingleResult();
			entityManager.remove(member);
		} catch (NoResultException e) {
			;
		} catch (NonUniqueResultException e) {
			;
		}

	}

	@Override
	public SportConsume findsportBypk(Integer pk) {
		return entityManager.find(SportConsume.class, pk);
	}

	@Override
	public String sportmerge(SportConsume sportConsume) {
		String result = "";
		try {
			entityManager.merge(sportConsume);
			result = "新增成功";

		} catch (Exception e) {
			result = "新增失敗";
		}
		return result;
	}

	@Override
	public String foodsave(Food food) {
		String result = "";
		System.out.println("repository food save = "+food);
		try {
			entityManager.persist(food);
			result = "新增成功";

		} catch (Exception e) {
			result = "新增失敗";
		}
		return result;
	}

	@Override
	public void fooddelete(Integer foodid) {
		String hql = "FROM 	Food m WHERE m.foodid = :id";
		Food food = null;
		try {
			food = entityManager.createQuery(hql, Food.class).setParameter("id", foodid).getSingleResult();
			entityManager.remove(food);
		} catch (NoResultException e) {
			;
		} catch (NonUniqueResultException e) {
			;
		}
	}

	@Override
	public String foodedit(Food food) {
		Food food0 = findbyfoodid(food.getFoodid());
		String result = "";
		try {
			if (food.getImage() == null && food.getMimeType() == null) {
				food.setImage(food0.getImage());
				food.setMimeType(food0.getMimeType());
			} else {

			}

			entityManager.detach(food0);
			entityManager.merge(food);
			result = "新增成功";

		} catch (Exception e) {
			result = "新增失敗";
		}
		return result;
	}

}
