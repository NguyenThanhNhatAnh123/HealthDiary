<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử tập luyện - Health Diary</title>
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
            padding: 0;
        }

        /* Navigation Bar */
        .nav-bar {
            background: #fff;
            box-shadow: 0 2px 20px rgba(25, 118, 210, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 32px;
        }

        .nav-brand {
            font-size: 24px;
            font-weight: 700;
            color: #1976d2;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-brand::before {
            content: "🏥";
            font-size: 28px;
        }

        .nav-menu {
            display: flex;
            gap: 24px;
        }

        .nav-menu a {
            color: #1976d2;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .nav-menu a:hover {
            background: #e3f2fd;
            transform: translateY(-1px);
        }

        /* Main Content */
        .main-content {
            padding: 20px;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Page Header */
        .page-header {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 20px rgba(25, 118, 210, 0.1);
            padding: 40px 32px;
            margin-bottom: 24px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #1976d2, #42a5f5, #1976d2);
        }

        .page-header h1 {
            color: #1976d2;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #666;
            font-size: 16px;
        }

        /* Exercise Statistics */
        .exercise-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 24px;
        }

        .stat-card {
            background: #fff;
            border-radius: 16px;
            padding: 32px 24px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #1976d2, #42a5f5);
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 40px rgba(25, 118, 210, 0.16);
        }

        .stat-icon {
            background: #e3f2fd;
            width: 64px;
            height: 64px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            font-size: 28px;
            color: #1976d2;
        }

        .stat-number {
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 8px;
            color: #1976d2;
        }

        .stat-label {
            font-size: 14px;
            color: #666;
            font-weight: 500;
        }

        /* Filter Controls */
        .filter-section {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            padding: 24px 32px;
            margin-bottom: 24px;
        }

        .filter-section h3 {
            color: #1976d2;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .filter-section h3 i {
            background: #e3f2fd;
            padding: 8px;
            border-radius: 8px;
            font-size: 16px;
        }

        .filter-controls {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
        }

        .filter-label {
            color: #1976d2;
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .filter-controls select,
        .filter-controls input {
            padding: 14px 16px;
            border: 2px solid #e3f2fd;
            border-radius: 12px;
            font-size: 16px;
            background: #fafafa;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .filter-controls select:focus,
        .filter-controls input:focus {
            outline: none;
            border-color: #1976d2;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
            transform: translateY(-1px);
        }

        /* Exercise List */
        .exercise-list {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            margin-bottom: 24px;
            position: relative;
            overflow: hidden;
        }

        .exercise-list::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #1976d2, #42a5f5, #1976d2);
        }

        .exercise-list-header {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            padding: 24px 32px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .exercise-list-header i {
            font-size: 24px;
        }

        .exercise-list-header h3 {
            font-size: 20px;
            font-weight: 600;
        }

        .exercise-list-content {
            padding: 0;
        }

        .exercise-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 32px;
            border-bottom: 1px solid #e3f2fd;
            transition: all 0.3s ease;
        }

        .exercise-item:hover {
            background-color: #f8f9fa;
            transform: translateX(4px);
        }

        .exercise-item:last-child {
            border-bottom: none;
        }

        .exercise-info {
            flex: 1;
        }

        .exercise-name {
            font-weight: 600;
            color: #1976d2;
            margin-bottom: 8px;
            font-size: 16px;
        }

        .exercise-details {
            font-size: 14px;
            color: #666;
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .exercise-details span {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .exercise-calories {
            background: linear-gradient(135deg, #d32f2f, #f44336);
            color: #fff;
            padding: 12px 20px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 16px;
            text-align: center;
            min-width: 120px;
        }

        /* Action Buttons */
        .action-buttons {
            text-align: center;
            margin-top: 40px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 14px 32px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            margin: 0 8px;
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

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 32px;
            color: #666;
        }

        .empty-state i {
            font-size: 64px;
            color: #e3f2fd;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            color: #1976d2;
            margin-bottom: 12px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                gap: 16px;
                text-align: center;
            }

            .nav-menu {
                flex-wrap: wrap;
                justify-content: center;
                gap: 12px;
            }

            .main-content {
                padding: 16px;
            }

            .page-header {
                padding: 32px 24px;
            }

            .exercise-stats {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .filter-section {
                padding: 20px 24px;
            }

            .filter-controls {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .exercise-list-header {
                padding: 20px 24px;
            }

            .exercise-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
                padding: 20px 24px;
            }

            .exercise-calories {
                align-self: stretch;
                text-align: center;
            }

            .action-buttons .btn {
                display: block;
                margin: 8px auto;
                width: 100%;
                max-width: 300px;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="nav-bar">
        <div class="nav-container">
            <a href="dashboard" class="nav-brand">Health Diary</a>
            <div class="nav-menu">
                <a href="dashboard">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <a href="exercise-history">
                    <i class="fas fa-history"></i> Lịch sử tập luyện
                </a>
                <a href="exercise-log">
                    <i class="fas fa-plus-circle"></i> Ghi bài tập
                </a>
                <a href="profile">
                    <i class="fas fa-user"></i> Hồ sơ
                </a>
                <a href="logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="main-content">
        <div class="dashboard-container">
            <!-- Page Header -->
            <div class="page-header">
                <h1><i class="fas fa-history"></i> Lịch sử tập luyện</h1>
                <p>Theo dõi tiến trình và thống kê hoạt động thể chất của bạn</p>
            </div>
            
            <!-- Exercise Statistics -->
            <div class="exercise-stats">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-number" id="totalSessions">${totalSessions}</div>
                    <div class="stat-label">Tổng buổi tập</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-number" id="totalDuration">${totalDuration}</div>
                    <div class="stat-label">Tổng thời gian (phút)</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-fire"></i>
                    </div>
                    <div class="stat-number" id="totalCalories">${totalCalories}</div>
                    <div class="stat-label">Tổng calo đốt cháy</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="stat-number" id="avgDuration">${avgDuration}</div>
                    <div class="stat-label">TB thời gian/buổi</div>
                </div>
            </div>
            
            <!-- Filter Controls -->
            <div class="filter-section">
                <h3>
                    <i class="fas fa-filter"></i>
                    Bộ lọc tìm kiếm
                </h3>
                <div class="filter-controls">
                    <div class="filter-group">
                        <label class="filter-label" for="dateFrom">
                            <i class="fas fa-calendar-alt"></i>
                            Từ ngày
                        </label>
                        <input type="date" id="dateFrom" value="${dateFrom}">
                    </div>
                    <div class="filter-group">
                        <label class="filter-label" for="dateTo">
                            <i class="fas fa-calendar-alt"></i>
                            Đến ngày
                        </label>
                        <input type="date" id="dateTo" value="${dateTo}">
                    </div>
                    <div class="filter-group">
                        <label class="filter-label" for="exerciseType">
                            <i class="fas fa-dumbbell"></i>
                            Loại bài tập
                        </label>
                        <select id="exerciseType">
                            <option value="">Tất cả</option>
                            <option value="cardio">Cardio</option>
                            <option value="strength">Sức mạnh</option>
                            <option value="flexibility">Linh hoạt</option>
                            <option value="balance">Cân bằng</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label class="filter-label" for="intensity">
                            <i class="fas fa-tachometer-alt"></i>
                            Cường độ
                        </label>
                        <select id="intensity">
                            <option value="">Tất cả</option>
                            <option value="low">Nhẹ</option>
                            <option value="medium">Trung bình</option>
                            <option value="high">Cao</option>
                        </select>
                    </div>
                </div>
            </div>
            
            <!-- Exercise List -->
            <div class="exercise-list">
                <div class="exercise-list-header">
                    <i class="fas fa-list-ul"></i>
                    <h3>Danh sách bài tập</h3>
                </div>
                <div class="exercise-list-content" id="exerciseList">
                    <c:choose>
                        <c:when test="${not empty exercises}">
                            <c:forEach var="exercise" items="${exercises}">
                                <div class="exercise-item">
                                    <div class="exercise-info">
                                        <div class="exercise-name">${exercise.exerciseType}</div>
                                        <div class="exercise-details">
                                            <span>
                                                <i class="fas fa-calendar"></i>
                                                <fmt:formatDate value="${exercise.logDate}" pattern="dd/MM/yyyy HH:mm" />
                                            </span>
                                            <span>
                                                <i class="fas fa-clock"></i>
                                                ${exercise.durationMin} phút
                                            </span>
                                        </div>
                                    </div>
                                    <div class="exercise-calories">
                                        <i class="fas fa-fire"></i>
                                        ${exercise.caloriesBurned} kcal
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-dumbbell"></i>
                                <h3>Chưa có dữ liệu</h3>
                                <p>Chưa có bài tập nào được ghi nhận trong khoảng thời gian này.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="exercise-log" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    Ghi bài tập mới
                </a>
                <a href="dashboard" class="btn btn-secondary">
                    <i class="fas fa-home"></i>
                    Về trang chủ
                </a>
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