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

@WebServlet("/health-status")
public class HealthStatusServlet extends HttpServlet {
    private HealthDAO healthDAO;

    @Override
    public void init() throws ServletException {
        healthDAO = new HealthDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = (User) request.getSession().getAttribute("user");
            String dateStr = request.getParameter("date");
            String status = request.getParameter("status");
            String notes = request.getParameter("notes");

            // Parse date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date logDate = sdf.parse(dateStr);

            // Check if already logged for today
            if (healthDAO.hasStatusForDate(user.getId(), dateStr)) {
                // Update existing record
                healthDAO.updateHealthStatus(user.getId(), dateStr, status, notes);
            } else {
                // Create new record
                Health_status_logs log = new Health_status_logs();
                log.setUserId(user.getId());
                log.setLogDate(logDate);
                log.setStatus(status);
                healthDAO.addHealthStatus(log);
            }

            response.sendRedirect("health-history");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi lưu trạng thái sức khỏe");
            request.getRequestDispatcher("health-form.jsp").forward(request, response);
        }
    }
}