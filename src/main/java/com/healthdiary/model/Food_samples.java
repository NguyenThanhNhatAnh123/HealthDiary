package com.healthdiary.model;

public class Food_samples {
    private int id;
    private String foodName;
    private String type;
    private int calories;
    private double protein;
    private double carbs;
    private double fat;

    // Default constructor
    public Food_samples() {
    }

    // Constructor with all fields except id
    public Food_samples(String foodName, String type, int calories, double protein, double carbs, double fat) {
        this.foodName = foodName;
        this.type = type;
        this.calories = calories;
        this.protein = protein;
        this.carbs = carbs;
        this.fat = fat;
    }

    // Constructor with all fields
    public Food_samples(int id, String foodName, String type, int calories, double protein, double carbs, double fat) {
        this.id = id;
        this.foodName = foodName;
        this.type = type;
        this.calories = calories;
        this.protein = protein;
        this.carbs = carbs;
        this.fat = fat;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getCalories() {
        return calories;
    }

    public void setCalories(int calories) {
        this.calories = calories;
    }

    public double getProtein() {
        return protein;
    }

    public void setProtein(double protein) {
        this.protein = protein;
    }

    public double getCarbs() {
        return carbs;
    }

    public void setCarbs(double carbs) {
        this.carbs = carbs;
    }

    public double getFat() {
        return fat;
    }

    public void setFat(double fat) {
        this.fat = fat;
    }

    @Override
    public String toString() {
        return "Food_samples{" +
                "id=" + id +
                ", foodName='" + foodName + '\'' +
                ", type='" + type + '\'' +
                ", calories=" + calories +
                ", protein=" + protein +
                ", carbs=" + carbs +
                ", fat=" + fat +
                '}';
    }
}