package com.healthdiary.model;

public class Exercise_samples {
    private int id;
    private String exerciseName;
    private int caloriesBurnedPerMin;

    // Default constructor
    public Exercise_samples() {
    }

    // Constructor with all fields except id
    public Exercise_samples(String exerciseName, int caloriesBurnedPerMin) {
        this.exerciseName = exerciseName;
        this.caloriesBurnedPerMin = caloriesBurnedPerMin;
    }

    // Constructor with all fields
    public Exercise_samples(int id, String exerciseName, int caloriesBurnedPerMin) {
        this.id = id;
        this.exerciseName = exerciseName;
        this.caloriesBurnedPerMin = caloriesBurnedPerMin;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getExerciseName() {
        return exerciseName;
    }

    public void setExerciseName(String exerciseName) {
        this.exerciseName = exerciseName;
    }

    public int getCaloriesBurnedPerMin() {
        return caloriesBurnedPerMin;
    }

    public void setCaloriesBurnedPerMin(int caloriesBurnedPerMin) {
        this.caloriesBurnedPerMin = caloriesBurnedPerMin;
    }

    @Override
    public String toString() {
        return "Exercise_samples{" +
                "id=" + id +
                ", exerciseName='" + exerciseName + '\'' +
                ", caloriesBurnedPerMin=" + caloriesBurnedPerMin +
                '}';
    }
}