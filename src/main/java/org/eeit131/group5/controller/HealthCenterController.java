package org.eeit131.group5.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.eeit131.group5.model.Food;
import org.eeit131.group5.model.Food2;
import org.eeit131.group5.model.FoodCenter;
import org.eeit131.group5.model.HealthCalculate;
import org.eeit131.group5.model.HealthCenter;
import org.eeit131.group5.model.Member;
import org.eeit131.group5.model.SportConsume;
import org.eeit131.group5.service.HealthCenterService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
public class HealthCenterController {
	private static Logger log = LoggerFactory.getLogger(HealthCenterController.class);
	@Autowired
	HealthCenterService healthCenterService;

	@Autowired
	HealthCalculate healthCalculate;

	// 新刪改查
	@GetMapping("/healthCenter/getmembervalue/")
	public @ResponseBody HealthCenter gethealthCentervalue(@RequestParam("mbid") Integer mbid) {
		
		System.out.println("mbid = " + mbid);
		HealthCenter result = new HealthCenter();
		String result1 = "";
		try {
			System.out.println("+ result");
			result = healthCenterService.findById(mbid);
			
			return result ;
		} catch (Exception e) {
			return null ;
		}
	}

	@GetMapping("/insertCenter/getname/")
	public @ResponseBody String getname(@RequestParam("mbid") Integer mbid) {
		System.out.println("mbid = " + mbid);
		Member result = new Member();
		String result1 = "";
		try {
			result = healthCenterService.getname(mbid);
			result1 = result.getMbname();
		} catch (Exception e) {
			result1 = "";

		}
		return result1;
	}

