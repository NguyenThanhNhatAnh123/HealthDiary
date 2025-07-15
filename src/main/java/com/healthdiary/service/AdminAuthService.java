package com.healthdiary.service;

import com.healthdiary.dao.AdminUserDAO;
import com.healthdiary.model.Admin_User;

public class AdminAuthService {
    private AdminUserDAO adminUserDAO;

    public AdminAuthService() {
        this.adminUserDAO = new AdminUserDAO();
    }

    // Đăng nhập admin
    public Admin_User loginAdmin(String username, String password) throws Exception {
        // Nếu bạn dùng hash, hãy hash password trước khi so sánh
        // Ở đây chỉ so sánh plain text cho đơn giản
        return adminUserDAO.login(username, password);
    }
}