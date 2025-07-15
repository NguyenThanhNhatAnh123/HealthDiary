package com.healthdiary.servlet;

import com.healthdiary.model.User;
import com.healthdiary.service.AuthService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private AuthService authService;

    @Override
    public void init() throws ServletException {
        authService = new AuthService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        User user = null;
		try {
			user = authService.getUserById(userId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (user == null) {
            session.invalidate();
            response.sendRedirect("login.jsp");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        // Get form parameters
        String fullName = request.getParameter("fullName");
        String ageStr = request.getParameter("age");
        String gender = request.getParameter("gender");
        String heightStr = request.getParameter("height");
        String weightStr = request.getParameter("weight");
        String goal = request.getParameter("goal");

        // Validate required fields
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Họ tên không được để trống");
            User user = null;
			try {
				user = authService.getUserById(userId);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            request.setAttribute("user", user);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        // Parse optional numeric fields
        Integer age = null;
        Float height = null;
        Float weight = null;

        try {
            if (ageStr != null && !ageStr.trim().isEmpty()) {
                age = Integer.parseInt(ageStr.trim());
                if (age <= 0 || age > 150) {
                    request.setAttribute("error", "Tuổi không hợp lệ");
                    User user = authService.getUserById(userId);
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                    return;
                }
            }

            if (heightStr != null && !heightStr.trim().isEmpty()) {
            	heightStr = heightStr.replaceAll("[^\\d.]", "");
                height = Float.parseFloat(heightStr.trim());
                if (height <= 0 || height > 300) {
                    request.setAttribute("error", "Chiều cao không hợp lệ");
                    User user = authService.getUserById(userId);
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                    return;
                }
            }

            if (weightStr != null && !weightStr.trim().isEmpty()) {
            	weightStr = weightStr.replaceAll("[^\\d.]", "");
                weight = Float.parseFloat(weightStr.trim());
                if (weight <= 0 || weight > 500) {
                    request.setAttribute("error", "Cân nặng không hợp lệ");
                    User user = authService.getUserById(userId);
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                    return;
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu số không hợp lệ");
            User user = null;
			try {
				user = authService.getUserById(userId);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
            request.setAttribute("user", user);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // Update profile
        boolean success = false;
		try {
			success = authService.updateUserProfile(
			        userId, fullName.trim(), age, gender, height, weight, goal);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (success) {
            // Update session with new user data
            User updatedUser = null;
			try {
				updatedUser = authService.getUserById(userId);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            session.setAttribute("user", updatedUser);
            session.setAttribute("userName", updatedUser.getFullName());

            request.setAttribute("success", "Cập nhật thông tin thành công!");
            request.setAttribute("user", updatedUser);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin");
            User user = null;
			try {
				user = authService.getUserById(userId);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            request.setAttribute("user", user);
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}