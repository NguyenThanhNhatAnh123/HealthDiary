package com.healthdiary.dao;

import com.healthdiary.model.Meal;
import com.healthdiary.model.Meal_item;
import com.healthdiary.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MealDAO {

    // Thêm meal mới và trả về meal_id
    public int addMeal(Meal meal) {
        String sql = "INSERT INTO meals (user_id, meal_time, log_date, total_calories) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, meal.getUserId());
            pstmt.setString(2, meal.getMealTime());
            pstmt.setDate(3, new java.sql.Date(meal.getLogDate().getTime()));
            pstmt.setObject(4, meal.getTotalCalories());

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1); // Trả về meal_id
                }
            }
            return -1;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    // Thêm meal item
    public boolean addMealItem(Meal_item mealItem) {
        String sql = "INSERT INTO meals_items (meal_id, food_name, calories, image, quantity) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, mealItem.getMealId());
            pstmt.setString(2, mealItem.getFoodName());
            pstmt.setInt(3, mealItem.getCalories());
            pstmt.setString(4, mealItem.getImage());
            pstmt.setDouble(5, mealItem.getQuantity()); // Thêm dòng này

            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy danh sách meals của user
    public List<Meal> getMealsByUserId(int userId) {
        List<Meal> meals = new ArrayList<>();
        String sql = "SELECT * FROM meals WHERE user_id = ? ORDER BY log_date DESC, meal_time";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Meal meal = new Meal();
                meal.setId(rs.getInt("id"));
                meal.setUserId(rs.getInt("user_id"));
                meal.setMealTime(rs.getString("meal_time"));
                meal.setLogDate(rs.getDate("log_date"));
                meal.setTotalCalories(rs.getObject("total_calories") != null ? rs.getInt("total_calories") : null);
                meals.add(meal);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return meals;
    }

    // Lấy meal theo ID
    public Meal getMealById(int id) {
        String sql = "SELECT * FROM meals WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Meal meal = new Meal();
                meal.setId(rs.getInt("id"));
                meal.setUserId(rs.getInt("user_id"));
                meal.setMealTime(rs.getString("meal_time"));
                meal.setLogDate(rs.getDate("log_date"));
                meal.setTotalCalories(rs.getObject("total_calories") != null ? rs.getInt("total_calories") : null);
                return meal;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Meal_item> getMealItemsByMealId(int mealId) {
        List<Meal_item> mealItems = new ArrayList<>();
        String sql = "SELECT * FROM meals_items WHERE meal_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, mealId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Meal_item mealItem = new Meal_item();
                mealItem.setId(rs.getInt("id"));
                mealItem.setMealId(rs.getInt("meal_id"));
                mealItem.setFoodName(rs.getString("food_name"));
                mealItem.setCalories(rs.getInt("calories"));
                mealItem.setImage(rs.getString("image"));
                mealItem.setQuantity(rs.getDouble("quantity")); // Thêm dòng này
                mealItems.add(mealItem);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mealItems;
    }

    // Cập nhật meal
    public boolean updateMeal(Meal meal) {
        String sql = "UPDATE meals SET meal_time = ?, log_date = ?, total_calories = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, meal.getMealTime());
            pstmt.setDate(2, new java.sql.Date(meal.getLogDate().getTime()));
            pstmt.setObject(3, meal.getTotalCalories());
            pstmt.setInt(4, meal.getId());

            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa meal items của một meal
    public boolean deleteMealItems(int mealId) {
        String sql = "DELETE FROM meals_items WHERE meal_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, mealId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa meal
    public boolean deleteMeal(int id) {
        // Xóa meal items trước
        deleteMealItems(id);

        String sql = "DELETE FROM meals WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Tính tổng calories theo ngày
    public int getTotalCaloriesByDate(int userId, java.util.Date date) {
        String sql = "SELECT SUM(total_calories) FROM meals WHERE user_id = ? AND log_date = ?";
        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            pstmt.setDate(2, new java.sql.Date(date.getTime()));
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy meals theo ngày
    public List<Meal> getMealsForDate(int userId, String date) {
        List<Meal> meals = new ArrayList<>();
        String sql = "SELECT * FROM meals WHERE user_id = ? AND DATE(log_date) = ? ORDER BY meal_time";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            pstmt.setString(2, date);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Meal meal = new Meal();
                meal.setId(rs.getInt("id"));
                meal.setUserId(rs.getInt("user_id"));
                meal.setMealTime(rs.getString("meal_time"));
                meal.setLogDate(rs.getDate("log_date"));
                meal.setTotalCalories(rs.getObject("total_calories") != null ? rs.getInt("total_calories") : null);
                meals.add(meal);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return meals;
    }

    // Tính tổng calories theo ngày (string date)
    public double getTotalCaloriesForDate(int userId, String date) {
        String sql = "SELECT SUM(total_calories) FROM meals WHERE user_id = ? AND DATE(log_date) = ?";
        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            pstmt.setString(2, date);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }
}