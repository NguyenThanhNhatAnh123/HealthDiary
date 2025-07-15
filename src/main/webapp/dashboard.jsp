<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Health Diary</title>
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
            <div class="dashboard-header">
                <h1>Chào mừng, ${userName}!</h1>
                <p>Quản lý sức khỏe của bạn một cách thông minh</p>
            </div>
            
            <!-- User Stats -->
            <div class="stats-grid">
                <div class="stat-card">
                    <h3>${user.age != null ? user.age : 'N/A'}</h3>
                    <p>Tuổi</p>
                </div>
                <div class="stat-card">
                    <h3>${user.heightCm != null ? user.heightCm : 'N/A'}</h3>
                    <p>Chiều cao (cm)</p>
                </div>
                <div class="stat-card">
                    <h3>${user.weightKg != null ? user.weightKg : 'N/A'}</h3>
                    <p>Cân nặng (kg)</p>
                </div>
                <c:if test="${user.heightCm != null && user.weightKg != null}">
                    <c:set var="heightM" value="${user.heightCm / 100}" />
                    <c:set var="bmi" value="${user.weightKg / (heightM * heightM)}" />
                    <c:set var="bmiRounded" value="${Math.round(bmi * 10) / 10}" />
                    <div class="stat-card">
                        <h3>${bmiRounded}</h3>
                        <p>Chỉ số BMI</p>
                    </div>
                </c:if>
            </div>
            
            <!-- User Information -->
            <div class="user-info">
                <h3>Thông tin cá nhân</h3>
                <div class="info-row">
                    <span class="info-label">Email:</span>
                    <span class="info-value">${user.email}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Họ và tên:</span>
                    <span class="info-value">${user.fullName}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Giới tính:</span>
                    <span class="info-value">${user.gender != null ? user.gender : 'Chưa cập nhật'}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Mục tiêu sức khỏe:</span>
                    <span class="info-value">${user.goal != null ? user.goal : 'Chưa cập nhật'}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Ngày tham gia:</span>
                    <span class="info-value">${user.createdAt}</span>
                </div>
            </div>
            
            <!-- BMI Analysis -->
            <c:if test="${user.heightCm != null && user.weightKg != null}">
                <div class="user-info">
                    <h3>Phân tích BMI</h3>
                    <c:set var="heightM" value="${user.heightCm / 100}" />
                    <c:set var="bmi" value="${user.weightKg / (heightM * heightM)}" />
                    <c:set var="bmiRounded" value="${Math.round(bmi * 10) / 10}" />
                    
                    <div class="info-row">
                        <span class="info-label">Chỉ số BMI:</span>
                        <span class="info-value">${bmiRounded}</span>
                    </div>
                    
                    <div class="info-row">
                        <span class="info-label">Phân loại:</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${bmi < 18.5}">
                                    <span style="color: #ffc107; font-weight: bold;">Thiếu cân</span>
                                </c:when>
                                <c:when test="${bmi >= 18.5 && bmi < 25}">
                                    <span style="color: #28a745; font-weight: bold;">Bình thường</span>
                                </c:when>
                                <c:when test="${bmi >= 25 && bmi < 30}">
                                    <span style="color: #ffc107; font-weight: bold;">Thừa cân</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #dc3545; font-weight: bold;">Béo phì</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    
                    <div class="info-row">
                        <span class="info-label">Khuyến nghị:</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${bmi < 18.5}">
                                    Cần tăng cường dinh dưỡng và tập luyện để tăng cân
                                </c:when>
                                <c:when test="${bmi >= 18.5 && bmi < 25}">
                                    Duy trì chế độ ăn uống và tập luyện hiện tại
                                </c:when>
                                <c:when test="${bmi >= 25 && bmi < 30}">
                                    Cần giảm cân thông qua chế độ ăn và tập luyện
                                </c:when>
                                <c:otherwise>
                                    Cần tham khảo ý kiến bác sĩ để có kế hoạch giảm cân an toàn
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </c:if>
            
            <!-- Action Buttons -->
            <div style="margin-top: 30px; text-align: center;">
                <a href="profile" class="btn btn-primary" style="display: inline-block; width: auto; margin: 0 10px;">
                    Cập nhật hồ sơ
                </a>
                <c:if test="${user.heightCm == null || user.weightKg == null}">
                    <a href="profile" class="btn btn-secondary" style="display: inline-block; width: auto; margin: 0 10px;">
                        Hoàn thiện thông tin
                    </a>
                </c:if>
            </div>
        </div>
    </div>
    
    <script>
        // Check if user is logged in
        <c:if test="${empty user}">
            window.location.href = 'login';
        </c:if>
    </script>
</body>
</html> 