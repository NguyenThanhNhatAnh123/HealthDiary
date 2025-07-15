package com.healthdiary.servlet;

import com.healthdiary.dao.AdminDashboardDAO;
import com.healthdiary.dao.UserDAO;
import com.healthdiary.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        AdminDashboardDAO dao = new AdminDashboardDAO();
        
        try {
            // Set dashboard statistics
            request.setAttribute("totalUsers", dao.getTotalUsers());
            request.setAttribute("totalFoods", dao.getTotalFoods());
            request.setAttribute("totalExercises", dao.getTotalExercises());
            request.setAttribute("activeUsers", dao.getActiveUsersToday());
            
            // Get user list for the table
            UserDAO userDAO = new UserDAO();
            List<User> userList = userDAO.getAllUsers();
            request.setAttribute("userList", userList);
            
        
           
            
        } catch (Exception e) {
            e.printStackTrace();
            // Set empty list if error occurs
            request.setAttribute("userList", new java.util.ArrayList<User>());
        }
        
        // Forward to JSP page
        request.getRequestDispatcher("dashboard_admin.jsp").forward(request, response);
    }
}