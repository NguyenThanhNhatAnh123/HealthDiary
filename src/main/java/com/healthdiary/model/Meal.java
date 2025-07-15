package com.healthdiary.model;

import java.util.Date;

public class Meal {
    private int id;
    private int userId;
    private String mealTime; // enum: 'sáng', 'trưa', 'tối'
    private Date logDate;
    private Integer totalCalories;

    // Default constructor
    public Meal() {
    }

    // Constructor with all fields except id
    public Meal(int userId, String mealTime, Date logDate, Integer totalCalories) {
        this.userId = userId;
        this.mealTime = mealTime;
        this.logDate = logDate;
        this.totalCalories = totalCalories;
    }

    // Constructor with all fields
    public Meal(int id, int userId, String mealTime, Date logDate, Integer totalCalories) {
        this.id = id;
        this.userId = userId;
        this.mealTime = mealTime;
        this.logDate = logDate;
        this.totalCalories = totalCalories;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getMealTime() {
        return mealTime;
    }

    public void setMealTime(String mealTime) {
        this.mealTime = mealTime;
    }

    public Date getLogDate() {
        return logDate;
    }

    public void setLogDate(Date logDate) {
        this.logDate = logDate;
    }

    public Integer getTotalCalories() {
        return totalCalories;
    }

    public void setTotalCalories(Integer totalCalories) {
        this.totalCalories = totalCalories;
    }

    @Override
    public String toString() {
        return "Meal{" +
                "id=" + id +
                ", userId=" + userId +
                ", mealTime='" + mealTime + '\'' +
                ", logDate=" + logDate +
                ", totalCalories=" + totalCalories +
                '}';
    }
}