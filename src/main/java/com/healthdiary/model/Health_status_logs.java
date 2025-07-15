package com.healthdiary.model;

import java.util.Date;

public class Health_status_logs {
    private int id;
    private int userId;
    private String status;
    private Date logDate;

    // Default constructor
    public Health_status_logs() {
    }

    // Constructor with all fields except id
    public Health_status_logs(int userId, String status, Date logDate) {
        this.userId = userId;
        this.status = status;
        this.logDate = logDate;
    }

    // Constructor with all fields
    public Health_status_logs(int id, int userId, String status, Date logDate) {
        this.id = id;
        this.userId = userId;
        this.status = status;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getLogDate() {
        return logDate;
    }

    public void setLogDate(Date logDate) {
        this.logDate = logDate;
    }

    @Override
    public String toString() {
        return "Health_status_logs{" +
                "id=" + id +
                ", userId=" + userId +
                ", status='" + status + '\'' +
                ", logDate=" + logDate +
                '}';
    }
}