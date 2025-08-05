package com.healthdiary.servlet;

import com.healthdiary.dao.FoodDAO;
import com.healthdiary.model.Food_samples;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/foods")
public class AdminListFoodServlet extends HttpServlet {
    private FoodDAO foodDAO;

    @Override
    public void init() throws ServletException {
        foodDAO = new FoodDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy danh sách tất cả food
            List<Food_samples> foods = foodDAO.getAllFoods();

            // Đặt danh sách food vào request attribute
            request.setAttribute("foods", foods);

            // Kiểm tra có thông báo success từ session không
            String successMessage = (String) request.getSession().getAttribute("success");
            if (successMessage != null) {
                request.setAttribute("success", successMessage);
                request.getSession().removeAttribute("success"); // Xóa sau khi hiển thị
            }

            // Forward đến JSP
            request.getRequestDispatcher("/admin_list_food.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải danh sách food: " + e.getMessage());
            request.getRequestDispatcher("/admin_list_food.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String foodIdStr = request.getParameter("foodId");

            if (foodIdStr != null) {
                try {
                    int foodId = Integer.parseInt(foodIdStr);
                    boolean success = foodDAO.deleteFood(foodId);

                    if (success) {
                        request.getSession().setAttribute("success", "Xóa food thành công!");
                    } else {
                        request.getSession().setAttribute("error", "Xóa food thất bại!");
                    }
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("error", "ID food không hợp lệ!");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.getSession().setAttribute("error", "Lỗi khi xóa food: " + e.getMessage());
                }
            }
        }

        // Redirect để tránh form resubmission
        response.sendRedirect(request.getContextPath() + "/admin/foods");
    }
}