	@PostMapping("/insertCenter")
	public @ResponseBody Map<String, String> save(@RequestBody HealthCenter healthCenter, Model m) {
		log.info("save()方法執行中...");
		Map<String, String> map = new HashMap<>();
		System.out.println("healthCenter = " + healthCenter);
		String result = "";
		try {
			result = healthCenterService.save(healthCenter);
			System.out.println("result = " + result);
			map.put("success", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}

	@PutMapping("/updateCenter/{pk}")
	public @ResponseBody Map<String, String> update(@RequestBody HealthCenter healthCenter, @PathVariable Integer pk) {
		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
			healthCenterService.update(healthCenter);
			System.out.println("healthCenter = " + healthCenter);
			result = "更新成功";
			map.put("success", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}

		return map;
	}

	@DeleteMapping("/deleteByPk/{pk}") //
	public @ResponseBody Map<String, String> deleteById(@PathVariable Integer pk) {
		Map<String, String> map = new HashMap<>();
		String result = "";
		try {

			healthCenterService.delete(pk);
			System.out.println("idfrom = " + pk);
			result = "刪除成功";
			map.put("success", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}

	// bmi bmr區

	@GetMapping("/healthCenter/bmi/{idfrom}")
	public @ResponseBody List<HealthCalculate> bmi(@PathVariable String idfrom, Model model) {

		List<HealthCenter> bmi = healthCenterService.findByMemberId(idfrom);
		List<HealthCalculate> events = new ArrayList<>();
		for (HealthCenter healthCenter : bmi) {
			HealthCalculate event = new HealthCalculate();
			Timestamp AA = healthCenter.getCreatetime();
			Long aa = AA.getTime();
			event.setDaytime(aa);
			Double height = healthCenter.getHeight();
			Double kg = healthCenter.getKg();
			Double y = height / 100;
			Double a = kg / y / y;
			Integer bmi1 = (int) Math.round(a);
//			System.out.print(kg+"/");
//			System.out.print(y+"/");
//			System.out.print(a+"/");
//			System.out.println(bmi1);
			event.setBmi(bmi1);
			events.add(event);

		}
		return events;
	}

	// bmr
	@GetMapping("/healthCenter/bmr/{idfrom}")
	public @ResponseBody List<HealthCalculate> bmr(@PathVariable String idfrom, Model model) {

		List<HealthCenter> bmr = healthCenterService.findByMemberId(idfrom);
		List<HealthCalculate> events = new ArrayList<>();
		for (HealthCenter healthCenter : bmr) {
			HealthCalculate event = new HealthCalculate();
			Timestamp AA = healthCenter.getCreatetime();
			Long aa = AA.getTime();
			event.setDaytime(aa);
			Double height = healthCenter.getHeight();
			Double kg = healthCenter.getKg();
			Integer age = healthCenter.getAge();
			String gender = healthCenter.getGender();
			Double age1 = (double) (age * 5);
			Double kg1 = kg * 10;
			Double height1 = height * 6.25;
			System.out.print(kg1 + "/");
			System.out.print(height1 + "/");
			System.out.println(age1 + "/");
			Double a = null;

			if (gender.equals("female")) {
				a = kg1 + height1 - age1 - 161;
				System.out.println(a);
			} else {
				a = kg1 + height1 - age1 + 5;
				System.out.println(a);
			}
			System.out.println(a);
			Integer bmr1 = (int) Math.round(a);

			event.setBmr(bmr1);
			events.add(event);

		}

		return events;
	}

	// kg
	@GetMapping("/healthCenter/kg/{idfrom}")
	public @ResponseBody List<HealthCalculate> kg(@PathVariable String idfrom, Model model) {
		List<HealthCenter> kg2 = healthCenterService.findByMemberId(idfrom);
		List<HealthCalculate> events = new ArrayList<>();
		for (HealthCenter healthCenter : kg2) {
			HealthCalculate event = new HealthCalculate();
			Timestamp AA = healthCenter.getCreatetime();
			Long aa = AA.getTime();
			event.setDaytime(aa);
			Double kg1 = healthCenter.getKg();
			Integer checkfrom = healthCenter.getCheckform();
			System.out.print(kg1 + "/");
			Integer kg = (int) Math.round(kg1);
			event.setCheckfrom(checkfrom);
			event.setKg(kg);
			System.out.println("event=" + event);
			events.add(event);

		}
		model.addAttribute("aa", "asd");

		return events;
	}

	// food區
	@GetMapping("/healthCenter/food/all/")
	public String foodAll(HttpServletRequest request, Model model) {
		String eat = request.getParameter("eat");

		if (eat.equals("")) {
			System.out.println("eat== " + eat);
			List<Food> food = healthCenterService.foodAll();
			model.addAttribute("foodlist", food);
			return "healthcenter/_01/food/foods";
		} else {
			List<Food> food = healthCenterService.foodbyname(eat);
			if (food != null) {
				model.addAttribute("foodlist", food);
				return "healthcenter/_01/food/foods";
			} else {
				return null;
			}

		}
	}

	@GetMapping("/healthCenter/food/all2/")
	public String foodAll2(Model model) {
		try {
			List<Food> food = healthCenterService.foodAll();
			model.addAttribute("foodlist", food);
			return "healthcenter/_01/food/foods";
		} catch (Exception e) {
			return null;
		}

	}

	// 登記健康表
	@GetMapping("/healthCenter/record") // 健康紀錄
	public String foodrecord(@RequestParam("foodid") Integer id, Model model) {

		Food food = healthCenterService.findbyfoodid(id);
		System.out.println(food);
		model.addAttribute("food", food);

		return "healthcenter/_01/food/record";
	}

	@GetMapping("/healthCenter/foodidsave") // 把食物id存進資料庫
	public @ResponseBody Map<String, String> foodidsave(@RequestParam("foodid") Integer foodid,
			@RequestParam("idfrom") String idfrom, Model model) {
		Map<String, String> map = new HashMap<>();
		String result = "";
		System.out.println("foodid = " + foodid);
		System.out.println("idfrom = " + idfrom);
		FoodCenter food = new FoodCenter();
		LocalDate today = LocalDate.now();

		try {
			food.setDate(today);
			food.setIdfrom(idfrom);
			food.setFoodid(foodid);
			System.out.println("food = " + food);

			result = healthCenterService.foodidsave(food);

			map.put("success", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}

		System.out.println("result = " + result);
		return map;
	}

	@GetMapping("/healthCenter/record5588/{mbid}") // 健康表區
	public String foodrecord2(@PathVariable String mbid, Model model) {

		String idfrom = mbid;
		List<FoodCenter> food = healthCenterService.getfoodCenter(idfrom);
		List<Food2> events = new ArrayList<>();
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy年MM月dd日");
		String toDay1 = sdFormatter.format(ts);
		LocalDate today = LocalDate.now();
		LocalDate todaytime = LocalDate.now();
		System.out.println("food = " + food);
		for (FoodCenter foodCenter : food) {
			System.out.println(foodCenter.getDate().equals(today));
			if (foodCenter.getDate().equals(today)) {
				Food event = healthCenterService.findbyfoodid(foodCenter.getFoodid());
				Food2 event2 = new Food2();
				System.out.println("foodCenter.getPk = " + foodCenter.getPk());
				int a = foodCenter.getPk();
				event2.setFoodid(event.getFoodid());
				event2.setCategory(event.getCategory());
				event2.setCalorie(event.getCalorie());
				event2.setName(event.getName());
				event2.setWeight(event.getWeight());
				event2.setCarbohydrates(event.getCarbohydrates());
				event2.setFat(event.getFat());
				event2.setProtein(event.getProtein());
				event2.setPkk(a);
				events.add(event2);
			}
			System.out.println("events = " + events);
		}

		int year = todaytime.getYear();
		int month = todaytime.getMonthValue();
		int day = todaytime.getDayOfMonth();
		int yday = day - 1;
		int tday = day + 1;
//		LocalDate yesterday = LocalDate.of(year, month, yday);
//		LocalDate tomorrow  = LocalDate.of(year, month, tday);
		LocalDate yesterday = todaytime.minusDays(1);
		LocalDate tomorrow = todaytime.plusDays(1);
		System.out.println("yesterday= " + yesterday);
		System.out.println("tomorrow= " + tomorrow);
		System.out.println("today = " + today);
		DayOfWeek week = today.getDayOfWeek();
		System.out.println("week = " + week);
		model.addAttribute("today", today);
		model.addAttribute("today1", toDay1);
		model.addAttribute("week", week);
		model.addAttribute("yesterday", yesterday);
		model.addAttribute("tomorrow", tomorrow);
		model.addAttribute("foodlist", events);
		return "healthcenter/_01/food/record2";
	}

	@GetMapping("/healthCenter/recordc") // 健康表區
	public String foodrecordc(@RequestParam("date") @DateTimeFormat(iso = ISO.DATE) LocalDate date,
			@RequestParam("mbid") String mbid, Model model) {

		String idfrom = mbid;
//		 System.out.println("idfrom = " + idfrom);
		List<FoodCenter> food = healthCenterService.getfoodCenter(idfrom);
		System.out.println("food = " + food);
		List<Food2> events = new ArrayList<>();
		for (FoodCenter foodCenter : food) {
			System.out.println(foodCenter.getDate().equals(date));
			if (foodCenter.getDate().equals(date)) {
				Food event = healthCenterService.findbyfoodid(foodCenter.getFoodid());
				Food2 event2 = new Food2();
				System.out.println("foodCenter.getPk = " + foodCenter.getPk());
				int a = foodCenter.getPk();
				event2.setFoodid(event.getFoodid());
				event2.setCategory(event.getCategory());
				event2.setCalorie(event.getCalorie());
				event2.setName(event.getName());
				event2.setWeight(event.getWeight());
				event2.setCarbohydrates(event.getCarbohydrates());
				event2.setFat(event.getFat());
				event2.setProtein(event.getProtein());
				event2.setPkk(a);
				System.out.println("event2 = " + event2);
				events.add(event2);

			}
			System.out.println("events = " + events);
		}
		System.out.println("events = " + events);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy年MM月dd日");
		String toDay1 = date.format(formatter);
//		System.out.println("data = " + date);
		int year = date.getYear();
		int month = date.getMonthValue();
		int day = date.getDayOfMonth();
		int yday = day - 1;
		int tday = day + 1;
		DayOfWeek week = date.getDayOfWeek();
//		LocalDate yesterday = LocalDate.of(year, month, yday);
//		LocalDate tomorrow  = LocalDate.of(year, month, tday);
		LocalDate yesterday = date.minusDays(1);
		LocalDate tomorrow = date.plusDays(1);
		model.addAttribute("today", date);
		model.addAttribute("today1", toDay1);
		model.addAttribute("week", week);
		model.addAttribute("yesterday", yesterday);
		model.addAttribute("tomorrow", tomorrow);
		model.addAttribute("foodlist", events);

		return "healthcenter/_01/food/record2";

	}

	@GetMapping("/healthCenter/food/recordc/remove/") // 刪除食物
	public String foodremove(@RequestParam Integer pk, Model model) {
		try {
			System.out.println("pk = " + pk);
			healthCenterService.removefood(pk);

			model.addAttribute("delete", "刪除成功");
			return "healthcenter/_01/food/record2";
		} catch (Exception e) {
			return "healthcenter/_01/food/record2";
		}

	}

	// food區結束

	// 健身卡洛里計算
	@GetMapping("/healthCenter/findconsumebyname/")
	public @ResponseBody Double findconsumebyname(@RequestParam("name") String name) {
		Map<String, Double> map = new HashMap<>();
		Double see = 1.1;
		System.out.println("name = " + name);
		try {
			SportConsume a = healthCenterService.findconsumebyname(name);
			see = a.getConsume();
			System.out.println("see = " + see);
			return see;
		} catch (Exception e) {
			return see;
		}

	}

	@GetMapping("/healthcenter/findAllsport")
	public @ResponseBody List<SportConsume> sportAll(Model model) {
		try {
			SportConsume a = new SportConsume();

			List<SportConsume> sportConsume = new ArrayList<>();
			sportConsume = healthCenterService.sportAll();
			System.out.println("找運動成功");
			return sportConsume;
		} catch (Exception e) {
			System.out.println("找運動失敗");
		}
		return null;

	}
}
