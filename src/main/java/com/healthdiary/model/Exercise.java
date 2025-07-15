package com.healthdiary.model;

import java.util.Date;

public class Exercise {
    private int id;
    private int userId;
    private String exerciseType;
    private int durationMin;
    private Integer caloriesBurned;
    private Date logDate;


    public Exercise() {
    }

    
    public Exercise(int userId, String exerciseType, int durationMin, Integer caloriesBurned, Date logDate) {
        this.userId = userId;
        this.exerciseType = exerciseType;
        this.durationMin = durationMin;
        this.caloriesBurned = caloriesBurned;
        this.logDate = logDate;
    }


    public Exercise(int id, int userId, String exerciseType, int durationMin, Integer caloriesBurned, Date logDate) {
        this.id = id;
        this.userId = userId;
        this.exerciseType = exerciseType;
        this.durationMin = durationMin;
        this.caloriesBurned = caloriesBurned;
        this.logDate = logDate;
    }

  
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

    public String getExerciseType() {
        return exerciseType;
    }

    public void setExerciseType(String exerciseType) {
        this.exerciseType = exerciseType;
    }

    public int getDurationMin() {
        return durationMin;
    }

    public void setDurationMin(int durationMin) {
        this.durationMin = durationMin;
    }

    public Integer getCaloriesBurned() {
        return caloriesBurned;
    }

    public void setCaloriesBurned(Integer caloriesBurned) {
        this.caloriesBurned = caloriesBurned;
    }

    public Date getLogDate() {
        return logDate;
    }

    public void setLogDate(Date logDate) {
        this.logDate = logDate;
    }

    @Override
    public String toString() {
        return "Exercise{" +
                "id=" + id +
                ", userId=" + userId +
                ", exerciseType='" + exerciseType + '\'' +
                ", durationMin=" + durationMin +
                ", caloriesBurned=" + caloriesBurned +
                ", logDate=" + logDate +
                '}';
    }
}
