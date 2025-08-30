<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý bài tập - Health Diary</title>
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
            max-width: 1400px;
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

        /* Main Layout */
        .main-layout {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            align-items: start;
        }

        /* Exercise List Section */
        .exercise-list-section {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            padding: 32px;
            position: relative;
            overflow: hidden;
        }

        .exercise-list-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #1976d2, #42a5f5, #1976d2);
        }

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
            padding: 12px;
            border-radius: 10px;
            font-size: 18px;
        }

        /* Exercise Grid */
        .exercise-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 16px;
            margin-bottom: 32px;
        }

        .exercise-card {
            background: linear-gradient(135deg, #f8f9ff 0%, #e3f2fd 100%);
            border: 2px solid #e3f2fd;
            border-radius: 16px;
            padding: 20px;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .exercise-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(25, 118, 210, 0.15);
            border-color: #1976d2;
        }

        .exercise-card.selected {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            border-color: #1565c0;
            box-shadow: 0 8px 25px rgba(25, 118, 210, 0.3);
        }

        .exercise-card h4 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 12px;
            color: inherit;
        }

        .exercise-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            font-size: 14px;
        }

        .exercise-details span {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .exercise-details i {
            width: 16px;
            opacity: 0.7;
        }

        .calories-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background: rgba(255, 255, 255, 0.9);
            color: #1976d2;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }

        .exercise-card.selected .calories-badge {
            background: rgba(255, 255, 255, 0.2);
            color: #fff;
        }

        /* Form Section */
        .form-section {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(25, 118, 210, 0.12);
            padding: 32px;
            position: relative;
            overflow: hidden;
        }

        .form-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #4caf50, #66bb6a, #4caf50);
        }

        /* Form Elements */
        .form-group {
            margin-bottom: 20px;
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

        input[type="datetime-local"], input[type="number"], textarea, select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e3f2fd;
            border-radius: 12px;
            font-size: 16px;
            background: #fafafa;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: #1976d2;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
        }

        /* Intensity Selector */
        .intensity-selector {
            display: flex;
            gap: 8px;
        }

        .intensity-option {
            padding: 12px 16px;
            border: 2px solid #e3f2fd;
            border-radius: 12px;
            cursor: pointer;
            text-align: center;
            flex: 1;
            background: #fafafa;
            transition: all 0.3s ease;
            font-weight: 500;
            font-size: 14px;
        }

        .intensity-option:hover {
            border-color: #1976d2;
            transform: translateY(-1px);
        }

        .intensity-option.selected {
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            border-color: #1976d2;
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.3);
        }

        /* Exercise Info */
        .exercise-info {
            background: #e3f2fd;
            padding: 16px;
            border-radius: 12px;
            margin: 16px 0;
            border-left: 4px solid #1976d2;
        }

        .exercise-info h5 {
            color: #1976d2;
            margin-bottom: 8px;
            font-size: 16px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            font-size: 14px;
        }

        /* Calorie Estimation */
        .calorie-estimation {
            background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c9 100%);
            padding: 16px;
            border-radius: 12px;
            text-align: center;
            margin: 16px 0;
            border-left: 4px solid #4caf50;
        }

        .estimated-calories {
            font-size: 24px;
            font-weight: bold;
            color: #2e7d32;
            margin-top: 8px;
        }

        /* Buttons */
        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 24px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            flex: 1;
            justify-content: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4caf50, #66bb6a);
            color: #fff;
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
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
            margin-bottom: 20px;
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

        /* User Exercises History */
        .user-exercises {
            margin-top: 32px;
            display: none;
        }

        .user-exercises.visible {
            display: block;
        }

        .user-exercises h4 {
            color: #1976d2;
            margin-bottom: 16px;
            font-size: 18px;
        }

        .exercise-history {
            max-height: 300px;
            overflow-y: auto;
        }

        .exercise-history-item {
            background: #f8f9ff;
            border: 1px solid #e3f2fd;
            border-radius: 10px;
            padding: 12px 16px;
            margin-bottom: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .exercise-history-item:last-child {
            margin-bottom: 0;
        }

        .exercise-name {
            font-weight: 600;
            color: #1976d2;
        }

        .exercise-stats {
            display: flex;
            gap: 16px;
            font-size: 14px;
            color: #666;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .main-layout {
                grid-template-columns: 1fr;
                gap: 20px;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 16px;
            }

            .exercise-grid {
                grid-template-columns: 1fr;
            }

            .intensity-selector {
                flex-direction: column;
            }

            .button-group {
                flex-direction: column;
            }

            .exercise-details {
                grid-template-columns: 1fr;
            }
        }

        /* Loading state */
        .loading {
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .spinner {
            width: 16px;
            height: 16px;
            border: 2px solid transparent;
            border-top: 2px solid currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-dumbbell"></i> Health Diary</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-home"></i> Trang chủ</a>
                <a href="${pageContext.request.contextPath}/exercise-history"><i class="fas fa-chart-line"></i> Theo dõi</a>
                <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user"></i> Hồ sơ</a>
                <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>

        <!-- Alerts -->
        <c:if test="${not empty success}">
            <div class="alert alert-success" id="successAlert">
                <i class="fas fa-check-circle"></i>
                <span>${success}</span>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-error" id="errorAlert">
                <i class="fas fa-exclamation-triangle"></i>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Main Layout -->
        <div class="main-layout">
            <!-- Exercise List Section -->
            <div class="exercise-list-section">
                <div class="section-header">
                    <i class="fas fa-list"></i>
                    Danh sách bài tập
                </div>

                <div class="exercise-grid" id="exerciseGrid">
                    <c:choose>
                        <c:when test="${not empty exerciseList}">
                            <c:forEach var="exercise" items="${exerciseList}">
                                <div class="exercise-card" onclick="selectExercise(${exercise.id}, '${exercise.exerciseName}', '${exercise.type}', '${exercise.muscleGroup}', '${exercise.difficulty}', ${exercise.caloriesPerHour})" 
                                     data-exercise-id="${exercise.id}">
                                    <div class="calories-badge">${exercise.caloriesPerHour} kcal/h</div>
                                    <h4>${exercise.exerciseName}</h4>
                                    <div class="exercise-details">
                                        <span><i class="fas fa-tag"></i> ${exercise.type}</span>
                                        <span><i class="fas fa-dumbbell"></i> ${exercise.muscleGroup}</span>
                                        <span><i class="fas fa-signal"></i> ${exercise.difficulty}</span>
                                        <span><i class="fas fa-fire"></i> ${exercise.caloriesPerHour} kcal/h</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #666;">
                                <i class="fas fa-exclamation-circle" style="font-size: 48px; margin-bottom: 16px; opacity: 0.5;"></i>
                                <p>Không có bài tập nào trong cơ sở dữ liệu.</p>
                                <p><small>Vui lòng liên hệ quản trị viên để thêm dữ liệu bài tập.</small></p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- User Exercise History -->
                <div class="user-exercises ${not empty userExercises ? 'visible' : ''}" id="userExercisesSection">
                    <h4><i class="fas fa-history"></i> Lịch sử bài tập của bạn</h4>
                    <div class="exercise-history" id="exerciseHistory">
                        <c:choose>
                            <c:when test="${not empty userExercises}">
                                <c:forEach var="userEx" items="${userExercises}">
                                    <div class="exercise-history-item">
                                        <div>
                                            <div class="exercise-name">${userEx.exerciseType}</div>
                                            <div><fmt:formatDate value="${userEx.logDate}" pattern="dd/MM/yyyy HH:mm"/></div>
                                        </div>
                                        <div class="exercise-stats">
                                            <span><i class="fas fa-clock"></i> ${userEx.durationMin} phút</span>
                                            <span><i class="fas fa-fire"></i> ${userEx.caloriesBurned} kcal</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p style="text-align: center; color: #666; padding: 20px;">
                                    <i class="fas fa-info-circle"></i> Chưa có lịch sử bài tập nào.
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Form Section -->
            <div class="form-section">
                <div class="section-header">
                    <i class="fas fa-plus-circle"></i>
                    Ghi nhận bài tập
                </div>

                <form id="exerciseForm" method="post" action="${pageContext.request.contextPath}/exercise-form">
                    <div class="form-group">
                        <label for="date">Thời gian <span class="required">*</span></label>
                        <input type="datetime-local" id="date" name="date" required 
                               value="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd'T'HH:mm" />">
                    </div>

                    <div class="form-group">
                        <label>Chọn bài tập <span class="required">*</span></label>
                        <div class="exercise-info" id="selectedExerciseInfo" style="display: none;">
                            <h5 id="selectedExerciseName"></h5>
                            <div class="info-grid">
                                <span><i class="fas fa-tag"></i> <span id="selectedExerciseType"></span></span>
                                <span><i class="fas fa-fire"></i> <span id="selectedExerciseCalories"></span> kcal/h</span>
                                <span><i class="fas fa-dumbbell"></i> <span id="selectedExerciseMuscle"></span></span>
                                <span><i class="fas fa-signal"></i> <span id="selectedExerciseDifficulty"></span></span>
                            </div>
                        </div>
                        <input type="hidden" id="exerciseType" name="exerciseType" required>
                    </div>

                    <div class="form-group">
                        <label>Cường độ <span class="required">*</span></label>
                        <div class="intensity-selector">
                            <div class="intensity-option" data-intensity="low" onclick="selectIntensity('low', this)">
                                🟢 Nhẹ
                            </div>
                            <div class="intensity-option" data-intensity="medium" onclick="selectIntensity('medium', this)">
                                🟡 Vừa
                            </div>
                            <div class="intensity-option" data-intensity="high" onclick="selectIntensity('high', this)">
                                🔴 Mạnh
                            </div>
                        </div>
                        <input type="hidden" id="intensity" name="intensity" required>
                    </div>

                    <div class="form-group">
                        <label for="duration">Thời gian (phút) <span class="required">*</span></label>
                        <input type="number" id="duration" name="duration" min="1" max="600" 
                               placeholder="30" oninput="calculateCalories()" required>
                    </div>

                    <div class="form-group">
                        <label for="weight">Cân nặng (kg)</label>
                        <input type="number" id="weight" name="weight" min="30" max="200" step="0.1"
                               placeholder="70" value="${userWeight != null ? userWeight : 70}" oninput="calculateCalories()">
                    </div>

                    <div class="calorie-estimation" id="calorieEstimation" style="display: none;">
                        <div style="color: #2e7d32; font-weight: 600;">🔥 Ước tính calorie đốt cháy:</div>
                        <div class="estimated-calories" id="estimatedCalories">0 kcal</div>
                        <input type="hidden" id="caloriesBurned" name="caloriesBurned" value="0">
                    </div>

                    <div class="form-group">
                        <label for="notes">Ghi chú</label>
                        <textarea id="notes" name="notes" placeholder="Mô tả chi tiết về bài tập..." rows="3">${param.notes}</textarea>
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Lưu bài tập
                        </button>
                        <button type="reset" class="btn btn-secondary" onclick="resetForm()">
                            <i class="fas fa-redo"></i> Đặt lại
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Biến toàn cục
        let selectedExercise = null;
        let selectedIntensity = null;
        let selectedExerciseId = null;
        
        // Khởi tạo trang
        document.addEventListener('DOMContentLoaded', function() {
            // Thiết lập ngày giờ hiện tại nếu chưa có giá trị
            if (!document.getElementById('date').value) {
                const now = new Date();
                const localDateTime = now.toISOString().slice(0, 16);
                document.getElementById('date').value = localDateTime;
            }
            
            // Khôi phục trạng thái form nếu có
            <c:if test="${not empty param.exerciseType}">
                selectExercise(${param.exerciseType}, '${param.exerciseName}', '${param.type}', '${param.muscleGroup}', '${param.difficulty}', ${param.caloriesPerHour});
            </c:if>
            
            <c:if test="${not empty param.intensity}">
                selectIntensity('${param.intensity}');
            </c:if>
        });
        
        // Chọn bài tập
        function selectExercise(id, name, type, muscle, difficulty, calories) {
            // Bỏ chọn tất cả các thẻ bài tập
            document.querySelectorAll('.exercise-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            // Chọn thẻ bài tập hiện tại
            const selectedCard = document.querySelector(`.exercise-card[data-exercise-id="${id}"]`);
            if (selectedCard) {
                selectedCard.classList.add('selected');
            }
            
            selectedExerciseId = id;
            selectedExercise = { id, name, type, muscle, difficulty, calories };
            
            // Cập nhật form với thông tin bài tập
            document.getElementById('exerciseType').value = id;
            document.getElementById('selectedExerciseName').textContent = name;
            document.getElementById('selectedExerciseType').textContent = type;
            document.getElementById('selectedExerciseCalories').textContent = calories;
            document.getElementById('selectedExerciseMuscle').textContent = muscle;
            document.getElementById('selectedExerciseDifficulty').textContent = difficulty;
            
            // Hiển thị thông tin bài tập
            document.getElementById('selectedExerciseInfo').style.display = 'block';
            
            // Tính lại calorie nếu đã có thời gian
            const duration = document.getElementById('duration').value;
            if (duration) {
                calculateCalories();
            }
        }
        
        // Chọn cường độ
        function selectIntensity(intensity, element) {
            // Bỏ chọn tất cả các tùy chọn cường độ
            document.querySelectorAll('.intensity-option').forEach(option => {
                option.classList.remove('selected');
            });
            
            // Chọn tùy chọn cường độ hiện tại
            if (element) {
                element.classList.add('selected');
            } else {
                // Tìm phần tử tương ứng với cường độ
                const intensityElement = document.querySelector(`.intensity-option[data-intensity="${intensity}"]`);
                if (intensityElement) {
                    intensityElement.classList.add('selected');
                }
            }
            
            selectedIntensity = intensity;
            document.getElementById('intensity').value = intensity;
            
            // Tính lại calorie nếu đã có bài tập và thời gian
            if (selectedExercise && document.getElementById('duration').value) {
                calculateCalories();
            }
        }
        
        // Tính toán calorie
        function calculateCalories() {
            if (!selectedExercise || !selectedIntensity) return;
            
            const duration = parseFloat(document.getElementById('duration').value);
            const weight = parseFloat(document.getElementById('weight').value) || 70;
            
            if (!duration || duration <= 0) return;
            
            // Tính toán calorie dựa trên bài tập, cường độ, thời gian và cân nặng
            let intensityMultiplier = 1;
            switch(selectedIntensity) {
                case 'low': intensityMultiplier = 0.7; break;
                case 'medium': intensityMultiplier = 1.0; break;
                case 'high': intensityMultiplier = 1.3; break;
            }
            
            // Công thức tính calorie đơn giản
            const caloriesPerMinute = (selectedExercise.calories * intensityMultiplier * (weight / 70)) / 60;
            const totalCalories = Math.round(caloriesPerMinute * duration);
            
            // Hiển thị kết quả
            document.getElementById('estimatedCalories').textContent = `${totalCalories} kcal`;
            document.getElementById('caloriesBurned').value = totalCalories;
            document.getElementById('calorieEstimation').style.display = 'block';
        }
        
        // Đặt lại form
        function resetForm() {
            selectedExercise = null;
            selectedIntensity = null;
            selectedExerciseId = null;
            
            document.querySelectorAll('.exercise-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            document.querySelectorAll('.intensity-option').forEach(option => {
                option.classList.remove('selected');
            });
            
            document.getElementById('selectedExerciseInfo').style.display = 'none';
            document.getElementById('calorieEstimation').style.display = 'none';
            document.getElementById('intensity').value = '';
            
            // Thiết lập lại ngày giờ hiện tại
            const now = new Date();
            const localDateTime = now.toISOString().slice(0, 16);
            document.getElementById('date').value = localDateTime;
        }
        
        // Xử lý gửi form
        document.getElementById('exerciseForm').addEventListener('submit', function(event) {
            // Kiểm tra các trường bắt buộc
            if (!selectedExerciseId) {
                event.preventDefault();
                alert('Vui lòng chọn một bài tập.');
                return;
            }
            
            if (!selectedIntensity) {
                event.preventDefault();
                alert('Vui lòng chọn cường độ tập luyện.');
                return;
            }
            
            // Hiển thị trạng thái loading
            const submitButton = this.querySelector('button[type="submit"]');
            const originalText = submitButton.innerHTML;
            submitButton.innerHTML = '<div class="loading"><div class="spinner"></div> Đang lưu...</div>';
            submitButton.disabled = true;
            
            // Cho phép form được gửi đi
        });
    </script>
</body>
</html>