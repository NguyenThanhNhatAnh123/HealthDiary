package com.healthdiary.servlet;

import com.healthdiary.dao.ExerciseDAO;
import com.healthdiary.model.Exercise_samples;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/exercise/delete")
public class AdminDeleteExerciseServlet extends HttpServlet {
    private ExerciseDAO exerciseDAO;

    @Override
    public void init() throws ServletException {
        exerciseDAO = new ExerciseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID của exercise cần xóa
        String exerciseIdStr = request.getParameter("id");

        if (exerciseIdStr == null || exerciseIdStr.trim().isEmpty()) {
            request.getSession().setAttribute("error", "ID exercise không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/exercises");
            return;
        }

        try {
            int exerciseId = Integer.parseInt(exerciseIdStr.trim());

            // Kiểm tra xem exercise có tồn tại không
            Exercise_samples exercise = exerciseDAO.getExerciseById(exerciseId);
            if (exercise == null) {
                request.getSession().setAttribute("error", "Không tìm thấy exercise với ID: " + exerciseId);
                response.sendRedirect(request.getContextPath() + "/admin/exercises");
                return;
            }

            // Đặt thông tin exercise vào request để hiển thị xác nhận
            request.setAttribute("exercise", exercise);
            request.getRequestDispatcher("/admin_delete_exercise.jsp").forward(request, response);

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
        // Lấy ID của exercise cần xóa
        String exerciseIdStr = request.getParameter("exerciseId");
        String confirmDelete = request.getParameter("confirmDelete");

        // Kiểm tra xác nhận xóa
        if (!"true".equals(confirmDelete)) {
            request.getSession().setAttribute("error", "Vui lòng xác nhận việc xóa exercise");
            response.sendRedirect(request.getContextPath() + "/admin/exercises");
            return;
        }

        if (exerciseIdStr == null || exerciseIdStr.trim().isEmpty()) {
            request.getSession().setAttribute("error", "ID exercise không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/exercises");
            return;
        }

        try {
            int exerciseId = Integer.parseInt(exerciseIdStr.trim());

            // Kiểm tra xem exercise có tồn tại không
            Exercise_samples exercise = exerciseDAO.getExerciseById(exerciseId);
            if (exercise == null) {
                request.getSession().setAttribute("error", "Không tìm thấy exercise với ID: " + exerciseId);
                response.sendRedirect(request.getContextPath() + "/admin/exercises");
                return;
            }

            // Thực hiện xóa exercise
            boolean success = exerciseDAO.deleteExercise(exerciseId);

            if (success) {
                request.getSession().setAttribute("success",
                        "Đã xóa exercise '" + exercise.getExerciseName() + "' thành công!");
            } else {
                request.getSession().setAttribute("error", "Xóa exercise thất bại. Vui lòng thử lại.");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID exercise không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi xóa exercise: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/exercises");
    }
}