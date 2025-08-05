package com.healthdiary.model;

public class Exercise_samples {
    private int id;
    private String exerciseName;
    private String type;
    private String muscleGroup;
    private String difficulty;
    private int caloriesPerHour;

    // Default constructor
    public Exercise_samples() {
    }

    // Constructor with all fields except id
    public Exercise_samples(String exerciseName, String type, String muscleGroup, String difficulty, int caloriesPerHour) {
        this.exerciseName = exerciseName;
        this.type = type;
        this.muscleGroup = muscleGroup;
        this.difficulty = difficulty;
        this.caloriesPerHour = caloriesPerHour;
    }

    // Constructor with all fields
    public Exercise_samples(int id, String exerciseName, String type, String muscleGroup, String difficulty, int caloriesPerHour) {
        this.id = id;
        this.exerciseName = exerciseName;
        this.type = type;
        this.muscleGroup = muscleGroup;
        this.difficulty = difficulty;
        this.caloriesPerHour = caloriesPerHour;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getMuscleGroup() {
        return muscleGroup;
    }

    public void setMuscleGroup(String muscleGroup) {
        this.muscleGroup = muscleGroup;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public int getCaloriesPerHour() {
        return caloriesPerHour;
    }

    public void setCaloriesPerHour(int caloriesPerHour) {
        this.caloriesPerHour = caloriesPerHour;
    }

    @Override
    public String toString() {
        return "Exercise_samples{" +
                "id=" + id +
                ", exerciseName='" + exerciseName + '\'' +
                ", type='" + type + '\'' +
                ", muscleGroup='" + muscleGroup + '\'' +
                ", difficulty='" + difficulty + '\'' +
                ", caloriesPerHour=" + caloriesPerHour +
                '}';
    }
}