package com.healthdiary.service;

import com.healthdiary.dao.UserDAO;
import com.healthdiary.model.User;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class AuthService {
    private UserDAO userDAO;

    public AuthService() {
        this.userDAO = new UserDAO();
    }
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            return password; 
        }
    }

    // Register new user
    public boolean registerUser(String fullName, String email, String password,
            Integer age, String gender, Float heightCm,
            Float weightKg, String goal) throws Exception {

        // Check if email already exists
        if (userDAO.emailExists(email)) {
            return false;
        }

        // Hash password
        String passwordHash = hashPassword(password);

        // Create user object
        User user = new User(fullName, email, passwordHash);
        user.setAge(age);
        user.setGender(gender);
        user.setHeightCm(heightCm);
        user.setWeightKg(weightKg);
        user.setGoal(goal);

        // Save to database
        return userDAO.createUser(user);
    }

    // Login user
    public User loginUser(String email, String password) throws Exception {
        User user = userDAO.getUserByEmail(email);

        if (user != null && hashPassword(password).equals(user.getPasswordHash())) {
            return user;
        }

        return null;
    }

    // Update user profile
    public boolean updateUserProfile(int userId, String fullName, Integer age,
            String gender, Float heightCm, Float weightKg, String goal) throws Exception {

        User user = userDAO.getUserById(userId);
        if (user == null) {
            return false;
        }

        user.setFullName(fullName);
        user.setAge(age);
        user.setGender(gender);
        user.setHeightCm(heightCm);
        user.setWeightKg(weightKg);
        user.setGoal(goal);

        return userDAO.updateUser(user);
    }

    // Change password
    public boolean changePassword(int userId, String currentPassword, String newPassword) throws Exception {
        User user = userDAO.getUserById(userId);

        if (user == null || !hashPassword(currentPassword).equals(user.getPasswordHash())) {
            return false;
        }

        String newPasswordHash = hashPassword(newPassword);
        return userDAO.updatePassword(userId, newPasswordHash);
    }

    // Simple email validation
    public boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return email.contains("@") && email.contains(".");
    }

    // Simple password validation
    public boolean isValidPassword(String password) {
        return password != null && password.length() >= 4;
    }

    // Get user by ID
    public User getUserById(int userId) throws Exception {
        return userDAO.getUserById(userId);
    }
    public String getPasswordHash(String password) {
        return hashPassword(password);
    }
}