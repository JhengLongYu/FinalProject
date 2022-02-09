package org.eeit131.group5.controller;

import java.sql.SQLException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.eeit131.group5.model.Food;
import org.eeit131.group5.model.HealthCalculate;
import org.eeit131.group5.model.HealthCenter;
import org.eeit131.group5.model.SportConsume;
import org.eeit131.group5.service.HealthCenterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HealthCenter_Back {

	@Autowired
	HealthCenterService healthCenterService;

	@Autowired
	HealthCalculate healthCalculate;

	@Autowired
	ServletContext ctx;

	// 後端跳轉新增食物
	@GetMapping("/CenterBack/foods/save")
	public String foodgoregister() {
		return "healthcenter/_01/center_back/food-register";
	}

	// 後端跳轉新增食物
	@GetMapping("/CenterBack/sports/save")
	public String sportgoregister() {
		return "healthcenter/_01/center_back/sport-register";
	}

	// 把後端新增食物
	@PostMapping(value = "/CenterBack/sportsave/go", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String sportregister(@RequestBody SportConsume sportConsume, Model model) {
		String result = "";
		try {
			if (sportConsume.getName() != "") {
				if (sportConsume.getConsume() != null) {
			System.out.println("SportConsume =" + sportConsume);
			String asd = healthCenterService.sportsave(sportConsume);
			result = "更新成功";
			System.out.println("asd =" + asd);
				}
			}
		} catch (Exception e) {
			result = "更新失敗";
		}
		return result;
	}

	// 把後端新增食物
	@PostMapping(value = "/CenterBack/sportmerge/go", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String sporteditmerge(@RequestBody SportConsume sportConsume, Model model) {
		String result = "";
		try {
			System.out.println("SportConsume =" + sportConsume);
			if (sportConsume.getName() != "") {
				if (sportConsume.getConsume() != null) {
				String asd = healthCenterService.sportmerge(sportConsume);
				result = "更新成功";
				System.out.println("asd =" + asd);
				}
			}
		} catch (Exception e) {
			result = "更新失敗";
		}
		return result;
	}

	// 把後端新增食物
	@PostMapping(value = "/CenterBack/foodsave/go", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String foodregister(@RequestBody Food food, Model model) {
//		System.out.println(" food123 " );
		System.out.println("food =" + food);
		String result = "";
	
		if (food.getFileDataUrl() != null) {
			Integer startIndex = "data:".length();
			Integer endIndex = food.getFileDataUrl().indexOf(";");
			String mimeType =  food.getFileDataUrl().substring(startIndex, endIndex);
			String base64 =    food.getFileDataUrl().substring(food.getFileDataUrl().indexOf(",") + 1);
			byte[] a = Base64.getDecoder().decode(base64);
			try {
				food.setImage(new SerialBlob(a));
			} catch (SerialException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			food.setMimeType(mimeType);
		} else {
			food.setImage(null);
			food.setMimeType(null);
		}
		try {
			System.out.println("contoller foodsave = "+food);
			healthCenterService.foodsave(food);
			result = "更新成功";
			
		} catch (Exception e) {
			result = "更新失敗";
		}
		return result;
	}
	
	// 把後端新增食物
		@PostMapping(value = "/CenterBack/foodedit/go", produces = { "application/json; charset=UTF-8" })
		public @ResponseBody String foodeditgo(@RequestBody Food food, Model model) {
//			System.out.println(" food123 " );
			System.out.println("food =" + food);
			String result = "";
		
			if (food.getFileDataUrl() != null) {
				Integer startIndex = "data:".length();
				Integer endIndex = food.getFileDataUrl().indexOf(";");
				String mimeType =  food.getFileDataUrl().substring(startIndex, endIndex);
				String base64 =    food.getFileDataUrl().substring(food.getFileDataUrl().indexOf(",") + 1);
				byte[] a = Base64.getDecoder().decode(base64);
				try {
					food.setImage(new SerialBlob(a));
				} catch (SerialException e) {
					e.printStackTrace();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				food.setMimeType(mimeType);
			} else {
				food.setImage(null);
				food.setMimeType(null);
			}
			try {

				healthCenterService.foodedit(food);
				result = "更新成功";
				
			} catch (Exception e) {
				result = "更新失敗";
			}
			return result;
		}

// 把後端會員跑出來	
	@GetMapping("/CenterBack/foods/savex")
	public @ResponseBody HealthCenter findByMemberId(@RequestParam("pk") Integer pk) {
		return healthCenterService.findByCenterId(pk);
	}

	@GetMapping("/healthCenter/member/{id}") // showallmember的
	public @ResponseBody HealthCenter findById(@PathVariable Integer idfrom) {
		return healthCenterService.findById(idfrom);
	}

	// 後台控制台
	@GetMapping("/CenterBack/sports") // 後端sport全部資料
	public @ResponseBody List<SportConsume> sportfindAll() {
		return healthCenterService.sportAll();
	}

	@GetMapping("/_01/CenterBack/Allsports") // 後端sport全部資料
	public String getsportall(Model model) {
//		List<SportConsume> members = healthCenterService.sportAll();
//		model.addAttribute("members123", members);
		return "healthcenter/_01/center_back/sportall";
	}

	@GetMapping("/CenterBack/foods") // 後端食物全部資料
	public @ResponseBody List<Food> findAll() {
		return healthCenterService.foodAll();
	}

	@GetMapping("/_01/showAllMembers") // 後端食物全部資料
	public String gethealthCenterall(Model model) {
		List<HealthCenter> members = healthCenterService.findAll();
		model.addAttribute("members123", members);
		return "healthcenter/_01/showAllMembers";
	}

	@GetMapping("/healthCenter/editForm") // showallmember的修改
	public String sendEditForm(@RequestParam("pk") Integer pk, Model model) {

		model.addAttribute("idid", pk);

		return "healthcenter/_01/center_back/foodedit";
	}

	@GetMapping("/healthCenter/sport/editForm") // sport的修改
	public String sportEditForm(@RequestParam("pk") Integer pk, Model model) {

		model.addAttribute("idid", pk);

		return "healthcenter/_01/center_back/sport-edit";
	}

	@GetMapping("/healthCenter/CenterBack/sportget/") // sport的修改取資料
	public @ResponseBody SportConsume sportEdit(@RequestParam("pk") Integer pk, Model model) {
		Map<String, String> map = new HashMap<>();
		Map<String, Double> map1 = new HashMap<>();
		SportConsume sportConsume = new SportConsume();
		try {
			sportConsume = healthCenterService.findsportBypk(pk);
			return sportConsume;
		} catch (Exception e) {
			return null;
		}
	}
	
	@GetMapping("/healthCenter/CenterBack/foodget/") // food的修改取資料
	public @ResponseBody Food foodEditget(@RequestParam("foodid") Integer foodid, Model model) {
		Map<String, String> map = new HashMap<>();
		Map<String, Double> map1 = new HashMap<>();
		Food food = new Food();
		try {
			food = healthCenterService.findbyfoodid(foodid);
			return food ;
		} catch (Exception e) {
			return null;
		}
	}
	
	

	@GetMapping("/healthCenter/food/delete") // showallmember的刪除
	public String deleteForm(@RequestParam("foodid") Integer foodid, Model model) {
		try {
			healthCenterService.fooddelete(foodid);
			System.out.println(foodid);
			model.addAttribute("delete", "刪除成功");
			return "healthcenter/_01/showAllMembers";
		} catch (Exception e) {
			return "healthcenter/_01/showAllMembers";
		}

	}

	@GetMapping("/healthCenter/sport/delete") // sport的刪除
	public String deletesport(@RequestParam("pk") Integer pk, Model model) {
		try {
			healthCenterService.sportdelete(pk);
			System.out.println(pk);
			model.addAttribute("delete", "刪除成功");
			return "healthcenter/_01/center_back/sportall";
		} catch (Exception e) {
			return "healthcenter/_01/center_back/sportall";
		}

	}

}
