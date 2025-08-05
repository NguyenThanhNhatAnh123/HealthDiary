<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ghi cân nặng - Health Diary</title>
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

        /* Form Container */
        .form-container {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            padding: 40px;
            max-width: 800px;
            margin: 0 auto;
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
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
            font-size: 20px;
            font-weight: 600;
            margin: 32px 0 24px 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-header:first-child {
            margin-top: 0;
        }

        .section-header i {
            background: #e3f2fd;
            padding: 8px;
            border-radius: 8px;
            font-size: 16px;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 24px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group label {
            color: #1976d2;
            font-weight: 600;
            font-size: 14px;
            display: block;
            margin-bottom: 8px;
        }

        .required {
            color: #d32f2f;
            font-weight: 700;
        }

        /* Form Controls */
        input[type="text"], 
        input[type="email"], 
        input[type="password"], 
        input[type="number"], 
        input[type="datetime-local"],
        select, 
        textarea {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e3f2fd;
            border-radius: 12px;
            font-size: 16px;
            background: #fafafa;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        input[type="text"]:focus, 
        input[type="email"]:focus, 
        input[type="password"]:focus, 
        input[type="number"]:focus, 
        input[type="datetime-local"]:focus,
        select:focus, 
        textarea:focus {
            outline: none;
            border-color: #1976d2;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
            transform: translateY(-1px);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        select {
            cursor: pointer;
        }

        /* Buttons */
        .button-group {
            display: flex;
            gap: 16px;
            justify-content: center;
            margin-top: 40px;
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

        .alert-danger {
            background: #ffebee;
            color: #d32f2f;
            border-left: 4px solid #d32f2f;
        }

        .alert-success {
            background: #e8f5e8;
            color: #2e7d32;
            border-left: 4px solid #4caf50;
        }

        /* User Info */
        .user-info {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 24px;
        }

        .user-info h3 {
            color: #1976d2;
            margin-bottom: 16px;
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-row {
            display: flex;
            margin-bottom: 12px;
            padding-bottom: 12px;
            border-bottom: 1px solid #e3f2fd;
        }

        .info-label {
            font-weight: 600;
            color: #1976d2;
            width: 150px;
        }

        .info-value {
            color: #333;
            flex: 1;
        }

        .weight-change-positive {
            color: #dc3545;
            font-weight: 600;
        }

        .weight-change-negative {
            color: #28a745;
            font-weight: 600;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 16px;
                text-align: center;
            }

            .form-container {
                padding: 24px;
            }

            .form-row {
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
            <h1><i class="fas fa-weight"></i> Ghi cân nặng</h1>
            <div class="breadcrumb">
                <a href="dashboard">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <span class="separator">•</span>
                <a href="weight-chart">
                    <i class="fas fa-chart-line"></i> Biểu đồ cân nặng
                </a>
                <span class="separator">•</span>
                <span style="color: #666;">Ghi cân nặng</span>
            </div>
        </div>

        <!-- Form Container -->
        <div class="form-container">
            <!-- Error Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>${error}</span>
                </div>
            </c:if>
            
            <!-- Success Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <span>${success}</span>
                </div>
            </c:if>
            
            <!-- Current Weight Info -->
            <c:if test="${latestWeight != null}">
                <div class="user-info">
                    <h3><i class="fas fa-info-circle"></i> Cân nặng gần nhất</h3>
                    <div class="info-row">
                        <span class="info-label">Cân nặng:</span>
                        <span class="info-value">${latestWeight.weight} kg</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Ngày ghi:</span>
                        <span class="info-value">
                            <fmt:formatDate value="${latestWeight.date}" pattern="dd/MM/yyyy HH:mm" />
                        </span>
                    </div>
                    <c:if test="${weightChange != null}">
                        <div class="info-row">
                            <span class="info-label">Thay đổi:</span>
                            <span class="info-value weight-change-${weightChange > 0 ? 'positive' : 'negative'}">
                                ${weightChange > 0 ? '+' : ''}${weightChange} kg
                            </span>
                        </div>
                    </c:if>
                </div>
            </c:if>
            
            <!-- Weight Log Form -->
            <form action="weight-log" method="post" id="weightForm">
                <h3 class="section-header">
                    <i class="fas fa-edit"></i>
                    Ghi cân nặng mới
                </h3>
                
                <div class="form-group">
                    <label for="weight">Cân nặng (kg) <span class="required">*</span></label>
                    <input type="number" id="weight" name="weight" step="0.1" min="10" max="500" required>
                    <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                        Nhập cân nặng từ 10kg đến 500kg
                    </small>
                </div>
                
                <div class="form-group">
                    <label for="date">Ngày ghi</label>
                    <input type="datetime-local" id="date" name="date" 
                           value="<fmt:formatDate value='<%= new java.util.Date() %>' pattern='yyyy-MM-dd\'T\'HH:mm' />">
                    <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                        Để trống để sử dụng thời gian hiện tại
                    </small>
                </div>
                
                <div class="form-group">
                    <label for="notes">Ghi chú</label>
                    <textarea id="notes" name="notes" placeholder="Ghi chú về cân nặng (tùy chọn)..."></textarea>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Ghi cân nặng
                    </button>
                </div>
            </form>
            
            <!-- Recent Weight History -->
            <c:if test="${not empty recentWeights}">
                <div class="user-info">
                    <h3><i class="fas fa-history"></i> Lịch sử gần đây</h3>
                    <c:forEach items="${recentWeights}" var="weight" varStatus="status">
                        <div class="info-row">
                            <span class="info-label">
                                <fmt:formatDate value="${weight.date}" pattern="dd/MM/yyyy HH:mm" />
                            </span>
                            <span class="info-value">
                                <strong>${weight.weight} kg</strong>
                                <c:if test="${not empty weight.notes}">
                                    <br><small style="color: #666;">${weight.notes}</small>
                                </c:if>
                            </span>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            
            <!-- Action Buttons -->
            <div class="button-group">
                <a href="weight-chart" class="btn btn-secondary">
                    <i class="fas fa-chart-line"></i> Xem biểu đồ
                </a>
                <a href="dashboard" class="btn btn-secondary">
                    <i class="fas fa-home"></i> Về trang chủ
                </a>
            </div>
        </div>
    </div>
    
    <script>
        // Form validation
        document.getElementById('weightForm').addEventListener('submit', function(e) {
            const weight = parseFloat(document.getElementById('weight').value);
            
            if (isNaN(weight) {
                e.preventDefault();
                alert('Vui lòng nhập cân nặng hợp lệ');
                return false;
            }
            
            if (weight < 10 || weight > 500) {
                e.preventDefault();
                alert('Cân nặng phải từ 10kg đến 500kg');
                return false;
            }

            // Show loading
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
            submitBtn.disabled = true;
        });
        
        // Auto-fill current date if empty
        document.getElementById('date').addEventListener('change', function() {
            if (!this.value) {
                const now = new Date();
                const year = now.getFullYear();
                const month = String(now.getMonth() + 1).padStart(2, '0');
                const day = String(now.getDate()).padStart(2, '0');
                const hours = String(now.getHours()).padStart(2, '0');
                const minutes = String(now.getMinutes()).padStart(2, '0');
                this.value = `${year}-${month}-${day}T${hours}:${minutes}`;
            }
        });
        
        // Check if user is logged in
        <c:if test="${empty user}">
            window.location.href = 'login';
        </c:if>
    </script>
</body>
</html>