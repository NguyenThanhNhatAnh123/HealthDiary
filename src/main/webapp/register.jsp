<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Health Diary</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Đăng ký tài khoản</h1>
        
        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                ${error}
            </div>
        </c:if>
        
        <form action="register" method="post" id="registerForm">
            <div class="form-group">
                <label for="fullName">Họ và tên *</label>
                <input type="text" id="fullName" name="fullName" value="${fullName}" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" value="${email}" required>
            </div>
            
            <div class="form-group">
                <label for="password">Mật khẩu *</label>
                <input type="password" id="password" name="password" required>
                <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                    Mật khẩu phải có ít nhất 4 ký tự
                </small>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Xác nhận mật khẩu *</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            
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
            
            <div class="form-group">
                <label for="height">Chiều cao (cm)</label>
                <input type="number" id="height" name="height" value="${height}" step="0.1">
            </div>
            
            <div class="form-group">
                <label for="weight">Cân nặng (kg)</label>
                <input type="number" id="weight" name="weight" value="${weight}" step="0.1">
            </div>
            
            <div class="form-group">
                <label for="goal">Mục tiêu sức khỏe</label>
                <textarea id="goal" name="goal" placeholder="Mô tả mục tiêu sức khỏe của bạn...">${goal}</textarea>
            </div>
            
            <button type="submit" class="btn btn-primary">Đăng ký</button>
        </form>
        
        <div class="link-container">
            <p>Đã có tài khoản? <a href="login">Đăng nhập</a></p>
        </div>
    </div>
    
    <script>
        // Simple form validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const fullName = document.getElementById('fullName').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            // Check required fields
            if (!fullName || !email || !password || !confirmPassword) {
                e.preventDefault();
                alert('Vui lòng nhập đầy đủ thông tin bắt buộc');
                return false;
            }
            
            // Simple email check
            if (!email.includes('@') || !email.includes('.')) {
                e.preventDefault();
                alert('Email không hợp lệ');
                return false;
            }
            
            // Simple password check
            if (password.length < 4) {
                e.preventDefault();
                alert('Mật khẩu phải có ít nhất 4 ký tự');
                return false;
            }
            
            // Password confirmation
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp');
                return false;
            }
        });
    </script>
</body>
</html> 