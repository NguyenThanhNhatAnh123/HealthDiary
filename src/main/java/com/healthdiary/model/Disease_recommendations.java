package com.healthdiary.model;

public class Disease_recommendations {
    private int id;
    private String diseaseName;
    private String recommendedFood;
    private String recommendedExercise;

    // Default constructor
    public Disease_recommendations() {
    }

    // Constructor with all fields except id
    public Disease_recommendations(String diseaseName, String recommendedFood, String recommendedExercise) {
        this.diseaseName = diseaseName;
        this.recommendedFood = recommendedFood;
        this.recommendedExercise = recommendedExercise;
    }

    // Constructor with all fields
    public Disease_recommendations(int id, String diseaseName, String recommendedFood, String recommendedExercise) {
        this.id = id;
        this.diseaseName = diseaseName;
        this.recommendedFood = recommendedFood;
        this.recommendedExercise = recommendedExercise;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDiseaseName() {
        return diseaseName;
    }

    public void setDiseaseName(String diseaseName) {
        this.diseaseName = diseaseName;
    }

    public String getRecommendedFood() {
        return recommendedFood;
    }

    public void setRecommendedFood(String recommendedFood) {
        this.recommendedFood = recommendedFood;
    }

    public String getRecommendedExercise() {
        return recommendedExercise;
    }

    public void setRecommendedExercise(String recommendedExercise) {
        this.recommendedExercise = recommendedExercise;
    }

    @Override
    public String toString() {
        return "Disease_recommendations{" +
                "id=" + id +
                ", diseaseName='" + diseaseName + '\'' +
                ", recommendedFood='" + recommendedFood + '\'' +
                ", recommendedExercise='" + recommendedExercise + '\'' +
                '}';
    }
}