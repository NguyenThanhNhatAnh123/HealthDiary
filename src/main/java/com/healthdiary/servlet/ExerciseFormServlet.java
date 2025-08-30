package com.healthdiary.servlet;

import com.healthdiary.dao.ExerciseDAO;
import com.healthdiary.model.Exercise;
import com.healthdiary.model.Exercise_samples;
import com.healthdiary.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            User user = (User) session.getAttribute("user");
            
            // Load exercise samples for dropdown
            List<Exercise_samples> exerciseSamples = exerciseDAO.getAllExercises();
            request.setAttribute("exerciseList", exerciseSamples);

            // Load user's exercise history (recent 10 entries)
            List<Exercise> userExercises = exerciseDAO.getUserExercises(user.getId());
            if (userExercises.size() > 10) {
                userExercises = userExercises.subList(0, 10); // Limit to recent 10 entries
            }
            request.setAttribute("userExercises", userExercises);

            // Debug: Print the list sizes
            System.out.println("Loaded " + exerciseSamples.size() + " exercise samples from database");
            System.out.println("Loaded " + userExercises.size() + " user exercises from database");
            
            for (Exercise_samples ex : exerciseSamples) {
                System.out.println("Exercise: " + ex.getExerciseName() + " - " + ex.getCaloriesPerHour() + " kcal/h");
            }

            request.getRequestDispatcher("exercise-form.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách bài tập: " + e.getMessage());
            request.getRequestDispatcher("exercise-form.jsp").forward(request, response);
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

        // Set character encoding for Vietnamese text
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            User user = (User) session.getAttribute("user");
            
            // Get form parameters
            String dateStr = request.getParameter("date");
            String exerciseTypeParam = request.getParameter("exerciseType");
            String customExerciseName = request.getParameter("customExerciseName");
            String intensityParam = request.getParameter("intensity");
            String durationStr = request.getParameter("duration");
            String weightStr = request.getParameter("weight");
            String caloriesBurnedStr = request.getParameter("caloriesBurned");
            String notes = request.getParameter("notes");

            // Debug: Print received parameters
//            System.out.println("=== Exercise Form Submission ===");
//            System.out.println("Date: " + dateStr);
//            System.out.println("Exercise Type: " + exerciseTypeParam);
//            System.out.println("Custom Name: " + customExerciseName);
//            System.out.println("Intensity: " + intensityParam);
//            System.out.println("Duration: " + durationStr);
//            System.out.println("Weight: " + weightStr);
//            System.out.println("Calories: " + caloriesBurnedStr);
//            System.out.println("Notes: " + notes);

            // Validation
            if (dateStr == null || dateStr.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng chọn thời gian");
                doGet(request, response);
                return;
            }

            if (exerciseTypeParam == null || exerciseTypeParam.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng chọn loại bài tập");
                doGet(request, response);
                return;
            }

            if ("other".equals(exerciseTypeParam) && (customExerciseName == null || customExerciseName.trim().isEmpty())) {
                request.setAttribute("error", "Vui lòng nhập tên bài tập");
                doGet(request, response);
                return;
            }

            if (intensityParam == null || intensityParam.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng chọn cường độ");
                doGet(request, response);
                return;
            }

            if (durationStr == null || durationStr.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập thời gian");
                doGet(request, response);
                return;
            }

            // Parse and validate values
            Date logDate;
            int duration;
            int caloriesBurned;

            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                logDate = sdf.parse(dateStr);
            } catch (Exception e) {
                request.setAttribute("error", "Định dạng thời gian không hợp lệ");
                doGet(request, response);
                return;
            }

            try {
                duration = Integer.parseInt(durationStr);
                if (duration <= 0 || duration > 600) {
                    request.setAttribute("error", "Thời gian phải từ 1 đến 600 phút");
                    doGet(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Thời gian phải là số");
                doGet(request, response);
                return;
            }

            try {
                caloriesBurned = caloriesBurnedStr != null ? Integer.parseInt(caloriesBurnedStr) : 0;
                if (caloriesBurned < 0) {
                    caloriesBurned = 0;
                }
            } catch (NumberFormatException e) {
                caloriesBurned = 0;
            }

            // Determine exercise name
            String exerciseName;
            if ("other".equals(exerciseTypeParam)) {
                exerciseName = customExerciseName.trim();
            } else {
                try {
                    int exerciseId = Integer.parseInt(exerciseTypeParam);
                    Exercise_samples exerciseSample = exerciseDAO.getExerciseById(exerciseId);
                    if (exerciseSample != null) {
                        exerciseName = exerciseSample.getExerciseName();
                    } else {
                        request.setAttribute("error", "Bài tập được chọn không tồn tại");
                        doGet(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID bài tập không hợp lệ");
                    doGet(request, response);
                    return;
                }
            }

            // If calories not calculated on client side, calculate here
            if (caloriesBurned == 0) {
                caloriesBurned = calculateCaloriesServer(exerciseTypeParam, intensityParam, duration, weightStr);
            }

            // Create and save exercise
            Exercise exercise = new Exercise();
            exercise.setUserId(user.getId());
            exercise.setExerciseType(exerciseName + " (" + intensityParam + ")");
            exercise.setDurationMin(duration);
            exercise.setCaloriesBurned(caloriesBurned);
            exercise.setLogDate(logDate);

            System.out.println("Saving exercise: " + exercise.toString());

            boolean success = exerciseDAO.addUserExercise(exercise);

            if (success) {
                request.setAttribute("success", "Ghi nhận bài tập thành công! Đã đốt cháy " + caloriesBurned + " calories.");
                System.out.println("Exercise saved successfully!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi lưu bài tập vào database");
                System.out.println("Failed to save exercise to database");
            }

            doGet(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu nhập vào không hợp lệ: " + e.getMessage());
            doGet(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi lưu bài tập: " + e.getMessage());
            doGet(request, response);
        }
    }

    /**
     * Calculate calories on server side as fallback
     */
    private int calculateCaloriesServer(String exerciseTypeParam, String intensity, int duration, String weightStr) {
        try {
            double weight = weightStr != null ? Double.parseDouble(weightStr) : 70.0;
            int baseCaloriesPerHour = 300; // Default

            if (!"other".equals(exerciseTypeParam)) {
                try {
                    int exerciseId = Integer.parseInt(exerciseTypeParam);
                    Exercise_samples exerciseSample = exerciseDAO.getExerciseById(exerciseId);
                    if (exerciseSample != null) {
                        baseCaloriesPerHour = exerciseSample.getCaloriesPerHour();
                    }
                } catch (Exception e) {
                    System.out.println("Error getting exercise calories: " + e.getMessage());
                }
            }

            // Adjust for intensity
            double intensityMultiplier = 1.0;
            switch (intensity) {
                case "low":
                    intensityMultiplier = 0.7;
                    break;
                case "medium":
                    intensityMultiplier = 1.0;
                    break;
                case "high":
                    intensityMultiplier = 1.3;
                    break;
            }

            // Adjust for weight (assuming base calories are for 70kg person)
            double weightFactor = weight / 70.0;
            double caloriesPerHour = baseCaloriesPerHour * intensityMultiplier * weightFactor;
            double caloriesPerMinute = caloriesPerHour / 60.0;
            
            return (int) Math.round(caloriesPerMinute * duration);
        } catch (Exception e) {
            System.out.println("Error calculating calories: " + e.getMessage());
            return duration * 5; // Fallback: 5 calories per minute
        }
    }
}