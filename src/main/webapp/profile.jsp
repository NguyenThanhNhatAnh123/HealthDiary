<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ cá nhân - Health Diary</title>
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

        .alert-danger {
            background: #ffebee;
            color: #d32f2f;
            border-left: 4px solid #d32f2f;
        }

        .alert-success {
            background: #e8f5e8;
            color: #2e7d32;
            border-left: 4px solid #4caf50;
        }

        /* User Info */
        .user-info {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 24px;
        }

        .user-info h3 {
            color: #1976d2;
            margin-bottom: 16px;
            font-size: 18px;
        }

        .info-row {
            display: flex;
            margin-bottom: 12px;
            padding-bottom: 12px;
            border-bottom: 1px solid #e3f2fd;
        }

        .info-label {
            font-weight: 600;
            color: #1976d2;
            width: 150px;
        }

        .info-value {
            color: #333;
            flex: 1;
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
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-user-circle"></i> Hồ sơ cá nhân</h1>
            <div class="breadcrumb">
                <a href="dashboard">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <span class="separator">•</span>
                <span style="color: #666;">Hồ sơ</span>
            </div>
        </div>

        <!-- Form Container -->
        <div class="form-container">
            <!-- Error Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>${error}</span>
                </div>
            </c:if>
            
            <!-- Success Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <span>${success}</span>
                </div>
            </c:if>
            
            <!-- User Information Display -->
            <div class="user-info">
                <h3><i class="fas fa-info-circle"></i> Thông tin hiện tại</h3>
                <div class="info-row">
                    <span class="info-label">Email:</span>
                    <span class="info-value">${user.email}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Họ và tên:</span>
                    <span class="info-value">${user.fullName}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Tuổi:</span>
                    <span class="info-value">${user.age != null ? user.age : 'Chưa cập nhật'}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Giới tính:</span>
                    <span class="info-value">${user.gender != null ? user.gender : 'Chưa cập nhật'}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Chiều cao:</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${user.heightCm != null}">
                                ${user.heightCm} cm
                            </c:when>
                            <c:otherwise>
                                Chưa cập nhật
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="info-row">
                    <span class="info-label">Cân nặng:</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${user.weightKg != null}">
                                ${user.weightKg} kg
                            </c:when>
                            <c:otherwise>
                                Chưa cập nhật
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="info-row">
                    <span class="info-label">Mục tiêu:</span>
                    <span class="info-value">${user.goal != null ? user.goal : 'Chưa cập nhật'}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Ngày tham gia:</span>
                    <span class="info-value">${user.createdAt}</span>
                </div>
            </div>
            
            <!-- Update Form -->
            <form action="profile" method="post" id="profileForm">
                <h3 class="section-header">
                    <i class="fas fa-edit"></i>
                    Cập nhật thông tin
                </h3>
                
                <div class="form-group">
                    <label for="fullName">Họ và tên <span class="required">*</span></label>
                    <input type="text" id="fullName" name="fullName" value="${user.fullName}" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="age">Tuổi</label>
                        <input type="number" id="age" name="age" value="${user.age}" min="1" max="150">
                    </div>
                    
                    <div class="form-group">
                        <label for="gender">Giới tính</label>
                        <select id="gender" name="gender">
                            <option value="">Chọn giới tính</option>
                            <option value="Nam" ${user.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                            <option value="Nữ" ${user.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                            <option value="Khác" ${user.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="height">Chiều cao (cm)</label>
                        <input type="number" id="height" name="height" value="${user.heightCm}" min="50" max="300" step="0.1">
                    </div>
                    
                    <div class="form-group">
                        <label for="weight">Cân nặng (kg)</label>
                        <input type="number" id="weight" name="weight" value="${user.weightKg}" min="10" max="500" step="0.1">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="goal">Mục tiêu sức khỏe</label>
                    <textarea id="goal" name="goal" placeholder="Mô tả mục tiêu sức khỏe của bạn...">${user.goal}</textarea>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Cập nhật thông tin
                    </button>
                </div>
            </form>
            
            <!-- BMI Calculator -->
            <c:if test="${user.heightCm != null && user.weightKg != null}">
                <div class="user-info" style="margin-top: 30px;">
                    <h3><i class="fas fa-calculator"></i> Chỉ số BMI</h3>
                    <c:set var="heightM" value="${user.heightCm / 100}" />
                    <c:set var="bmi" value="${user.weightKg / (heightM * heightM)}" />
                    
                    <div class="info-row">
                        <span class="info-label">Chỉ số BMI:</span>
                        <span class="info-value">
                            <fmt:formatNumber value="${bmi}" maxFractionDigits="1" minFractionDigits="1"/>
                        </span>
                    </div>
                    
                    <div class="info-row">
                        <span class="info-label">Phân loại:</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${bmi < 18.5}">
                                    <span style="color: #ffc107;">Thiếu cân</span>
                                </c:when>
                                <c:when test="${bmi >= 18.5 && bmi < 25}">
                                    <span style="color: #28a745;">Bình thường</span>
                                </c:when>
                                <c:when test="${bmi >= 25 && bmi < 30}">
                                    <span style="color: #ffc107;">Thừa cân</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #dc3545;">Béo phì</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
    
    <script>
        // Form validation
        document.getElementById('profileForm').addEventListener('submit', function(e) {
            const fullName = document.getElementById('fullName').value.trim();
            const age = document.getElementById('age').value;
            const height = document.getElementById('height').value;
            const weight = document.getElementById('weight').value;
            
            // Required fields validation
            if (!fullName) {
                e.preventDefault();
                alert('Họ tên không được để trống');
                return false;
            }
            
            // Age validation
            if (age && (age < 1 || age > 150)) {
                e.preventDefault();
                alert('Tuổi không hợp lệ');
                return false;
            }
            
            // Height validation
            if (height && (height < 50 || height > 300)) {
                e.preventDefault();
                alert('Chiều cao không hợp lệ');
                return false;
            }
            
            // Weight validation
            if (weight && (weight < 10 || weight > 500)) {
                e.preventDefault();
                alert('Cân nặng không hợp lệ');
                return false;
            }

            // Show loading
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
            submitBtn.disabled = true;
        });
    </script>
</body>
</html>