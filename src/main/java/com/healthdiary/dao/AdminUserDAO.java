package com.healthdiary.dao;

import com.healthdiary.model.Admin_User;
import com.healthdiary.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminUserDAO {
    // Kiểm tra đăng nhập admin
    public Admin_User login (String username, String password) throws Exception {
        String sql = "SELECT * FROM admin_users WHERE username = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String hash = rs.getString("password_hash");
                
                if (password.equals(hash)) {
                    Admin_User admin = new Admin_User();
                    admin.setId(rs.getInt("id"));
                    admin.setUsername(rs.getString("username"));
                    admin.setPassword(hash);
                    admin.setCreated_at(rs.getTimestamp("created_at"));
                    return admin;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
