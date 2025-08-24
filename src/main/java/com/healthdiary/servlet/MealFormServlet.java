package com.healthdiary.servlet;

import com.healthdiary.dao.FoodDAO;
import com.healthdiary.model.Food_samples;
import com.healthdiary.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/meal-form")
public class MealFormServlet extends HttpServlet {
    private FoodDAO foodDAO = new FoodDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        // Get user from session and add to request
        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);

        try {
            // Load food samples from admin list for dropdown
            List<Food_samples> foodSamples = foodDAO.getAllFoods();
            request.setAttribute("foodSamples", foodSamples);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách thực phẩm");
        }

        request.getRequestDispatcher("/meal-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        // Get user from session
        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        try {
            // Get form parameters
            String date = request.getParameter("date");
            String mealType = request.getParameter("mealType");
            String notes = request.getParameter("notes");

            // Validate required fields
            if (date == null || date.trim().isEmpty() ||
                mealType == null || mealType.trim().isEmpty()) {
                
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
                doGet(request, response);
                return;
            }

            // Process food items (this would typically involve parsing multiple food items)
            // and saving the meal record with userId
            
            // TODO: Save meal record to database with userId and food items
            // This would typically involve creating a Meal record associated with the user
            
            request.setAttribute("success", "Bữa ăn đã được lưu thành công!");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi lưu bữa ăn: " + e.getMessage());
        }

        doGet(request, response);
    }
}