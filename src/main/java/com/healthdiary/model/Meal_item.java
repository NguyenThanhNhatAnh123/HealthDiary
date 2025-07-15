package com.healthdiary.model;

public class Meal_item {
    private int id;
    private int mealId;
    private String foodName;
    private int calories;
    private String image;
    // Default constructor
    public Meal_item() {
    }

    // Constructor with all fields except id
    public Meal_item(int mealId, String foodName, int calories,String image) {
        this.mealId = mealId;
        this.foodName = foodName;
        this.calories = calories;
        this.image = image;
    }

    // Constructor with all fields
    public Meal_item(int id, int mealId, String foodName, int calories,String image) {
        this.id = id;
        this.mealId = mealId;
        this.foodName = foodName;
        this.calories = calories;
        this.image = image;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMealId() {
        return mealId;
    }

    public void setMealId(int mealId) {
        this.mealId = mealId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public int getCalories() {
        return calories;
    }

    public void setCalories(int calories) {
        this.calories = calories;
    }
    
    public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Override
    public String toString() {
        return "Meal_item{" +
                "id=" + id +
                ", mealId=" + mealId +
                ", foodName='" + foodName + '\'' +
                ", calories=" + calories +
                '}';
    }
}