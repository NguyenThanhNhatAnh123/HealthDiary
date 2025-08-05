<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Health Diary</title>
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
            max-width: 800px;
            margin: 0 auto;
        }

        /* Form Container */
        .form-container {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            padding: 40px;
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

        h1 {
            color: #1976d2;
            font-size: 32px;
            font-weight: 700;
            text-align: center;
            margin-bottom: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        h1 i {
            background: #e3f2fd;
            padding: 12px;
            border-radius: 12px;
            font-size: 24px;
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

        small {
            color: #666;
            font-size: 12px;
            margin-top: 5px;
            display: block;
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

        /* Link Container */
        .link-container {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e3f2fd;
        }

        .link-container p {
            margin: 0;
            font-size: 14px;
            color: #666;
        }

        .link-container a {
            color: #1976d2;
            text-decoration: none;
            font-weight: 500;
            padding: 4px 8px;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .link-container a:hover {
            background: #e3f2fd;
            transform: translateY(-1px);
        }

        /* Password strength indicator */
        .password-match {
            font-size: 12px;
            margin-top: 5px;
            font-weight: 500;
        }

        .password-match.error {
            color: #d32f2f;
        }

        .password-match.success {
            color: #2e7d32;
        }

        /* Responsive */
        @media (max-width: 768px) {
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

            h1 {
                font-size: 28px;
            }
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
        <div class="form-container">
            <h1><i class="fas fa-user-plus"></i> Đăng ký tài khoản</h1>
            
            <!-- Error Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <form action="register" method="post" id="registerForm">
                <div class="section-header"><i class="fas fa-user"></i> Thông tin cá nhân</div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="fullName">Họ và tên <span class="required">*</span></label>
                        <input type="text" id="fullName" name="fullName" value="${fullName}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email <span class="required">*</span></label>
                        <input type="email" id="email" name="email" value="${email}" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Mật khẩu <span class="required">*</span></label>
                        <input type="password" id="password" name="password" required>
                        <small>Mật khẩu phải có ít nhất 4 ký tự</small>
                        <div class="password-match" id="passwordStrength"></div>
                    </div>
                    
                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu <span class="required">*</span></label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                        <div class="password-match" id="passwordMatch"></div>
                    </div>
                </div>
                
                <div class="section-header"><i class="fas fa-heart"></i> Thông tin sức khỏe</div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="age">Tuổi</label>
                        <input type="number" id="age" name="age" value="${age}">
                    </div>
                    
                    <div class="form-group">
                        <label for="gender">Giới tính</label>
                        <select id="gender" name="gender">
                            <option value="">Chọn giới tính</option>
                            <option value="Nam" ${gender == 'Nam' ? 'selected' : ''}>Nam</option>
                            <option value="Nữ" ${gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                            <option value="Khác" ${gender == 'Khác' ? 'selected' : ''}>Khác</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="height">Chiều cao (cm)</label>
                        <input type="number" id="height" name="height" value="${height}" step="0.1">
                    </div>
                    
                    <div class="form-group">
                        <label for="weight">Cân nặng (kg)</label>
                        <input type="number" id="weight" name="weight" value="${weight}" step="0.1">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="goal">Mục tiêu sức khỏe</label>
                    <textarea id="goal" name="goal" placeholder="Mô tả mục tiêu sức khỏe của bạn...">${goal}</textarea>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-check"></i> Đăng ký</button>
                    <a href="login" class="btn"><i class="fas fa-sign-in-alt"></i> Đăng nhập</a>
                </div>
            </form>
            
            <div class="link-container">
                <p>Đã có tài khoản? <a href="login">Đăng nhập ngay</a></p>
            </div>
        </div>
    </div>
    
    <script>
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const fullName = document.getElementById('fullName').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            // Check required fields
            if (!fullName || !email || !password || !confirmPassword) {
                showAlert('Vui lòng nhập đầy đủ thông tin bắt buộc');
                return false;
            }
            
            // Simple email check
            if (!email.includes('@') || !email.includes('.')) {
                showAlert('Email không hợp lệ');
                return false;
            }
            
            // Password validation
            if (password.length < 4) {
                showAlert('Mật khẩu phải có ít nhất 4 ký tự');
                return false;
            }
            
            if (password !== confirmPassword) {
                showAlert('Mật khẩu xác nhận không khớp');
                return false;
            }
            
            // If all validations pass, submit the form
            this.submit();
        });

        // Password strength and match checker
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const passwordStrength = document.getElementById('passwordStrength');
        const passwordMatch = document.getElementById('passwordMatch');

        passwordInput.addEventListener('input', function() {
            const password = this.value;
            if (password.length >= 4) {
                passwordStrength.textContent = 'Mật khẩu đủ mạnh';
                passwordStrength.className = 'password-match success';
            } else {
                passwordStrength.textContent = 'Mật khẩu quá ngắn';
                passwordStrength.className = 'password-match error';
            }
            checkPasswordMatch();
        });

        confirmPasswordInput.addEventListener('input', checkPasswordMatch);

        function checkPasswordMatch() {
            const password = passwordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            
            if (confirmPassword.length > 0) {
                if (password === confirmPassword) {
                    passwordMatch.textContent = 'Mật khẩu khớp';
                    passwordMatch.className = 'password-match success';
                } else {
                    passwordMatch.textContent = 'Mật khẩu không khớp';
                    passwordMatch.className = 'password-match error';
                }
            } else {
                passwordMatch.textContent = '';
                passwordMatch.className = 'password-match';
            }
        }

        function showAlert(message) {
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-danger';
            alertDiv.innerHTML = `<i class="fas fa-exclamation-circle"></i> ${message}`;
            
            const formContainer = document.querySelector('.form-container');
            const existingAlert = formContainer.querySelector('.alert');
            if (existingAlert) {
                existingAlert.remove();
            }
            
            formContainer.insertBefore(alertDiv, formContainer.querySelector('form'));
            
            setTimeout(() => {
                alertDiv.remove();
            }, 3000);
        }
    </script>
</body>
</html>