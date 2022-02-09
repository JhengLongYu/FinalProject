package org.eeit131.group5.model;



import org.springframework.stereotype.Component;

@Component("food2")
public class Food2 {


	Integer foodid;


	String category;


	String name;

	String weight;

	Integer calorie;

	Double carbohydrates;

	Double fat;

	Double protein;
	
	Integer pkk;	
	
	public Integer getPkk() {
		return pkk;
	}

	public void setPkk(Integer pkk) {
		this.pkk = pkk;
	}

	@Override
	public String toString() {
		return "food ["
				+ "foodid=" + foodid + 
				", category=" + category + 
				", name=" + name +
				", weight=" + weight + 
				", calorie=" + calorie + 
				", carbohydrates=" + carbohydrates +
				", fat=" + fat + 
				", protein=" + protein+ 
				", pkk=" + pkk+ 
				"]";
	}

	public Integer getFoodid() {
		return foodid;
	}

	public void setFoodid(Integer foodid) {
		this.foodid = foodid;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	public Integer getCalorie() {
		return calorie;
	}

	public void setCalorie(Integer calorie) {
		this.calorie = calorie;
	}

	public Double getCarbohydrates() {
		return carbohydrates;
	}

	public void setCarbohydrates(Double carbohydrates) {
		this.carbohydrates = carbohydrates;
	}

	public Double getFat() {
		return fat;
	}

	public void setFat(Double fat) {
		this.fat = fat;
	}

	public Double getProtein() {
		return protein;
	}

	public void setProtein(Double protein) {
		this.protein = protein;
	}

}
