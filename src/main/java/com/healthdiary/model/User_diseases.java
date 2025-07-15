package com.healthdiary.model;

public class User_diseases {
    private int id;
    private int userId;
    private int diseaseId;

    // Default constructor
    public User_diseases() {
    }

    // Constructor with all fields except id
    public User_diseases(int userId, int diseaseId) {
        this.userId = userId;
        this.diseaseId = diseaseId;
    }

    // Constructor with all fields
    public User_diseases(int id, int userId, int diseaseId) {
        this.id = id;
        this.userId = userId;
        this.diseaseId = diseaseId;
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

    public int getDiseaseId() {
        return diseaseId;
    }

    public void setDiseaseId(int diseaseId) {
        this.diseaseId = diseaseId;
    }

    @Override
    public String toString() {
        return "User_diseases{" +
                "id=" + id +
                ", userId=" + userId +
                ", diseaseId=" + diseaseId +
                '}';
    }
}