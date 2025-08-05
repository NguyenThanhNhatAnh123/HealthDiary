package com.healthdiary.servlet;

import com.healthdiary.dao.ExerciseDAO;
import com.healthdiary.model.Exercise_samples;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/exercises")
public class AdminListExerciseServlet extends HttpServlet {
    private ExerciseDAO exerciseDAO;

    @Override
    public void init() throws ServletException {
        exerciseDAO = new ExerciseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy danh sách tất cả exercise
            List<Exercise_samples> exercises = exerciseDAO.getAllExercises();

            // Đặt danh sách exercise vào request attribute
            request.setAttribute("exercises", exercises);

            // Kiểm tra có thông báo success từ session không
            String successMessage = (String) request.getSession().getAttribute("success");
            if (successMessage != null) {
                request.setAttribute("success", successMessage);
                request.getSession().removeAttribute("success"); // Xóa sau khi hiển thị
            }

            // Forward đến JSP
            request.getRequestDispatcher("/admin_list_exercise.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải danh sách exercise: " + e.getMessage());
            request.getRequestDispatcher("/admin_list_exercise.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String exerciseIdStr = request.getParameter("exerciseId");

            if (exerciseIdStr != null) {
                try {
                    int exerciseId = Integer.parseInt(exerciseIdStr);
                    boolean success = exerciseDAO.deleteExercise(exerciseId);

                    if (success) {
                        request.getSession().setAttribute("success", "Xóa exercise thành công!");
                    } else {
                        request.getSession().setAttribute("error", "Xóa exercise thất bại!");
                    }
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("error", "ID exercise không hợp lệ!");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.getSession().setAttribute("error", "Lỗi khi xóa exercise: " + e.getMessage());
                }
            }
        }

        // Redirect để tránh form resubmission
        response.sendRedirect(request.getContextPath() + "/admin/exercises");
    }
}