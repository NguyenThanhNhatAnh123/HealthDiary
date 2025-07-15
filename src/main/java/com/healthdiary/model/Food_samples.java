package com.healthdiary.model;

public class Food_samples {
    private int id;
    private String foodName;
    private int calories;

    // Default constructor
    public Food_samples() {
    }

    // Constructor with all fields except id
    public Food_samples(String foodName, int calories) {
        this.foodName = foodName;
        this.calories = calories;
    }

    // Constructor with all fields
    public Food_samples(int id, String foodName, int calories) {
        this.id = id;
        this.foodName = foodName;
        this.calories = calories;
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

    public int getCalories() {
        return calories;
    }

    public void setCalories(int calories) {
        this.calories = calories;
    }

    @Override
    public String toString() {
        return "Food_samples{" +
                "id=" + id +
                ", foodName='" + foodName + '\'' +
                ", calories=" + calories +
                '}';
    }
}