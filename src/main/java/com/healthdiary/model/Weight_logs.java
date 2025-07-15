package com.healthdiary.model;

import java.util.Date;

public class Weight_logs {
    private int id;
    private int userId;
    private float weightKg;
    private Date logDate;

    // Default constructor
    public Weight_logs() {
    }

    // Constructor with all fields except id
    public Weight_logs(int userId, float weightKg, Date logDate) {
        this.userId = userId;
        this.weightKg = weightKg;
        this.logDate = logDate;
    }

    // Constructor with all fields
    public Weight_logs(int id, int userId, float weightKg, Date logDate) {
        this.id = id;
        this.userId = userId;
        this.weightKg = weightKg;
        this.logDate = logDate;
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

    public float getWeightKg() {
        return weightKg;
    }

    public void setWeightKg(float weightKg) {
        this.weightKg = weightKg;
    }

    public Date getLogDate() {
        return logDate;
    }

    public void setLogDate(Date logDate) {
        this.logDate = logDate;
    }

    @Override
    public String toString() {
        return "Weight_logs{" +
                "id=" + id +
                ", userId=" + userId +
                ", weightKg=" + weightKg +
                ", logDate=" + logDate +
                '}';
    }
}