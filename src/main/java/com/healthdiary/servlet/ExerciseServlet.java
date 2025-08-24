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
public class ExerciseServlet extends HttpServlet {
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
            // Load exercise samples for dropdown
            List<Exercise_samples> exerciseSamples = exerciseDAO.getAllExercises();
            request.setAttribute("exerciseList", exerciseSamples);

            // Debug: Print the list size
            System.out.println("Loaded " + exerciseSamples.size() + " exercises from database");
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
            
            // Ensure parameters are not null
            if (notes == null) {
                notes = "";
            }
            if (weightStr == null) {
                weightStr = "";
            }

            // Debug: Print received parameters
            System.out.println("=== Exercise Form Submission ===");
            System.out.println("Date: " + dateStr);
            System.out.println("Exercise Type: " + exerciseTypeParam);
            System.out.println("Custom Name: " + customExerciseName);
            System.out.println("Intensity: " + intensityParam);
            System.out.println("Duration: " + durationStr);
            System.out.println("Weight: " + weightStr);
            System.out.println("Calories: " + caloriesBurnedStr);
            System.out.println("Notes: " + notes);

            // Validation
            if (dateStr == null || dateStr.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng chọn thời gian");
                doGet(request, response);
                return;
            }
            
            // Ensure dateStr is not null
            if (dateStr == null) {
                dateStr = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").format(new Date());
            }

            if (exerciseTypeParam == null || exerciseTypeParam.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng chọn loại bài tập");
                doGet(request, response);
                return;
            }
            
            // Ensure exerciseTypeParam is not null
            if (exerciseTypeParam == null) {
                exerciseTypeParam = "other";
            }

            if ("other".equals(exerciseTypeParam) && (customExerciseName == null || customExerciseName.trim().isEmpty())) {
                request.setAttribute("error", "Vui lòng nhập tên bài tập");
                doGet(request, response);
                return;
            }
            
            // Ensure customExerciseName is not null
            if (customExerciseName == null) {
                customExerciseName = "";
            }
            
            // Ensure exerciseTypeParam is not null
            if (exerciseTypeParam == null) {
                exerciseTypeParam = "other";
            }

            if (intensityParam == null || intensityParam.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng chọn cường độ");
                doGet(request, response);
                return;
            }
            
            // Ensure intensityParam is not null
            if (intensityParam == null) {
                intensityParam = "medium";
            }
            
            // Ensure dateStr is not null
            if (dateStr == null) {
                dateStr = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").format(new Date());
            }

            if (durationStr == null || durationStr.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập thời gian");
                doGet(request, response);
                return;
            }
            
            // Ensure durationStr is not null
            if (durationStr == null) {
                durationStr = "30";
            }
            
            // Ensure caloriesBurnedStr is not null
            if (caloriesBurnedStr == null) {
                caloriesBurnedStr = "0";
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
            
            // Ensure caloriesBurnedStr is not null
            if (caloriesBurnedStr == null) {
                caloriesBurnedStr = "0";
            }

            // Determine exercise name
            String exerciseName = null;
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
            
            // Ensure weightStr is not null for display purposes
            if (weightStr == null) {
                weightStr = "";
            }
            
            // Ensure notes is not null
            if (notes == null) {
                notes = "";
            }
            
            // Validate that we have a valid exercise name
            if (exerciseName == null || exerciseName.trim().isEmpty()) {
                request.setAttribute("error", "Tên bài tập không hợp lệ");
                doGet(request, response);
                return;
            }
            
            // Ensure exerciseName is not null
            if (exerciseName == null) {
                exerciseName = "Unknown Exercise";
            }

            // Create and save exercise
            Exercise exercise = new Exercise();
            exercise.setUserId(user.getId());
            String intensityDisplay = intensityParam != null ? intensityParam : "medium";
            exercise.setExerciseType(exerciseName + " (" + intensityDisplay + ")");
            exercise.setDurationMin(duration);
            exercise.setCaloriesBurned(caloriesBurned);
            exercise.setLogDate(logDate);
            
            // Ensure all required fields are set
            if (exercise.getUserId() <= 0 || exercise.getExerciseType() == null || exercise.getDurationMin() <= 0) {
                request.setAttribute("error", "Dữ liệu bài tập không hợp lệ");
                doGet(request, response);
                return;
            }

            System.out.println("Saving exercise: " + exercise.toString());

            boolean success = exerciseDAO.addUserExercise(exercise);

            if (success) {
                request.setAttribute("success", "Ghi nhận bài tập thành công! Đã đốt cháy " + caloriesBurned + " calories.");
                System.out.println("Exercise saved successfully!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi lưu bài tập vào database");
                System.out.println("Failed to save exercise to database");
            }
            
            // Ensure we have a valid exercise object before proceeding
            if (exercise == null) {
                request.setAttribute("error", "Không thể tạo đối tượng bài tập");
                doGet(request, response);
                return;
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
        
        // Ensure we always have a valid response
        if (response.isCommitted()) {
            return;
        }
    }

    /**
     * Calculate calories on server side as fallback
     */
    private int calculateCaloriesServer(String exerciseTypeParam, String intensity, int duration, String weightStr) {
        try {
            // Validate parameters
            if (exerciseTypeParam == null || intensity == null || duration <= 0) {
                return Math.max(duration * 5, 1); // Fallback: 5 calories per minute, minimum 1
            }
            
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
            if (intensity != null) {
                switch (intensity.toLowerCase()) {
                    case "low":
                        intensityMultiplier = 0.7;
                        break;
                    case "medium":
                        intensityMultiplier = 1.0;
                        break;
                    case "high":
                        intensityMultiplier = 1.3;
                        break;
                    default:
                        intensityMultiplier = 1.0; // Default to medium
                        break;
                }
            }

            // Adjust for weight (assuming base calories are for 70kg person)
            double weightFactor = weight / 70.0;
            double caloriesPerHour = baseCaloriesPerHour * intensityMultiplier * weightFactor;
            double caloriesPerMinute = caloriesPerHour / 60.0;
            
            int calculatedCalories = (int) Math.round(caloriesPerMinute * duration);
            return Math.max(calculatedCalories, 1); // Ensure at least 1 calorie
        } catch (Exception e) {
            System.out.println("Error calculating calories: " + e.getMessage());
            return Math.max(duration * 5, 1); // Fallback: 5 calories per minute, minimum 1
        }
        } catch (Exception e) {
            System.out.println("Error calculating calories: " + e.getMessage());
            return Math.max(duration * 5, 1); // Fallback: 5 calories per minute, minimum 1
        }
    }
}