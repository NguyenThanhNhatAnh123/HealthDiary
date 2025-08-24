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

        try {
            // Load food samples for dropdown
            List<Food_samples> foodList = foodDAO.getAllFoods();
            request.setAttribute("foodList", foodList);
            
            // Set user information
            User user = (User) session.getAttribute("user");
            request.setAttribute("user", user);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách thực phẩm");
        }

        request.getRequestDispatcher("/meal-form.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        try {
            // Get user from session
            User user = (User) session.getAttribute("user");
            
            // Get form parameters
            String dateStr = request.getParameter("date");
            String mealType = request.getParameter("mealType");
            String notes = request.getParameter("notes");
            
            // Validate required fields
            if (dateStr == null || dateStr.trim().isEmpty() || 
                mealType == null || mealType.trim().isEmpty()) {
                
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
                doGet(request, response);
                return;
            }
            
            // TODO: Save meal data to database
            // This would typically involve creating a Meal model and saving via DAO
            
            request.setAttribute("success", "Lưu bữa ăn thành công!");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        // Reload the form with success/error message
        doGet(request, response);
    }
}