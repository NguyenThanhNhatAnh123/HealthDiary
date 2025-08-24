<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử tình trạng sức khỏe - Health Diary</title>
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

        .breadcrumb .separator {
            color: #90caf9;
            font-size: 14px;
        }

        /* Main Container */
        .main-container {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
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
            background: linear-gradient(90deg, #1976d2, #42a5f5, #1976d2);
        }

        /* Section Headers */
        .section-header {
            color: #1976d2;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 24px;
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

        /* Health Status Cards */
        .health-status-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .health-status-card {
            background: #f8f9fa;
            border-radius: 16px;
            padding: 24px;
            border: 2px solid #e3f2fd;
            transition: all 0.3s ease;
        }

        .health-status-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(25, 118, 210, 0.15);
            border-color: #1976d2;
        }

        .health-status-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .health-status-date {
            font-size: 18px;
            font-weight: 600;
            color: #1976d2;
        }

        .health-status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-excellent {
            background: #e8f5e8;
            color: #2e7d32;
        }

        .status-good {
            background: #e3f2fd;
            color: #1976d2;
        }

        .status-fair {
            background: #fff3e0;
            color: #f57c00;
        }

        .status-poor {
            background: #ffebee;
            color: #d32f2f;
        }

        .health-status-notes {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
            margin-top: 12px;
            padding: 12px;
            background: white;
            border-radius: 8px;
            border-left: 4px solid #1976d2;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state i {
            font-size: 64px;
            color: #90caf9;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-size: 24px;
            color: #1976d2;
            margin-bottom: 12px;
        }

        .empty-state p {
            font-size: 16px;
            margin-bottom: 24px;
        }

        /* Buttons */
        .button-group {
            display: flex;
            gap: 16px;
            justify-content: center;
            margin-top: 30px;
            padding-top: 24px;
            border-top: 1px solid #e3f2fd;
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

            .health-status-grid {
                grid-template-columns: 1fr;
            }

            .button-group {
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
            <h1><i class="fas fa-heartbeat"></i> Lịch sử tình trạng sức khỏe</h1>
            <div class="breadcrumb">
                <a href="dashboard"><i class="fas fa-home"></i> Trang chủ</a>
                <span class="separator">•</span>
                <a href="health-form"><i class="fas fa-plus"></i> Ghi nhận sức khỏe</a>
                <span class="separator">•</span>
                <span style="color: #666;">Lịch sử sức khỏe</span>
                <span class="separator">•</span>
                <a href="logout" class="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>

        <!-- Main Container -->
        <div class="main-container">
            <div class="section-header">
                <i class="fas fa-history"></i>
                Lịch sử tình trạng sức khỏe
            </div>

            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Success Alert -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <span>${success}</span>
                </div>
            </c:if>

            <!-- Health Status History -->
            <c:choose>
                <c:when test="${not empty healthHistory and healthHistory.size() > 0}">
                    <div class="health-status-grid">
                        <c:forEach var="healthLog" items="${healthHistory}">
                            <div class="health-status-card">
                                <div class="health-status-header">
                                    <div class="health-status-date">
                                        <fmt:formatDate value="${healthLog.date}" pattern="dd/MM/yyyy" />
                                    </div>
                                    <div class="health-status-badge status-${healthLog.status.toLowerCase()}">
                                        ${healthLog.status}
                                    </div>
                                </div>
                                
                                <c:if test="${not empty healthLog.notes}">
                                    <div class="health-status-notes">
                                        <strong>Ghi chú:</strong> ${healthLog.notes}
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-clipboard-list"></i>
                        <h3>Chưa có lịch sử sức khỏe</h3>
                        <p>Bạn chưa ghi nhận tình trạng sức khỏe nào. Hãy bắt đầu theo dõi sức khỏe của mình ngay hôm nay!</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- Buttons -->
            <div class="button-group">
                <a href="health-form" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Ghi nhận sức khỏe mới
                </a>
                <a href="dashboard" class="btn btn-secondary">
                    <i class="fas fa-home"></i> Về trang chủ
                </a>
            </div>
        </div>
    </div>

    <script>
        // Check if user is logged in
        <c:if test="${empty user}">
            window.location.href = 'login';
        </c:if>

        // Smooth animations
        document.addEventListener('DOMContentLoaded', function() {
            const mainContainer = document.querySelector('.main-container');
            if (mainContainer) {
                mainContainer.style.opacity = '0';
                mainContainer.style.transform = 'translateY(20px)';

                setTimeout(() => {
                    mainContainer.style.transition = 'all 0.6s ease';
                    mainContainer.style.opacity = '1';
                    mainContainer.style.transform = 'translateY(0)';
                }, 100);
            }
        });
    </script>
</body>
</html>