package com.healthdiary.servlet;

import com.healthdiary.model.Exercise_samples;
import com.healthdiary.dao.ExerciseDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/exercise/add")
public class AdminAddExerciseServlet extends HttpServlet {
    private ExerciseDAO exerciseDAO;

    @Override
    public void init() throws ServletException {
        exerciseDAO = new ExerciseDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("login_admin");
            return;
        }
        
        // Hiển thị form thêm exercise
        request.getRequestDispatcher("/admin_add_exercise.jsp").forward(request, response);
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
        
        request.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String exerciseName = request.getParameter("exerciseName");
        String type = request.getParameter("type");
        String muscleGroup = request.getParameter("muscleGroup");
        String difficulty = request.getParameter("difficulty");
        String caloriesPerHourStr = request.getParameter("caloriesPerHour");
        
        // Ensure parameters are not null
        if (exerciseName == null) exerciseName = "";
        if (type == null) type = "";
        if (muscleGroup == null) muscleGroup = "";
        if (difficulty == null) difficulty = "";
        if (caloriesPerHourStr == null) caloriesPerHourStr = "";

        // Kiểm tra dữ liệu bắt buộc
        if (exerciseName.trim().isEmpty() ||
                type.trim().isEmpty() ||
                muscleGroup.trim().isEmpty() ||
                difficulty.trim().isEmpty() ||
                caloriesPerHourStr.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            request.getRequestDispatcher("/admin_add_exercise.jsp").forward(request, response);
            return;
        }

        // Parse calories per hour
        int caloriesPerHour;
        try {
            caloriesPerHour = Integer.parseInt(caloriesPerHourStr.trim());
            if (caloriesPerHour < 0) {
                request.setAttribute("error", "Calories per hour phải là số dương");
                request.getRequestDispatcher("/admin_add_exercise.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Calories per hour không hợp lệ");
            request.getRequestDispatcher("/admin_add_exercise.jsp").forward(request, response);
            return;
        }

        // Tạo exercise object
        Exercise_samples exercise = new Exercise_samples();
        exercise.setExerciseName(exerciseName);
        exercise.setType(type);
        exercise.setMuscleGroup(muscleGroup);
        exercise.setDifficulty(difficulty);
        exercise.setCaloriesPerHour(caloriesPerHour);

        // Lưu exercise vào database
        try {
            boolean success = exerciseDAO.addExercise(exercise);
            if (success) {
                request.getSession().setAttribute("success", "Thêm exercise thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/exercises");
            } else {
                request.setAttribute("error", "Thêm exercise thất bại.");
                request.getRequestDispatcher("/admin_add_exercise.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi thêm exercise: " + e.getMessage());
            request.getRequestDispatcher("/admin_add_exercise.jsp").forward(request, response);
        }
    }
}