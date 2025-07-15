<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm User Mới - Admin Dashboard</title>
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
            <h1><i class="fas fa-user-plus"></i> Thêm User Mới</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin-dashboard">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <span class="separator">•</span>
                <a href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i> Danh sách User
                </a>
                <span class="separator">•</span>
                <span style="color: #666;">Thêm User</span>
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
                <span>Thêm user thành công!</span>
            </div>

            <div class="alert alert-error" style="display: none;" id="errorAlert">
                <i class="fas fa-exclamation-triangle"></i>
                <span>Có lỗi xảy ra, vui lòng thử lại!</span>
            </div>

            <!-- FORM với action và method -->
            <form id="addUserForm" action="${pageContext.request.contextPath}/admin/user/add" method="POST">
                <!-- Basic Information -->
                <div class="section-header">
                    <i class="fas fa-user"></i>
                    Thông tin cơ bản
                </div>

                <div class="form-group">
                    <label for="fullName">Họ và tên <span class="required">*</span></label>
                    <input type="text" id="fullName" name="fullName" required placeholder="Nhập họ và tên" value="${param.fullName}">
                </div>

                <div class="form-group">
                    <label for="email">Email <span class="required">*</span></label>
                    <input type="email" id="email" name="email" required placeholder="Nhập địa chỉ email" value="${param.email}">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Mật khẩu <span class="required">*</span></label>
                        <input type="password" id="password" name="password" required placeholder="Nhập mật khẩu">
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu <span class="required">*</span></label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Nhập lại mật khẩu">
                    </div>
                </div>

                <!-- Personal Information -->
                <div class="section-header">
                    <i class="fas fa-id-card"></i>
                    Thông tin cá nhân
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="age">Tuổi</label>
                        <input type="number" id="age" name="age" min="1" max="120" placeholder="Nhập tuổi" value="${param.age}">
                    </div>
                    <div class="form-group">
                        <label for="gender">Giới tính</label>
                        <select id="gender" name="gender">
                            <option value="">Chọn giới tính</option>
                            <option value="Nam" ${param.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                            <option value="Nữ" ${param.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                            <option value="Khác" ${param.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="height">Chiều cao (cm)</label>
                        <input type="number" id="height" name="height" min="50" max="300" step="0.1" placeholder="Nhập chiều cao" value="${param.height}">
                    </div>
                    <div class="form-group">
                        <label for="weight">Cân nặng (kg)</label>
                        <input type="number" id="weight" name="weight" min="20" max="500" step="0.1" placeholder="Nhập cân nặng" value="${param.weight}">
                    </div>
                </div>

                <!-- Health Goals -->
                <div class="section-header">
                    <i class="fas fa-heartbeat"></i>
                    Mục tiêu sức khỏe
                </div>

                <div class="form-group">
                    <label for="goal">Mục tiêu sức khỏe</label>
                    <textarea id="goal" name="goal" placeholder="Nhập mục tiêu sức khỏe của user...">${param.goal}</textarea>
                </div>

                <!-- Buttons -->
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Thêm User
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Hủy
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Form validation trước khi submit
        document.getElementById('addUserForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            // Kiểm tra mật khẩu khớp
            if (password !== confirmPassword) {
                e.preventDefault(); // Chặn submit
                showAlert('error', 'Mật khẩu xác nhận không khớp!');
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

        // Real-time password validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (confirmPassword && password !== confirmPassword) {
                this.style.borderColor = '#d32f2f';
            } else {
                this.style.borderColor = '#e3f2fd';
            }
        });
    </script>
</body>
</html>