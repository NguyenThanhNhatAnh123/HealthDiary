<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Food - Admin Dashboard</title>
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
            max-width: 1400px;
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

        .header-actions {
            display: flex;
            gap: 12px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 12px;
            font-size: 14px;
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

        .btn-danger {
            background: linear-gradient(135deg, #d32f2f, #f44336);
            color: #fff;
            box-shadow: 0 4px 15px rgba(211, 47, 47, 0.3);
            font-size: 12px;
            padding: 8px 16px;
        }

        .btn-danger:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(211, 47, 47, 0.4);
        }

        .btn-edit {
            background: linear-gradient(135deg, #ed6c02, #ff9800);
            color: #fff;
            box-shadow: 0 4px 15px rgba(237, 108, 2, 0.3);
            font-size: 12px;
            padding: 8px 16px;
        }

        .btn-edit:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(237, 108, 2, 0.4);
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

        /* Table Container */
        .table-container {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            overflow: hidden;
            position: relative;
        }

        .table-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #1976d2, #42a5f5, #1976d2);
        }

        /* Table */
        .food-table {
            width: 100%;
            border-collapse: collapse;
        }

        .food-table th {
            background: #f8f9fa;
            color: #1976d2;
            font-weight: 600;
            padding: 20px 16px;
            text-align: left;
            font-size: 14px;
            border-bottom: 2px solid #e3f2fd;
        }

        .food-table td {
            padding: 16px;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }

        .food-table tr:hover {
            background: #f8f9fa;
        }

        .food-table tr:last-child td {
            border-bottom: none;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state i {
            font-size: 64px;
            color: #ccc;
            margin-bottom: 16px;
        }

        .empty-state h3 {
            font-size: 20px;
            margin-bottom: 8px;
            color: #999;
        }

        .empty-state p {
            font-size: 14px;
            color: #666;
            margin-bottom: 24px;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
        }

        /* Type Badge */
        .type-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .type-breakfast {
            background: #fff3e0;
            color: #f57c00;
        }

        .type-lunch {
            background: #e8f5e8;
            color: #2e7d32;
        }

        .type-dinner {
            background: #f3e5f5;
            color: #7b1fa2;
        }

        .type-snack {
            background: #e1f5fe;
            color: #0277bd;
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

        /* Responsive */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 16px;
                text-align: center;
            }

            .header-actions {
                justify-content: center;
            }

            .food-table {
                font-size: 12px;
            }

            .food-table th,
            .food-table td {
                padding: 12px 8px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 4px;
            }
        }

        /* Loading */
        .loading {
            text-align: center;
            padding: 40px;
        }

        .loading i {
            font-size: 32px;
            color: #1976d2;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>
                <i class="fas fa-utensils"></i>
                Danh sách Food
            </h1>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/admin/food/add" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    Thêm Food Mới
                </a>
                <!-- Breadcrumb Navigation -->
                <div class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/admin-dashboard">
                        <i class="fas fa-home"></i>
                        Dashboard
                    </a>
                </div>
            </div>
        </div>

        <!-- Success Alert -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${success}</span>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <!-- Error Alert -->
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-triangle"></i>
                <span>${error}</span>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <!-- Table Container -->
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty foods}">
                    <table class="food-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên món ăn</th>
                                <th>Loại</th>
                                <th>Calories</th>
                                <th>Protein (g)</th>
                                <th>Carbs (g)</th>
                                <th>Fat (g)</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="food" items="${foods}">
                                <tr>
                                    <td>${food.id}</td>
                                    <td>
                                        <strong>${food.foodName}</strong>
                                    </td>
                                    <td>
                                        <span class="type-badge type-${food.type.toLowerCase()}">${food.type}</span>
                                    </td>
                                    <td>${food.calories} kcal</td>
                                    <td>${food.protein}</td>
                                    <td>${food.carbs}</td>
                                    <td>${food.fat}</td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/admin/food/edit?id=${food.id}" class="btn btn-edit">
                                                <i class="fas fa-edit"></i>
                                                Sửa
                                            </a>
                                            <button class="btn btn-danger" onclick="deleteFood(${food.id})">
                                                <i class="fas fa-trash"></i>
                                                Xóa
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-utensils"></i>
                        <h3>Không có món ăn nào</h3>
                        <p>Chưa có món ăn nào trong hệ thống. Hãy thêm món ăn đầu tiên!</p>
                        <a href="${pageContext.request.contextPath}/admin/food/add" class="btn btn-primary">
                            <i class="fas fa-plus"></i>
                            Thêm Food Đầu Tiên
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
    function deleteFood(foodId) {
        if (confirm('Bạn có chắc chắn muốn xóa món ăn này?')) {
            window.location.href = '${pageContext.request.contextPath}/admin/food/delete?id=' + foodId;
        }
    }

        // Auto hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.style.opacity = '0';
                    setTimeout(() => {
                        alert.style.display = 'none';
                    }, 300);
                }, 5000);
            });
        });
    </script>
</body>
</html>