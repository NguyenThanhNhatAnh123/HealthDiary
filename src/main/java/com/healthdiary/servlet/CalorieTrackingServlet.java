package com.healthdiary.servlet;

import com.healthdiary.dao.MealDAO;
import com.healthdiary.dao.ExerciseDAO;
import com.healthdiary.model.Meal;
import com.healthdiary.model.Exercise;
import com.healthdiary.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/calorie-tracking")
public class CalorieTrackingServlet extends HttpServlet {
    private MealDAO mealDAO;
    private ExerciseDAO exerciseDAO;

    @Override
    public void init() throws ServletException {
        mealDAO = new MealDAO();
        exerciseDAO = new ExerciseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = (User) request.getSession().getAttribute("user");
            String date = request.getParameter("date");

            if (date == null) {
                date = LocalDate.now().toString();
            }

            // Calculate total calories consumed
            double totalCaloriesConsumed = mealDAO.getTotalCaloriesForDate(user.getId(), date);

            // Calculate total calories burned
            double totalCaloriesBurned = exerciseDAO.getTotalCaloriesBurnedForDate(user.getId(), date);

            // Get meals and exercises for the day
            List<Meal> meals = mealDAO.getMealsForDate(user.getId(), date);
            List<Exercise> exercises = exerciseDAO.getUserExercisesForDate(user.getId(), date);

            request.setAttribute("date", date);
            request.setAttribute("totalCaloriesConsumed", totalCaloriesConsumed);
            request.setAttribute("totalCaloriesBurned", totalCaloriesBurned);
            request.setAttribute("netCalories", totalCaloriesConsumed - totalCaloriesBurned);
            request.setAttribute("meals", meals);
            request.setAttribute("exercises", exercises);

            request.getRequestDispatcher("calorie-tracking.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải dữ liệu calorie tracking");
            request.getRequestDispatcher("calorie-tracking.jsp").forward(request, response);
        }
    }
}