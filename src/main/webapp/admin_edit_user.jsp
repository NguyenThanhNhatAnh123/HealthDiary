<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa User - Admin Dashboard</title>
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

        /* Password Section */
        .password-section {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 24px;
            margin-top: 24px;
        }

        .password-section h4 {
            color: #1976d2;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .password-note {
            background: #e3f2fd;
            color: #1976d2;
            border-radius: 8px;
            padding: 12px 16px;
            margin-top: 16px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
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

        /* Loading animation */
        .btn:active {
            transform: translateY(0);
        }

        /* Hover effects */
        .form-group:hover .form-label {
            color: #1565c0;
        }

        /* Custom focus ring */
        .form-group:focus-within .form-label {
            color: #1565c0;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-user-edit"></i> Chỉnh sửa User</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin-dashboard">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <span class="separator">•</span>
                <a href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i> Danh sách User
                </a>
                <span class="separator">•</span>
                <span style="color: #666;">Chỉnh sửa User</span>
            </div>
        </div>

        <!-- Form Container -->
        <div class="edit-form-container">
            <div class="form-header">
                <i class="fas fa-user-edit"></i>
                <h1>Chỉnh sửa User</h1>
                <p>Cập nhật thông tin người dùng trong hệ thống</p>
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

                <c:if test="${not empty user}">
                    <form action="${pageContext.request.contextPath}/admin/user/edit" method="post">
                        <input type="hidden" name="userId" value="${user.id}">
                        <!-- Thông tin cơ bản -->
                        <div class="section-title">
                            <i class="fas fa-user"></i>
                            Thông tin cơ bản
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-user"></i>
                                    Họ và tên <span class="required">*</span>
                                </label>
                                <input type="text" name="fullName" class="form-input" value="${user.fullName}" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-envelope"></i>
                                    Email <span class="required">*</span>
                                </label>
                                <input type="email" name="email" class="form-input" value="${user.email}" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-calendar"></i>
                                    Tuổi
                                </label>
                                <input type="number" name="age" class="form-input" value="${user.age}" min="1" max="120">
                            </div>
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-venus-mars"></i>
                                    Giới tính
                                </label>
                                <select name="gender" class="form-select">
                                    <option value="">Chọn giới tính</option>
                                    <option value="Nam" <c:if test="${user.gender == 'Nam'}">selected</c:if>>Nam</option>
                                    <option value="Nữ" <c:if test="${user.gender == 'Nữ'}">selected</c:if>>Nữ</option>
                                    <option value="Khác" <c:if test="${user.gender == 'Khác'}">selected</c:if>>Khác</option>
                                </select>
                            </div>
                        </div>
                        <!-- Thông tin thể chất -->
                        <div class="section-title">
                            <i class="fas fa-heartbeat"></i>
                            Thông tin thể chất
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-ruler-vertical"></i>
                                    Chiều cao (cm)
                                </label>
                                <input type="number" name="height" class="form-input" value="${user.heightCm}" min="50" max="300" step="0.1">
                            </div>
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-weight"></i>
                                    Cân nặng (kg)
                                </label>
                                <input type="number" name="weight" class="form-input" value="${user.weightKg}" min="20" max="300" step="0.1">
                            </div>
                        </div>
                        <div class="form-group full-width">
                            <label class="form-label">
                                <i class="fas fa-target"></i>
                                Mục tiêu sức khỏe
                            </label>
                            <textarea name="goal" class="form-input" placeholder="Nhập mục tiêu sức khỏe của user...">${user.goal}</textarea>
                        </div>
                        <!-- Thay đổi mật khẩu -->
                        <div class="password-section">
                            <h4>
                                <i class="fas fa-key"></i>
                                Thay đổi mật khẩu (tùy chọn)
                            </h4>
                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-lock"></i>
                                        Mật khẩu mới
                                    </label>
                                    <input type="password" name="password" class="form-input" minlength="4" placeholder="Để trống nếu không thay đổi">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-lock"></i>
                                        Xác nhận mật khẩu
                                    </label>
                                    <input type="password" name="confirmPassword" class="form-input" minlength="4" placeholder="Nhập lại mật khẩu mới">
                                </div>
                            </div>
                            <div class="password-note">
                                <i class="fas fa-info-circle"></i>
                                Mật khẩu phải có ít nhất 4 ký tự. Nếu không nhập, mật khẩu hiện tại sẽ được giữ nguyên.
                            </div>
                        </div>
                        <div class="action-buttons">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i>
                                Cập nhật User
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                                <i class="fas fa-times"></i>
                                Hủy bỏ
                            </a>
                        </div>
                    </form>
                </c:if>
                <c:if test="${empty user}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>Không tìm thấy thông tin user để chỉnh sửa.</span>
                    </div>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i>
                            Quay lại danh sách
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        // JavaScript functions cho form validation và submission

        // Password confirmation validation
        document.querySelector('input[name="confirmPassword"]').addEventListener('input', function() {
            const password = document.querySelector('input[name="password"]').value;
            const confirmPassword = this.value;
            
            if (confirmPassword && password !== confirmPassword) {
                this.style.borderColor = '#d32f2f';
                this.setCustomValidity('Mật khẩu xác nhận không khớp!');
            } else {
                this.style.borderColor = '#e3f2fd';
                this.setCustomValidity('');
            }
        });

        // Real-time password validation
        document.querySelector('input[name="password"]').addEventListener('input', function() {
            const confirmPassword = document.querySelector('input[name="confirmPassword"]');
            if (confirmPassword.value && this.value !== confirmPassword.value) {
                confirmPassword.style.borderColor = '#d32f2f';
                confirmPassword.setCustomValidity('Mật khẩu xác nhận không khớp!');
            } else if (confirmPassword.value) {
                confirmPassword.style.borderColor = '#e3f2fd';
                confirmPassword.setCustomValidity('');
            }
        });

        // Form validation
        function validateForm() {
            const fullName = document.querySelector('input[name="fullName"]').value.trim();
            const email = document.querySelector('input[name="email"]').value.trim();
            const password = document.querySelector('input[name="password"]').value;
            const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;

            // Validate required fields
            if (!fullName) {
                alert('Vui lòng nhập họ và tên!');
                return false;
            }

            if (!email) {
                alert('Vui lòng nhập email!');
                return false;
            }

            // Validate email format
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert('Vui lòng nhập email hợp lệ!');
                return false;
            }

            // Validate password if provided
            if (password || confirmPassword) {
                if (password.length < 4) {
                    alert('Mật khẩu phải có ít nhất 4 ký tự!');
                    return false;
                }

                if (password !== confirmPassword) {
                    alert('Mật khẩu xác nhận không khớp!');
                    return false;
                }
            }

            return true;
        }

        // Form submission with loading state
        document.querySelector('form').addEventListener('submit', function(e) {
            e.preventDefault();
            
            if (!validateForm()) {
                return;
            }

            const submitBtn = document.querySelector('.btn-primary');
            const originalText = submitBtn.innerHTML;
            
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang cập nhật...';
            submitBtn.disabled = true;

            // Simulate form submission (replace with actual form submission)
            setTimeout(() => {
                // Show success message
                showAlert('success', 'Cập nhật user thành công!');
                
                // Reset form state
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
                
                // Optionally redirect after success
                setTimeout(() => {
                    window.location.href = 'admin_user_list.jsp';
                }, 2000);
            }, 1500);
        });

        // Alert function
        function showAlert(type, message) {
            // Create alert element
            const alertDiv = document.createElement('div');
            alertDiv.className = `alert alert-${type}`;
            alertDiv.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 16px 20px;
                border-radius: 12px;
                color: ${type === 'success' ? '#2e7d32' : '#d32f2f'};
                background: ${type === 'success' ? '#e8f5e8' : '#ffebee'};
                border-left: 4px solid ${type === 'success' ? '#4caf50' : '#d32f2f'};
                z-index: 1000;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 500;
            `;
            
            alertDiv.innerHTML = `
                <i class="fas fa-${type === 'success' ? 'check-circle' : 'exclamation-circle'}"></i>
                <span>${message}</span>
            `;
            
            document.body.appendChild(alertDiv);
            
            // Remove alert after 3 seconds
            setTimeout(() => {
                alertDiv.remove();
            }, 3000);
        }

        // Auto-save draft functionality
        let autoSaveTimer;
        const formInputs = document.querySelectorAll('input, select, textarea');
        
        formInputs.forEach(input => {
            input.addEventListener('input', function() {
                clearTimeout(autoSaveTimer);
                autoSaveTimer = setTimeout(() => {
                    saveFormDraft();
                }, 2000); // Auto-save after 2 seconds of inactivity
            });
        });

        function saveFormDraft() {
            const formData = new FormData(document.querySelector('form'));
            const draft = {};
            
            for (let [key, value] of formData.entries()) {
                draft[key] = value;
            }
            
            localStorage.setItem('userEditDraft', JSON.stringify(draft));
            console.log('Form draft saved');
        }

        function loadFormDraft() {
            const draft = localStorage.getItem('userEditDraft');
            if (draft) {
                const formData = JSON.parse(draft);
                Object.keys(formData).forEach(key => {
                    const input = document.querySelector(`[name="${key}"]`);
                    if (input && !input.value) {
                        input.value = formData[key];
                    }
                });
            }
        }

        // Load draft on page load
        document.addEventListener('DOMContentLoaded', function() {
            loadFormDraft();
        });

        // Clear draft when form is successfully submitted
        document.querySelector('form').addEventListener('submit', function() {
            localStorage.removeItem('userEditDraft');
        });
    </script>
</body>
</html>