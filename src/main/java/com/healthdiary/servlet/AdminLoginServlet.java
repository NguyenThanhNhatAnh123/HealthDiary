package com.healthdiary.servlet;

import com.healthdiary.model.Admin_User;
import com.healthdiary.service.AdminAuthService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login_admin")
public class AdminLoginServlet extends HttpServlet {
    private AdminAuthService adminAuthService;

    @Override
    public void init() throws ServletException {
        adminAuthService = new AdminAuthService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.getSession().invalidate();
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("adminUser") != null) {
            response.sendRedirect("dashboard_admin.jsp");
            return;
        }
        request.getRequestDispatcher("login_admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
            request.getRequestDispatcher("login_admin.jsp").forward(request, response);
            return;
        }

        Admin_User admin = null;
        try {
            admin = adminAuthService.loginAdmin(username.trim(), password);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", admin);
            response.sendRedirect("admin-dashboard");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            request.setAttribute("username", username);
            request.getRequestDispatcher("login_admin.jsp").forward(request, response);
        }
    }
}