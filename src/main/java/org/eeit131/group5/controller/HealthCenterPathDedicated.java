package org.eeit131.group5.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HealthCenterPathDedicated {

	@GetMapping("/addMemberForm")
	public String addMemberForm(Model model) {
		return "healthcenter/_01/register";
	}

	@GetMapping("/test")
	public String testForm(Model model) {
		return "healthcenter/_01/test";
	}

	@GetMapping("/healthCenter")
	public String healthCenter(Model model) {
		return "healthcenter/_01/healthCenter";
	}

	@GetMapping("/healthCenterfrontpage")
	public String healthCenterfrontpage(Model model) {
		return "healthcenter/_01/healthCenterfrontpage";
	}

	@GetMapping("/healthCenterLogin")
	public String healthCenterLogin(Model model) {
		return "healthcenter/_01/healthCenterLogin";
	}
	
	@GetMapping("/healthCentercheck")
	public String bmi(Model model) {
		return "healthcenter/_01/bm/healthCentercheck";
	}
	
	@GetMapping("/bmr123")
	public String bmr(Model model) {
		return "healthcenter/_01/bm/bmr";
	}
	
	@GetMapping("/healthCenter/foods")
	public String food(Model model) {
		return "healthcenter/_01/food/search";
	}
	
	@GetMapping("/healthCenter/record2/")
	public String record2(Model model) {
		return "healthcenter/_01/food/record2";
	}
	
	@GetMapping("/healthCenter/consume/")
	public String consume(Model model) {
		return "healthcenter/_01/SportConsume/consume";
	}

}
