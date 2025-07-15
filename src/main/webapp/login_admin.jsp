<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập Admin - Health Diary</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Đăng nhập Admin</h1>
        
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
        
        <form action="login_admin" method="post">
            <div class="form-group">
                <label for="username">Tên đăng nhập *</label>
                <input type="text" id="username" name="username" value="${username}" required>
            </div>
            
            <div class="form-group">
                <label for="password">Mật khẩu *</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Đăng nhập</button>
        </form>
        
        <div class="link-container">
            <p><a href="login">Quay lại đăng nhập người dùng</a></p>
        </div>
    </div>
    
    <script>
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            
            if (!username || !password) {
                e.preventDefault();
                alert('Vui lòng nhập đầy đủ thông tin');
                return false;
            }
            
            // Username validation (minimum 3 characters)
            if (username.length < 3) {
                e.preventDefault();
                alert('Tên đăng nhập phải có ít nhất 3 ký tự');
                return false;
            }
            
            // Password validation (minimum 6 characters)
            if (password.length < 6) {
                e.preventDefault();
                alert('Mật khẩu phải có ít nhất 6 ký tự');
                return false;
            }
        });
    </script>
</body>
</html>