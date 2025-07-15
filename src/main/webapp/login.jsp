<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Health Diary</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .admin-link {
            display: inline-block;
            margin-top: 15px;
            padding: 8px 16px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
        }
        
        .admin-link:hover {
            background-color: #545b62;
            text-decoration: none;
            color: white;
        }
        
        .admin-section {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #dee2e6;
        }
        
        .admin-section p {
            margin: 0 0 10px 0;
            font-size: 14px;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Đăng nhập</h1>
        
        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                ${error}
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>
        
        <!-- Success Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                ${success}
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>
        
        <form action="login" method="post">
            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" value="${email}" required>
            </div>
            
            <div class="form-group">
                <label for="password">Mật khẩu *</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Đăng nhập</button>
        </form>
        
        <div class="link-container">
            <p>Chưa có tài khoản? <a href="register">Đăng ký ngay</a></p>
        </div>
        
        <!-- Admin Section -->
        <div class="admin-section">
            <p>Dành cho quản trị viên</p>
            <a href="login_admin" class="admin-link">
                <i class="icon-admin"></i> Đăng nhập Admin
            </a>
        </div>
    </div>
    
    <script>
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();
            
            if (!email || !password) {
                e.preventDefault();
                alert('Vui lòng nhập đầy đủ thông tin');
                return false;
            }
            
            // Simple email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Email không hợp lệ');
                return false;
            }
        });
    </script>
</body>
</html>