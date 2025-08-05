package com.healthdiary.dao;

import com.healthdiary.model.Health_status_logs;
import com.healthdiary.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HealthDAO {

    public boolean addHealthStatus(Health_status_logs healthLog) throws Exception {
        String sql = "INSERT INTO health_status_logs (userId, status, logDate) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, healthLog.getUserId());
            stmt.setString(2, healthLog.getStatus());
            stmt.setDate(3, new java.sql.Date(healthLog.getLogDate().getTime()));

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean hasStatusForDate(int userId, String date) throws Exception {
        String sql = "SELECT COUNT(*) FROM health_status_logs WHERE userId = ? AND DATE(logDate) = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, date);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateHealthStatus(int userId, String date, String status, String notes) throws Exception {
        String sql = "UPDATE health_status_logs SET status = ? WHERE userId = ? AND DATE(logDate) = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, userId);
            stmt.setString(3, date);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Health_status_logs> getUserHealthHistory(int userId) throws Exception {
        List<Health_status_logs> healthLogs = new ArrayList<>();
        String sql = "SELECT * FROM health_status_logs WHERE userId = ? ORDER BY logDate DESC";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Health_status_logs log = new Health_status_logs();
                log.setId(rs.getInt("id"));
                log.setUserId(rs.getInt("userId"));
                log.setStatus(rs.getString("status"));
                log.setLogDate(rs.getDate("logDate"));
                healthLogs.add(log);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return healthLogs;
    }

    public Health_status_logs getHealthStatusForDate(int userId, String date) throws Exception {
        String sql = "SELECT * FROM health_status_logs WHERE userId = ? AND DATE(logDate) = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, date);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Health_status_logs log = new Health_status_logs();
                log.setId(rs.getInt("id"));
                log.setUserId(rs.getInt("userId"));
                log.setStatus(rs.getString("status"));
                log.setLogDate(rs.getDate("logDate"));
                return log;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}