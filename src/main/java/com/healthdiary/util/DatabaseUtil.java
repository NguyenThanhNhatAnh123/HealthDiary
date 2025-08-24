package com.healthdiary.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
    private static final String DB_URL = System.getenv("DB_URL") != null ? 
        System.getenv("DB_URL") : "jdbc:mysql://localhost:3306/health_diary";
    private static final String DB_USERNAME = System.getenv("DB_USERNAME") != null ? 
        System.getenv("DB_USERNAME") : "root";
    private static final String DB_PASSWORD = System.getenv("DB_PASSWORD") != null ? 
        System.getenv("DB_PASSWORD") : "123";
    
    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
    }
}
