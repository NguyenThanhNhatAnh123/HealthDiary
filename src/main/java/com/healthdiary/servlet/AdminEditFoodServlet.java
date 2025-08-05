package com.healthdiary.servlet;

import com.healthdiary.dao.FoodDAO;
import com.healthdiary.model.Food_samples;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/food/edit")
public class AdminEditFoodServlet extends HttpServlet {
    private FoodDAO foodDAO;

    @Override
    public void init() throws ServletException {
        foodDAO = new FoodDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String foodIdStr = request.getParameter("id");

        if (foodIdStr == null || foodIdStr.trim().isEmpty()) {
            request.getSession().setAttribute("error", "ID food không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/foods");
            return;
        }

        try {
            int foodId = Integer.parseInt(foodIdStr.trim());
            Food_samples food = foodDAO.getFoodById(foodId);

            if (food == null) {
                request.getSession().setAttribute("error", "Không tìm thấy food với ID: " + foodId);
                response.sendRedirect(request.getContextPath() + "/admin/foods");
                return;
            }

            request.setAttribute("food", food);
            request.getRequestDispatcher("/admin_edit_food.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID food không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/foods");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi tải thông tin food");
            response.sendRedirect(request.getContextPath() + "/admin/foods");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String foodIdStr = request.getParameter("foodId");
        String foodName = request.getParameter("foodName");
        String type = request.getParameter("type");
        String caloriesStr = request.getParameter("calories");
        String proteinStr = request.getParameter("protein");
        String carbsStr = request.getParameter("carbs");
        String fatStr = request.getParameter("fat");

        if (foodIdStr == null || foodIdStr.trim().isEmpty()) {
            request.getSession().setAttribute("error", "ID food không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/foods");
            return;
        }

        int foodId;
        try {
            foodId = Integer.parseInt(foodIdStr.trim());
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID food không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/foods");
            return;
        }

        Food_samples currentFood;
        try {
            currentFood = foodDAO.getFoodById(foodId);
            if (currentFood == null) {
                request.getSession().setAttribute("error", "Không tìm thấy food với ID: " + foodId);
                response.sendRedirect(request.getContextPath() + "/admin/foods");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi tải thông tin food");
            response.sendRedirect(request.getContextPath() + "/admin/foods");
            return;
        }

        // Validate dữ liệu bắt buộc
        if (foodName == null || foodName.trim().isEmpty() ||
                type == null || type.trim().isEmpty() ||
                caloriesStr == null || caloriesStr.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            request.setAttribute("food", currentFood);
            request.getRequestDispatcher("/admin_edit_food.jsp").forward(request, response);
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
                request.setAttribute("food", currentFood);
                request.getRequestDispatcher("/admin_edit_food.jsp").forward(request, response);
                return;
            }

            if (proteinStr != null && !proteinStr.trim().isEmpty()) {
                protein = Double.parseDouble(proteinStr.trim());
                if (protein < 0) {
                    request.setAttribute("error", "Protein phải là số dương");
                    request.setAttribute("food", currentFood);
                    request.getRequestDispatcher("/admin_edit_food.jsp").forward(request, response);
                    return;
                }
            }

            if (carbsStr != null && !carbsStr.trim().isEmpty()) {
                carbs = Double.parseDouble(carbsStr.trim());
                if (carbs < 0) {
                    request.setAttribute("error", "Carbs phải là số dương");
                    request.setAttribute("food", currentFood);
                    request.getRequestDispatcher("/admin_edit_food.jsp").forward(request, response);
                    return;
                }
            }

            if (fatStr != null && !fatStr.trim().isEmpty()) {
                fat = Double.parseDouble(fatStr.trim());
                if (fat < 0) {
                    request.setAttribute("error", "Fat phải là số dương");
                    request.setAttribute("food", currentFood);
                    request.getRequestDispatcher("/admin_edit_food.jsp").forward(request, response);
                    return;
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu số không hợp lệ");
            request.setAttribute("food", currentFood);
            request.getRequestDispatcher("/admin_edit_food.jsp").forward(request, response);
            return;
        }

        // Cập nhật food
        currentFood.setFoodName(foodName.trim());
        currentFood.setType(type.trim());
        currentFood.setCalories(calories);
        currentFood.setProtein(protein);
        currentFood.setCarbs(carbs);
        currentFood.setFat(fat);

        try {
            boolean updated = foodDAO.updateFood(currentFood);
            if (updated) {
                request.getSession().setAttribute("success", "Cập nhật food thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/foods");
            } else {
                request.setAttribute("error", "Cập nhật food thất bại.");
                request.setAttribute("food", currentFood);
                request.getRequestDispatcher("/admin_edit_food.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi cập nhật food: " + e.getMessage());
            request.setAttribute("food", currentFood);
            request.getRequestDispatcher("/admin_edit_food.jsp").forward(request, response);
        }
    }
}