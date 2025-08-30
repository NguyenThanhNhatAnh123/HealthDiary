package com.healthdiary.servlet;

import com.healthdiary.dao.FoodDAO;
import com.healthdiary.dao.MealDAO;
import com.healthdiary.model.Food_samples;
import com.healthdiary.model.Meal;
import com.healthdiary.model.Meal_item;
import com.healthdiary.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/meal")
public class MealServlet extends HttpServlet {
    private MealDAO mealDAO = new MealDAO();
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

        // Show meal form
        showMealForm(request, response);
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

        // Handle meal submission
        addMeal(request, response);
    }

    private void showMealForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Load food samples for dropdown (if needed)
            List<Food_samples> foodSamples = foodDAO.getAllFoods();
            request.setAttribute("foodSamples", foodSamples);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách thực phẩm");
        }

        request.getRequestDispatcher("/meal-form.jsp").forward(request, response);
    }

    private void addMeal(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        try {
            String mealType = request.getParameter("mealType");
            String dateStr = request.getParameter("date");
            String notes = request.getParameter("notes");

            // Get food items data
            String foodName = request.getParameter("foodName");
            String foodCaloriesStr = request.getParameter("foodCalories");
            String foodQuantityStr = request.getParameter("foodQuantity");

            // Debug logging

            if (mealType == null || mealType.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng chọn loại bữa ăn");
                showMealForm(request, response);
                return;
            }

            if (dateStr == null || dateStr.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng chọn thời gian");
                showMealForm(request, response);
                return;
            }

            if (foodName == null || foodName.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng chọn ít nhất một thực phẩm");
                showMealForm(request, response);
                return;
            }

            // Parse date and calculate calories
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date logDate = sdf.parse(dateStr);
            
            int calories = Integer.parseInt(foodCaloriesStr);
            double quantity = Double.parseDouble(foodQuantityStr);
            int totalItemCalories = (int) (calories * quantity / 100); // Adjust for per 100g

            // Create new meal first
            Meal meal = new Meal();
            meal.setUserId(user.getId());
            meal.setMealTime(mealType);
            meal.setLogDate(logDate);
            meal.setTotalCalories(null); // Will be updated after adding items
            
            int mealId = mealDAO.addMeal(meal);
            
            if (mealId <= 0) {
                throw new Exception("Failed to create meal record");
            }
            
            // Create meal item with correct mealId
            Meal_item mealItem = new Meal_item();
            mealItem.setMealId(mealId); // Use the actual meal ID, not user ID
            mealItem.setFoodName(foodName);
            mealItem.setCalories(totalItemCalories);
            mealItem.setImage(""); // Default image
            mealItem.setQuantity(quantity); // Add quantity
            
            System.out.println("DEBUG - Saving meal item: " + mealItem.toString());
            
            boolean success = mealDAO.addMealItem(mealItem);
            
            if (success) {
                // Update meal with total calories
                meal.setId(mealId);
                meal.setTotalCalories(totalItemCalories);
                mealDAO.updateMeal(meal);
                
                request.setAttribute("success", "Ghi bữa ăn thành công! Đã thêm " + foodName + " (" + totalItemCalories + " kcal).");
                System.out.println("DEBUG - Meal and meal item saved successfully!");
            } else {
                System.err.println("ERROR - Failed to save meal item to database");
                request.setAttribute("error", "Có lỗi xảy ra khi ghi bữa ăn vào cơ sở dữ liệu!");
            }

        } catch (NumberFormatException | ParseException e) {
            System.err.println("ERROR - Data parsing error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu không hợp lệ! Vui lòng kiểm tra lại thông tin.");
        } catch (Exception e) {
            System.err.println("ERROR - Unexpected error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi hệ thống xảy ra. Vui lòng thử lại sau.");
        }

        // Forward back to form
        showMealForm(request, response);
    }
}