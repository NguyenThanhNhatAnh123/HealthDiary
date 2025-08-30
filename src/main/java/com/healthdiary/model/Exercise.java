package com.healthdiary.model;

import java.util.Date;

public class Exercise {
    private int id;
    private int user_id;
    private String exercise_type;
    private int duration_min;
    private Integer calories_burned;
    private Date log_date;


    public Exercise() {
    }

    
    public Exercise(int user_id, String exercise_type, int duration_min, Integer calories_burned, Date log_date) {
        this.user_id = user_id;
        this.exercise_type = exercise_type;
        this.duration_min = duration_min;
        this.calories_burned = calories_burned;
        this.log_date = log_date;
    }


    public Exercise(int id, int user_id, String exercise_type, int duration_min, Integer calories_burned, Date log_date) {
        this.id = id;
        this.user_id = user_id;
        this.exercise_type = exercise_type;
        this.duration_min = duration_min;
        this.calories_burned = calories_burned;
        this.log_date = log_date;
    }

  
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return user_id;
    }

    public void setUserId(int userId) {
        this.user_id = userId;
    }

    public String getExerciseType() {
        return exercise_type;
    }

    public void setExerciseType(String exerciseType) {
        this.exercise_type = exerciseType;
    }

    public int getDurationMin() {
        return duration_min;
    }

    public void setDurationMin(int durationMin) {
        this.duration_min = durationMin;
    }

    public Integer getCaloriesBurned() {
        return calories_burned;
    }

    public void setCaloriesBurned(Integer caloriesBurned) {
        this.calories_burned = caloriesBurned;
    }

    public Date getLogDate() {
        return log_date;
    }

    public void setLogDate(Date logDate) {
        this.log_date = logDate;
    }

  
}
