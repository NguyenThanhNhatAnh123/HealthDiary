package com.healthdiary.servlet;

import com.healthdiary.dao.HealthDAO;
import com.healthdiary.model.Health_status_logs;
import com.healthdiary.model.User;
import com.healthdiary.util.LogUtil;

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
    private HealthDAO healthDAO;

    @Override
    public void init() throws ServletException {
        healthDAO = new HealthDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            User user = (User) session.getAttribute("user");
            List<Health_status_logs> healthHistory = healthDAO.getUserHealthHistory(user.getUserID());
            request.setAttribute("healthHistory", healthHistory);
            request.getRequestDispatcher("health-history.jsp").forward(request, response);
        } catch (Exception e) {
            LogUtil.logError("HealthHistoryServlet", "doGet", "Failed to load health history", e);
            request.setAttribute("error", "Không thể tải lịch sử sức khỏe");
            request.getRequestDispatcher("health-history.jsp").forward(request, response);
        }
    }
}
