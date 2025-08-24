package com.healthdiary.servlet;

import com.healthdiary.dao.ExerciseDAO;
import com.healthdiary.model.Exercise_samples;
import com.healthdiary.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/exercise-form")
public class ExerciseFormServlet extends HttpServlet {
    private ExerciseDAO exerciseDAO;

    @Override
    public void init() throws ServletException {
        exerciseDAO = new ExerciseDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            // Load exercise samples for dropdown
            List<Exercise_samples> exerciseList = exerciseDAO.getAllExercises();
            request.setAttribute("exerciseList", exerciseList);
            
            // Set user information
            User user = (User) session.getAttribute("user");
            request.setAttribute("user", user);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách bài tập");
        }

        request.getRequestDispatcher("/exercise-form.jsp").forward(request, response);
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
            // Get user from session
            User user = (User) session.getAttribute("user");
            
            // Get form parameters
            String dateStr = request.getParameter("date");
            String exerciseType = request.getParameter("exerciseType");
            String customExerciseName = request.getParameter("customExerciseName");
            String intensity = request.getParameter("intensity");
            String durationStr = request.getParameter("duration");
            String weightStr = request.getParameter("weight");
            String caloriesBurnedStr = request.getParameter("caloriesBurned");
            String notes = request.getParameter("notes");
            
            // Validate required fields
            if (dateStr == null || dateStr.trim().isEmpty() || 
                exerciseType == null || exerciseType.trim().isEmpty() ||
                intensity == null || intensity.trim().isEmpty() ||
                durationStr == null || durationStr.trim().isEmpty()) {
                
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
                doGet(request, response);
                return;
            }
            
            // Handle custom exercise
            if ("other".equals(exerciseType) && (customExerciseName == null || customExerciseName.trim().isEmpty())) {
                request.setAttribute("error", "Vui lòng nhập tên bài tập tùy chỉnh");
                doGet(request, response);
                return;
            }
            
            // Parse numeric values
            int duration = Integer.parseInt(durationStr);
            double weight = weightStr != null && !weightStr.trim().isEmpty() ? 
                          Double.parseDouble(weightStr) : user.getWeight();
            int caloriesBurned = caloriesBurnedStr != null && !caloriesBurnedStr.trim().isEmpty() ? 
                               Integer.parseInt(caloriesBurnedStr) : 0;
            
            // TODO: Save exercise data to database
            // This would typically involve creating an Exercise model and saving via DAO
            
            request.setAttribute("success", "Lưu bài tập thành công!");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu số không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        // Reload the form with success/error message
        doGet(request, response);
    }
}