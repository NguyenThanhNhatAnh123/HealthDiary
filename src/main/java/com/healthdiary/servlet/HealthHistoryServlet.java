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
import java.util.List;

@WebServlet("/health-history")
public class HealthHistoryServlet extends HttpServlet {
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
            // Get user's health history
            List<Health_status_logs> healthHistory = healthDAO.getUserHealthHistory(user.getId());
            request.setAttribute("healthHistory", healthHistory);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải lịch sử sức khỏe");
        }

        request.getRequestDispatcher("health-history.jsp").forward(request, response);
    }
}
