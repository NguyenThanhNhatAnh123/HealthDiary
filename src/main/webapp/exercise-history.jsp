<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử tập luyện - Health Diary</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .exercise-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .stat-number {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #007bff;
        }
        .stat-label {
            font-size: 14px;
            color: #666;
        }
        .exercise-list {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .exercise-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #eee;
            transition: background-color 0.2s;
        }
        .exercise-item:hover {
            background-color: #f8f9fa;
        }
        .exercise-item:last-child {
            border-bottom: none;
        }
        .exercise-info {
            flex: 1;
        }
        .exercise-name {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        .exercise-details {
            font-size: 14px;
            color: #666;
        }
        .exercise-calories {
            font-weight: bold;
            color: #dc3545;
            text-align: right;
        }
        .filter-controls {
            display: flex;
            gap: 15px;
            margin: 20px 0;
            flex-wrap: wrap;
        }
        .filter-controls select,
        .filter-controls input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 20px 0;
        }
        .pagination button {
            padding: 8px 12px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 5px;
            cursor: pointer;
        }
        .pagination button.active {
            background: #007bff;
            color: white;
            border-color: #007bff;
        }
        .pagination button:hover:not(.active) {
            background: #f8f9fa;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="nav-bar">
        <div class="nav-container">
            <a href="dashboard" class="nav-brand">Health Diary</a>
            <div class="nav-menu">
                <a href="dashboard">Trang chủ</a>
                <a href="exercise-history">Lịch sử tập luyện</a>
                <a href="exercise-log">Ghi bài tập</a>
                <a href="profile">Hồ sơ</a>
                <a href="logout">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <div class="main-content">
        <div class="dashboard-container">
            <h1>Lịch sử tập luyện</h1>
            
            <!-- Exercise Statistics -->
            <div class="exercise-stats">
                <div class="stat-card">
                    <div class="stat-number" id="totalSessions">0</div>
                    <div class="stat-label">Tổng buổi tập</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="totalDuration">0</div>
                    <div class="stat-label">Tổng thời gian (phút)</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="totalCalories">0</div>
                    <div class="stat-label">Tổng calo đốt cháy</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="avgDuration">0</div>
                    <div class="stat-label">TB thời gian/buổi</div>
                </div>
            </div>
            
            <!-- Filter Controls -->
            <div class="filter-controls">
                <div>
                    <label for="dateFrom">Từ ngày:</label>
                    <input type="date" id="dateFrom" onchange="filterExercises()">
                </div>
                <div>
                    <label for="dateTo">Đến ngày:</label>
                    <input type="date" id="dateTo" onchange="filterExercises()">
                </div>
                <div>
                    <label for="exerciseType">Loại bài tập:</label>
                    <select id="exerciseType" onchange="filterExercises()">
                        <option value="">Tất cả</option>
                        <option value="cardio">Cardio</option>
                        <option value="strength">Sức mạnh</option>
                        <option value="flexibility">Linh hoạt</option>
                        <option value="balance">Cân bằng</option>
                    </select>
                </div>
                <div>
                    <label for="intensity">Cường độ:</label>
                    <select id="intensity" onchange="filterExercises()">
                        <option value="">Tất cả</option>
                        <option value="low">Nhẹ</option>
                        <option value="medium">Trung bình</option>
                        <option value="high">Cao</option>
                    </select>
                </div>
            </div>
            
            <!-- Exercise List -->
            <div class="exercise-list">
                <h3>Danh sách bài tập</h3>
                <div id="exerciseList">
                    <p style="text-align: center; color: #666;">Đang tải dữ liệu...</p>
                </div>
                
                <!-- Pagination -->
                <div class="pagination" id="pagination">
                    <!-- Pagination buttons will be generated here -->
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div style="text-align: center; margin-top: 30px;">
                <a href="exercise-log" class="btn btn-primary" style="display: inline-block; width: auto; margin: 0 10px;">
                    Ghi bài tập mới
                </a>
                <a href="dashboard" class="btn btn-secondary" style="display: inline-block; width: auto; margin: 0 10px;">
                    Về trang chủ
                </a>
            </div>
        </div>
    </div>
    
    <script>
        let currentPage = 1;
        let totalPages = 1;
        let exercises = [];
        
        // Load exercise history
        function loadExerciseHistory(page = 1) {
            const dateFrom = document.getElementById('dateFrom').value;
            const dateTo = document.getElementById('dateTo').value;
            const exerciseType = document.getElementById('exerciseType').value;
            const intensity = document.getElementById('intensity').value;
            
            // Show loading
            document.getElementById('exerciseList').innerHTML = '<p style="text-align: center; color: #666;">Đang tải dữ liệu...</p>';
            
            // Build query parameters
            const params = new URLSearchParams({
                page: page,
                dateFrom: dateFrom || '',
                dateTo: dateTo || '',
                exerciseType: exerciseType || '',
                intensity: intensity || ''
            });
            
            // Fetch data from server
            fetch(`api/exercise-history?${params}`)
                .then(response => response.json())
                .then(data => {
                    exercises = data.exercises || [];
                    currentPage = data.currentPage || 1;
                    totalPages = data.totalPages || 1;
                    
                    updateExerciseList();
                    updateStatistics(data.statistics);
                    updatePagination();
                })
                .catch(error => {
                    console.error('Error loading exercise history:', error);
                    document.getElementById('exerciseList').innerHTML = '<p style="text-align: center; color: #666;">Không thể tải dữ liệu</p>';
                });
        }
        
        // Update exercise list display
        function updateExerciseList() {
            const exerciseList = document.getElementById('exerciseList');
            
            if (exercises.length === 0) {
                exerciseList.innerHTML = '<p style="text-align: center; color: #666;">Không có dữ liệu bài tập</p>';
                return;
            }
            
            let html = '';
            exercises.forEach(exercise => {
                const date = new Date(exercise.date).toLocaleDateString('vi-VN');
                const time = new Date(exercise.date).toLocaleTimeString('vi-VN', {
                    hour: '2-digit',
                    minute: '2-digit'
                });
                
                html += `
                    <div class="exercise-item">
                        <div class="exercise-info">
                            <div class="exercise-name">${exercise.exerciseName}</div>
                            <div class="exercise-details">
                                ${date} ${time} • ${exercise.duration} phút • ${exercise.intensity}
                            </div>
                        </div>
                        <div class="exercise-calories">
                            ${exercise.totalCaloriesBurned} kcal
                        </div>
                    </div>
                `;
            });
            
            exerciseList.innerHTML = html;
        }
        
        // Update statistics
        function updateStatistics(stats) {
            if (!stats) return;
            
            document.getElementById('totalSessions').textContent = stats.totalSessions || 0;
            document.getElementById('totalDuration').textContent = stats.totalDuration || 0;
            document.getElementById('totalCalories').textContent = stats.totalCalories || 0;
            document.getElementById('avgDuration').textContent = stats.avgDuration || 0;
        }
        
        // Update pagination
        function updatePagination() {
            const pagination = document.getElementById('pagination');
            
            if (totalPages <= 1) {
                pagination.innerHTML = '';
                return;
            }
            
            let html = '';
            
            // Previous button
            if (currentPage > 1) {
                html += `<button onclick="loadExerciseHistory(${currentPage - 1})">Trước</button>`;
            }
            
            // Page numbers
            for (let i = 1; i <= totalPages; i++) {
                if (i === currentPage) {
                    html += `<button class="active">${i}</button>`;
                } else {
                    html += `<button onclick="loadExerciseHistory(${i})">${i}</button>`;
                }
            }
            
            // Next button
            if (currentPage < totalPages) {
                html += `<button onclick="loadExerciseHistory(${currentPage + 1})">Sau</button>`;
            }
            
            pagination.innerHTML = html;
        }
        
        // Filter exercises
        function filterExercises() {
            loadExerciseHistory(1); // Reset to first page when filtering
        }
        
        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Set default date range (last 30 days)
            const today = new Date();
            const thirtyDaysAgo = new Date(today.getTime() - (30 * 24 * 60 * 60 * 1000));
            
            document.getElementById('dateFrom').value = thirtyDaysAgo.toISOString().split('T')[0];
            document.getElementById('dateTo').value = today.toISOString().split('T')[0];
            
            loadExerciseHistory();
        });
        
        // Check if user is logged in
        <c:if test="${empty user}">
            window.location.href = 'login';
        </c:if>
    </script>
</body>
</html>