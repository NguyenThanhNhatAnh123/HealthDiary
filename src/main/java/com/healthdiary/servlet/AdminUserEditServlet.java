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

@WebServlet("/admin/user/edit")
public class AdminUserEditServlet extends HttpServlet {
    private AuthService authService;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        authService = new AuthService();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID của user cần edit
        String userIdStr = request.getParameter("id");

        if (userIdStr == null || userIdStr.trim().isEmpty()) {
            request.setAttribute("error", "ID user không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr.trim());
            User user = userDAO.getUserById(userId);

            if (user == null) {
                request.setAttribute("error", "Không tìm thấy user với ID: " + userId);
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            // Đặt user vào request để hiển thị trong form
            request.setAttribute("user", user);
            request.getRequestDispatcher("/admin_edit_user.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID user không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải thông tin user");
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String userIdStr = request.getParameter("userId");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String ageStr = request.getParameter("age");
        String gender = request.getParameter("gender");
        String heightStr = request.getParameter("height");
        String weightStr = request.getParameter("weight");
        String goal = request.getParameter("goal");

        // Kiểm tra ID user
        if (userIdStr == null || userIdStr.trim().isEmpty()) {
            request.setAttribute("error", "ID user không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(userIdStr.trim());
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID user không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        // Lấy thông tin user hiện tại
        User currentUser;
        try {
            currentUser = userDAO.getUserById(userId);
            if (currentUser == null) {
                request.setAttribute("error", "Không tìm thấy user với ID: " + userId);
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải thông tin user");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        // Kiểm tra dữ liệu bắt buộc
        if (fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/admin_edit_user.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email hợp lệ
        if (!authService.isValidEmail(email.trim())) {
            request.setAttribute("error", "Email không hợp lệ");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/admin_edit_user.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email đã tồn tại (trừ user hiện tại)
        if (!email.trim().equals(currentUser.getEmail())) {
            try {
                if (userDAO.emailExists(email.trim())) {
                    request.setAttribute("error", "Email đã tồn tại. Vui lòng chọn email khác.");
                    request.setAttribute("user", currentUser);
                    request.getRequestDispatcher("/admin_edit_user.jsp").forward(request, response);
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi kiểm tra email.");
                request.setAttribute("user", currentUser);
                request.getRequestDispatcher("/admin_edit_user.jsp").forward(request, response);
                return;
            }
        }

        // Kiểm tra password nếu có thay đổi
        if (password != null && !password.trim().isEmpty()) {
            if (!authService.isValidPassword(password)) {
                request.setAttribute("error", "Mật khẩu phải có ít nhất 4 ký tự");
                request.setAttribute("user", currentUser);
                request.getRequestDispatcher("/admin_edit_user.jsp").forward(request, response);
                return;
            }

            if (confirmPassword == null || !password.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp");
                request.setAttribute("user", currentUser);
                request.getRequestDispatcher("/admin_edit_user.jsp").forward(request, response);
                return;
            }
        }

        // Parse các trường số
        Integer age = null;
        Float height = null;
        Float weight = null;
        try {
            if (ageStr != null && !ageStr.trim().isEmpty()) {
                age = Integer.parseInt(ageStr.trim());
            }
            if (heightStr != null && !heightStr.trim().isEmpty()) {
                height = Float.parseFloat(heightStr.trim());
            }
            if (weightStr != null && !weightStr.trim().isEmpty()) {
                weight = Float.parseFloat(weightStr.trim());
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu số không hợp lệ");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/admin_edit_user.jsp").forward(request, response);
            return;
        }

        // Cập nhật thông tin user
        currentUser.setFullName(fullName.trim());
        currentUser.setEmail(email.trim());
        currentUser.setAge(age);
        currentUser.setGender(gender);
        currentUser.setHeightCm(height);
        currentUser.setWeightKg(weight);
        currentUser.setGoal(goal);

        // Lưu thông tin user vào database
        try {
            boolean success = userDAO.updateUser(currentUser);
            if (success) {
                // Cập nhật password nếu có thay đổi
                if (password != null && !password.trim().isEmpty()) {
                    String passwordHash = authService.getPasswordHash(password);
                    userDAO.updatePassword(userId, passwordHash);
                }

                request.getSession().setAttribute("success", "Cập nhật user thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } else {
                request.setAttribute("error", "Cập nhật user thất bại.");
                request.setAttribute("user", currentUser);
                request.getRequestDispatcher("/admin_edit_user.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi cập nhật user.");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/admin_edit_user.jsp").forward(request, response);
        }
    }
}
