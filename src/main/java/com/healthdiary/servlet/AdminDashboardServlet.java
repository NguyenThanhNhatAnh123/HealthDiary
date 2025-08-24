package com.healthdiary.servlet;

import com.healthdiary.dao.AdminDashboardDAO;
import com.healthdiary.dao.UserDAO;
import com.healthdiary.dao.FoodDAO;
import com.healthdiary.dao.ExerciseDAO;
import com.healthdiary.model.User;
import com.healthdiary.model.Food_samples;
import com.healthdiary.model.Exercise_samples;

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

        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("login_admin");
            return;
        }

        System.out.println("=== AdminDashboardServlet started ===");

        AdminDashboardDAO dao = new AdminDashboardDAO();

        try {
            // Set dashboard statistics
            int totalUsers = dao.getTotalUsers();
            int totalFoods = dao.getTotalFoods();
            int totalExercises = dao.getTotalExercises();
            int activeUsers = dao.getActiveUsersToday();

            System.out.println("Dashboard Stats - Users: " + totalUsers + ", Foods: " + totalFoods + ", Exercises: "
                    + totalExercises + ", Active: " + activeUsers);

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalFoods", totalFoods);
            request.setAttribute("totalExercises", totalExercises);
            request.setAttribute("activeUsers", activeUsers);

            // Get user list for the table
            System.out.println("Loading users...");
            UserDAO userDAO = new UserDAO();
            List<User> userList = userDAO.getAllUsers();
            System.out.println("Loaded " + userList.size() + " users");
            request.setAttribute("userList", userList);

            // Get food list for the table
            System.out.println("Loading foods...");
            FoodDAO foodDAO = new FoodDAO();
            List<Food_samples> foodList = foodDAO.getAllFoods();
            System.out.println("Loaded " + foodList.size() + " foods");
            if (foodList.size() > 0) {
                System.out.println("First food: " + foodList.get(0).getFoodName());
            }
            request.setAttribute("foodList", foodList);

            // Get exercise list for the table
            System.out.println("Loading exercises...");
            ExerciseDAO exerciseDAO = new ExerciseDAO();
            List<Exercise_samples> exerciseList = exerciseDAO.getAllExercises();
            System.out.println("Loaded " + exerciseList.size() + " exercises");
            if (exerciseList.size() > 0) {
                System.out.println("First exercise: " + exerciseList.get(0).getExerciseName());
            }
            request.setAttribute("exerciseList", exerciseList);

            System.out.println("=== AdminDashboardServlet completed successfully ===");

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error loading dashboard data: " + e.getMessage());
            System.err.println("Stack trace:");
            e.printStackTrace();
            // Set empty lists if error occurs
            request.setAttribute("userList", new java.util.ArrayList<User>());
            request.setAttribute("foodList", new java.util.ArrayList<Food_samples>());
            request.setAttribute("exerciseList", new java.util.ArrayList<Exercise_samples>());
            request.setAttribute("totalUsers", 0);
            request.setAttribute("totalFoods", 0);
            request.setAttribute("totalExercises", 0);
            request.setAttribute("activeUsers", 0);
        }

        // Forward to JSP page
        System.out.println("Forwarding to dashboard_admin.jsp");
        request.getRequestDispatcher("dashboard_admin.jsp").forward(request, response);
    }
}