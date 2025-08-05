<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Exercise Mới - Admin Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 50%, #90caf9 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Header */
        .header {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 20px rgba(25, 118, 210, 0.1);
            padding: 24px 32px;
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            color: #1976d2;
            font-size: 28px;
            font-weight: 700;
        }

        .breadcrumb {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .breadcrumb a {
            color: #1976d2;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .breadcrumb a:hover {
            background: #e3f2fd;
            transform: translateY(-1px);
        }

        .breadcrumb .separator {
            color: #90caf9;
            font-size: 14px;
        }

        /* Form Container */
        .form-container {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            padding: 40px;
            max-width: 800px;
            margin: 0 auto;
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #1976d2, #42a5f5, #1976d2);
        }

        /* Section Headers */
        .section-header {
            color: #1976d2;
            font-size: 20px;
            font-weight: 600;
            margin: 32px 0 24px 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-header:first-child {
            margin-top: 0;
        }

        .section-header i {
            background: #e3f2fd;
            padding: 8px;
            border-radius: 8px;
            font-size: 16px;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 24px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group label {
            color: #1976d2;
            font-weight: 600;
            font-size: 14px;
            display: block;
            margin-bottom: 8px;
        }

        .required {
            color: #d32f2f;
            font-weight: 700;
        }

        /* Form Controls */
        input[type="text"], 
        input[type="email"], 
        input[type="password"], 
        input[type="number"], 
        select, 
        textarea {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e3f2fd;
            border-radius: 12px;
            font-size: 16px;
            background: #fafafa;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        input[type="text"]:focus, 
        input[type="email"]:focus, 
        input[type="password"]:focus, 
        input[type="number"]:focus, 
        select:focus, 
        textarea:focus {
            outline: none;
            border-color: #1976d2;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
            transform: translateY(-1px);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        select {
            cursor: pointer;
        }

        /* Buttons */
        .button-group {
            display: flex;
            gap: 16px;
            justify-content: center;
            margin-top: 40px;
            padding-top: 24px;
            border-top: 1px solid #e3f2fd;
        }

        .btn {
            padding: 14px 32px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 118, 210, 0.4);
        }

        .btn-secondary {
            background: #fff;
            color: #1976d2;
            border: 2px solid #1976d2;
        }

        .btn-secondary:hover {
            background: #e3f2fd;
            transform: translateY(-1px);
        }

        /* Alerts */
        .alert {
            border-radius: 12px;
            padding: 16px 20px;
            margin-bottom: 24px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert-error {
            background: #ffebee;
            color: #d32f2f;
            border-left: 4px solid #d32f2f;
        }

        .alert-success {
            background: #e8f5e8;
            color: #2e7d32;
            border-left: 4px solid #4caf50;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 16px;
                text-align: center;
            }

            .form-container {
                padding: 24px;
                margin: 16px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        /* Loading animation */
        .btn-primary:active {
            transform: translateY(0);
        }

        /* Hover effects */
        .form-group:hover label {
            color: #1565c0;
        }

        /* Custom focus ring */
        .form-group:focus-within label {
            color: #1565c0;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-dumbbell"></i> Thêm Exercise Mới</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin-dashboard">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <span class="separator">•</span>
                <a href="${pageContext.request.contextPath}/admin/exercises">
                    <i class="fas fa-dumbbell"></i> Danh sách Exercise
                </a>
                <span class="separator">•</span>
                <span style="color: #666;">Thêm Exercise</span>
            </div>
        </div>

        <!-- Form Container -->
        <div class="form-container">
            <!-- Error Alert từ server -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Success Alert từ server -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <span>${success}</span>
                </div>
            </c:if>

            <!-- Client-side alerts -->
            <div class="alert alert-success" style="display: none;" id="successAlert">
                <i class="fas fa-check-circle"></i>
                <span>Thêm exercise thành công!</span>
            </div>

            <div class="alert alert-error" style="display: none;" id="errorAlert">
                <i class="fas fa-exclamation-triangle"></i>
                <span>Có lỗi xảy ra, vui lòng thử lại!</span>
            </div>

            <!-- FORM với action và method -->
            <form id="addExerciseForm" action="${pageContext.request.contextPath}/admin/exercise/add" method="POST">
                <!-- Basic Information -->
                <div class="section-header">
                    <i class="fas fa-dumbbell"></i>
                    Thông tin cơ bản
                </div>

                <div class="form-group">
                    <label for="exerciseName">Tên bài tập <span class="required">*</span></label>
                    <input type="text" id="exerciseName" name="exerciseName" required placeholder="Nhập tên bài tập" value="${param.exerciseName}">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="type">Loại bài tập <span class="required">*</span></label>
                        <select id="type" name="type" required>
                            <option value="">Chọn loại bài tập</option>
                            <option value="Cardio" ${param.type == 'Cardio' ? 'selected' : ''}>Cardio</option>
                            <option value="Strength" ${param.type == 'Strength' ? 'selected' : ''}>Strength</option>
                            <option value="Flexibility" ${param.type == 'Flexibility' ? 'selected' : ''}>Flexibility</option>
                            <option value="Balance" ${param.type == 'Balance' ? 'selected' : ''}>Balance</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="muscleGroup">Nhóm cơ <span class="required">*</span></label>
                        <input type="text" id="muscleGroup" name="muscleGroup" required placeholder="Nhập nhóm cơ" value="${param.muscleGroup}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="difficulty">Độ khó <span class="required">*</span></label>
                        <select id="difficulty" name="difficulty" required>
                            <option value="">Chọn độ khó</option>
                            <option value="Beginner" ${param.difficulty == 'Beginner' ? 'selected' : ''}>Beginner</option>
                            <option value="Intermediate" ${param.difficulty == 'Intermediate' ? 'selected' : ''}>Intermediate</option>
                            <option value="Advanced" ${param.difficulty == 'Advanced' ? 'selected' : ''}>Advanced</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="caloriesPerHour">Calories/giờ (kcal) <span class="required">*</span></label>
                        <input type="number" id="caloriesPerHour" name="caloriesPerHour" required min="0" placeholder="Nhập calories/giờ" value="${param.caloriesPerHour}">
                    </div>
                </div>

                <!-- Buttons -->
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Thêm Exercise
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/exercises" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Hủy
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Form validation trước khi submit
        document.getElementById('addExerciseForm').addEventListener('submit', function(e) {
            const caloriesPerHour = document.getElementById('caloriesPerHour').value;
            
            // Kiểm tra calories per hour phải là số dương
            if (caloriesPerHour && parseInt(caloriesPerHour) < 0) {
                e.preventDefault();
                showAlert('error', 'Calories per hour phải là số dương!');
                return false;
            }
            
            // Hiển thị loading
            const submitBtn = document.querySelector('.btn-primary');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
            submitBtn.disabled = true;
            
            // Cho phép form submit bình thường
            return true;
        });

        function showAlert(type, message) {
            const alertId = type === 'success' ? 'successAlert' : 'errorAlert';
            const alert = document.getElementById(alertId);
            alert.querySelector('span').textContent = message;
            alert.style.display = 'flex';
            
            setTimeout(() => {
                alert.style.display = 'none';
            }, 3000);
        }

        // Real-time validation cho calories per hour
        document.getElementById('caloriesPerHour').addEventListener('input', function() {
            const value = this.value;
            if (value && parseInt(value) < 0) {
                this.style.borderColor = '#d32f2f';
            } else {
                this.style.borderColor = '#e3f2fd';
            }
        });
    </script>
</body>
</html>