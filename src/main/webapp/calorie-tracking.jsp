<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Theo dõi Calorie - Health Diary</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c9 50%, #a5d6a7 100%);
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
            box-shadow: 0 2px 20px rgba(76, 175, 80, 0.1);
            padding: 24px 32px;
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            color: #4caf50;
            font-size: 28px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .breadcrumb {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .breadcrumb a {
            color: #4caf50;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .breadcrumb a:hover {
            background: #e8f5e8;
            transform: translateY(-1px);
        }

        .breadcrumb .separator {
            color: #a5d6a7;
            font-size: 14px;
        }

        .breadcrumb a.logout {
            color: #d32f2f;
        }

        .breadcrumb a.logout:hover {
            background: #ffebee;
        }

        /* Main Container */
        .main-container {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(76, 175, 80, 0.12);
            padding: 40px;
            position: relative;
            overflow: hidden;
        }

        .main-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #4caf50, #66bb6a, #4caf50);
        }

        /* Section Headers */
        .section-header {
            color: #4caf50;
            font-size: 24px;
            font-weight: 600;
            margin: 32px 0 24px 0;
            display: flex;
            align-items: center;
            gap: 12px;
            text-align: center;
            justify-content: center;
        }

        .section-header:first-child {
            margin-top: 0;
            font-size: 32px;
        }

        .section-header i {
            background: #e8f5e8;
            padding: 8px;
            border-radius: 8px;
            font-size: 20px;
        }

        /* Date Selector */
        .date-selector {
            background: linear-gradient(135deg, #e8f5e8, #f1f8e9);
            padding: 20px;
            border-radius: 16px;
            margin-bottom: 30px;
            text-align: center;
            border: 2px solid #c8e6c9;
        }

        .date-selector input[type="date"] {
            padding: 12px 16px;
            border: 2px solid #c8e6c9;
            border-radius: 12px;
            font-size: 16px;
            margin: 0 10px;
            background: #fff;
            transition: all 0.3s ease;
        }

        .date-selector input[type="date"]:focus {
            outline: none;
            border-color: #4caf50;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }

        .date-selector label {
            font-weight: 600;
            color: #4caf50;
            margin-right: 10px;
        }

        /* Calorie Summary Grid */
        .calorie-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .calorie-card {
            background: linear-gradient(135deg, #fff, #f8f9fa);
            padding: 30px 25px;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            text-align: center;
            border-left: 4px solid #4caf50;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .calorie-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg, transparent, #4caf50, transparent);
        }

        .calorie-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .calorie-card.consumed {
            border-left-color: #ff9800;
        }

        .calorie-card.consumed::before {
            background: linear-gradient(90deg, transparent, #ff9800, transparent);
        }

        .calorie-card.burned {
            border-left-color: #f44336;
        }

        .calorie-card.burned::before {
            background: linear-gradient(90deg, transparent, #f44336, transparent);
        }

        .calorie-card.net {
            border-left-color: #2196f3;
        }

        .calorie-card.net::before {
            background: linear-gradient(90deg, transparent, #2196f3, transparent);
        }

        .calorie-card h3 {
            color: #666;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .calorie-card .value {
            font-size: 42px;
            font-weight: 700;
            color: #4caf50;
            margin-bottom: 8px;
            line-height: 1;
        }

        .calorie-card.consumed .value {
            color: #ff9800;
        }

        .calorie-card.burned .value {
            color: #f44336;
        }

        .calorie-card.net .value {
            color: #2196f3;
        }

        .calorie-card .unit {
            color: #999;
            font-size: 16px;
            font-weight: 500;
        }

        /* Lists Section */
        .list-section {
            margin-bottom: 40px;
        }

        .list-container {
            background: #f8f9fa;
            border-radius: 16px;
            padding: 24px;
            border: 2px solid #e8f5e8;
        }

        .list-item {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.3s ease;
            border-left: 4px solid #4caf50;
        }

        .list-item:hover {
            transform: translateX(4px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
        }

        .list-item:last-child {
            margin-bottom: 0;
        }

        .item-info {
            flex: 1;
        }

        .item-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
            font-size: 16px;
        }

        .item-details {
            color: #666;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .item-calories {
            font-weight: 700;
            font-size: 20px;
            color: #4caf50;
            background: #e8f5e8;
            padding: 8px 16px;
            border-radius: 20px;
        }

        .empty-message {
            text-align: center;
            color: #999;
            font-style: italic;
            padding: 40px 20px;
            background: white;
            border-radius: 12px;
            border: 2px dashed #e0e0e0;
        }

        /* Buttons */
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
            text-align: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4caf50, #66bb6a);
            color: #fff;
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
        }

        .btn-secondary {
            background: #fff;
            color: #4caf50;
            border: 2px solid #4caf50;
        }

        .btn-secondary:hover {
            background: #e8f5e8;
            transform: translateY(-1px);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 16px;
            justify-content: center;
            margin-top: 40px;
            padding-top: 24px;
            border-top: 1px solid #e8f5e8;
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

            .main-container {
                padding: 24px;
                margin: 16px;
            }

            .calorie-summary {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .list-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }

            .item-calories {
                align-self: flex-end;
            }

            .action-buttons {
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
            <h1><i class="fas fa-chart-line"></i> Theo dõi Calorie</h1>
            <div class="breadcrumb">
                <a href="dashboard">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <span class="separator">•</span>
                <a href="profile">
                    <i class="fas fa-user"></i> Hồ sơ
                </a>
                <span class="separator">•</span>
                <a href="logout" class="logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>

        <!-- Main Container -->
        <div class="main-container">
            <div class="section-header">
                <i class="fas fa-chart-pie"></i>
                Theo dõi Calorie
            </div>

            <!-- Error Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Date Selector -->
            <div class="date-selector">
                <form action="calorie-tracking" method="get" style="display: inline-block;">
                    <label for="date"><i class="fas fa-calendar-alt"></i> Chọn ngày:</label>
                    <input type="date" id="date" name="date" value="${date}" onchange="this.form.submit()">
                </form>
            </div>

            <!-- Calorie Summary -->
            <div class="calorie-summary">
                <div class="calorie-card consumed">
                    <h3><i class="fas fa-utensils"></i> Calorie tiêu thụ</h3>
                    <div class="value">
                        <fmt:formatNumber value="${totalCaloriesConsumed}" maxFractionDigits="0"/>
                    </div>
                    <div class="unit">kcal</div>
                </div>
                <div class="calorie-card burned">
                    <h3><i class="fas fa-fire"></i> Calorie đốt cháy</h3>
                    <div class="value">
                        <fmt:formatNumber value="${totalCaloriesBurned}" maxFractionDigits="0"/>
                    </div>
                    <div class="unit">kcal</div>
                </div>
                <div class="calorie-card net">
                    <h3><i class="fas fa-balance-scale"></i> Calorie ròng</h3>
                    <div class="value">
                        <fmt:formatNumber value="${netCalories}" maxFractionDigits="0"/>
                    </div>
                    <div class="unit">kcal</div>
                </div>
            </div>

            <!-- Meals Section -->
            <div class="list-section">
                <div class="section-header">
                    <i class="fas fa-utensils"></i>
                    Bữa ăn
                </div>
                <div class="list-container">
                    <c:choose>
                        <c:when test="${not empty meals}">
                            <c:forEach var="meal" items="${meals}">
                                <div class="list-item">
                                    <div class="item-info">
                                        <div class="item-name">
                                            <c:choose>
                                                <c:when test="${meal.mealTime == 'breakfast'}">🌅 Bữa sáng</c:when>
                                                <c:when test="${meal.mealTime == 'lunch'}">☀️ Bữa trưa</c:when>
                                                <c:when test="${meal.mealTime == 'dinner'}">🌙 Bữa tối</c:when>
                                                <c:when test="${meal.mealTime == 'snack'}">🍿 Ăn vặt</c:when>
                                                <c:otherwise>${meal.mealTime}</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="item-details">
                                            <i class="fas fa-clock"></i>
                                            <fmt:formatDate value="${meal.logDate}" pattern="HH:mm" />
                                        </div>
                                    </div>
                                    <div class="item-calories">
                                        <fmt:formatNumber value="${meal.totalCalories}" maxFractionDigits="0"/> kcal
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-message">
                                <i class="fas fa-info-circle"></i>
                                Chưa có bữa ăn nào được ghi nhận trong ngày này
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Exercises Section -->
            <div class="list-section">
                <div class="section-header">
                    <i class="fas fa-running"></i>
                    Bài tập
                </div>
                <div class="list-container">
                    <c:choose>
                        <c:when test="${not empty exercises}">
                            <c:forEach var="exercise" items="${exercises}">
                                <div class="list-item">
                                    <div class="item-info">
                                        <div class="item-name">${exercise.exerciseType}</div>
                                        <div class="item-details">
                                            <i class="fas fa-stopwatch"></i>
                                            Thời gian: ${exercise.durationMin} phút
                                            <span>|</span>
                                            <i class="fas fa-clock"></i>
                                            <fmt:formatDate value="${exercise.logDate}" pattern="HH:mm" />
                                        </div>
                                    </div>
                                    <div class="item-calories" style="color: #f44336; background: #ffebee;">
                                        -<fmt:formatNumber value="${exercise.caloriesBurned}" maxFractionDigits="0"/> kcal
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-message">
                                <i class="fas fa-info-circle"></i>
                                Chưa có bài tập nào được ghi nhận trong ngày này
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="meal" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    Thêm bữa ăn
                </a>
                <a href="exercise-form" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    Thêm bài tập
                </a>
                <a href="dashboard" class="btn btn-secondary">
                    <i class="fas fa-home"></i>
                    Về trang chủ
                </a>
            </div>
        </div>
    </div>

    <script>
        // Animation on load
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.calorie-card, .list-item');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    card.style.transition = 'all 0.6s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });

        // Check if user is logged in
        <c:if test="${empty user}">
            window.location.href = 'login';
        </c:if>
    </script>
</body>
</html>