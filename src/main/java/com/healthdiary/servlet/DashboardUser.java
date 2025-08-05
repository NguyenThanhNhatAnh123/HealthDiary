
package com.healthdiary.servlet;

import com.healthdiary.dao.*;
import com.healthdiary.model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/dashboard")
public class DashboardUser extends HttpServlet {

    private ExerciseDAO exerciseDAO = new ExerciseDAO();
    private MealDAO mealDAO = new MealDAO();
    private WeightDAO weightDAO = new WeightDAO();
    private HealthDAO healthDAO = new HealthDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String today = LocalDate.now().toString();

        // === Thông tin cơ bản user ===
        request.setAttribute("userName", user.getFullName());
        request.setAttribute("user", user);

        // === Thống kê hôm nay ===
        try {
            // Tổng calo tiêu thụ hôm nay
            double caloriesConsumed = mealDAO.getTotalCaloriesForDate(user.getId(), today);
            request.setAttribute("todayCaloriesIn", Math.round(caloriesConsumed));

            // Tổng calo đốt cháy hôm nay
            double caloriesBurned = exerciseDAO.getTotalCaloriesBurnedForDate(user.getId(), today);
            request.setAttribute("todayCaloriesOut", Math.round(caloriesBurned));

            // Calo ròng (tiêu thụ - đốt cháy)
            double netCalories = caloriesConsumed - caloriesBurned;
            request.setAttribute("todayNetCalories", Math.round(netCalories));

            // Cân nặng gần nhất
            Weight_logs latestWeight = weightDAO.getLatestWeight(user.getId());
            request.setAttribute("latestWeight", latestWeight);

            // Kiểm tra đã ghi cân nặng hôm nay chưa
            boolean hasWeightToday = weightDAO.hasWeightForDate(user.getId(), today);
            request.setAttribute("hasWeightToday", hasWeightToday);

            // Tình trạng sức khỏe hôm nay
            Health_status_logs todayHealth = healthDAO.getHealthStatusForDate(user.getId(), today);
            request.setAttribute("todayHealthStatus", todayHealth);

        } catch (Exception e) {
            // Log error và set giá trị mặc định
            e.printStackTrace();
            request.setAttribute("todayCaloriesIn", 0);
            request.setAttribute("todayCaloriesOut", 0);
            request.setAttribute("todayNetCalories", 0);
            request.setAttribute("todayMealsCount", 0);
            request.setAttribute("todayExercisesCount", 0);
            request.setAttribute("hasWeightToday", false);
        }

        // === Phân tích BMI ===
        if (user.getHeightCm() != null && user.getWeightKg() != null) {
            double heightM = user.getHeightCm() / 100.0;
            double bmi = user.getWeightKg() / (heightM * heightM);
            double bmiRounded = Math.round(bmi * 10.0) / 10.0;

            request.setAttribute("currentBMI", bmiRounded);

            // BMI advice
            String bmiAdvice = "";
            if (bmi < 18.5) {
                bmiAdvice = "Cần tăng cường dinh dưỡng và tập luyện để tăng cân";
            } else if (bmi >= 18.5 && bmi < 25) {
                bmiAdvice = "Duy trì chế độ ăn uống và tập luyện hiện tại";
            } else if (bmi >= 25 && bmi < 30) {
                bmiAdvice = "Cần giảm cân thông qua chế độ ăn và tập luyện";
            } else {
                bmiAdvice = "Cần tham khảo ý kiến bác sĩ để có kế hoạch giảm cân an toàn";
            }
            request.setAttribute("bmiAdvice", bmiAdvice);
        }

        // Forward tới dashboard.jsp
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}