package com.healthdiary.servlet;

import com.healthdiary.dao.ExerciseDAO;
import com.healthdiary.model.Exercise;
import com.healthdiary.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/exercise-history")
public class ExerciseHistoryServlet extends HttpServlet {
    private ExerciseDAO exerciseDAO;

    @Override
    public void init() throws ServletException {
        exerciseDAO = new ExerciseDAO();
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
            List<Exercise> exercises = exerciseDAO.getUserExercises(user.getId());

            request.setAttribute("exercises", exercises);
            request.getRequestDispatcher("exercise-history.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải lịch sử bài tập");
            request.getRequestDispatcher("exercise-history.jsp").forward(request, response);
        }
    }
}
