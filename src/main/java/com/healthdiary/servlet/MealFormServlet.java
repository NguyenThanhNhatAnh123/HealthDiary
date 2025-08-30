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

@WebServlet("/meal-form")
public class MealFormServlet extends HttpServlet {
    private MealDAO mealDAO = new MealDAO();
    private FoodDAO foodDAO = new FoodDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        showMealForm(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        addMeal(request, response);
    }

    private void showMealForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
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
            String foodName = request.getParameter("foodName");
            String foodCaloriesStr = request.getParameter("foodCalories");
            String foodQuantityStr = request.getParameter("quantity"); // Sửa tên parameter

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

                // Add meal item with food details
                try {
                    int calories = Integer.parseInt(foodCaloriesStr);
                    double quantity = Double.parseDouble(foodQuantityStr);
                    int totalItemCalories = (int) (calories * quantity / 100);
                    totalCalories += totalItemCalories;

                    Meal_item mealItem = new Meal_item();
                    mealItem.setMealId(mealId);
                    mealItem.setFoodName(foodName);
                    mealItem.setCalories(totalItemCalories);
                    mealItem.setImage("");
                    mealItem.setQuantity(quantity); // Thêm quantity vào meal item
                    
                    boolean itemAdded = mealDAO.addMealItem(mealItem);
                    
                    if (!itemAdded) {
                        throw new Exception("Không thể thêm meal item vào database");
                    }
                    
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Dữ liệu calories hoặc số lượng không hợp lệ");
                    showMealForm(request, response);
                    return;
                }

                // Update total calories for meal
                meal.setId(mealId);
                meal.setTotalCalories(totalCalories);
                boolean updated = mealDAO.updateMeal(meal);

                request.setAttribute("success", "Ghi bữa ăn thành công! Đã thêm " + foodName + " (" + totalCalories + " kcal).");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi ghi bữa ăn vào cơ sở dữ liệu!");
            }

        } catch (ParseException e) {
            request.setAttribute("error", "Định dạng ngày tháng không hợp lệ!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi hệ thống xảy ra. Vui lòng thử lại sau.");
        }

        showMealForm(request, response);
    }
}