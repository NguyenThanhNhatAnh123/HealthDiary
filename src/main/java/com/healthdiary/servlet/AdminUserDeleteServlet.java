package com.healthdiary.servlet;

import com.healthdiary.dao.UserDAO;
import com.healthdiary.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/user/delete")
public class AdminUserDeleteServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID của user cần xóa
        String userIdStr = request.getParameter("id");

        if (userIdStr == null || userIdStr.trim().isEmpty()) {
            request.getSession().setAttribute("error", "ID user không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr.trim());
            
            // Kiểm tra xem user có tồn tại không
            User user = userDAO.getUserById(userId);
            if (user == null) {
                request.getSession().setAttribute("error", "Không tìm thấy user với ID: " + userId);
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            // Đặt thông tin user vào request để hiển thị xác nhận
            request.setAttribute("user", user);
            request.getRequestDispatcher("/admin_delete_user.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID user không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi tải thông tin user");
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID của user cần xóa
        String userIdStr = request.getParameter("userId");
        String confirmDelete = request.getParameter("confirmDelete");

        // Kiểm tra xác nhận xóa
        if (!"true".equals(confirmDelete)) {
            request.getSession().setAttribute("error", "Vui lòng xác nhận việc xóa user");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        if (userIdStr == null || userIdStr.trim().isEmpty()) {
            request.getSession().setAttribute("error", "ID user không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr.trim());
            
            // Kiểm tra xem user có tồn tại không
            User user = userDAO.getUserById(userId);
            if (user == null) {
                request.getSession().setAttribute("error", "Không tìm thấy user với ID: " + userId);
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            // Thực hiện xóa user
            boolean success = userDAO.deleteUser(userId);
            
            if (success) {
                request.getSession().setAttribute("success", "Đã xóa user '" + user.getFullName() + "' thành công!");
            } else {
                request.getSession().setAttribute("error", "Xóa user thất bại. Vui lòng thử lại.");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID user không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi xóa user: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}