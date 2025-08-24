<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GPT Assistant - Health Diary</title>
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
            max-width: 900px;
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

        /* Form */
        .gpt-form {
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            color: #1976d2;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 16px;
        }

        .form-group input[type="text"] {
            width: 100%;
            padding: 16px;
            border: 2px solid #e3f2fd;
            border-radius: 12px;
            font-size: 16px;
            background: #fafafa;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-group input[type="text"]:focus {
            outline: none;
            border-color: #1976d2;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
            transform: translateY(-1px);
        }

        .btn {
            padding: 16px 32px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.3);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 118, 210, 0.4);
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        /* Response */
        .response-container {
            background: #f8f9fa;
            border-radius: 16px;
            padding: 24px;
            border: 2px solid #e3f2fd;
            margin-bottom: 20px;
        }

        .response-header {
            color: #1976d2;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .response-content {
            background: white;
            border-radius: 12px;
            padding: 20px;
            border-left: 4px solid #1976d2;
            font-family: 'Courier New', monospace;
            font-size: 14px;
            line-height: 1.6;
            white-space: pre-wrap;
            overflow-x: auto;
        }

        /* Error */
        .error-message {
            background: #ffebee;
            color: #d32f2f;
            border: 2px solid #d32f2f;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        /* Loading */
        .loading {
            text-align: center;
            padding: 40px;
            color: #1976d2;
        }

        .loading i {
            font-size: 48px;
            margin-bottom: 16px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
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

        .btn-secondary {
            background: #fff;
            color: #1976d2;
            border: 2px solid #1976d2;
            box-shadow: none;
        }

        .btn-secondary:hover {
            background: #e3f2fd;
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
            <h1><i class="fas fa-robot"></i> GPT Assistant</h1>
            <div class="breadcrumb">
                <a href="dashboard"><i class="fas fa-home"></i> Trang chủ</a>
                <span class="separator">•</span>
                <span style="color: #666;">GPT Assistant</span>
                <span class="separator">•</span>
                <a href="logout" class="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>

        <!-- Main Container -->
        <div class="main-container">
            <div class="section-header">
                <i class="fas fa-comments"></i>
                Hỏi đáp với AI
            </div>

            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="error-message">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- GPT Form -->
            <form action="gpt" method="post" class="gpt-form" id="gptForm">
                <div class="form-group">
                    <label for="question">Nhập câu hỏi của bạn:</label>
                    <input type="text" id="question" name="question" 
                           placeholder="VD: Gợi ý một bữa ăn lành mạnh cho bữa sáng" 
                           value="${param.question}" required>
                </div>
                <button type="submit" class="btn" id="submitBtn">
                    <i class="fas fa-paper-plane"></i> Gửi câu hỏi
                </button>
            </form>

            <!-- Response -->
            <c:if test="${not empty response}">
                <div class="response-container">
                    <div class="response-header">
                        <i class="fas fa-robot"></i>
                        Phản hồi từ GPT:
                    </div>
                    <div class="response-content">${response}</div>
                </div>
            </c:if>

            <!-- Buttons -->
            <div class="button-group">
                <a href="dashboard" class="btn btn-secondary">
                    <i class="fas fa-home"></i> Về trang chủ
                </a>
                <a href="calorie-tracking" class="btn btn-secondary">
                    <i class="fas fa-chart-line"></i> Theo dõi Calorie
                </a>
            </div>
        </div>
    </div>

    <script>
        // Check if user is logged in
        <c:if test="${empty user}">
            window.location.href = 'login';
        </c:if>

        // Form submission handling
        document.getElementById('gptForm').addEventListener('submit', function(e) {
            const submitBtn = document.getElementById('submitBtn');
            const question = document.getElementById('question').value.trim();
            
            if (!question) {
                e.preventDefault();
                alert('Vui lòng nhập câu hỏi');
                return false;
            }
            
            // Show loading state
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
            submitBtn.disabled = true;
            
            return true;
        });

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
