package com.healthdiary.servlet;

import com.healthdiary.dao.HealthDAO;
import com.healthdiary.model.Health_status_logs;
import com.healthdiary.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/health-form")
public class HealthFormServlet extends HttpServlet {
    private HealthDAO healthDAO = new HealthDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        
        try {
            // Check if user has already logged health status for today
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String today = sdf.format(new Date());
            
            Health_status_logs todayHealthStatus = healthDAO.getHealthStatusForDate(user.getId(), today);
            request.setAttribute("todayHealthStatus", todayHealthStatus);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải dữ liệu sức khỏe");
        }

        request.getRequestDispatcher("/health-form.jsp").forward(request, response);
    }
}