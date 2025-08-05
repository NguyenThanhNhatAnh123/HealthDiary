package com.healthdiary.servlet;

import com.healthdiary.dao.DiseaseDAO;
import com.healthdiary.model.Disease_recommendations;
import com.healthdiary.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/disease-management")
public class DiseaseManagementServlet extends HttpServlet {
    private DiseaseDAO diseaseDAO;

    @Override
    public void init() throws ServletException {
        diseaseDAO = new DiseaseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            User user = (User) session.getAttribute("user");

            // Get user's current disease IDs
            List<Integer> userDiseaseIds = diseaseDAO.getUserDiseases(user.getId());
            
            // Get user's current diseases with full details for display
            List<Disease_recommendations> userDiseaseRecommendations = diseaseDAO.getUserDiseaseRecommendations(user.getId());

            // Set attributes for JSP
            request.setAttribute("user", user);
            request.setAttribute("userDiseaseIds", userDiseaseIds);
            request.setAttribute("userDiseaseRecommendations", userDiseaseRecommendations);

            request.getRequestDispatcher("disease-selection.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách bệnh: " + e.getMessage());
            request.getRequestDispatcher("disease-selection.jsp").forward(request, response);
        }
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
            User user = (User) session.getAttribute("user");
            
            // Check if removing a disease
            String removeDiseaseId = request.getParameter("remove_disease");
            if (removeDiseaseId != null) {
                // Remove specific disease
                diseaseDAO.removeUserDisease(user.getId(), Integer.parseInt(removeDiseaseId));
                request.setAttribute("success", "Đã xóa tình trạng sức khỏe thành công");
                doGet(request, response); // Reload the page
                return;
            }
            
            // Get selected disease IDs from form
            String[] selectedDiseaseIds = request.getParameterValues("diseaseIds");

            // Clear existing user diseases
            diseaseDAO.clearUserDiseases(user.getId());

            // Add selected diseases
            if (selectedDiseaseIds != null && selectedDiseaseIds.length > 0) {
                for (String diseaseIdStr : selectedDiseaseIds) {
                    int diseaseId = Integer.parseInt(diseaseIdStr);
                    diseaseDAO.addUserDisease(user.getId(), diseaseId);
                }
                request.setAttribute("success", "Đã cập nhật tình trạng sức khỏe thành công!");
            } else {
                request.setAttribute("success", "Đã xóa tất cả tình trạng sức khỏe");
            }

            // Reload the page to show updated diseases
            doGet(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật bệnh: " + e.getMessage());
            doGet(request, response);
        }
    }
}