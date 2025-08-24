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
            String[] foodNames = request.getParameterValues("foodName");
            String[] foodCalories = request.getParameterValues("foodCalories");
            String[] foodQuantities = request.getParameterValues("foodQuantity");
            String[] foodUnits = request.getParameterValues("foodUnit");

            if (mealType == null || mealType.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng chọn loại bữa ăn");
                showMealForm(request, response);
                return;
            }

            // Parse date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date logDate = sdf.parse(dateStr);

            // Create new meal
            Meal meal = new Meal();
            meal.setUserId(user.getId());
            meal.setMealTime(mealType);
            meal.setLogDate(logDate);

            int mealId = mealDAO.addMeal(meal);

            if (mealId > 0) {
                int totalCalories = 0;

                // Add meal items
                if (foodNames != null && foodCalories != null && foodQuantities != null) {
                    for (int i = 0; i < foodNames.length && i < foodCalories.length && i < foodQuantities.length; i++) {
                        if (foodNames[i] != null && !foodNames[i].trim().isEmpty() &&
                            foodCalories[i] != null && !foodCalories[i].trim().isEmpty() &&
                            foodQuantities[i] != null && !foodQuantities[i].trim().isEmpty()) {
                            
                            try {
                                int calories = Integer.parseInt(foodCalories[i]);
                                double quantity = Double.parseDouble(foodQuantities[i]);
                                int totalItemCalories = (int) (calories * quantity);
                                totalCalories += totalItemCalories;

                                Meal_item mealItem = new Meal_item();
                                mealItem.setMealId(mealId);
                                mealItem.setFoodName(foodNames[i]);
                                mealItem.setCalories(totalItemCalories);
                                mealItem.setImage(""); // Default image
                                mealDAO.addMealItem(mealItem);
                            } catch (NumberFormatException e) {
                                System.out.println("Error parsing food data at index " + i + ": " + e.getMessage());
                                continue; // Skip this item and continue with the next
                            }
                        }
                    }
                }

                // Update total calories for meal
                meal.setId(mealId);
                meal.setTotalCalories(totalCalories);
                mealDAO.updateMeal(meal);

                request.setAttribute("success", "Ghi bữa ăn thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi ghi bữa ăn!");
            }

        } catch (NumberFormatException | ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
        }

        // Forward back to form
        showMealForm(request, response);
    }
}