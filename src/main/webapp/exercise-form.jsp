<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ghi nhận bài tập - Health Diary</title>
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
            max-width: 1000px;
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

        /* Form Container */
        .form-container {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            padding: 40px;
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
        input[type="datetime-local"], 
        input[type="number"], 
        input[type="text"], 
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

        input[type="datetime-local"]:focus, 
        input[type="number"]:focus, 
        input[type="text"]:focus, 
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

        /* Exercise Info Display */
        .exercise-info {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
            border: 2px solid #e3f2fd;
            display: none;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }

        .info-item {
            text-align: center;
            padding: 15px;
            background: white;
            border-radius: 8px;
            border: 1px solid #e3f2fd;
        }

        .info-item strong {
            display: block;
            color: #1976d2;
            font-size: 12px;
            margin-bottom: 5px;
            text-transform: uppercase;
        }

        .info-item span {
            color: #424242;
            font-weight: 600;
            font-size: 14px;
        }

        /* Intensity Selector */
        .intensity-selector {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin: 15px 0;
        }

        .intensity-option {
            padding: 20px 15px;
            border: 2px solid #e3f2fd;
            border-radius: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
            text-align: center;
            font-weight: 600;
            color: #424242;
        }

        .intensity-option:hover {
            border-color: #1976d2;
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(25, 118, 210, 0.2);
        }

        .intensity-option.selected {
            border-color: #1976d2;
            background: #e3f2fd;
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(25, 118, 210, 0.3);
        }

        /* Calorie Estimation */
        .calorie-estimation {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            padding: 25px;
            border-radius: 16px;
            margin: 25px 0;
            text-align: center;
            border: 2px solid #42a5f5;
            box-shadow: 0 4px 16px rgba(25, 118, 210, 0.1);
        }

        .estimated-calories {
            font-size: 32px;
            font-weight: 700;
            color: #1976d2;
            text-shadow: 1px 1px 2px rgba(25, 118, 210, 0.1);
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

            .form-container {
                padding: 24px;
                margin: 16px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .intensity-selector {
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
            <h1><i class="fas fa-dumbbell"></i> Health Diary</h1>
            <div class="breadcrumb">
                <a href="dashboard"><i class="fas fa-home"></i> Trang chủ</a>
                <span class="separator">•</span>
                <a href="calorie-tracking"><i class="fas fa-chart-line"></i> Theo dõi Calorie</a>
                <span class="separator">•</span>
                <a href="profile"><i class="fas fa-user"></i> Hồ sơ</a>
                <span class="separator">•</span>
                <a href="logout" class="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>

        <!-- Form Container -->
        <div class="form-container">
            <div class="section-header">
                <i class="fas fa-dumbbell"></i>
                Ghi nhận bài tập
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

            <!-- Client-side alerts -->
            <div class="alert alert-success" style="display: none;" id="successAlert">
                <i class="fas fa-check-circle"></i>
                <span>Lưu bài tập thành công!</span>
            </div>

            <div class="alert alert-error" style="display: none;" id="errorAlert">
                <i class="fas fa-exclamation-triangle"></i>
                <span id="errorMessage">Có lỗi xảy ra, vui lòng thử lại!</span>
            </div>

            <!-- Exercise Form -->
            <form id="exerciseForm" action="exercise-form" method="post">
                <div class="section-header">
                    <i class="fas fa-info-circle"></i>
                    Thông tin bài tập
                </div>

                <div class="form-group">
                    <label for="date">Thời gian <span class="required">*</span></label>
                    <input type="datetime-local" id="date" name="date" 
                           value="<fmt:formatDate value='<%= new java.util.Date() %>' pattern='yyyy-MM-dd\'T\'HH:mm' />" required>
                </div>

                <div class="form-group">
                    <label for="exerciseType">Loại bài tập <span class="required">*</span></label>
                    <select id="exerciseType" name="exerciseType" required onchange="selectExerciseType(this.value)">
                        <option value="">Chọn bài tập</option>
                        <!-- Dynamically populated from server -->
                        <c:forEach var="exercise" items="${exerciseList}">
                            <option value="${exercise.id}" 
                                    data-calories="${exercise.caloriesPerHour}" 
                                    data-name="${fn:escapeXml(exercise.exerciseName)}"
                                    data-type="${fn:escapeXml(exercise.type)}"
                                    data-muscle="${fn:escapeXml(exercise.muscleGroup)}"
                                    data-difficulty="${fn:escapeXml(exercise.difficulty)}">
                                ${fn:escapeXml(exercise.exerciseName)}
                            </option>
                        </c:forEach>
                        <option value="other">Khác</option>
                    </select>
                </div>

                <!-- Exercise Info Display -->
                <div class="exercise-info" id="exerciseInfo">
                    <h4 id="exerciseInfoTitle">Thông tin bài tập</h4>
                    <div class="info-grid">
                        <div class="info-item">
                            <strong>Loại</strong>
                            <span id="exerciseInfoType">-</span>
                        </div>
                        <div class="info-item">
                            <strong>Nhóm cơ</strong>
                            <span id="exerciseInfoMuscle">-</span>
                        </div>
                        <div class="info-item">
                            <strong>Độ khó</strong>
                            <span id="exerciseInfoDifficulty">-</span>
                        </div>
                        <div class="info-item">
                            <strong>Calories/giờ</strong>
                            <span id="exerciseInfoCalories">-</span>
                        </div>
                    </div>
                </div>

                <div class="form-group" id="customExerciseGroup" style="display: none;">
                    <label for="customExerciseName">Tên bài tập <span class="required">*</span></label>
                    <input type="text" id="customExerciseName" name="customExerciseName" placeholder="Nhập tên bài tập...">
                </div>

                <div class="form-group">
                    <label>Cường độ <span class="required">*</span></label>
                    <div class="intensity-selector">
                        <div class="intensity-option low" onclick="selectIntensity('low')" data-intensity="low" tabindex="0">
                            🟢 Nhẹ
                        </div>
                        <div class="intensity-option medium" onclick="selectIntensity('medium')" data-intensity="medium" tabindex="0">
                            🟡 Vừa
                        </div>
                        <div class="intensity-option high" onclick="selectIntensity('high')" data-intensity="high" tabindex="0">
                            🔴 Mạnh
                        </div>
                    </div>
                    <input type="hidden" id="intensity" name="intensity" value="" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="duration">Thời gian (phút) <span class="required">*</span></label>
                        <input type="number" id="duration" name="duration" min="1" max="600" 
                               placeholder="30" oninput="calculateCalories()" required>
                    </div>
                    <div class="form-group">
                        <label for="weight">Cân nặng (kg)</label>
                        <input type="number" id="weight" name="weight" min="30" max="200" step="0.1"
                               placeholder="70" value="${user.weightKg}" oninput="calculateCalories()">
                    </div>
                </div>

                <div class="calorie-estimation" id="calorieEstimation" style="display: none;">
                    <div style="color: #1976d2; font-weight: 600;">🔥 Ước tính calorie đốt cháy:</div>
                    <div class="estimated-calories" id="estimatedCalories">0 kcal</div>
                    <input type="hidden" id="caloriesBurned" name="caloriesBurned" value="0">
                </div>

                <div class="form-group">
                    <label for="notes">Ghi chú</label>
                    <textarea id="notes" name="notes" placeholder="Mô tả chi tiết về bài tập..."></textarea>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Lưu bài tập
                    </button>
                    <a href="calorie-tracking" class="btn btn-secondary">
                        <i class="fas fa-chart-line"></i> Xem theo dõi Calorie
                    </a>
                    <a href="dashboard" class="btn btn-secondary">
                        <i class="fas fa-home"></i> Về trang chủ
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Exercise calories per minute per kg (fallback for custom exercises)
        const defaultCaloriesPerHour = {
            low: 200,    // 200 calories/hour for low intensity
            medium: 350, // 350 calories/hour for medium intensity
            high: 500    // 500 calories/hour for high intensity
        };

        function selectExerciseType(type) {
            const customGroup = document.getElementById('customExerciseGroup');
            const customInput = document.getElementById('customExerciseName');
            const exerciseInfo = document.getElementById('exerciseInfo');
            const exerciseSelect = document.getElementById('exerciseType');

            if (type === '' || type === 'other') {
                customGroup.style.display = type === 'other' ? 'block' : 'none';
                customInput.required = type === 'other';
                exerciseInfo.style.display = 'none';
                if (type !== 'other') {
                    customInput.value = '';
                }
            } else {
                customGroup.style.display = 'none';
                customInput.required = false;
                customInput.value = '';
                
                // Show exercise info
                const selectedOption = exerciseSelect.selectedOptions[0];
                if (selectedOption && selectedOption.dataset) {
                    document.getElementById('exerciseInfoTitle').textContent = selectedOption.dataset.name || '-';
                    document.getElementById('exerciseInfoType').textContent = selectedOption.dataset.type || '-';
                    document.getElementById('exerciseInfoMuscle').textContent = selectedOption.dataset.muscle || '-';
                    document.getElementById('exerciseInfoDifficulty').textContent = selectedOption.dataset.difficulty || '-';
                    
                    const calories = selectedOption.dataset.calories || '0';
                    document.getElementById('exerciseInfoCalories').textContent = calories + ' kcal';
                    exerciseInfo.style.display = 'block';
                }
            }

            calculateCalories();
        }

        function selectIntensity(intensity) {
            document.querySelectorAll('.intensity-option').forEach(option => {
                option.classList.remove('selected');
            });

            event.currentTarget.classList.add('selected');
            document.getElementById('intensity').value = intensity;

            calculateCalories();
        }

        function calculateCalories() {
            const exerciseTypeSelect = document.getElementById('exerciseType');
            const exerciseType = exerciseTypeSelect.value;
            const intensity = document.getElementById('intensity').value;
            const duration = parseFloat(document.getElementById('duration').value) || 0;
            const weight = parseFloat(document.getElementById('weight').value) || 70;

            // Kiểm tra xem cường độ đã được chọn chưa
            if (!intensity) {
                document.getElementById('calorieEstimation').style.display = 'none';
                document.getElementById('caloriesBurned').value = '0';
                return;
            }

            if (exerciseType && intensity && duration > 0) {
                let caloriesPerHour;
                
                if (exerciseType === 'other' || exerciseType === '') {
                    // Use default calories for custom exercises
                    caloriesPerHour = defaultCaloriesPerHour[intensity] || 300;
                } else {
                    // Get calories from selected exercise
                    const selectedOption = exerciseTypeSelect.selectedOptions[0];
                    let baseCalories = 300; // Giá trị mặc định
                    
                    if (selectedOption && selectedOption.dataset && selectedOption.dataset.calories) {
                        baseCalories = parseFloat(selectedOption.dataset.calories);
                        if (isNaN(baseCalories)) baseCalories = 300;
                    }
                    
                    // Adjust calories based on intensity
                    const intensityMultiplier = { low: 0.7, medium: 1.0, high: 1.3 };
                    caloriesPerHour = baseCalories * (intensityMultiplier[intensity] || 1.0);
                }

                // Calculate total calories based on weight (assuming calories are for 70kg person)
                const weightFactor = weight / 70;
                const caloriesPerMinute = (caloriesPerHour * weightFactor) / 60;
                const totalCalories = Math.round(caloriesPerMinute * duration);

                document.getElementById('estimatedCalories').textContent = totalCalories + ' kcal';
                document.getElementById('caloriesBurned').value = totalCalories;
                document.getElementById('calorieEstimation').style.display = 'block';
            } else {
                document.getElementById('calorieEstimation').style.display = 'none';
                document.getElementById('caloriesBurned').value = '0';
            }
        }

        // Add keyboard support for intensity options
        document.querySelectorAll('.intensity-option').forEach(option => {
            option.addEventListener('keypress', function(e) {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    this.click();
                }
            });
        });

        // Form validation
        document.getElementById('exerciseForm').addEventListener('submit', function(e) {
            const exerciseType = document.getElementById('exerciseType').value;
            const intensity = document.getElementById('intensity').value;
            const duration = parseFloat(document.getElementById('duration').value);
            const customExerciseName = document.getElementById('customExerciseName').value;

            // Reset alerts
            document.getElementById('successAlert').style.display = 'none';
            document.getElementById('errorAlert').style.display = 'none';

            if (!exerciseType) {
                e.preventDefault();
                showAlert('error', 'Vui lòng chọn loại bài tập');
                return false;
            }

            if (exerciseType === 'other' && !customExerciseName.trim()) {
                e.preventDefault();
                showAlert('error', 'Vui lòng nhập tên bài tập');
                return false;
            }

            if (!intensity) {
                e.preventDefault();
                showAlert('error', 'Vui lòng chọn cường độ');
                return false;
            }

            if (!duration || isNaN(duration) || duration <= 0 || duration > 600) {
                e.preventDefault();
                showAlert('error', 'Thời gian phải từ 1 đến 600 phút');
                return false;
            }

            const submitBtn = this.querySelector('.btn-primary');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang lưu...';
            submitBtn.disabled = true;
            return true;
        });

        function showAlert(type, message) {
            const alertId = type === 'success' ? 'successAlert' : 'errorAlert';
            const alert = document.getElementById(alertId);
            
            if (type === 'error') {
                document.getElementById('errorMessage').textContent = message;
            }
            
            alert.style.display = 'flex';

            setTimeout(() => {
                alert.style.display = 'none';
            }, 5000);
        }

        // Check if user is logged in
        <c:if test="${empty user}">
            window.location.href = 'login';
        </c:if>

        // Smooth animations
        document.addEventListener('DOMContentLoaded', function() {
            const formContainer = document.querySelector('.form-container');
            if (formContainer) {
                formContainer.style.opacity = '0';
                formContainer.style.transform = 'translateY(20px)';

                setTimeout(() => {
                    formContainer.style.transition = 'all 0.6s ease';
                    formContainer.style.opacity = '1';
                    formContainer.style.transform = 'translateY(0)';
                }, 100);
            }
            
            // Khởi tạo cường độ mặc định
            setTimeout(() => {
                if (!document.getElementById('intensity').value) {
                    selectIntensity('medium');
                }
            }, 300);
        });
    </script>
</body>
</html>