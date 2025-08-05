package com.healthdiary.servlet;

import com.healthdiary.model.Food_samples;
import com.healthdiary.dao.FoodDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/food/add")
public class AdminAddFoodServlet extends HttpServlet {
    private FoodDAO foodDAO;

    @Override
    public void init() throws ServletException {
        foodDAO = new FoodDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị form thêm food
        request.getRequestDispatcher("/admin_add_food.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String foodName = request.getParameter("foodName");
        String type = request.getParameter("type");
        String caloriesStr = request.getParameter("calories");
        String proteinStr = request.getParameter("protein");
        String carbsStr = request.getParameter("carbs");
        String fatStr = request.getParameter("fat");

        // Kiểm tra dữ liệu bắt buộc
        if (foodName == null || foodName.trim().isEmpty() ||
                type == null || type.trim().isEmpty() ||
                caloriesStr == null || caloriesStr.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            request.getRequestDispatcher("/admin_add_food.jsp").forward(request, response);
            return;
        }

        // Parse các trường số
        int calories;
        double protein = 0.0;
        double carbs = 0.0;
        double fat = 0.0;

        try {
            calories = Integer.parseInt(caloriesStr.trim());
            if (calories < 0) {
                request.setAttribute("error", "Calories phải là số dương");
                request.getRequestDispatcher("/admin_add_food.jsp").forward(request, response);
                return;
            }

            if (proteinStr != null && !proteinStr.trim().isEmpty()) {
                protein = Double.parseDouble(proteinStr.trim());
                if (protein < 0) {
                    request.setAttribute("error", "Protein phải là số dương");
                    request.getRequestDispatcher("/admin_add_food.jsp").forward(request, response);
                    return;
                }
            }

            if (carbsStr != null && !carbsStr.trim().isEmpty()) {
                carbs = Double.parseDouble(carbsStr.trim());
                if (carbs < 0) {
                    request.setAttribute("error", "Carbs phải là số dương");
                    request.getRequestDispatcher("/admin_add_food.jsp").forward(request, response);
                    return;
                }
            }

            if (fatStr != null && !fatStr.trim().isEmpty()) {
                fat = Double.parseDouble(fatStr.trim());
                if (fat < 0) {
                    request.setAttribute("error", "Fat phải là số dương");
                    request.getRequestDispatcher("/admin_add_food.jsp").forward(request, response);
                    return;
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu số không hợp lệ");
            request.getRequestDispatcher("/admin_add_food.jsp").forward(request, response);
            return;
        }

        // Tạo food object
        Food_samples food = new Food_samples();
        food.setFoodName(foodName.trim());
        food.setType(type.trim());
        food.setCalories(calories);
        food.setProtein(protein);
        food.setCarbs(carbs);
        food.setFat(fat);

        // Lưu food vào database
        try {
            boolean success = foodDAO.addFood(food);
            if (success) {
                request.getSession().setAttribute("success", "Thêm food thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/foods");
            } else {
                request.setAttribute("error", "Thêm food thất bại.");
                request.getRequestDispatcher("/admin_add_food.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi thêm food: " + e.getMessage());
            request.getRequestDispatcher("/admin_add_food.jsp").forward(request, response);
        }
    }
}