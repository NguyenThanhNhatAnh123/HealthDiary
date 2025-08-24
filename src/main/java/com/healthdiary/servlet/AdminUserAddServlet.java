package com.healthdiary.servlet;

import com.healthdiary.model.User;
import com.healthdiary.service.AuthService;
import com.healthdiary.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/user/add")
public class AdminUserAddServlet extends HttpServlet {
    private AuthService authService;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        authService = new AuthService();
        userDAO = new UserDAO();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("login_admin");
            return;
        }
        
        // Hiển thị form thêm user
        request.getRequestDispatcher("/admin_add_user.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("login_admin");
            return;
        }
        
        // Lấy dữ liệu từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String ageStr = request.getParameter("age");
        String gender = request.getParameter("gender");
        String heightStr = request.getParameter("height");
        String weightStr = request.getParameter("weight");
        String goal = request.getParameter("goal");
        
        // Ensure parameters are not null
        if (fullName == null) fullName = "";
        if (email == null) email = "";
        if (password == null) password = "";
        if (confirmPassword == null) confirmPassword = "";
        if (ageStr == null) ageStr = "";
        if (gender == null) gender = "";
        if (heightStr == null) heightStr = "";
        if (weightStr == null) weightStr = "";
        if (goal == null) goal = "";

        // Kiểm tra dữ liệu bắt buộc
        if (fullName.trim().isEmpty() ||
                email.trim().isEmpty() ||
                password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            request.getRequestDispatcher("/admin_add_user.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email hợp lệ
        if (!authService.isValidEmail(email)) {
            request.setAttribute("error", "Email không hợp lệ");
            request.getRequestDispatcher("/admin_add_user.jsp").forward(request, response);
            return;
        }

        // Kiểm tra password hợp lệ
        if (!authService.isValidPassword(password)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 4 ký tự");
            request.getRequestDispatcher("/admin_add_user.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xác nhận mật khẩu
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            request.getRequestDispatcher("/admin_add_user.jsp").forward(request, response);
            return;
        }

        // Parse các trường số
        Integer age = null;
        Float height = null;
        Float weight = null;
        try {
            if (!ageStr.trim().isEmpty()) {
                age = Integer.parseInt(ageStr.trim());
            }
            if (!heightStr.trim().isEmpty()) {
                height = Float.parseFloat(heightStr.trim());
            }
            if (!weightStr.trim().isEmpty()) {
                weight = Float.parseFloat(weightStr.trim());
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu số không hợp lệ");
            request.getRequestDispatcher("/admin_add_user.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email đã tồn tại
        try {
            if (userDAO.emailExists(email)) {
                request.setAttribute("error", "Email đã tồn tại. Vui lòng chọn email khác.");
                request.getRequestDispatcher("/admin_add_user.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi kiểm tra email.");
            request.getRequestDispatcher("/admin_add_user.jsp").forward(request, response);
            return;
        }

        // Hash password
        String passwordHash = authService.getPasswordHash(password);

        // Tạo user
        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPasswordHash(passwordHash);
        user.setAge(age);
        user.setGender(gender);
        user.setHeightCm(height);
        user.setWeightKg(weight);
        user.setGoal(goal);

        // Lưu user vào database
        try {
            boolean success = userDAO.createUser(user);
            if (success) {
            	request.getSession().setAttribute("success", "Thêm user thành công!");
            	response.sendRedirect(request.getContextPath() + "/admin-dashboard");
            } else {
                request.setAttribute("error", "Thêm user thất bại.");
                request.getRequestDispatcher("/admin_add_user.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi thêm user.");
            request.getRequestDispatcher("/admin_add_user.jsp").forward(request, response);
        }
    }
}
