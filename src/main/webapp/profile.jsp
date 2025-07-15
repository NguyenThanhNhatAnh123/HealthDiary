<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ cá nhân - Health Diary</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="nav-bar">
        <div class="nav-container">
            <a href="dashboard" class="nav-brand">Health Diary</a>
            <div class="nav-menu">
                <a href="dashboard">Trang chủ</a>
                <a href="profile">Hồ sơ</a>
                <a href="logout">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <div class="main-content">
        <div class="dashboard-container">
            <h1>Cập nhật hồ sơ cá nhân</h1>
            
            <!-- Error Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>
            
            <!-- Success Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    ${success}
                </div>
            </c:if>
            
            <!-- User Information Display -->
            <div class="user-info">
                <h3>Thông tin hiện tại</h3>
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
                <h3>Cập nhật thông tin</h3>
                
                <div class="form-group">
                    <label for="fullName">Họ và tên *</label>
                    <input type="text" id="fullName" name="fullName" value="${user.fullName}" required>
                </div>
                
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
                
                <div class="form-group">
                    <label for="height">Chiều cao (cm)</label>
                    <input type="number" id="height" name="height" value="${user.heightCm}" min="50" max="300" step="0.1">
                </div>
                
                <div class="form-group">
                    <label for="weight">Cân nặng (kg)</label>
                    <input type="number" id="weight" name="weight" value="${user.weightKg}" min="10" max="500" step="0.1">
                </div>
                
                <div class="form-group">
                    <label for="goal">Mục tiêu sức khỏe</label>
                    <textarea id="goal" name="goal" placeholder="Mô tả mục tiêu sức khỏe của bạn...">${user.goal}</textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">Cập nhật thông tin</button>
            </form>
            
            <!-- BMI Calculator -->
            <c:if test="${user.heightCm != null && user.weightKg != null}">
                <div class="user-info" style="margin-top: 30px;">
                    <h3>Chỉ số BMI</h3>
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
        });
    </script>
</body>
</html>