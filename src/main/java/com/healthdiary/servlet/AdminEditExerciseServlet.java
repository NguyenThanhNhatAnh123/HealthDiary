package com.healthdiary.servlet;

import com.healthdiary.dao.ExerciseDAO;
import com.healthdiary.model.Exercise_samples;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/exercise/edit")
public class AdminEditExerciseServlet extends HttpServlet {
    private ExerciseDAO exerciseDAO;

    @Override
    public void init() throws ServletException {
        exerciseDAO = new ExerciseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String exerciseIdStr = request.getParameter("id");

        if (exerciseIdStr == null || exerciseIdStr.trim().isEmpty()) {
            request.getSession().setAttribute("error", "ID exercise không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/exercises");
            return;
        }

        try {
            int exerciseId = Integer.parseInt(exerciseIdStr.trim());
            Exercise_samples exercise = exerciseDAO.getExerciseById(exerciseId);

            if (exercise == null) {
                request.getSession().setAttribute("error", "Không tìm thấy exercise với ID: " + exerciseId);
                response.sendRedirect(request.getContextPath() + "/admin/exercises");
                return;
            }

            request.setAttribute("exercise", exercise);
            request.getRequestDispatcher("/admin_edit_exercise.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID exercise không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/exercises");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi tải thông tin exercise");
            response.sendRedirect(request.getContextPath() + "/admin/exercises");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String exerciseIdStr = request.getParameter("exerciseId");
        String exerciseName = request.getParameter("exerciseName");
        String type = request.getParameter("type");
        String muscleGroup = request.getParameter("muscleGroup");
        String difficulty = request.getParameter("difficulty");
        String caloriesPerHourStr = request.getParameter("caloriesPerHour");

        if (exerciseIdStr == null || exerciseIdStr.trim().isEmpty()) {
            request.getSession().setAttribute("error", "ID exercise không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/exercises");
            return;
        }

        int exerciseId;
        try {
            exerciseId = Integer.parseInt(exerciseIdStr.trim());
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID exercise không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/exercises");
            return;
        }

        Exercise_samples currentExercise;
        try {
            currentExercise = exerciseDAO.getExerciseById(exerciseId);
            if (currentExercise == null) {
                request.getSession().setAttribute("error", "Không tìm thấy exercise với ID: " + exerciseId);
                response.sendRedirect(request.getContextPath() + "/admin/exercises");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi tải thông tin exercise");
            response.sendRedirect(request.getContextPath() + "/admin/exercises");
            return;
        }

        // Validate dữ liệu bắt buộc
        if (exerciseName == null || exerciseName.trim().isEmpty() ||
                type == null || type.trim().isEmpty() ||
                muscleGroup == null || muscleGroup.trim().isEmpty() ||
                difficulty == null || difficulty.trim().isEmpty() ||
                caloriesPerHourStr == null || caloriesPerHourStr.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            request.setAttribute("exercise", currentExercise);
            request.getRequestDispatcher("/admin_edit_exercise.jsp").forward(request, response);
            return;
        }

        // Parse calories per hour
        int caloriesPerHour;
        try {
            caloriesPerHour = Integer.parseInt(caloriesPerHourStr.trim());
            if (caloriesPerHour < 0) {
                request.setAttribute("error", "Calories per hour phải là số dương");
                request.setAttribute("exercise", currentExercise);
                request.getRequestDispatcher("/admin_edit_exercise.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Calories per hour không hợp lệ");
            request.setAttribute("exercise", currentExercise);
            request.getRequestDispatcher("/admin_edit_exercise.jsp").forward(request, response);
            return;
        }

        // Cập nhật exercise
        currentExercise.setExerciseName(exerciseName.trim());
        currentExercise.setType(type.trim());
        currentExercise.setMuscleGroup(muscleGroup.trim());
        currentExercise.setDifficulty(difficulty.trim());
        currentExercise.setCaloriesPerHour(caloriesPerHour);

        try {
            boolean updated = exerciseDAO.updateExercise(currentExercise);
            if (updated) {
                request.getSession().setAttribute("success", "Cập nhật exercise thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/exercises");
            } else {
                request.setAttribute("error", "Cập nhật exercise thất bại.");
                request.setAttribute("exercise", currentExercise);
                request.getRequestDispatcher("/admin_edit_exercise.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi cập nhật exercise: " + e.getMessage());
            request.setAttribute("exercise", currentExercise);
            request.getRequestDispatcher("/admin_edit_exercise.jsp").forward(request, response);
        }
    }
}