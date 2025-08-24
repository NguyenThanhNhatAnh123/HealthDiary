package com.healthdiary.servlet;

import com.healthdiary.service.AuthService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private AuthService authService;

    @Override
    public void init() throws ServletException {
        authService = new AuthService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
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

        // Basic validation - only check required fields
        if (fullName.trim().isEmpty() ||
                email.trim().isEmpty() ||
                password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            setFormData(request, fullName, email, ageStr, gender, heightStr, weightStr, goal);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Simple email validation
        if (!authService.isValidEmail(email)) {
            request.setAttribute("error", "Email không hợp lệ");
            setFormData(request, fullName, email, ageStr, gender, heightStr, weightStr, goal);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Simple password validation
        if (!authService.isValidPassword(password)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 4 ký tự");
            setFormData(request, fullName, email, ageStr, gender, heightStr, weightStr, goal);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check password confirmation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            setFormData(request, fullName, email, ageStr, gender, heightStr, weightStr, goal);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Parse optional numeric fields (simple parsing)
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
            setFormData(request, fullName, email, ageStr, gender, heightStr, weightStr, goal);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Attempt registration
        boolean success = false;
		try {
			success = authService.registerUser(
			        fullName, email, password,
			        age, gender, height, weight, goal);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (success) {
            // Registration successful
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Registration failed (likely email already exists)
            request.setAttribute("error", "Email đã được sử dụng. Vui lòng chọn email khác.");
            setFormData(request, fullName, email, ageStr, gender, heightStr, weightStr, goal);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private void setFormData(HttpServletRequest request, String fullName, String email,
            String age, String gender, String height, String weight, String goal) {
        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("age", age);
        request.setAttribute("gender", gender);
        request.setAttribute("height", height);
        request.setAttribute("weight", weight);
        request.setAttribute("goal", goal);
    }
}