<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Food - Admin Dashboard</title>
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
        .edit-form-container {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            max-width: 800px;
            margin: 0 auto;
            position: relative;
            overflow: hidden;
        }

        .edit-form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #1976d2, #42a5f5, #1976d2);
        }

        .form-header {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            padding: 40px 32px;
            text-align: center;
        }

        .form-header i {
            font-size: 48px;
            margin-bottom: 16px;
            display: block;
        }

        .form-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .form-header p {
            font-size: 16px;
            opacity: 0.9;
        }

        .form-content {
            padding: 40px 32px;
        }

        /* Section Headers */
        .section-title {
            color: #1976d2;
            font-size: 20px;
            font-weight: 600;
            margin: 32px 0 24px 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-title:first-child {
            margin-top: 0;
        }

        .section-title i {
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

        .form-label {
            color: #1976d2;
            font-weight: 600;
            font-size: 14px;
            display: block;
            margin-bottom: 8px;
        }

        .form-label i {
            margin-right: 8px;
        }

        .required {
            color: #d32f2f;
            font-weight: 700;
        }

        /* Form Controls */
        .form-input, 
        .form-select, 
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

        .form-input:focus, 
        .form-select:focus, 
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

        .form-select {
            cursor: pointer;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        /* Buttons */
        .action-buttons {
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

        /* Error Message */
        .error-message {
            background: #ffebee;
            color: #d32f2f;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 24px;
            border-left: 4px solid #d32f2f;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        /* Success Message */
        .success-message {
            background: #e8f5e8;
            color: #2e7d32;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 24px;
            border-left: 4px solid #4caf50;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 16px;
                text-align: center;
            }

            .edit-form-container {
                margin: 16px;
            }

            .form-header {
                padding: 32px 24px;
            }

            .form-content {
                padding: 32px 24px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-utensils"></i> Chỉnh sửa Food</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin-dashboard">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <span class="separator">•</span>
                <a href="${pageContext.request.contextPath}/admin/foods">
                    <i class="fas fa-utensils"></i> Danh sách Food
                </a>
                <span class="separator">•</span>
                <span style="color: #666;">Chỉnh sửa Food</span>
            </div>
        </div>

        <!-- Form Container -->
        <div class="edit-form-container">
            <div class="form-header">
                <i class="fas fa-utensils"></i>
                <h1>Chỉnh sửa Food</h1>
                <p>Cập nhật thông tin món ăn trong hệ thống</p>
            </div>

            <div class="form-content">
                <c:if test="${not empty error}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${error}</span>
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="success-message">
                        <i class="fas fa-check-circle"></i>
                        <span>${success}</span>
                    </div>
                </c:if>

                <c:if test="${not empty food}">
                    <form action="${pageContext.request.contextPath}/admin/food/edit" method="post">
                        <input type="hidden" name="foodId" value="${food.id}">
                        
                        <!-- Thông tin cơ bản -->
                        <div class="section-title">
                            <i class="fas fa-utensils"></i>
                            Thông tin cơ bản
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-utensils"></i>
                                Tên món ăn <span class="required">*</span>
                            </label>
                            <input type="text" name="foodName" class="form-input" value="${food.foodName}" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-tag"></i>
                                Loại món ăn <span class="required">*</span>
                            </label>
                            <select name="type" class="form-select" required>
                                <option value="">Chọn loại món ăn</option>
                                <option value="Breakfast" <c:if test="${food.type == 'Breakfast'}">selected</c:if>>Breakfast</option>
                                <option value="Lunch" <c:if test="${food.type == 'Lunch'}">selected</c:if>>Lunch</option>
                                <option value="Dinner" <c:if test="${food.type == 'Dinner'}">selected</c:if>>Dinner</option>
                                <option value="Snack" <c:if test="${food.type == 'Snack'}">selected</c:if>>Snack</option>
                            </select>
                        </div>
                        
                        <!-- Thông tin dinh dưỡng -->
                        <div class="section-title">
                            <i class="fas fa-chart-pie"></i>
                            Thông tin dinh dưỡng
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-fire"></i>
                                Calories (kcal) <span class="required">*</span>
                            </label>
                            <input type="number" name="calories" class="form-input" value="${food.calories}" min="0" required>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-dumbbell"></i>
                                    Protein (g)
                                </label>
                                <input type="number" name="protein" class="form-input" value="${food.protein}" min="0" step="0.1">
                            </div>
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-bread-slice"></i>
                                    Carbs (g)
                                </label>
                                <input type="number" name="carbs" class="form-input" value="${food.carbs}" min="0" step="0.1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-oil-can"></i>
                                Fat (g)
                            </label>
                            <input type="number" name="fat" class="form-input" value="${food.fat}" min="0" step="0.1">
                        </div>
                        
                        <div class="action-buttons">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i>
                                Cập nhật Food
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/foods" class="btn btn-secondary">
                                <i class="fas fa-times"></i>
                                Hủy bỏ
                            </a>
                        </div>
                    </form>
                </c:if>
                
                <c:if test="${empty food}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>Không tìm thấy thông tin food để chỉnh sửa.</span>
                    </div>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/admin/foods" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i>
                            Quay lại danh sách
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        // Form validation functions
        function validateForm() {
            const foodName = document.querySelector('input[name="foodName"]').value.trim();
            const type = document.querySelector('select[name="type"]').value;
            const calories = document.querySelector('input[name="calories"]').value;
            const protein = document.querySelector('input[name="protein"]').value;
            const carbs = document.querySelector('input[name="carbs"]').value;
            const fat = document.querySelector('input[name="fat"]').value;

            // Validate required fields
            if (!foodName) {
                alert('Vui lòng nhập tên món ăn!');
                return false;
            }

            if (!type) {
                alert('Vui lòng chọn loại món ăn!');
                return false;
            }

            if (!calories || parseInt(calories) < 0) {
                alert('Vui lòng nhập calories hợp lệ (số dương)!');
                return false;
            }

            // Validate optional numeric fields
            if (protein && parseFloat(protein) < 0) {
                alert('Protein phải là số dương!');
                return false;
            }

            if (carbs && parseFloat(carbs) < 0) {
                alert('Carbs phải là số dương!');
                return false;
            }

            if (fat && parseFloat(fat) < 0) {
                alert('Fat phải là số dương!');
                return false;
            }

            return true;
        }

        // Real-time validation for numeric inputs
        const numericInputs = ['calories', 'protein', 'carbs', 'fat'];
        numericInputs.forEach(inputName => {
            const input = document.querySelector(`input[name="${inputName}"]`);
            if (input) {
                input.addEventListener('input', function() {
                    const value = this.value;
                    if (value && parseFloat(value) < 0) {
                        this.style.borderColor = '#d32f2f';
                    } else {
                        this.style.borderColor = '#e3f2fd';
                    }
                });
            }
        });

        // Form submission with validation
        const form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', function(e) {
                if (!validateForm()) {
                    e.preventDefault();
                    return false;
                }
                
                // Disable submit button to prevent double submission
                const submitBtn = document.querySelector('.btn-primary');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang cập nhật...';
                submitBtn.disabled = true;
                
                // Form sẽ được submit bình thường
                return true;
            });
        }
    </script>
</body>
</html>