<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Health Diary</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .header h1 i {
            background: #e3f2fd;
            padding: 8px;
            border-radius: 8px;
            font-size: 20px;
        }

        .breadcrumb {
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
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

        .breadcrumb a.logout {
            color: #d32f2f;
        }

        .breadcrumb a.logout:hover {
            background: #ffebee;
        }

        /* Navigation */
        .nav-tabs {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 20px rgba(25, 118, 210, 0.1);
            padding: 24px 32px;
            margin-bottom: 24px;
        }

        .nav-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .nav-btn {
            padding: 12px 18px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #fff;
            color: #1976d2;
            border: 2px solid #e3f2fd;
            text-decoration: none;
            flex: 1 1 auto;
            max-width: 200px; 
    		min-width: 140px;
   	     }

        .nav-btn:hover {
            background: #e3f2fd;
            transform: translateY(-1px);
        }

        .nav-btn.active {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            border-color: #1976d2;
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.3);
        }

        /* Main Content */
        .main-content {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            padding: 40px;
            position: relative;
            overflow: hidden;
        }

        .main-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #1976d2, #42a5f5, #1976d2);
        }

        /* Welcome Section */
        .welcome-section {
            margin-bottom: 40px;
        }

        .welcome-title {
            color: #1976d2;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .welcome-subtitle {
            color: #666;
            font-size: 18px;
            margin-bottom: 20px;
        }

        /* Alert */
        .alert {
            padding: 20px;
            border-radius: 12px;
            margin: 16px 0;
            border-left: 4px solid #1976d2;
            background: #e3f2fd;
            color: #1976d2;
        }

        .alert-warning {
            border-left-color: #f57c00;
            background: #fff3e0;
            color: #f57c00;
        }

        .alert-success {
            border-left-color: #2e7d32;
            background: #e8f5e8;
            color: #2e7d32;
        }

        .alert-danger {
            border-left-color: #d32f2f;
            background: #ffebee;
            color: #d32f2f;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
            border-radius: 16px;
            padding: 32px 24px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(25, 118, 210, 0.08);
            transition: all 0.3s ease;
            border: 1px solid #e3f2fd;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(25, 118, 210, 0.15);
        }

        .stat-icon {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            font-size: 24px;
        }

        .stat-value {
            font-size: 36px;
            font-weight: 700;
            color: #1976d2;
            margin-bottom: 8px;
        }

        .stat-label {
            color: #666;
            font-size: 14px;
            font-weight: 500;
        }

        /* Quick Actions */
        .section-header {
            color: #1976d2;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 32px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-header i {
            background: #e3f2fd;
            padding: 8px;
            border-radius: 8px;
            font-size: 18px;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .action-card {
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
            border-radius: 16px;
            padding: 24px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(25, 118, 210, 0.08);
            transition: all 0.3s ease;
            border: 1px solid #e3f2fd;
            text-decoration: none;
            color: inherit;
        }

        .action-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(25, 118, 210, 0.15);
            text-decoration: none;
        }

        .action-icon {
            font-size: 36px;
            margin-bottom: 16px;
            color: #1976d2;
        }

        .action-title {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .action-desc {
            font-size: 14px;
            color: #666;
        }

        /* Widget */
        .widget {
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 4px 20px rgba(25, 118, 210, 0.08);
            border: 1px solid #e3f2fd;
            margin-bottom: 24px;
            transition: all 0.3s ease;
        }

        .widget:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(25, 118, 210, 0.15);
        }

        .widget h3 {
            color: #1976d2;
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        /* Info Rows */
        .user-info {
            background: #f8f9fa;
            padding: 24px;
            border-radius: 12px;
            margin: 20px 0;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #666;
        }

        .info-value {
            color: #333;
            text-align: right;
            font-weight: 500;
        }

        /* Buttons */
        .btn {
            padding: 14px 24px;
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
            margin: 4px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 118, 210, 0.4);
            text-decoration: none;
        }

        .btn-secondary {
            background: #fff;
            color: #1976d2;
            border: 2px solid #1976d2;
        }

        .btn-secondary:hover {
            background: #e3f2fd;
            transform: translateY(-1px);
            text-decoration: none;
        }

        .btn-success {
            background: linear-gradient(135deg, #2e7d32, #4caf50);
            color: #fff;
            box-shadow: 0 4px 15px rgba(46, 125, 50, 0.3);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(46, 125, 50, 0.4);
            text-decoration: none;
        }

        /* Badge */
        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .badge-success {
            background: #e8f5e8;
            color: #2e7d32;
        }

        .badge-warning {
            background: #fff3e0;
            color: #f57c00;
        }

        .badge-danger {
            background: #ffebee;
            color: #d32f2f;
        }

        /* Net calories colors */
        .net-calories-positive {
            color: #d32f2f;
            font-weight: bold;
        }

        .net-calories-negative {
            color: #2e7d32;
            font-weight: bold;
        }

        /* BMI colors */
        .bmi-normal {
            color: #2e7d32;
            font-weight: bold;
        }

        .bmi-underweight {
            color: #f57c00;
            font-weight: bold;
        }

        .bmi-overweight {
            color: #f57c00;
            font-weight: bold;
        }

        .bmi-obese {
            color: #d32f2f;
            font-weight: bold;
        }

        /* Progress bar */
        .progress-container {
            background: #e0e0e0;
            border-radius: 10px;
            height: 20px;
            margin: 10px 0;
            overflow: hidden;
        }

        .progress-bar {
            height: 100%;
            border-radius: 10px;
            transition: width 0.3s ease;
        }

        .progress-bar-success {
            background: linear-gradient(90deg, #2e7d32, #4caf50);
        }

        .progress-bar-warning {
            background: linear-gradient(90deg, #f57c00, #ff9800);
        }

        .progress-bar-danger {
            background: linear-gradient(90deg, #d32f2f, #f44336);
        }

        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding: 12px;
            }

            .header {
                flex-direction: column;
                gap: 16px;
                text-align: center;
                padding: 20px;
            }

            .nav-buttons {
                flex-direction: column;
            }

            .nav-btn {
                width: 100%;
                justify-content: center;
            }

            .main-content {
                padding: 24px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .quick-actions {
                grid-template-columns: repeat(2, 1fr);
                gap: 16px;
            }

            .welcome-title {
                font-size: 24px;
                text-align: center;
            }

            .welcome-subtitle {
                text-align: center;
            }

            .info-row {
                flex-direction: column;
                gap: 8px;
            }

            .info-value {
                text-align: left;
            }
        }

        @media (max-width: 480px) {
            .quick-actions {
                grid-template-columns: 1fr;
            }
        }

        /* Loading states */
        .loading {
            opacity: 0.6;
            pointer-events: none;
        }

        /* Animations */
        @keyframes slideIn {
            from { 
                opacity: 0;
                transform: translateY(20px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }

        .widget, .stat-card, .action-card {
            animation: slideIn 0.5s ease-out;
        }

        /* Notification */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 16px 24px;
            border-radius: 12px;
            color: #fff;
            font-weight: 600;
            z-index: 1000;
            transform: translateX(100%);
            transition: transform 0.3s ease;
        }

        .notification.show {
            transform: translateX(0);
        }

        .notification-success {
            background: linear-gradient(135deg, #2e7d32, #4caf50);
        }

        .notification-warning {
            background: linear-gradient(135deg, #f57c00, #ff9800);
        }

        .notification-error {
            background: linear-gradient(135deg, #d32f2f, #f44336);
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>
                <i class="fas fa-heart-pulse"></i>
                Health Diary
            </h1>
            <div class="breadcrumb">
                <a href="dashboard"><i class="fas fa-home"></i> Trang chủ</a>
                <a href="profile"><i class="fas fa-user"></i> Hồ sơ</a>
                <a href="logout" class="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>

        <!-- Navigation -->
        <div class="nav-tabs">
            <div class="nav-buttons">
                <a href="weight-chart" class="nav-btn">
                    <i class="fas fa-chart-line"></i>
                    Biểu đồ cân nặng
                </a>
                <a href="weight-log" class="nav-btn">
                    <i class="fas fa-weight"></i>
                    Ghi cân nặng
                </a>
                <a href="meal-form" class="nav-btn">
                    <i class="fas fa-utensils"></i>
                    Ghi bữa ăn
                </a>
                <a href="exercise-form" class="nav-btn">
                    <i class="fas fa-dumbbell"></i>
                    Ghi tập luyện
                </a>
                <a href="health-form" class="nav-btn">
                    <i class="fas fa-heartbeat"></i>
                    Tình trạng sức khỏe hôm nay
                </a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Welcome Section -->
            <div class="welcome-section">
                <h1 class="welcome-title">
                    <i class="fas fa-hand-wave"></i>
                    Chào mừng, ${userName}!
                </h1>
                <p class="welcome-subtitle">
                    Hôm nay là <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy" />
                </p>
                
                <!-- BMI Alert -->
                <c:if test="${currentBMI != null}">
                    <div class="alert">
                        <strong><i class="fas fa-info-circle"></i> BMI hiện tại: ${currentBMI}</strong> - ${bmiAdvice}
                    </div>
                </c:if>

                <!-- Daily Goal Progress -->
                <c:if test="${dailyGoal != null}">
                    <div class="widget">
                        <h3><i class="fas fa-target"></i> Tiến độ mục tiêu hôm nay</h3>
                        <div class="progress-container">
                            <div class="progress-bar progress-bar-success" style="width: ${dailyGoal.percentage}%"></div>
                        </div>
                        <p style="text-align: center; margin-top: 10px; color: #666;">
                            ${dailyGoal.current}/${dailyGoal.target} calo (${dailyGoal.percentage}%)
                        </p>
                    </div>
                </c:if>
            </div>

            <!-- Today's Stats -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-fire"></i>
                    </div>
                    <div class="stat-value">${todayCaloriesIn != null ? todayCaloriesIn : 0}</div>
                    <div class="stat-label">Calo nạp vào</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-running"></i>
                    </div>
                    <div class="stat-value">${todayCaloriesOut != null ? todayCaloriesOut : 0}</div>
                    <div class="stat-label">Calo đốt cháy</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-balance-scale"></i>
                    </div>
                    <div class="stat-value net-calories-${(todayNetCalories != null ? todayNetCalories : 0) > 0 ? 'positive' : 'negative'}">
                        ${todayNetCalories != null ? todayNetCalories : 0}
                    </div>
                    <div class="stat-label">Calo ròng</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-weight"></i>
                    </div>
                    <div class="stat-value">${latestWeight != null ? latestWeight.weight : 'N/A'}</div>
                    <div class="stat-label">Cân nặng (kg)</div>
                </div>
            </div>

            <!-- Quick Actions -->
            <!-- Health Status Widget -->
            <div class="widget">
                <h3><i class="fas fa-heartbeat"></i> Tình trạng sức khỏe</h3>
                <c:choose>
                    <c:when test="${todayHealthStatus != null}">
                        <div class="alert alert-success">
                            <strong>Hôm nay:</strong> ${todayHealthStatus.status}
                            <c:if test="${not empty todayHealthStatus.notes}">
                                <br><small>${todayHealthStatus.notes}</small>
                            </c:if>
                        </div>
                        <div style="text-align: center;">
                            <a href="health-form" class="btn btn-secondary">
                                <i class="fas fa-edit"></i> Cập nhật
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p style="text-align: center; color: #666; padding: 20px;">
                            Chưa ghi tình trạng hôm nay<br>
                            <a href="health-form" class="btn btn-primary" style="margin-top: 12px;">
                                <i class="fas fa-plus"></i> Ghi ngay
                            </a>
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- User Profile Summary -->
            <div class="widget">
                <h3><i class="fas fa-user"></i> Thông tin cá nhân</h3>
                <div class="user-info">
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
                        <span class="info-label">Chiều cao:</span>
                        <span class="info-value">${user.heightCm != null ? user.heightCm : 'Chưa cập nhật'} cm</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Cân nặng hiện tại:</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${latestWeight != null}">
                                    ${latestWeight.weight} kg
                                    <small>(<fmt:formatDate value="${latestWeight.date}" pattern="dd/MM/yyyy" />)</small>
                                </c:when>
                                <c:otherwise>Chưa cập nhật</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Mục tiêu:</span>
                        <span class="info-value">${user.goal != null ? user.goal : 'Chưa cập nhật'}</span>
                    </div>
                </div>
                
                <div style="text-align: center; margin-top: 15px;">
                    <a href="profile" class="btn btn-primary">
                        <i class="fas fa-edit"></i> Cập nhật hồ sơ
                    </a>
                </div>
            </div>

            <!-- BMI Analysis -->
            <c:if test="${user.heightCm != null && latestWeight != null}">
            <div class="widget">
                <h3><i class="fas fa-chart-pie"></i> Phân tích BMI</h3>
                <c:set var="heightM" value="${user.heightCm / 100}" />
                <c:set var="bmi" value="${latestWeight.weight / (heightM * heightM)}" />
                <c:set var="bmiRounded" value="${Math.round(bmi * 10) / 10}" />
                
                <div class="user-info">
                    <div class="info-row">
                        <span class="info-label">Chỉ số BMI:</span>
                        <span class="info-value">${bmiRounded}</span>
                    </div>
                    
                    <div class="info-row">
                        <span class="info-label">Phân loại:</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${bmi < 18.5}">
                                    <span class="bmi-underweight">Thiếu cân</span>
                                </c:when>
                                <c:when test="${bmi >= 18.5 && bmi < 25}">
                                    <span class="bmi-normal">Bình thường</span>
                                </c:when>
                                <c:when test="${bmi >= 25 && bmi < 30}">
                                    <span class="bmi-overweight">Thừa cân</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="bmi-obese">Béo phì</span>
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
            </div>
            </c:if>

            <!-- Quick Links -->
            <div class="widget">
                <h3><i class="fas fa-link"></i> Liên kết nhanh</h3>
                <div style="text-align: center;">
                    <a href="weight-chart" class="btn btn-secondary">
                        <i class="fas fa-chart-line"></i> Biểu đồ cân nặng
                    </a>
                    <a href="calorie-tracking" class="btn btn-secondary">
                        <i class="fas fa-fire"></i> Theo dõi calo
                    </a>
                    <a href="exercise-history" class="btn btn-secondary">
                        <i class="fas fa-history"></i> Lịch sử tập luyện
                    </a>
                    <a href="disease-management" class="btn btn-secondary">
                        <i class="fas fa-stethoscope"></i> Tình trạng sức khỏe bệnh
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Notification Container -->
    <div id="notification-container"></div>
    
    <script>
        // Check if user is logged in
        <c:if test="${empty user}">
            window.location.href = 'login';
        </c:if>

        // Show notification function
        function showNotification(message, type = 'success') {
            const container = document.getElementById('notification-container');
            const notification = document.createElement('div');
            notification.className = `notification notification-${type}`;
            notification.textContent = message;
            
            container.appendChild(notification);
            
            // Show notification
            setTimeout(() => {
                notification.classList.add('show');
            }, 100);
            
            // Hide and remove notification
            setTimeout(() => {
                notification.classList.remove('show');
                setTimeout(() => {
                    container.removeChild(notification);
                }, 300);
            }, 3000);
        }

        // Quick action keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey || e.metaKey) {
                switch(e.key) {
                    case 'm':
                        e.preventDefault();
                        window.location.href = 'meal-form';
                        break;
                    case 'e':
                        e.preventDefault(); 
                        window.location.href = 'exercise-form';
                        break;
                    case 'w':
                        e.preventDefault();
                        window.location.href = 'weight-log';
                        break;
                    case 'h':
                        e.preventDefault();
                        window.location.href = 'health-form';
                        break;
                    case 'c':
                        e.preventDefault();
                        window.location.href = 'weight-chart';
                        break;
                }
            }
        });

        // Auto-refresh stats every 5 minutes
        setInterval(function() {
            // You can add AJAX call here to refresh stats
            console.log('Refreshing dashboard stats...');
        }, 300000);

        // Add loading states to action cards
        document.querySelectorAll('.action-card').forEach(card => {
            card.addEventListener('click', function() {
                this.classList.add('loading');
            });
        });

        // Show welcome message on page load
        window.addEventListener('load', function() {
            const userName = '${userName}';
            if (userName) {
                showNotification(`Chào mừng trở lại, ${userName}!`, 'success');
            }
        });

        // Handle form submissions with better UX
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', function() {
                const submitBtn = this.querySelector('button[type="submit"]');
                if (submitBtn) {
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
                }
            });
        });

        // Add smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Add confirmation for logout
        document.querySelector('a[href="logout"]').addEventListener('click', function(e) {
            if (!confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                e.preventDefault();
            }
        });

        // Add tooltips for keyboard shortcuts
        const shortcuts = {
            'meal-form': 'Ctrl+M',
            'exercise-form': 'Ctrl+E', 
            'weight-log': 'Ctrl+W',
            'health-form': 'Ctrl+H',
            'weight-chart': 'Ctrl+C'
        };

        Object.entries(shortcuts).forEach(([href, shortcut]) => {
            const link = document.querySelector(`a[href="${href}"]`);
            if (link) {
                link.title = `Phím tắt: ${shortcut}`;
            }
        });
    </script>
</body>
</html>