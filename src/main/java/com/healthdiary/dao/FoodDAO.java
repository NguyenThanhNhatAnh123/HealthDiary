package com.healthdiary.dao;

import com.healthdiary.model.Food_samples;
import com.healthdiary.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FoodDAO {

    public List<Food_samples> getAllFoods() throws Exception {
        List<Food_samples> foods = new ArrayList<>();
        String sql = "SELECT * FROM food_samples ORDER BY id";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Food_samples food = new Food_samples();
                food.setId(rs.getInt("id"));
                food.setFoodName(rs.getString("foodName"));
                food.setType(rs.getString("type"));
                food.setCalories(rs.getInt("calories"));
                food.setProtein(rs.getDouble("protein"));
                food.setCarbs(rs.getDouble("carbs"));
                food.setFat(rs.getDouble("fat"));
                foods.add(food);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return foods;
    }

    public Food_samples getFoodById(int id) throws Exception {
        String sql = "SELECT * FROM food_samples WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Food_samples food = new Food_samples();
                food.setId(rs.getInt("id"));
                food.setFoodName(rs.getString("foodName"));
                food.setType(rs.getString("type"));
                food.setCalories(rs.getInt("calories"));
                food.setProtein(rs.getDouble("protein"));
                food.setCarbs(rs.getDouble("carbs"));
                food.setFat(rs.getDouble("fat"));
                return food;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addFood(Food_samples food) throws Exception {
        String sql = "INSERT INTO food_samples (foodName, type, calories, protein, carbs, fat) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, food.getFoodName());
            stmt.setString(2, food.getType());
            stmt.setInt(3, food.getCalories());
            stmt.setDouble(4, food.getProtein());
            stmt.setDouble(5, food.getCarbs());
            stmt.setDouble(6, food.getFat());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateFood(Food_samples food) throws Exception {
        String sql = "UPDATE food_samples SET foodName = ?, type = ?, calories = ?, protein = ?, carbs = ?, fat = ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, food.getFoodName());
            stmt.setString(2, food.getType());
            stmt.setInt(3, food.getCalories());
            stmt.setDouble(4, food.getProtein());
            stmt.setDouble(5, food.getCarbs());
            stmt.setDouble(6, food.getFat());
            stmt.setInt(7, food.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteFood(int id) throws Exception {
        String sql = "DELETE FROM food_samples WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Food_samples> searchFoods(String searchTerm) throws Exception {
        List<Food_samples> foods = new ArrayList<>();
        String sql = "SELECT * FROM food_samples WHERE foodName LIKE ? OR type LIKE ? ORDER BY id";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Food_samples food = new Food_samples();
                food.setId(rs.getInt("id"));
                food.setFoodName(rs.getString("foodName"));
                food.setType(rs.getString("type"));
                food.setCalories(rs.getInt("calories"));
                food.setProtein(rs.getDouble("protein"));
                food.setCarbs(rs.getDouble("carbs"));
                food.setFat(rs.getDouble("fat"));
                foods.add(food);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return foods;
    }

    public int getTotalFoods() throws Exception {
        String sql = "SELECT COUNT(*) FROM food_samples";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}