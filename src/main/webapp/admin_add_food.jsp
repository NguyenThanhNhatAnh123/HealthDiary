<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Food Mới - Admin Dashboard</title>
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
            <h1><i class="fas fa-utensils"></i> Thêm Food Mới</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin-dashboard">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <span class="separator">•</span>
                <a href="${pageContext.request.contextPath}/admin/foods">
                    <i class="fas fa-utensils"></i> Danh sách Food
                </a>
                <span class="separator">•</span>
                <span style="color: #666;">Thêm Food</span>
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
                <span>Thêm food thành công!</span>
            </div>

            <div class="alert alert-error" style="display: none;" id="errorAlert">
                <i class="fas fa-exclamation-triangle"></i>
                <span>Có lỗi xảy ra, vui lòng thử lại!</span>
            </div>

            <!-- FORM với action và method -->
            <form id="addFoodForm" action="${pageContext.request.contextPath}/admin/food/add" method="POST">
                <!-- Basic Information -->
                <div class="section-header">
                    <i class="fas fa-utensils"></i>
                    Thông tin cơ bản
                </div>

                <div class="form-group">
                    <label for="foodName">Tên món ăn <span class="required">*</span></label>
                    <input type="text" id="foodName" name="foodName" required placeholder="Nhập tên món ăn" value="${param.foodName}">
                </div>

                <div class="form-group">
                    <label for="type">Loại món ăn <span class="required">*</span></label>
                    <select id="type" name="type" required>
                        <option value="">Chọn loại món ăn</option>
                        <option value="Breakfast" ${param.type == 'Breakfast' ? 'selected' : ''}>Breakfast</option>
                        <option value="Lunch" ${param.type == 'Lunch' ? 'selected' : ''}>Lunch</option>
                        <option value="Dinner" ${param.type == 'Dinner' ? 'selected' : ''}>Dinner</option>
                        <option value="Snack" ${param.type == 'Snack' ? 'selected' : ''}>Snack</option>
                    </select>
                </div>

                <!-- Nutritional Information -->
                <div class="section-header">
                    <i class="fas fa-chart-pie"></i>
                    Thông tin dinh dưỡng
                </div>

                <div class="form-group">
                    <label for="calories">Calories (kcal) <span class="required">*</span></label>
                    <input type="number" id="calories" name="calories" required min="0" placeholder="Nhập calories" value="${param.calories}">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="protein">Protein (g)</label>
                        <input type="number" id="protein" name="protein" min="0" step="0.1" placeholder="Nhập protein" value="${param.protein}">
                    </div>
                    <div class="form-group">
                        <label for="carbs">Carbs (g)</label>
                        <input type="number" id="carbs" name="carbs" min="0" step="0.1" placeholder="Nhập carbs" value="${param.carbs}">
                    </div>
                </div>

                <div class="form-group">
                    <label for="fat">Fat (g)</label>
                    <input type="number" id="fat" name="fat" min="0" step="0.1" placeholder="Nhập fat" value="${param.fat}">
                </div>

                <!-- Buttons -->
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Thêm Food
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/foods" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Hủy
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Form validation trước khi submit
        document.getElementById('addFoodForm').addEventListener('submit', function(e) {
            const calories = document.getElementById('calories').value;
            const protein = document.getElementById('protein').value;
            const carbs = document.getElementById('carbs').value;
            const fat = document.getElementById('fat').value;
            
            // Kiểm tra calories phải là số dương
            if (calories && parseInt(calories) < 0) {
                e.preventDefault();
                showAlert('error', 'Calories phải là số dương!');
                return false;
            }
            
            // Kiểm tra protein phải là số dương
            if (protein && parseFloat(protein) < 0) {
                e.preventDefault();
                showAlert('error', 'Protein phải là số dương!');
                return false;
            }
            
            // Kiểm tra carbs phải là số dương
            if (carbs && parseFloat(carbs) < 0) {
                e.preventDefault();
                showAlert('error', 'Carbs phải là số dương!');
                return false;
            }
            
            // Kiểm tra fat phải là số dương
            if (fat && parseFloat(fat) < 0) {
                e.preventDefault();
                showAlert('error', 'Fat phải là số dương!');
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

        // Real-time validation cho các trường số
        const numberInputs = ['calories', 'protein', 'carbs', 'fat'];
        numberInputs.forEach(inputId => {
            document.getElementById(inputId).addEventListener('input', function() {
                const value = this.value;
                if (value && parseFloat(value) < 0) {
                    this.style.borderColor = '#d32f2f';
                } else {
                    this.style.borderColor = '#e3f2fd';
                }
            });
        });
    </script>
</body>
</html>