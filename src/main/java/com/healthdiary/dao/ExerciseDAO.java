package com.healthdiary.dao;

import com.healthdiary.model.Exercise;
import com.healthdiary.model.Exercise_samples;
import com.healthdiary.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExerciseDAO {

    public List<Exercise_samples> getAllExercises() throws Exception {
        List<Exercise_samples> exercises = new ArrayList<>();
        String sql = "SELECT * FROM exercise_samples ORDER BY id";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Exercise_samples exercise = new Exercise_samples();
                exercise.setId(rs.getInt("id"));
                exercise.setExerciseName(rs.getString("exerciseName"));
                exercise.setType(rs.getString("type"));
                exercise.setMuscleGroup(rs.getString("muscleGroup"));
                exercise.setDifficulty(rs.getString("difficulty"));
                exercise.setCaloriesPerHour(rs.getInt("caloriesPerHour"));
                exercises.add(exercise);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return exercises;
    }

    public Exercise_samples getExerciseById(int id) throws Exception {
        String sql = "SELECT * FROM exercise_samples WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Exercise_samples exercise = new Exercise_samples();
                exercise.setId(rs.getInt("id"));
                exercise.setExerciseName(rs.getString("exerciseName"));
                exercise.setType(rs.getString("type"));
                exercise.setMuscleGroup(rs.getString("muscleGroup"));
                exercise.setDifficulty(rs.getString("difficulty"));
                exercise.setCaloriesPerHour(rs.getInt("caloriesPerHour"));
                return exercise;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addExercise(Exercise_samples exercise) throws Exception {
        String sql = "INSERT INTO exercise_samples (exerciseName, type, muscleGroup, difficulty, caloriesPerHour) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, exercise.getExerciseName());
            stmt.setString(2, exercise.getType());
            stmt.setString(3, exercise.getMuscleGroup());
            stmt.setString(4, exercise.getDifficulty());
            stmt.setInt(5, exercise.getCaloriesPerHour());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateExercise(Exercise_samples exercise) throws Exception {
        String sql = "UPDATE exercise_samples SET exerciseName = ?, type = ?, muscleGroup = ?, difficulty = ?, caloriesPerHour = ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, exercise.getExerciseName());
            stmt.setString(2, exercise.getType());
            stmt.setString(3, exercise.getMuscleGroup());
            stmt.setString(4, exercise.getDifficulty());
            stmt.setInt(5, exercise.getCaloriesPerHour());
            stmt.setInt(6, exercise.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteExercise(int id) throws Exception {
        String sql = "DELETE FROM exercise_samples WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Exercise_samples> searchExercises(String searchTerm) throws Exception {
        List<Exercise_samples> exercises = new ArrayList<>();
        String sql = "SELECT * FROM exercise_samples WHERE exerciseName LIKE ? OR type LIKE ? OR muscleGroup LIKE ? ORDER BY id";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Exercise_samples exercise = new Exercise_samples();
                exercise.setId(rs.getInt("id"));
                exercise.setExerciseName(rs.getString("exerciseName"));
                exercise.setType(rs.getString("type"));
                exercise.setMuscleGroup(rs.getString("muscleGroup"));
                exercise.setDifficulty(rs.getString("difficulty"));
                exercise.setCaloriesPerHour(rs.getInt("caloriesPerHour"));
                exercises.add(exercise);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exercises;
    }

    public int getTotalExercises() throws Exception {
        String sql = "SELECT COUNT(*) FROM exercise_samples";

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

    // Methods for user exercise logs
    public boolean addUserExercise(Exercise exercise) throws Exception {
        String sql = "INSERT INTO exercises (userId, exerciseType, durationMin, caloriesBurned, logDate) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, exercise.getUserId());
            stmt.setString(2, exercise.getExerciseType());
            stmt.setInt(3, exercise.getDurationMin());
            stmt.setInt(4, exercise.getCaloriesBurned());
            stmt.setDate(5, new java.sql.Date(exercise.getLogDate().getTime()));

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Exercise> getUserExercises(int userId) throws Exception {
        List<Exercise> exercises = new ArrayList<>();
        String sql = "SELECT * FROM exercises WHERE userId = ? ORDER BY logDate DESC";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Exercise exercise = new Exercise();
                exercise.setId(rs.getInt("id"));
                exercise.setUserId(rs.getInt("userId"));
                exercise.setExerciseType(rs.getString("exerciseType"));
                exercise.setDurationMin(rs.getInt("durationMin"));
                exercise.setCaloriesBurned(rs.getInt("caloriesBurned"));
                exercise.setLogDate(rs.getDate("logDate"));
                exercises.add(exercise);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exercises;
    }

    public List<Exercise> getUserExercisesForDate(int userId, String date) throws Exception {
        List<Exercise> exercises = new ArrayList<>();
        String sql = "SELECT * FROM exercises WHERE userId = ? AND DATE(logDate) = ? ORDER BY logDate DESC";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, date);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Exercise exercise = new Exercise();
                exercise.setId(rs.getInt("id"));
                exercise.setUserId(rs.getInt("userId"));
                exercise.setExerciseType(rs.getString("exerciseType"));
                exercise.setDurationMin(rs.getInt("durationMin"));
                exercise.setCaloriesBurned(rs.getInt("caloriesBurned"));
                exercise.setLogDate(rs.getDate("logDate"));
                exercises.add(exercise);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exercises;
    }

    public double getTotalCaloriesBurnedForDate(int userId, String date) throws Exception {
        String sql = "SELECT SUM(caloriesBurned) FROM exercises WHERE userId = ? AND DATE(logDate) = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, date);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
}