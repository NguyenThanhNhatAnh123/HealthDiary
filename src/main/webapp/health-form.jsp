<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tình trạng sức khỏe - Health Diary</title>
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
            max-width: 900px;
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
        input[type="datetime-local"], 
        input[type="number"], 
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

        /* Health Status Display */
        .health-status {
            background: linear-gradient(135deg, #e3f2fd, #f3e5f5);
            padding: 25px;
            border-radius: 16px;
            margin: 25px 0;
            border: 1px solid #bbdefb;
            box-shadow: 0 4px 16px rgba(25, 118, 210, 0.1);
        }

        .info-row {
            display: flex;
            margin: 12px 0;
            align-items: center;
        }

        .info-label {
            font-weight: 600;
            color: #1976d2;
            min-width: 120px;
        }

        .info-value {
            color: #424242;
            font-weight: 500;
        }

        /* Mood Selector */
        .mood-selector {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
            gap: 12px;
            margin: 15px 0;
        }

        .mood-option {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 16px 12px;
            border: 2px solid #e3f2fd;
            border-radius: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
            text-align: center;
        }

        .mood-option:hover {
            border-color: #1976d2;
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(25, 118, 210, 0.2);
        }

        .mood-option.selected {
            border-color: #1976d2;
            background: #e3f2fd;
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(25, 118, 210, 0.3);
        }

        .mood-emoji {
            font-size: 32px;
            margin-bottom: 8px;
        }

        .mood-option div:last-child {
            font-weight: 600;
            color: #424242;
            font-size: 14px;
        }

        /* Symptom Items */
        .symptoms-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 12px;
            margin: 15px 0;
        }

        .symptom-item {
            display: flex;
            align-items: center;
            padding: 12px;
            background: #fafafa;
            border: 2px solid #e3f2fd;
            border-radius: 10px;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .symptom-item:hover {
            background: #f0f8ff;
            border-color: #1976d2;
        }

        .symptom-item input[type="checkbox"] {
            margin-right: 12px;
            width: 20px;
            height: 20px;
            accent-color: #1976d2;
        }

        .symptom-item label {
            margin: 0;
            font-weight: 500;
            color: #424242;
            cursor: pointer;
            flex: 1;
        }

        /* Range Inputs */
        .range-group {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        input[type="range"] {
            flex: 1;
            accent-color: #1976d2;
        }

        .range-value {
            background: #1976d2;
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            min-width: 40px;
            text-align: center;
            font-size: 14px;
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

            .mood-selector {
                grid-template-columns: repeat(2, 1fr);
            }

            .symptoms-grid {
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

        /* Hover effects */
        .form-group:hover label {
            color: #1565c0;
        }

        .form-group:focus-within label {
            color: #1565c0;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-heart-pulse"></i> Tình trạng sức khỏe</h1>
            <div class="breadcrumb">
                <a href="dashboard">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <span class="separator">•</span>
                <a href="health-history">
                    <i class="fas fa-chart-line"></i> Lịch sử
                </a>
                <span class="separator">•</span>
                <span style="color: #666;">Ghi nhật ký</span>
                <span class="separator">•</span>
                <a href="logout" class="logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>

        <!-- Form Container -->
        <div class="form-container">
            <!-- Error Alert từ server -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Success Alert từ server -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <span>${success}</span>
                </div>
            </c:if>

            <!-- Current Health Status -->
            <c:if test="${todayHealthStatus != null}">
                <div class="health-status">
                    <div class="section-header">
                        <i class="fas fa-chart-line"></i>
                        Tình trạng hôm nay
                    </div>
                    <div class="info-row">
                        <span class="info-label">Trạng thái:</span>
                        <span class="info-value">${todayHealthStatus.status}</span>
                    </div>
                    <c:if test="${not empty todayHealthStatus.notes}">
                        <div class="info-row">
                            <span class="info-label">Ghi chú:</span>
                            <span class="info-value">${todayHealthStatus.notes}</span>
                        </div>
                    </c:if>
                    <div class="info-row">
                        <span class="info-label">Thời gian:</span>
                        <span class="info-value">
                            <fmt:formatDate value="${todayHealthStatus.date}" pattern="dd/MM/yyyy HH:mm" />
                        </span>
                    </div>
                </div>
            </c:if>

            <!-- Health Status Form -->
            <form action="health-status" method="post" id="healthForm">
                <!-- Basic Information -->
                <div class="section-header">
                    <i class="fas fa-clock"></i>
                    Thông tin cơ bản
                </div>

                <div class="form-group">
                    <label for="date">Thời gian <span class="required">*</span></label>
                    <input type="datetime-local" id="date" name="date" 
                           value="<fmt:formatDate value='<%= new java.util.Date() %>' pattern='yyyy-MM-dd\'T\'HH:mm' />" required>
                </div>

                <!-- Mood Section -->
                <div class="section-header">
                    <i class="fas fa-smile"></i>
                    Tâm trạng
                </div>

                <div class="form-group">
                    <div class="mood-selector">
                        <div class="mood-option" onclick="selectMood('excellent')" tabindex="0">
                            <div class="mood-emoji">😊</div>
                            <div>Tuyệt vời</div>
                        </div>
                        <div class="mood-option" onclick="selectMood('good')" tabindex="0">
                            <div class="mood-emoji">🙂</div>
                            <div>Tốt</div>
                        </div>
                        <div class="mood-option" onclick="selectMood('normal')" tabindex="0">
                            <div class="mood-emoji">😐</div>
                            <div>Bình thường</div>
                        </div>
                        <div class="mood-option" onclick="selectMood('bad')" tabindex="0">
                            <div class="mood-emoji">😕</div>
                            <div>Không tốt</div>
                        </div>
                        <div class="mood-option" onclick="selectMood('terrible')" tabindex="0">
                            <div class="mood-emoji">😞</div>
                            <div>Rất tệ</div>
                        </div>
                    </div>
                    <input type="hidden" id="mood" name="mood" value="">
                </div>

                <!-- Symptoms Section -->
                <div class="section-header">
                    <i class="fas fa-stethoscope"></i>
                    Triệu chứng
                </div>

                <div class="form-group">
                    <div class="symptoms-grid">
                        <div class="symptom-item">
                            <input type="checkbox" id="fatigue" name="symptoms" value="fatigue">
                            <label for="fatigue">Mệt mỏi</label>
                        </div>
                        <div class="symptom-item">
                            <input type="checkbox" id="headache" name="symptoms" value="headache">
                            <label for="headache">Đau đầu</label>
                        </div>
                        <div class="symptom-item">
                            <input type="checkbox" id="fever" name="symptoms" value="fever">
                            <label for="fever">Sốt</label>
                        </div>
                        <div class="symptom-item">
                            <input type="checkbox" id="cough" name="symptoms" value="cough">
                            <label for="cough">Ho</label>
                        </div>
                        <div class="symptom-item">
                            <input type="checkbox" id="sore_throat" name="symptoms" value="sore_throat">
                            <label for="sore_throat">Đau họng</label>
                        </div>
                        <div class="symptom-item">
                            <input type="checkbox" id="nausea" name="symptoms" value="nausea">
                            <label for="nausea">Buồn nôn</label>
                        </div>
                        <div class="symptom-item">
                            <input type="checkbox" id="dizziness" name="symptoms" value="dizziness">
                            <label for="dizziness">Chóng mặt</label>
                        </div>
                        <div class="symptom-item">
                            <input type="checkbox" id="insomnia" name="symptoms" value="insomnia">
                            <label for="insomnia">Mất ngủ</label>
                        </div>
                        <div class="symptom-item">
                            <input type="checkbox" id="appetite_loss" name="symptoms" value="appetite_loss">
                            <label for="appetite_loss">Chán ăn</label>
                        </div>
                        <div class="symptom-item">
                            <input type="checkbox" id="none" name="symptoms" value="none">
                            <label for="none">Không có triệu chứng</label>
                        </div>
                    </div>
                </div>

                <!-- Health Metrics -->
                <div class="section-header">
                    <i class="fas fa-chart-bar"></i>
                    Chỉ số sức khỏe
                </div>

                <div class="form-group">
                    <label for="sleep_hours">Giờ ngủ (giờ)</label>
                    <input type="number" id="sleep_hours" name="sleep_hours" min="0" max="24" step="0.5" placeholder="Ví dụ: 7.5">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="stress_level">Mức độ căng thẳng (1-10)</label>
                        <div class="range-group">
                            <input type="range" id="stress_level" name="stress_level" min="1" max="10" value="5" 
                                   oninput="document.getElementById('stress_value').textContent = this.value">
                            <span class="range-value" id="stress_value">5</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="energy_level">Mức năng lượng (1-10)</label>
                        <div class="range-group">
                            <input type="range" id="energy_level" name="energy_level" min="1" max="10" value="7" 
                                   oninput="document.getElementById('energy_value').textContent = this.value">
                            <span class="range-value" id="energy_value">7</span>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="notes">Ghi chú</label>
                    <textarea id="notes" name="notes" placeholder="Mô tả chi tiết về tình trạng sức khỏe..."></textarea>
                </div>

                <!-- Buttons -->
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Lưu tình trạng
                    </button>
                    <a href="health-history" class="btn btn-secondary">
                        <i class="fas fa-chart-line"></i>
                        Lịch sử sức khỏe
                    </a>
                    <a href="dashboard" class="btn btn-secondary">
                        <i class="fas fa-home"></i>
                        Về trang chủ
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        function selectMood(mood) {
            // Remove selected class from all options
            document.querySelectorAll('.mood-option').forEach(option => {
                option.classList.remove('selected');
            });
            
            // Add selected class to clicked option
            event.currentTarget.classList.add('selected');
            
            // Set hidden input value
            document.getElementById('mood').value = mood;
        }
        
        // Add keyboard support for mood options
        document.querySelectorAll('.mood-option').forEach(option => {
            option.addEventListener('keypress', function(e) {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    this.click();
                }
            });
        });
        
        // Form validation
        document.getElementById('healthForm').addEventListener('submit', function(e) {
            const mood = document.getElementById('mood').value;
            const sleepHours = parseFloat(document.getElementById('sleep_hours').value);
            
            if (!mood) {
                e.preventDefault();
                alert('Vui lòng chọn tâm trạng');
                return false;
            }
            
            if (sleepHours && (sleepHours < 0 || sleepHours > 24)) {
                e.preventDefault();
                alert('Giờ ngủ phải từ 0 đến 24 giờ');
                return false;
            }
            
            // Add loading state
            const submitBtn = this.querySelector('.btn-primary');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang lưu...';
        });
        
        // Handle symptom checkboxes
        document.getElementById('none').addEventListener('change', function() {
            if (this.checked) {
                // Uncheck all other symptoms
                document.querySelectorAll('input[name="symptoms"]').forEach(checkbox => {
                    if (checkbox !== this) {
                        checkbox.checked = false;
                    }
                });
            }
        });
        
        // When other symptoms are checked, uncheck "none"
        document.querySelectorAll('input[name="symptoms"]').forEach(checkbox => {
            if (checkbox.id !== 'none') {
                checkbox.addEventListener('change', function() {
                    if (this.checked) {
                        document.getElementById('none').checked = false;
                    }
                });
            }
        });
        
        // Check symptom items on click
        document.querySelectorAll('.symptom-item').forEach(item => {
            item.addEventListener('click', function(e) {
                if (e.target.type !== 'checkbox') {
                    const checkbox = this.querySelector('input[type="checkbox"]');
                    checkbox.checked = !checkbox.checked;
                    checkbox.dispatchEvent(new Event('change'));
                }
            });
        });
    </script>
</body>
</html>