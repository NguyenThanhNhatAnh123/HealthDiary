package com.healthdiary.servlet;

import com.healthdiary.dao.FoodDAO;
import com.healthdiary.model.Food_samples;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/food/delete")
public class AdminDeleteFoodServlet extends HttpServlet {
    private FoodDAO foodDAO;

    @Override
    public void init() throws ServletException {
        foodDAO = new FoodDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID của food cần xóa
        String foodIdStr = request.getParameter("id");

        if (foodIdStr == null || foodIdStr.trim().isEmpty()) {
            request.getSession().setAttribute("error", "ID food không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/foods");
            return;
        }

        try {
            int foodId = Integer.parseInt(foodIdStr.trim());

            // Kiểm tra xem food có tồn tại không
            Food_samples food = foodDAO.getFoodById(foodId);
            if (food == null) {
                request.getSession().setAttribute("error", "Không tìm thấy food với ID: " + foodId);
                response.sendRedirect(request.getContextPath() + "/admin/foods");
                return;
            }

            // Đặt thông tin food vào request để hiển thị xác nhận
            request.setAttribute("food", food);
            request.getRequestDispatcher("/admin_delete_food.jsp").forward(request, response);

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
        // Lấy ID của food cần xóa
        String foodIdStr = request.getParameter("foodId");
        String confirmDelete = request.getParameter("confirmDelete");

        // Kiểm tra xác nhận xóa
        if (!"true".equals(confirmDelete)) {
            request.getSession().setAttribute("error", "Vui lòng xác nhận việc xóa food");
            response.sendRedirect(request.getContextPath() + "/admin/foods");
            return;
        }

        if (foodIdStr == null || foodIdStr.trim().isEmpty()) {
            request.getSession().setAttribute("error", "ID food không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/foods");
            return;
        }

        try {
            int foodId = Integer.parseInt(foodIdStr.trim());

            // Kiểm tra xem food có tồn tại không
            Food_samples food = foodDAO.getFoodById(foodId);
            if (food == null) {
                request.getSession().setAttribute("error", "Không tìm thấy food với ID: " + foodId);
                response.sendRedirect(request.getContextPath() + "/admin/foods");
                return;
            }

            // Thực hiện xóa food
            boolean success = foodDAO.deleteFood(foodId);

            if (success) {
                request.getSession().setAttribute("success", "Đã xóa food '" + food.getFoodName() + "' thành công!");
            } else {
                request.getSession().setAttribute("error", "Xóa food thất bại. Vui lòng thử lại.");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID food không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi xóa food: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/foods");
    }
}