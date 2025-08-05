<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${isDashboard}">Dashboard - HealthDiary</c:when>
            <c:otherwise>Welcome to HealthDiary</c:otherwise>
        </c:choose>
    </title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 80px 0;
        }
        
        .dashboard-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 25px;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        
        .stat-card {
            text-align: center;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #667eea;
        }
        
        .feature-icon {
            font-size: 3rem;
            color: #667eea;
            margin-bottom: 20px;
        }
        
        .alert-danger {
            border-left: 4px solid #dc3545;
        }
        
        .alert-warning {
            border-left: 4px solid #ffc107;
        }
        
        .alert-success {
            border-left: 4px solid #198754;
        }
        
        .quick-action-btn {
            width: 100%;
            margin-bottom: 10px;
            border-radius: 10px;
            font-weight: 500;
        }
        
        .health-trend-chart {
            height: 300px;
        }
        
        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }
        
        .welcome-message {
            background: linear-gradient(45deg, #f8f9fa, #e9ecef);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-heartbeat me-2"></i>HealthDiary
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-1"></i>Home
                        </a>
                    </li>
                    <c:if test="${isDashboard}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/profile">
                                <i class="fas fa-user me-1"></i>Profile
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/records">
                                <i class="fas fa-clipboard-list me-1"></i>Health Records
                            </a>
                        </li>
                    </c:if>
                </ul>
                
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${isDashboard}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle me-1"></i>${userName}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Profile</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/settings">Settings</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt me-1"></i>Login
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                    <i class="fas fa-user-plus me-1"></i>Register
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Alert Messages -->
    <c:if test="${not empty successMessage}">
        <div class="container mt-3">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
        <c:remove var="successMessage" scope="session" />
    </c:if>
    
    <c:if test="${not empty errorMessage}">
        <div class="container mt-3">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${isDashboard}">
            <!-- DASHBOARD CONTENT FOR AUTHENTICATED USERS -->
            <div class="container mt-4">
                <!-- Welcome Message -->
                <div class="welcome-message">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h2><i class="fas fa-sun text-warning me-2"></i>Good ${greeting}, ${userName}!</h2>
                            <p class="mb-0 text-muted">Here's your health summary for today</p>
                        </div>
                        <div class="col-md-4 text-end">
                            <small class="text-muted">
                                <i class="fas fa-calendar me-1"></i>
                                <fmt:formatDate value="${now}" pattern="EEEE, MMMM dd, yyyy" />
                            </small>
                        </div>
                    </div>
                </div>

                <!-- Health Alerts -->
                <c:if test="${not empty healthAlerts}">
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="card dashboard-card border-danger">
                                <div class="card-header bg-danger text-white">
                                    <i class="fas fa-exclamation-triangle me-2"></i>Health Alerts
                                </div>
                                <div class="card-body">
                                    <c:forEach var="alert" items="${healthAlerts}" varStatus="status">
                                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                            <i class="fas fa-warning me-2"></i>${alert.message}
                                            <form method="post" class="d-inline">
                                                <input type="hidden" name="action" value="dismissAlert">
                                                <input type="hidden" name="alertId" value="${alert.id}">
                                                <button type="submit" class="btn-close" aria-label="Close"></button>
                                            </form>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

                <div class="row">
                    <!-- Quick Actions -->
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="card dashboard-card">
                            <div class="card-header bg-primary text-white">
                                <i class="fas fa-plus-circle me-2"></i>Quick Actions
                            </div>
                            <div class="card-body">
                                <!-- Quick Health Entry Form -->
                                <form method="post" id="quickEntryForm">
                                    <input type="hidden" name="action" value="quickEntry">
                                    
                                    <div class="mb-3">
                                        <select class="form-select" name="metric" required>
                                            <option value="">Select Metric</option>
                                            <option value="weight">Weight</option>
                                            <option value="blood_pressure">Blood Pressure</option>
                                            <option value="heart_rate">Heart Rate</option>
                                            <option value="temperature">Temperature</option>
                                            <option value="blood_sugar">Blood Sugar</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <input type="text" class="form-control" name="value" 
                                               placeholder="Value" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <textarea class="form-control" name="notes" rows="2" 
                                                  placeholder="Notes (optional)"></textarea>
                                    </div>
                                    
                                    <button type="submit" class="quick-action-btn btn btn-success">
                                        <i class="fas fa-save me-2"></i>Record
                                    </button>
                                </form>
                                
                                <hr>
                                
                                <a href="${pageContext.request.contextPath}/records" class="quick-action-btn btn btn-outline-primary">
                                    <i class="fas fa-list me-2"></i>View All Records
                                </a>
                                
                                <a href="${pageContext.request.contextPath}/reports" class="quick-action-btn btn btn-outline-info">
                                    <i class="fas fa-chart-line me-2"></i>Generate Report
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Health Statistics -->
                    <div class="col-lg-6 col-md-6 mb-4">
                        <div class="card dashboard-card">
                            <div class="card-header bg-success text-white">
                                <i class="fas fa-chart-bar me-2"></i>Health Statistics
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty healthStats}">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <div class="text-center">
                                                <div class="stat-number text-primary">${healthStats.totalRecords}</div>
                                                <small class="text-muted">Total Records</small>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="text-center">
                                                <div class="stat-number text-success">${healthStats.thisWeekRecords}</div>
                                                <small class="text-muted">This Week</small>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="text-center">
                                                <div class="stat-number text-warning">${healthStats.avgHeartRate}</div>
                                                <small class="text-muted">Avg Heart Rate</small>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="text-center">
                                                <div class="stat-number text-info">${healthStats.lastWeight}</div>
                                                <small class="text-muted">Current Weight</small>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                
                                <!-- Health Trends Chart -->
                                <c:if test="${not empty healthTrends}">
                                    <div class="mt-3">
                                        <canvas id="trendsChart" class="health-trend-chart"></canvas>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Records & Reminders -->
                    <div class="col-lg-3 col-md-12 mb-4">
                        <div class="card dashboard-card">
                            <div class="card-header bg-info text-white">
                                <i class="fas fa-clock me-2"></i>Recent Activity
                            </div>
                            <div class="card-body" style="max-height: 400px; overflow-y: auto;">
                                <!-- Recent Records -->
                                <h6 class="fw-bold mb-3">Recent Records</h6>
                                <c:choose>
                                    <c:when test="${not empty recentRecords}">
                                        <c:forEach var="record" items="${recentRecords}">
                                            <div class="d-flex align-items-center mb-3 p-2 bg-light rounded">
                                                <div class="flex-shrink-0">
                                                    <i class="fas fa-heartbeat text-danger"></i>
                                                </div>
                                                <div class="flex-grow-1 ms-3">
                                                    <small class="fw-bold">${record.metric}</small><br>
                                                    <small class="text-muted">
                                                        <fmt:formatDate value="${record.recordDate}" pattern="MMM dd, HH:mm" />
                                                    </small>
                                                </div>
                                                <div class="flex-shrink-0">
                                                    <span class="badge bg-primary">${record.value}</span>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-muted small">No recent records found.</p>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Upcoming Reminders -->
                                <c:if test="${not empty upcomingReminders}">
                                    <hr>
                                    <h6 class="fw-bold mb-3">Upcoming</h6>
                                    <c:forEach var="reminder" items="${upcomingReminders}">
                                        <div class="d-flex align-items-center mb-3 p-2 bg-warning bg-opacity-10 rounded">
                                            <div class="flex-shrink-0">
                                                <i class="fas fa-bell text-warning"></i>
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <small class="fw-bold">${reminder.title}</small><br>
                                                <small class="text-muted">
                                                    <fmt:formatDate value="${reminder.reminderTime}" pattern="MMM dd, HH:mm" />
                                                </small>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recommended Actions -->
                <c:if test="${not empty recommendedActions}">
                    <div class="row mt-4">
                        <div class="col-12">
                            <div class="card dashboard-card">
                                <div class="card-header bg-secondary text-white">
                                    <i class="fas fa-lightbulb me-2"></i>Recommended Actions
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <c:forEach var="action" items="${recommendedActions}" varStatus="status">
                                            <div class="col-md-4 mb-3">
                                                <div class="alert alert-light border-start border-primary border-4">
                                                    <i class="fas fa-check-circle text-success me-2"></i>${action}
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>

        </c:when>
        <c:otherwise>
            <!-- PUBLIC LANDING PAGE FOR GUESTS -->
            
            <!-- Hero Section -->
            <section class="hero-section">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <h1 class="display-4 fw-bold mb-4">Take Control of Your Health</h1>
                            <p class="lead mb-4">
                                Track, monitor, and manage your health data securely with HealthDiary. 
                                Your comprehensive digital health companion.
                            </p>
                            <div class="d-flex gap-3">
                                <a href="${pageContext.request.contextPath}/register" class="btn btn-light btn-lg px-4">
                                    <i class="fas fa-user-plus me-2"></i>Get Started
                                </a>
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-lg px-4">
                                    <i class="fas fa-sign-in-alt me-2"></i>Sign In
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-6 text-center">
                            <i class="fas fa-heartbeat" style="font-size: 10rem; opacity: 0.3;"></i>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Statistics Section -->
            <c:if test="${not empty publicStats}">
                <section class="py-5 bg-light">
                    <div class="container">
                        <div class="row text-center">
                            <div class="col-md-3 col-sm-6 mb-4">
                                <div class="stat-card">
                                    <div class="stat-number">${publicStats.totalUsers}</div>
                                    <h5>Active Users</h5>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 mb-4">
                                <div class="stat-card">
                                    <div class="stat-number">${publicStats.totalRecords}</div>
                                    <h5>Health Records</h5>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 mb-4">
                                <div class="stat-card">
                                    <div class="stat-number">${publicStats.dataPoints}</div>
                                    <h5>Data Points</h5>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 mb-4">
                                <div class="stat-card">
                                    <div class="stat-number">99.9%</div>
                                    <h5>Uptime</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </c:if>

            <!-- Features Section -->
            <section class="py-5">
                <div class="container">
                    <div class="row">
                        <div class="col-12 text-center mb-5">
                            <h2 class="fw-bold">Why Choose HealthDiary?</h2>
                            <p class="text-muted">Comprehensive health tracking made simple</p>
                        </div>
                    </div>
                    
                    <c:if test="${not empty features}">
                        <div class="row">
                            <c:forEach var="feature" items="${features}" varStatus="status">
                                <div class="col-lg-3 col-md-6 mb-4">
                                    <div class="text-center">
                                        <div class="feature-icon">
                                            <c:choose>
                                                <c:when test="${status.index % 8 == 0}"><i class="fas fa-chart-line"></i></c:when>
                                                <c:when test="${status.index % 8 == 1}"><i class="fas fa-heartbeat"></i></c:when>
                                                <c:when test="${status.index % 8 == 2}"><i class="fas fa-pills"></i></c:when>
                                                <c:when test="${status.index % 8 == 3}"><i class="fas fa-file-medical"></i></c:when>
                                                <c:when test="${status.index % 8 == 4}"><i class="fas fa-shield-alt"></i></c:when>
                                                <c:when test="${status.index % 8 == 5}"><i class="fas fa-download"></i></c:when>
                                                <c:when test="${status.index % 8 == 6}"><i class="fas fa-mobile-alt"></i></c:when>
                                                <c:otherwise><i class="fas fa-target"></i></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <h5>${feature}</h5>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </section>

            <!-- Health Tips Section -->
            <c:if test="${not empty healthTips}">
                <section class="py-5 bg-light">
                    <div class="container">
                        <div class="row">
                            <div class="col-12 text-center mb-5">
                                <h2 class="fw-bold">Health Tips</h2>
                                <p class="text-muted">Expert advice for better health</p>
                            </div>
                        </div>
                        <div class="row">
                            <c:forEach var="tip" items="${healthTips}" varStatus="status">
                                <c:if test="${status.index < 3}">
                                    <div class="col-md-4 mb-4">
                                        <div class="card dashboard-card h-100">
                                            <div class="card-body">
                                                <h5 class="card-title">${tip.title}</h5>
                                                <p class="card-text">${tip.summary}</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </section>
            </c:if>

            <!-- Call to Action -->
            <section class="py-5">
                <div class="container">
                    <div class="row">
                        <div class="col-12 text-center">
                            <h2 class="fw-bold mb-4">Start Your Health Journey Today</h2>
                            <p class="lead mb-4">Join thousands of users who are taking control of their health</p>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-lg px-5">
                                <i class="fas fa-rocket me-2"></i>Get Started Free
                            </a>
                        </div>
                    </div>
                </div>
            </section>
        </c:otherwise>
    </c:choose>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-heartbeat me-2"></i>HealthDiary</h5>
                    <p class="mb-0">Your trusted health companion</p>
                </div>
                <div class="col-md-6 text-end">
                    <small>&copy; 2024 HealthDiary. All rights reserved.</small>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    
    <!-- Chart.js for Health Trends -->
    <c:if test="${isDashboard and not empty healthTrends}">
        <script>
            // Health Trends Chart
            const ctx = document.getElementById('trendsChart').getContext('2d');
            const trendsChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: [<c:forEach var="date" items="${healthTrends.dates}" varStatus="status">'${date}'<c:if test="${!status.last}">,</c:if></c:forEach>],
                    datasets: [{
                        label: 'Weight',
                        data: [<c:forEach var="weight" items="${healthTrends.weight}" varStatus="status">${weight}<c:if test="${!status.last}">,</c:if></c:forEach>],
                        borderColor: 'rgb(75, 192, 192)',
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        tension: 0.4
                    }, {
                        label: 'Heart Rate',
                        data: [<c:forEach var="hr" items="${healthTrends.heartRate}" varStatus="status">${hr}<c:if test="${!status.last}">,</c:if></c:forEach>],
                        borderColor: 'rgb(255, 99, 132)',
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: false
                        }
                    },
                    plugins: {
                        legend: {
                            position: 'top',
                        }
                    }
                }
            });
        </script>
    </c:if>
    
    <script>
        // Set greeting based on time
        const hour = new Date().getHours();
        let greeting = 'day';
        if (hour < 12) greeting = 'morning';
        else if (hour < 17) greeting = 'afternoon';
        else greeting = 'evening';
        
        // Update greeting if element exists
        const greetingElements = document.querySelectorAll('.greeting');
        greetingElements.forEach(el => el.textContent = greeting);
        
        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                if (alert.classList.contains('show')) {
                    bootstrap.Alert.getInstance(alert)?.close();
                }
            });
        }, 5000);
    </script>
</body>
</html>