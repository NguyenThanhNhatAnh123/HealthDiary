<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Page - Health Diary</title>
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
            max-width: 800px;
            margin: 0 auto;
        }

        .test-container {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            padding: 40px;
            position: relative;
            overflow: hidden;
        }

        .test-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #1976d2, #42a5f5, #1976d2);
        }

        h1 {
            color: #1976d2;
            font-size: 32px;
            font-weight: 700;
            text-align: center;
            margin-bottom: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        h1 i {
            background: #e3f2fd;
            padding: 12px;
            border-radius: 12px;
            font-size: 24px;
        }

        .test-section {
            margin-bottom: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 12px;
            border: 2px solid #e3f2fd;
        }

        .test-section h3 {
            color: #1976d2;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .test-section h3 i {
            background: #e3f2fd;
            padding: 6px;
            border-radius: 6px;
            font-size: 14px;
        }

        .test-links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .test-link {
            display: block;
            padding: 15px;
            background: white;
            border: 2px solid #e3f2fd;
            border-radius: 8px;
            text-decoration: none;
            color: #1976d2;
            font-weight: 600;
            text-align: center;
            transition: all 0.3s ease;
        }

        .test-link:hover {
            border-color: #1976d2;
            background: #e3f2fd;
            transform: translateY(-2px);
        }

        .status-info {
            background: #e8f5e8;
            border: 2px solid #4caf50;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            text-align: center;
        }

        .status-info h3 {
            color: #2e7d32;
            margin-bottom: 10px;
        }

        .status-info p {
            color: #2e7d32;
            font-size: 14px;
        }

        .btn {
            display: inline-block;
            padding: 14px 32px;
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin: 10px;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 118, 210, 0.3);
        }

        .btn-secondary {
            background: #fff;
            color: #1976d2;
            border: 2px solid #1976d2;
        }

        .btn-secondary:hover {
            background: #e3f2fd;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="test-container">
            <h1><i class="fas fa-vial"></i> Test Page</h1>
            
            <div class="status-info">
                <h3><i class="fas fa-check-circle"></i> System Status</h3>
                <p>This page is working correctly. Use the links below to test different parts of the system.</p>
            </div>

            <div class="test-section">
                <h3><i class="fas fa-link"></i> Core Pages</h3>
                <div class="test-links">
                    <a href="login" class="test-link">Login Page</a>
                    <a href="register" class="test-link">Register Page</a>
                    <a href="dashboard" class="test-link">User Dashboard</a>
                    <a href="login_admin" class="test-link">Admin Login</a>
                </div>
            </div>

            <div class="test-section">
                <h3><i class="fas fa-utensils"></i> User Features</h3>
                <div class="test-links">
                    <a href="meal-form" class="test-link">Meal Form</a>
                    <a href="exercise-form" class="test-link">Exercise Form</a>
                    <a href="health-form" class="test-link">Health Form</a>
                    <a href="weight-form" class="test-link">Weight Form</a>
                </div>
            </div>

            <div class="test-section">
                <h3><i class="fas fa-chart-line"></i> Tracking & History</h3>
                <div class="test-links">
                    <a href="calorie-tracking" class="test-link">Calorie Tracking</a>
                    <a href="weight-chart" class="test-link">Weight Chart</a>
                    <a href="exercise-history" class="test-link">Exercise History</a>
                    <a href="health-history" class="test-link">Health History</a>
                </div>
            </div>

            <div class="test-section">
                <h3><i class="fas fa-cog"></i> Admin Features</h3>
                <div class="test-links">
                    <a href="dashboard_admin" class="test-link">Admin Dashboard</a>
                    <a href="admin_user_list" class="test-link">User Management</a>
                    <a href="admin_list_food" class="test-link">Food Management</a>
                    <a href="admin_list_exercise" class="test-link">Exercise Management</a>
                </div>
            </div>

            <div style="text-align: center; margin-top: 30px;">
                <a href="dashboard" class="btn">
                    <i class="fas fa-home"></i> Go to Dashboard
                </a>
                <a href="login" class="btn btn-secondary">
                    <i class="fas fa-sign-in-alt"></i> Login
                </a>
            </div>
        </div>
    </div>

    <script>
        // Add click tracking for test purposes
        document.querySelectorAll('.test-link').forEach(link => {
            link.addEventListener('click', function(e) {
                console.log('Testing link:', this.href);
                // You can add analytics or logging here
            });
        });

        // Smooth animations
        document.addEventListener('DOMContentLoaded', function() {
            const testContainer = document.querySelector('.test-container');
            if (testContainer) {
                testContainer.style.opacity = '0';
                testContainer.style.transform = 'translateY(20px)';

                setTimeout(() => {
                    testContainer.style.transition = 'all 0.6s ease';
                    testContainer.style.opacity = '1';
                    testContainer.style.transform = 'translateY(0)';
                }, 100);
            }
        });
    </script>
</body>
</html>