<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin - Quản lý Hệ thống</title>
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

        /* Navigation Tabs */
        .nav-tabs {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 20px rgba(25, 118, 210, 0.1);
            padding: 24px 32px;
            margin-bottom: 24px;
        }

        .nav-buttons {
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
        }

        .nav-btn {
            padding: 14px 24px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #fff;
            color: #1976d2;
            border: 2px solid #e3f2fd;
        }

        .nav-btn:hover {
            background: #e3f2fd;
            transform: translateY(-1px);
        }

        .nav-btn.active {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            border-color: #1976d2;
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.3);
        }

        .nav-btn.active:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 118, 210, 0.4);
        }

        /* Main Content */
        .main-content {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            padding: 40px;
            position: relative;
            overflow: hidden;
        }

        .main-content::before {
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
            font-weight: 700;
            margin-bottom: 32px;
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

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
            border-radius: 16px;
            padding: 32px 24px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(25, 118, 210, 0.08);
            transition: all 0.3s ease;
            border: 1px solid #e3f2fd;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(25, 118, 210, 0.15);
        }

        .stat-icon {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            font-size: 24px;
        }

        .stat-value {
            font-size: 36px;
            font-weight: 700;
            color: #1976d2;
            margin-bottom: 8px;
        }

        .stat-label {
            color: #666;
            font-size: 14px;
            font-weight: 500;
        }

        /* Toolbar */
        .toolbar {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 32px;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 250px;
            padding: 14px 16px;
            border: 2px solid #e3f2fd;
            border-radius: 12px;
            font-size: 16px;
            background: #fafafa;
            transition: all 0.3s ease;
        }

        .search-box:focus {
            outline: none;
            border-color: #1976d2;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
        }

        /* Buttons */
        .btn {
            padding: 14px 24px;
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

        .btn-danger {
            background: #fff;
            color: #d32f2f;
            border: 2px solid #d32f2f;
        }

        .btn-danger:hover {
            background: #ffebee;
            transform: translateY(-1px);
        }

        .btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none !important;
        }

        /* Table */
        .user-table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(25, 118, 210, 0.08);
        }

        .user-table th {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            font-weight: 700;
            padding: 18px 16px;
            text-align: left;
            font-size: 14px;
        }

        .user-table td {
            padding: 16px;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }

        .user-table tr:nth-child(even) {
            background: #f8f9fa;
        }

        .user-table tr:hover {
            background: #e3f2fd;
            transform: translateY(-1px);
            transition: all 0.3s ease;
        }

        .user-table tr:last-child td {
            border-bottom: none;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            border: none;
            border-radius: 8px;
            padding: 8px 12px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .action-btn.edit {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
        }

        .action-btn.edit:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(25, 118, 210, 0.3);
        }

        .action-btn.delete {
            background: #fff;
            color: #d32f2f;
            border: 2px solid #d32f2f;
        }

        .action-btn.delete:hover {
            background: #ffebee;
            transform: translateY(-1px);
        }

        /* Status Badge */
        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .badge-success {
            background: #e8f5e8;
            color: #2e7d32;
        }

        .badge-danger {
            background: #ffebee;
            color: #d32f2f;
        }

        /* Empty State */
        .text-center {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 16px;
                text-align: center;
            }

            .nav-buttons {
                flex-direction: column;
            }

            .nav-btn {
                width: 100%;
                justify-content: center;
            }

            .main-content {
                padding: 24px;
                margin: 16px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .toolbar {
                flex-direction: column;
                align-items: stretch;
                gap: 12px;
            }

            .search-box {
                min-width: auto;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .user-table {
                font-size: 12px;
            }

            .user-table th,
            .user-table td {
                padding: 12px 8px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 4px;
            }

            .action-btn {
                width: 100%;
                justify-content: center;
            }
        }

        /* Loading animation */
        .btn:active {
            transform: translateY(0);
        }
        .user-table-wrapper {
            overflow-x: auto;
            width: 100%;
        }
        .user-table {
            width: 100%;
        }
        .user-table th, .user-table td {
            padding: 8px 6px;
            font-size: 13px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <header class="header">
            <h1>
                <i class="fas fa-tachometer-alt"></i>
                Dashboard Admin
            </h1>
            <nav class="breadcrumb">
                <a href="#dashboard" onclick="showSection('dashboard')">
                    <i class="fas fa-home"></i>
                    Tổng quan
                </a>
                <span class="separator">•</span>
                <a href="admin-logout" class="logout">
                    <i class="fas fa-sign-out-alt"></i>
                    Đăng xuất
                </a>
            </nav>
        </header>

        <!-- Navigation Tabs -->
        <div class="nav-tabs">
            <div class="nav-buttons">
                <button class="nav-btn active" onclick="showSection('dashboard')" id="dashboardBtn">
                    <i class="fas fa-tachometer-alt"></i>
                    Tổng quan
                </button>
                <button class="nav-btn" onclick="showSection('users')" id="usersBtn">
                    <i class="fas fa-users"></i>
                    Quản lý người dùng
                </button>
                <button class="nav-btn" onclick="showSection('foods')" id="foodsBtn">
                    <i class="fas fa-utensils"></i>
                    Quản lý món ăn
                </button>
                <button class="nav-btn" onclick="showSection('exercises')" id="exercisesBtn">
                    <i class="fas fa-dumbbell"></i>
                    Quản lý bài tập
                </button>
            </div>
        </div>

        <!-- Dashboard Overview -->
        <div id="dashboard" class="main-content">
            <h2 class="section-header">
                <i class="fas fa-chart-bar"></i>
                Tổng quan hệ thống
            </h2>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-value">
                        <c:choose>
                            <c:when test="${not empty totalUsers}">${totalUsers}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-label">Tổng người dùng</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <div class="stat-value">
                        <c:choose>
                            <c:when test="${not empty totalFoods}">${totalFoods}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-label">Món ăn</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-dumbbell"></i>
                    </div>
                    <div class="stat-value">
                        <c:choose>
                            <c:when test="${not empty totalExercises}">${totalExercises}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-label">Bài tập</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="stat-value">
                        <c:choose>
                            <c:when test="${not empty activeUsers}">${activeUsers}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-label">Hoạt động hôm nay</div>
                </div>
            </div>
        </div>

        <!-- User Management -->
        <div id="users" class="main-content" style="display: none;">
            <h2 class="section-header">
                <i class="fas fa-users"></i>
                Quản lý người dùng
            </h2>
            
            <div class="toolbar">
                <input type="text" class="search-box" placeholder="Tìm kiếm người dùng..." onkeyup="searchUsers(this.value)" id="userSearchInput">
                <a href="admin/user/add" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    Thêm người dùng
                </a>
            </div>

            <div class="user-table-wrapper">
                <table class="user-table">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="selectAllUsers" onchange="toggleSelectAllUsers()"></th>
                            <th>ID</th>
                            <th>Họ và tên</th>
                            <th>Email</th>
                            <th>Tuổi</th>
                            <th>Giới tính</th>
                            <th>Chiều cao</th>
                            <th>Cân nặng</th>
                            <th>Mục tiêu</th>
                            <th>Ngày tạo</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody id="usersTableBody">
                        <c:choose>
                            <c:when test="${not empty userList}">
                                <c:forEach var="user" items="${userList}">
                                    <tr class="user-row">
                                        <td>
                                            <input type="checkbox" class="user-checkbox" name="userSelect" value="${user.id}" onchange="updateUserButtonStates()">
                                        </td>
                                        <td>${user.id}</td>
                                        <td>${user.fullName}</td>
                                        <td>${user.email}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty user.age}">${user.age}</c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty user.gender}">${user.gender}</c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty user.heightCm}">${user.heightCm}</c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty user.weightKg}">${user.weightKg}</c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty user.goal}">${user.goal}</c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty user.createdAt}">
                                                    <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                </c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="action-btn edit" onclick="editUser('${user.id}')">
                                                    <i class="fas fa-edit"></i>
                                                    Sửa
                                                </button>
                                                <button class="action-btn delete" onclick="deleteUser('${user.id}')">
                                                    <i class="fas fa-trash"></i>
                                                    Xóa
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="11" class="text-center">
                                        <i class="fas fa-users" style="font-size: 48px; color: #ccc; margin-bottom: 16px; display: block;"></i>
                                        Không có người dùng nào
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Food Management -->
        <div id="foods" class="main-content" style="display: none;">
            <h2 class="section-header">
                <i class="fas fa-utensils"></i>
                Quản lý món ăn
            </h2>
            
            <div class="toolbar">
                <input type="text" class="search-box" placeholder="Tìm kiếm món ăn..." onkeyup="searchFoods(this.value)" id="foodSearchInput">
                <a href="admin_add_food.jsp" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    Thêm món ăn
                </a>
               
                
            </div>

            <table class="user-table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAllFoods" onchange="toggleSelectAllFoods()">
                        </th>
                        <th>ID</th>
                        <th>Tên món ăn</th>
                        <th>Loại</th>
                        <th>Calo (100g)</th>
                        <th>Protein (g)</th>
                        <th>Carbs (g)</th>
                        <th>Chất béo (g)</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody id="foodsTableBody">
                    <tr>
                        <td colspan="9" class="text-center">
                            <i class="fas fa-utensils" style="font-size: 48px; color: #ccc; margin-bottom: 16px; display: block;"></i>
                            Chưa có dữ liệu món ăn
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Exercise Management -->
        <div id="exercises" class="main-content" style="display: none;">
            <h2 class="section-header">
                <i class="fas fa-dumbbell"></i>
                Quản lý bài tập
            </h2>
            
            <div class="toolbar">
                <input type="text" class="search-box" placeholder="Tìm kiếm bài tập..." onkeyup="searchExercises(this.value)" id="exerciseSearchInput">
                <a href="admin_add_exercise.jsp" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    Thêm bài tập
                </a>
                
             
            </div>

            <table class="user-table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAllExercises" onchange="toggleSelectAllExercises()">
                        </th>
                        <th>ID</th>
                        <th>Tên bài tập</th>
                        <th>Loại</th>
                        <th>Nhóm cơ</th>
                        <th>Độ khó</th>
                        <th>Calo/giờ</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody id="exercisesTableBody">
                    <tr>
                        <td colspan="8" class="text-center">
                            <i class="fas fa-dumbbell" style="font-size: 48px; color: #ccc; margin-bottom: 16px; display: block;"></i>
                            Chưa có dữ liệu bài tập
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Navigation functions
        function showSection(sectionName) {
            // Hide all sections
            const sections = ['dashboard', 'users', 'foods', 'exercises'];
            sections.forEach(section => {
                document.getElementById(section).style.display = 'none';
            });
            
            // Show selected section
            document.getElementById(sectionName).style.display = 'block';
            
            // Update button states
            const buttons = ['dashboardBtn', 'usersBtn', 'foodsBtn', 'exercisesBtn'];
            buttons.forEach(btnId => {
                const btn = document.getElementById(btnId);
                if (btnId === sectionName + 'Btn') {
                    btn.classList.add('active');
                } else {
                    btn.classList.remove('active');
                }
            });
        }

        // Search functions
        function searchUsers(searchTerm) {
            const tableBody = document.getElementById('usersTableBody');
            const rows = tableBody.getElementsByTagName('tr');
            
            for (let i = 0; i < rows.length; i++) {
                const row = rows[i];
                const cells = row.getElementsByTagName('td');
                let found = false;
                
                for (let j = 1; j < cells.length - 1; j++) { // Skip checkbox and action columns
                    if (cells[j].textContent.toLowerCase().includes(searchTerm.toLowerCase())) {
                        found = true;
                        break;
                    }
                }
                
                row.style.display = found ? '' : 'none';
            }
        }

        function searchFoods(searchTerm) {
            const tableBody = document.getElementById('foodsTableBody');
            const rows = tableBody.getElementsByTagName('tr');
            
            for (let i = 0; i < rows.length; i++) {
                const row = rows[i];
                const cells = row.getElementsByTagName('td');
                let found = false;
                
                for (let j = 1; j < cells.length - 1; j++) { // Skip checkbox and action columns
                    if (cells[j].textContent.toLowerCase().includes(searchTerm.toLowerCase())) {
                        found = true;
                        break;
                    }
                }
                
                row.style.display = found ? '' : 'none';
            }
        }

        function searchExercises(searchTerm) {
            const tableBody = document.getElementById('exercisesTableBody');
            const rows = tableBody.getElementsByTagName('tr');
            
            for (let i = 0; i < rows.length; i++) {
                const row = rows[i];
                const cells = row.getElementsByTagName('td');
                let found = false;
                
                for (let j = 1; j < cells.length - 1; j++) { // Skip checkbox and action columns
                    if (cells[j].textContent.toLowerCase().includes(searchTerm.toLowerCase())) {
                        found = true;
                        break;
                    }
                }
                
                row.style.display = found ? '' : 'none';
            }
        }

        // Select all functions
        function toggleSelectAllUsers() {
            const selectAll = document.getElementById('selectAllUsers');
            const checkboxes = document.querySelectorAll('.user-checkbox');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAll.checked;
            });
            updateUserButtonStates();
        }

        function toggleSelectAllFoods() {
            const selectAll = document.getElementById('selectAllFoods');
            const checkboxes = document.querySelectorAll('.food-checkbox');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAll.checked;
            });
        }

        function toggleSelectAllExercises() {
            const selectAll = document.getElementById('selectAllExercises');
            const checkboxes = document.querySelectorAll('.exercise-checkbox');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAll.checked;
            });
        }

        // JavaScript functions cho toolbar actions


       
    	  function editUser(userId) {
    	  window.location.href = '${pageContext.request.contextPath}/admin/user/edit?id=' + userId;
	
       	 }
        function deleteUser(userId) {
            if (confirm('Bạn có chắc chắn muốn xóa user này?')) {
            	window.location.href = 'admin/user/delete?id=' + userId;
            }
        }

        // Food management functions
        function editFood(foodId) {
            if (confirm('Bạn có chắc muốn chỉnh sửa món ăn này?')) {
                window.location.href = `admin_edit_food.jsp?id=${foodId}`;
            }
        }

        function deleteFood(foodId) {
            if (confirm('Bạn có chắc muốn xóa món ăn này? Hành động này không thể hoàn tác.')) {
                fetch(`admin-delete-food?id=${foodId}`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Xóa món ăn thành công!');
                        location.reload();
                    } else {
                        alert('Lỗi khi xóa món ăn: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi xóa món ăn.');
                });
            }
        }

   


        // Exercise management functions
        function editExercise(exerciseId) {
            if (confirm('Bạn có chắc muốn chỉnh sửa bài tập này?')) {
                window.location.href = `admin_edit_exercise.jsp?id=${exerciseId}`;
            }
        }

        function deleteExercise(exerciseId) {
            if (confirm('Bạn có chắc muốn xóa bài tập này? Hành động này không thể hoàn tác.')) {
                fetch(`admin-delete-exercise?id=${exerciseId}`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Xóa bài tập thành công!');
                        location.reload();
                    } else {
                        alert('Lỗi khi xóa bài tập: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi xóa bài tập.');
                });
            }
        }


        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            // Show dashboard by default
            showSection('dashboard');
            
            // Add event listeners for checkboxes to update select all state
            document.addEventListener('change', function(e) {
                if (e.target.classList.contains('user-checkbox')) {
                    updateUserButtonStates();
                } else if (e.target.classList.contains('food-checkbox')) {
                    // updateSelectAllState('selectAllFoods', '.food-checkbox'); // No select all for foods
                } else if (e.target.classList.contains('exercise-checkbox')) {
                    // updateSelectAllState('selectAllExercises', '.exercise-checkbox'); // No select all for exercises
                }
            });
        });

        function updateUserButtonStates() {
            const selectAll = document.getElementById('selectAllUsers');
            const checkboxes = document.querySelectorAll('.user-checkbox');
            const checkedBoxes = document.querySelectorAll('.user-checkbox:checked');
            
            const hasSelection = checkedBoxes.length > 0;
            document.getElementById('editUserBtn').disabled = !hasSelection;
            document.getElementById('deleteUserBtn').disabled = !hasSelection;

            if (checkedBoxes.length === 0) {
                selectAll.indeterminate = false;
                selectAll.checked = false;
            } else if (checkedBoxes.length === checkboxes.length) {
                selectAll.indeterminate = false;
                selectAll.checked = true;
            } else {
                selectAll.indeterminate = true;
                selectAll.checked = false;
            }
        }

        // Utility functions
        function showNotification(message, type = 'success') {
            const notification = document.createElement('div');
            notification.className = `notification notification-${type}`;
            notification.textContent = message;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.remove();
            }, 3000);
        }

        // Auto-refresh dashboard stats every 30 seconds
        setInterval(function() {
            if (document.getElementById('dashboard').style.display !== 'none') {
                fetch('admin-dashboard-stats')
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            document.querySelector('.stat-card:nth-child(1) .stat-value').textContent = data.totalUsers || 0;
                            document.querySelector('.stat-card:nth-child(2) .stat-value').textContent = data.totalFoods || 0;
                            document.querySelector('.stat-card:nth-child(3) .stat-value').textContent = data.totalExercises || 0;
                            document.querySelector('.stat-card:nth-child(4) .stat-value').textContent = data.activeUsers || 0;
                        }
                    })
                    .catch(error => {
                        console.error('Error refreshing stats:', error);
                    });
            }
        }, 30000);
    </script>
</body>
</html>