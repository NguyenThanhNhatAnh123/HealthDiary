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
        /* ... (giữ nguyên phần CSS) ... */
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
                <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
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
                        <c:if test="${not empty exerciseList}">
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
                        </c:if>
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
                        <div class="intensity-option low" onclick="selectIntensity('low', event)" data-intensity="low" tabindex="0">
                            🟢 Nhẹ
                        </div>
                        <div class="intensity-option medium" onclick="selectIntensity('medium', event)" data-intensity="medium" tabindex="0">
                            🟡 Vừa
                        </div>
                        <div class="intensity-option high" onclick="selectIntensity('high', event)" data-intensity="high" tabindex="0">
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
                               placeholder="70" value="${user.weight}" oninput="calculateCalories()">
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

        function selectIntensity(intensity, event) {
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
                    // Set medium intensity as default without triggering the visual selection
                    document.getElementById('intensity').value = 'medium';
                    document.querySelector('.intensity-option.medium').classList.add('selected');
                }
            }, 300);
        });
    </script>
</body>
</html>