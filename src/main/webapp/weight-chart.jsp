<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biểu đồ cân nặng - Health Diary</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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

        /* Chart Container */
        .chart-container {
            background: white;
            border-radius: 12px;
            padding: 24px;
            margin: 24px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .chart-controls {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 20px 0;
        }

        .chart-controls button {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            background: #e3f2fd;
            color: #1976d2;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .chart-controls button:hover {
            background: #bbdefb;
            transform: translateY(-1px);
        }

        .chart-controls button.active {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: white;
            box-shadow: 0 2px 10px rgba(25, 118, 210, 0.2);
        }

        /* Stats Cards */
        .weight-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }

        .stat-card {
            background: #fff;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .stat-number {
            font-size: 28px;
            font-weight: 700;
            color: #1976d2;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 14px;
            color: #666;
        }

        /* Buttons */
        .button-group {
            display: flex;
            gap: 16px;
            justify-content: center;
            margin-top: 24px;
        }

        .btn {
            padding: 12px 24px;
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

            .weight-stats {
                grid-template-columns: 1fr 1fr;
            }

            .chart-controls {
                flex-wrap: wrap;
            }
        }

        @media (max-width: 480px) {
            .weight-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-chart-line"></i> Biểu đồ cân nặng</h1>
            <div class="breadcrumb">
                <a href="dashboard">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <span class="separator">•</span>
                <span style="color: #666;">Biểu đồ cân nặng</span>
            </div>
        </div>

        <!-- Form Container -->
        <div class="form-container">
            <!-- Weight Statistics -->
            <div class="weight-stats">
                <div class="stat-card">
                    <div class="stat-number">${latestWeight != null ? latestWeight.weight : 'N/A'}</div>
                    <div class="stat-label">Cân nặng hiện tại (kg)</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${weightChange != null ? weightChange : 'N/A'}</div>
                    <div class="stat-label">Thay đổi (kg)</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${avgWeight != null ? avgWeight : 'N/A'}</div>
                    <div class="stat-label">Trung bình (kg)</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${totalEntries != null ? totalEntries : 'N/A'}</div>
                    <div class="stat-label">Số lần ghi</div>
                </div>
            </div>
            
            <!-- Chart Controls -->
            <div class="chart-controls">
                <button class="active" onclick="loadWeightData(7)">7 ngày</button>
                <button onclick="loadWeightData(30)">30 ngày</button>
                <button onclick="loadWeightData(90)">3 tháng</button>
                <button onclick="loadWeightData(365)">1 năm</button>
            </div>
            
            <!-- Chart Container -->
            <div class="chart-container">
                <canvas id="weightChart"></canvas>
            </div>
            
            <!-- Add Weight Button -->
            <div class="button-group">
                <a href="weight-log" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Ghi cân nặng mới
                </a>
            </div>
        </div>
    </div>
    
    <script>
        let weightChart;
        
        // Initialize chart
        function initChart() {
            const ctx = document.getElementById('weightChart').getContext('2d');
            weightChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: [],
                    datasets: [{
                        label: 'Cân nặng (kg)',
                        data: [],
                        borderColor: '#1976d2',
                        backgroundColor: 'rgba(25, 118, 210, 0.1)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.4,
                        pointBackgroundColor: '#1976d2',
                        pointBorderColor: '#ffffff',
                        pointBorderWidth: 2,
                        pointRadius: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top'
                        },
                        tooltip: {
                            mode: 'index',
                            intersect: false
                        }
                    },
                    scales: {
                        x: {
                            display: true,
                            title: {
                                display: true,
                                text: 'Ngày'
                            }
                        },
                        y: {
                            display: true,
                            title: {
                                display: true,
                                text: 'Cân nặng (kg)'
                            },
                            beginAtZero: false
                        }
                    },
                    interaction: {
                        mode: 'nearest',
                        axis: 'x',
                        intersect: false
                    }
                }
            });
        }
        
        // Load weight data
        function loadWeightData(days) {
            // Update active button
            document.querySelectorAll('.chart-controls button').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
            
            // Show loading
            if (weightChart) {
                weightChart.data.labels = [];
                weightChart.data.datasets[0].data = [];
                weightChart.update();
            }
            
            // Fetch data from API
            fetch(`api/weight-data?days=${days}`)
                .then(response => response.json())
                .then(data => {
                    if (data.error) {
                        console.error('Error loading weight data:', data.error);
                        return;
                    }
                    
                    const labels = data.map(item => {
                        const date = new Date(item.date);
                        return date.toLocaleDateString('vi-VN', {
                            day: '2-digit',
                            month: '2-digit'
                        });
                    });
                    
                    const weights = data.map(item => item.weight);
                    
                    if (weightChart) {
                        weightChart.data.labels = labels;
                        weightChart.data.datasets[0].data = weights;
                        weightChart.update();
                    } else {
                        initChart();
                        weightChart.data.labels = labels;
                        weightChart.data.datasets[0].data = weights;
                        weightChart.update();
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi khi tải dữ liệu cân nặng');
                });
        }
        
        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            initChart();
            loadWeightData(30); // Default to 30 days
        });
        
        // Check if user is logged in
        <c:if test="${empty user}">
            window.location.href = 'login';
        </c:if>
    </script>
</body>
</html>