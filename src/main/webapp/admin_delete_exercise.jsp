<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận xóa Exercise - Admin Dashboard</title>
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

        /* Delete Confirmation Container */
        .delete-confirmation {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            max-width: 600px;
            margin: 0 auto;
            overflow: hidden;
            position: relative;
        }

        .delete-confirmation::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #d32f2f, #f44336, #d32f2f);
        }

        .delete-header {
            background: linear-gradient(135deg, #d32f2f, #f44336);
            color: #fff;
            padding: 40px 32px;
            text-align: center;
        }

        .delete-header i {
            font-size: 48px;
            margin-bottom: 16px;
            display: block;
        }

        .delete-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .delete-header p {
            font-size: 16px;
            opacity: 0.9;
        }

        .delete-content {
            padding: 40px 32px;
        }

        /* Exercise Info Section */
        .exercise-info {
            margin-bottom: 32px;
        }

        .exercise-info h3 {
            color: #1976d2;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .exercise-info h3 i {
            background: #e3f2fd;
            padding: 8px;
            border-radius: 8px;
            font-size: 16px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            color: #1976d2;
            font-weight: 600;
            font-size: 14px;
        }

        .info-value {
            color: #333;
            font-weight: 500;
        }

        /* Type Badge */
        .type-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .type-cardio {
            background: #e8f5e8;
            color: #2e7d32;
        }

        .type-strength {
            background: #fff3e0;
            color: #f57c00;
        }

        .type-flexibility {
            background: #f3e5f5;
            color: #7b1fa2;
        }

        .type-balance {
            background: #e1f5fe;
            color: #0277bd;
        }

        /* Difficulty Badge */
        .difficulty-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .difficulty-beginner {
            background: #e8f5e8;
            color: #2e7d32;
        }

        .difficulty-intermediate {
            background: #fff3e0;
            color: #f57c00;
        }

        .difficulty-advanced {
            background: #ffebee;
            color: #d32f2f;
        }

        /* Warning Message */
        .warning-message {
            background: #ffebee;
            color: #d32f2f;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 32px;
            border-left: 4px solid #d32f2f;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .warning-message i {
            font-size: 20px;
            margin-top: 2px;
        }

        .warning-message strong {
            font-weight: 700;
        }

        /* Buttons */
        .action-buttons {
            display: flex;
            gap: 16px;
            justify-content: center;
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

        .btn-danger {
            background: linear-gradient(135deg, #d32f2f, #f44336);
            color: #fff;
            box-shadow: 0 4px 15px rgba(211, 47, 47, 0.3);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(211, 47, 47, 0.4);
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

        /* Responsive */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 16px;
                text-align: center;
            }

            .delete-confirmation {
                margin: 16px;
            }

            .delete-header {
                padding: 32px 24px;
            }

            .delete-content {
                padding: 32px 24px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .info-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 4px;
            }
        }

        /* Loading animation */
        .btn:active {
            transform: translateY(0);
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-dumbbell"></i> Xác nhận xóa Exercise</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin-dashboard">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <span class="separator">•</span>
                <a href="${pageContext.request.contextPath}/admin/exercises">
                    <i class="fas fa-dumbbell"></i> Danh sách Exercise
                </a>
                <span class="separator">•</span>
                <span style="color: #666;">Xóa Exercise</span>
            </div>
        </div>

        <!-- Delete Confirmation -->
        <div class="delete-confirmation">
            <div class="delete-header">
                <i class="fas fa-exclamation-triangle"></i>
                <h1>Xác nhận xóa Exercise</h1>
                <p>Bạn sắp xóa một bài tập khỏi hệ thống</p>
            </div>

            <div class="delete-content">
                <c:if test="${not empty exercise}">
                    <div class="exercise-info">
                        <h3>
                            <i class="fas fa-dumbbell"></i>
                            Thông tin Exercise
                        </h3>
                        <div class="info-row">
                            <span class="info-label">Tên bài tập:</span>
                            <span class="info-value">${exercise.exerciseName}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Loại:</span>
                            <span class="info-value">
                                <span class="type-badge type-${exercise.type.toLowerCase()}">${exercise.type}</span>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Nhóm cơ:</span>
                            <span class="info-value">${exercise.muscleGroup}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Độ khó:</span>
                            <span class="info-value">
                                <span class="difficulty-badge difficulty-${exercise.difficulty.toLowerCase()}">${exercise.difficulty}</span>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Calories/giờ:</span>
                            <span class="info-value">${exercise.caloriesPerHour} kcal</span>
                        </div>
                    </div>

                    <div class="warning-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <div>
                            <strong>Cảnh báo:</strong> Hành động này không thể hoàn tác. Tất cả dữ liệu của bài tập này sẽ bị xóa vĩnh viễn khỏi hệ thống.
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/admin/exercise/delete" method="post">
                        <input type="hidden" name="exerciseId" value="${exercise.id}">
                        <input type="hidden" name="confirmDelete" value="true">
                        
                        <div class="action-buttons">
                            <button type="submit" class="btn btn-danger">
                                <i class="fas fa-trash"></i>
                                Xác nhận xóa
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/exercises" class="btn btn-secondary">
                                <i class="fas fa-times"></i>
                                Hủy bỏ
                            </a>
                        </div>
                    </form>
                </c:if>

                <c:if test="${empty exercise}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <span><strong>Lỗi:</strong> Không tìm thấy thông tin exercise để xóa.</span>
                    </div>
                    
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/admin/exercises" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i>
                            Quay lại danh sách
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>