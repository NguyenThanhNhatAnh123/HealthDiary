package com.healthdiary.dao;

import com.healthdiary.model.Weight_logs;
import com.healthdiary.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WeightDAO {

    public boolean addWeightLog(Weight_logs weightLog) throws Exception {
        String sql = "INSERT INTO weight_logs (userId, weightKg, logDate) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, weightLog.getUserId());
            stmt.setFloat(2, weightLog.getWeightKg());
            stmt.setDate(3, new java.sql.Date(weightLog.getLogDate().getTime()));

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean hasWeightForDate(int userId, String date) throws Exception {
        String sql = "SELECT COUNT(*) FROM weight_logs WHERE userId = ? AND DATE(logDate) = ?";

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

    public List<Weight_logs> getWeightHistory(int userId, int days) throws Exception {
        List<Weight_logs> weightLogs = new ArrayList<>();
        String sql = "SELECT * FROM weight_logs WHERE userId = ? ORDER BY logDate DESC LIMIT ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, days);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Weight_logs log = new Weight_logs();
                log.setId(rs.getInt("id"));
                log.setUserId(rs.getInt("userId"));
                log.setWeightKg(rs.getFloat("weightKg"));
                log.setLogDate(rs.getDate("logDate"));
                weightLogs.add(log);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return weightLogs;
    }

    public List<Weight_logs> getAllWeightHistory(int userId) throws Exception {
        List<Weight_logs> weightLogs = new ArrayList<>();
        String sql = "SELECT * FROM weight_logs WHERE userId = ? ORDER BY logDate DESC";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Weight_logs log = new Weight_logs();
                log.setId(rs.getInt("id"));
                log.setUserId(rs.getInt("userId"));
                log.setWeightKg(rs.getFloat("weightKg"));
                log.setLogDate(rs.getDate("logDate"));
                weightLogs.add(log);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return weightLogs;
    }

    public Weight_logs getLatestWeight(int userId) throws Exception {
        String sql = "SELECT * FROM weight_logs WHERE userId = ? ORDER BY logDate DESC LIMIT 1";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Weight_logs log = new Weight_logs();
                log.setId(rs.getInt("id"));
                log.setUserId(rs.getInt("userId"));
                log.setWeightKg(rs.getFloat("weightKg"));
                log.setLogDate(rs.getDate("logDate"));
                return log;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}