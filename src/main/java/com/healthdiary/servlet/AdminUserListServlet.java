package com.healthdiary.servlet;

import com.healthdiary.model.User;
import com.healthdiary.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserListServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("login_admin");
            return;
        }
        
        try {
            // Lấy danh sách tất cả user
            List<User> users = userDAO.getAllUsers();
            
            // Đặt danh sách user vào request attribute
            request.setAttribute("users", users);
            
            // Kiểm tra có thông báo success từ session không
            String successMessage = (String) request.getSession().getAttribute("success");
            if (successMessage != null) {
                request.setAttribute("success", successMessage);
                request.getSession().removeAttribute("success"); // Xóa sau khi hiển thị
            }
            
            // Forward đến JSP
            request.getRequestDispatcher("/admin_user_list.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải danh sách user: " + e.getMessage());
            request.getRequestDispatcher("/admin_user_list.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("login_admin");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        
        if ("delete".equals(action)) {
            String userIdStr = request.getParameter("userId");
            
            if (userIdStr != null && !userIdStr.trim().isEmpty()) {
                try {
                    int userId = Integer.parseInt(userIdStr);
                    boolean success = userDAO.deleteUser(userId);
                    
                    if (success) {
                        request.getSession().setAttribute("success", "Xóa user thành công!");
                    } else {
                        request.getSession().setAttribute("error", "Xóa user thất bại!");
                    }
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("error", "ID user không hợp lệ!");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.getSession().setAttribute("error", "Lỗi khi xóa user: " + e.getMessage());
                }
            }
        }
        
        // Redirect để tránh form resubmission
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}