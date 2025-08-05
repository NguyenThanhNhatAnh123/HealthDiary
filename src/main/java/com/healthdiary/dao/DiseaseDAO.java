package com.healthdiary.dao;

import com.healthdiary.model.Disease_recommendations;
import com.healthdiary.model.User_diseases;
import com.healthdiary.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("unused")
public class DiseaseDAO {

    public List<Disease_recommendations> getAllDiseases() throws Exception {
        List<Disease_recommendations> diseases = new ArrayList<>();
        String sql = "SELECT * FROM disease_recommendations ORDER BY id";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Disease_recommendations disease = new Disease_recommendations();
                disease.setId(rs.getInt("id"));
                disease.setDiseaseName(rs.getString("diseaseName"));
                disease.setRecommendedFood(rs.getString("recommendedFood"));
                disease.setRecommendedExercise(rs.getString("recommendedExercise"));
                diseases.add(disease);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return diseases;
    }

    public Disease_recommendations getDiseaseById(int id) throws Exception {
        String sql = "SELECT * FROM disease_recommendations WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Disease_recommendations disease = new Disease_recommendations();
                disease.setId(rs.getInt("id"));
                disease.setDiseaseName(rs.getString("diseaseName"));
                disease.setRecommendedFood(rs.getString("recommendedFood"));
                disease.setRecommendedExercise(rs.getString("recommendedExercise"));
                return disease;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Integer> getUserDiseases(int userId) throws Exception {
        List<Integer> diseaseIds = new ArrayList<>();
        String sql = "SELECT diseaseId FROM user_diseases WHERE userId = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                diseaseIds.add(rs.getInt("diseaseId"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return diseaseIds;
    }

    public boolean addUserDisease(int userId, int diseaseId) throws Exception {
        String sql = "INSERT INTO user_diseases (userId, diseaseId) VALUES (?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, diseaseId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean clearUserDiseases(int userId) throws Exception {
        String sql = "DELETE FROM user_diseases WHERE userId = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            return stmt.executeUpdate() >= 0; // Return true even if no records deleted
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Disease_recommendations> getUserDiseaseRecommendations(int userId) throws Exception {
        List<Disease_recommendations> recommendations = new ArrayList<>();
        String sql = "SELECT d.* FROM disease_recommendations d " +
                "INNER JOIN user_diseases ud ON d.id = ud.diseaseId " +
                "WHERE ud.userId = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Disease_recommendations disease = new Disease_recommendations();
                disease.setId(rs.getInt("id"));
                disease.setDiseaseName(rs.getString("diseaseName"));
                disease.setRecommendedFood(rs.getString("recommendedFood"));
                disease.setRecommendedExercise(rs.getString("recommendedExercise"));
                recommendations.add(disease);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recommendations;
    }

    public boolean removeUserDisease(int userId, int diseaseId) throws Exception {
        String sql = "DELETE FROM user_diseases WHERE userId = ? AND diseaseId = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, diseaseId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
}