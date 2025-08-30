<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ghi nhận bữa ăn - Health Diary</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #fff0f5 0%, #ffe4e6 50%, #ffe4e6 100%);
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
            box-shadow: 0 2px 20px rgba(233, 30, 99, 0.1);
            padding: 24px 32px;
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            color: #e91e63;
            font-size: 28px;
            font-weight: 700;
        }

        .breadcrumb {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .breadcrumb a {
            color: #e91e63;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .breadcrumb a:hover {
            background: #fce4ec;
            transform: translateY(-1px);
        }

        /* Main Layout */
        .main-layout {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            align-items: start;
        }

        /* Food List Section */
        .food-list-section {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(233, 30, 99, 0.12);
            padding: 32px;
            position: relative;
            overflow: hidden;
        }

        .food-list-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #e91e63, #f48fb1, #e91e63);
        }

        .section-header {
            color: #e91e63;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-header i {
            background: #fce4ec;
            padding: 12px;
            border-radius: 10px;
            font-size: 18px;
        }

        /* Food Grid */
        .food-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 16px;
            margin-bottom: 32px;
        }

        .food-card {
            background: linear-gradient(135deg, #fef4f8 0%, #fce4ec 100%);
            border: 2px solid #fce4ec;
            border-radius: 16px;
            padding: 20px;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .food-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(233, 30, 99, 0.15);
            border-color: #e91e63;
        }

        .food-card.selected {
            background: linear-gradient(135deg, #e91e63, #f48fb1);
            color: #fff;
            border-color: #c2185b;
            box-shadow: 0 8px 25px rgba(233, 30, 99, 0.3);
        }

        .food-card h4 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 12px;
            color: inherit;
        }

        .food-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            font-size: 14px;
        }

        .food-details span {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .food-details i {
            width: 16px;
            opacity: 0.7;
        }

        .calories-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background: rgba(255, 255, 255, 0.9);
            color: #e91e63;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }

        .food-card.selected .calories-badge {
            background: rgba(255, 255, 255, 0.2);
            color: #fff;
        }

        /* Form Section */
        .form-section {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(233, 30, 99, 0.12);
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
            color: #e91e63;
            font-weight: 600;
            font-size: 14px;
            display: block;
            margin-bottom: 8px;
        }

        .required {
            color: #d32f2f;
            font-weight: 700;
        }

        input[type="datetime-local"], input[type="number"], input[type="text"], textarea, select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #fce4ec;
            border-radius: 12px;
            font-size: 16px;
            background: #fafafa;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: #e91e63;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(233, 30, 99, 0.1);
        }

        /* Meal Type Selector */
        .meal-type-selector {
            display: flex;
            gap: 8px;
        }

        .meal-type-option {
            padding: 12px 16px;
            border: 2px solid #fce4ec;
            border-radius: 12px;
            cursor: pointer;
            text-align: center;
            flex: 1;
            background: #fafafa;
            transition: all 0.3s ease;
            font-weight: 500;
            font-size: 14px;
        }

        .meal-type-option:hover {
            border-color: #e91e63;
            transform: translateY(-1px);
        }

        .meal-type-option.selected {
            background: linear-gradient(135deg, #e91e63, #f48fb1);
            color: #fff;
            border-color: #e91e63;
            box-shadow: 0 4px 15px rgba(233, 30, 99, 0.3);
        }

        /* Food Info */
        .food-info {
            background: #fce4ec;
            padding: 16px;
            border-radius: 12px;
            margin: 16px 0;
            border-left: 4px solid #e91e63;
        }

        .food-info h5 {
            color: #e91e63;
            margin-bottom: 8px;
            font-size: 16px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            font-size: 14px;
        }

        /* Total Calories Display */
        .total-calories {
            background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c9 100%);
            padding: 16px;
            border-radius: 12px;
            text-align: center;
            margin: 16px 0;
            border-left: 4px solid #4caf50;
        }

        .total-calories-label {
            color: #2e7d32;
            font-weight: 600;
        }

        .total-calories-value {
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
            color: #e91e63;
            border: 2px solid #e91e63;
        }

        .btn-secondary:hover {
            background: #fce4ec;
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

            .food-grid {
                grid-template-columns: 1fr;
            }

            .meal-type-selector {
                flex-direction: column;
            }

            .button-group {
                flex-direction: column;
            }

            .food-details, .info-grid {
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
            <h1><i class="fas fa-utensils"></i> Health Diary</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-home"></i> Trang chủ</a>
                <a href="${pageContext.request.contextPath}/meal-history"><i class="fas fa-chart-line"></i> Theo dõi</a>
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
            <!-- Food List Section -->
            <div class="food-list-section">
                <div class="section-header">
                    <i class="fas fa-list"></i>
                    Danh sách thực phẩm
                </div>

                <div class="food-grid" id="foodGrid">
                    <c:choose>
                        <c:when test="${not empty foodSamples}">
                            <c:forEach var="food" items="${foodSamples}">
                                <div class="food-card" 
                                     data-food-id="${food.id}"
                                     data-food-name="${food.foodName}"
                                     data-food-type="${food.type != null ? food.type : 'N/A'}"
                                     data-food-calories="${food.calories != null ? food.calories : 0}"
                                     data-food-protein="${food.protein != null ? food.protein : 0}"
                                     data-food-carbs="${food.carbs != null ? food.carbs : 0}"
                                     data-food-fat="${food.fat != null ? food.fat : 0}">
                                    <div class="calories-badge">${food.calories != null ? food.calories : 0} kcal/100g</div>
                                    <h4>${food.foodName}</h4>
                                    <div class="food-details">
                                        <span><i class="fas fa-tag"></i> ${food.type != null ? food.type : 'N/A'}</span>
                                        <span><i class="fas fa-dumbbell"></i> ${food.protein != null ? food.protein : 0}g protein</span>
                                        <span><i class="fas fa-bread-slice"></i> ${food.carbs != null ? food.carbs : 0}g carbs</span>
                                        <span><i class="fas fa-tint"></i> ${food.fat != null ? food.fat : 0}g fat</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #666;">
                                <i class="fas fa-exclamation-circle" style="font-size: 48px; margin-bottom: 16px; opacity: 0.5;"></i>
                                <p>Không có thực phẩm nào trong cơ sở dữ liệu.</p>
                                <p><small>Vui lòng liên hệ quản trị viên để thêm dữ liệu thực phẩm.</small></p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Form Section -->
            <div class="form-section">
                <div class="section-header">
                    <i class="fas fa-plus-circle"></i>
                    Ghi nhận bữa ăn
                </div>

                <form id="mealForm" method="post" action="${pageContext.request.contextPath}/meal-form">
                    <div class="form-group">
                        <label for="date">Thời gian <span class="required">*</span></label>
                        <input type="datetime-local" id="date" name="date" required 
                               value="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd'T'HH:mm" />">
                    </div>

                    <div class="form-group">
                        <label>Loại bữa ăn <span class="required">*</span></label>
                        <div class="meal-type-selector">
                            <div class="meal-type-option" data-meal-type="breakfast" onclick="selectMealType('breakfast', this)">
                                🌅 Bữa sáng
                            </div>
                            <div class="meal-type-option" data-meal-type="lunch" onclick="selectMealType('lunch', this)">
                                ☀️ Bữa trưa
                            </div>
                            <div class="meal-type-option" data-meal-type="dinner" onclick="selectMealType('dinner', this)">
                                🌙 Bữa tối
                            </div>
                            <div class="meal-type-option" data-meal-type="snack" onclick="selectMealType('snack', this)">
                                🍿 Ăn vặt
                            </div>
                        </div>
                        <input type="hidden" id="mealType" name="mealType" required>
                    </div>

                    <div class="form-group">
                        <label>Chọn thực phẩm <span class="required">*</span></label>
                        <div class="food-info" id="selectedFoodInfo" style="display: none;">
                            <h5 id="selectedFoodName"></h5>
                            <div class="info-grid">
                                <span><i class="fas fa-tag"></i> <span id="selectedFoodType"></span></span>
                                <span><i class="fas fa-fire"></i> <span id="selectedFoodCalories"></span> kcal/100g</span>
                                <span><i class="fas fa-dumbbell"></i> <span id="selectedFoodProtein"></span>g protein</span>
                                <span><i class="fas fa-bread-slice"></i> <span id="selectedFoodCarbs"></span>g carbs</span>
                                <span><i class="fas fa-tint"></i> <span id="selectedFoodFat"></span>g fat</span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Số lượng (g)</label>
                        <input type="number" name="quantity" value="100" min="1" step="1" 
                               oninput="calculateTotalCalories()" required>
                    </div>

                    <div class="total-calories" id="totalCaloriesDisplay" style="display: none;">
                        <div class="total-calories-label">🔥 Tổng calorie:</div>
                        <div class="total-calories-value" id="totalCaloriesValue">0 kcal</div>
                        <input type="hidden" id="totalCalories" name="totalCalories" value="0">
                    </div>

                    <div class="form-group">
                        <label for="notes">Ghi chú</label>
                        <textarea id="notes" name="notes" placeholder="Mô tả chi tiết về bữa ăn..." rows="3">${param.notes}</textarea>
                    </div>

                    <!-- Hidden inputs for food data -->
                    <input type="hidden" name="foodName" id="hiddenFoodName">
                    <input type="hidden" name="foodCalories" id="hiddenFoodCalories">
                    <input type="hidden" name="foodQuantity" id="hiddenFoodQuantity">
                    <input type="hidden" name="foodUnit" value="g">

                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Lưu bữa ăn
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
        let selectedFood = null;
        let selectedMealType = null;
        
        // Khởi tạo trang
        document.addEventListener('DOMContentLoaded', function() {
            // Thiết lập ngày giờ hiện tại nếu chưa có giá trị
            if (!document.getElementById('date').value) {
                const now = new Date();
                const localDateTime = now.toISOString().slice(0, 16);
                document.getElementById('date').value = localDateTime;
            }
            
            // Thêm sự kiện click cho các thẻ thực phẩm
            document.querySelectorAll('.food-card').forEach(card => {
                card.addEventListener('click', function() {
                    const foodId = this.dataset.foodId;
                    const foodName = this.dataset.foodName;
                    const foodType = this.dataset.foodType;
                    const calories = this.dataset.foodCalories;
                    const protein = this.dataset.foodProtein;
                    const carbs = this.dataset.foodCarbs;
                    const fat = this.dataset.foodFat;
                    
                    selectFood(foodId, foodName, foodType, calories, protein, carbs, fat);
                });
            });
            
            // Khôi phục trạng thái form nếu có
            <c:if test="${not empty param.mealType}">
                selectMealType('${param.mealType}');
            </c:if>
        });
        
        // Chọn thực phẩm
        function selectFood(id, name, type, calories, protein, carbs, fat) {
            // Bỏ chọn tất cả các thẻ thực phẩm
            document.querySelectorAll('.food-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            // Chọn thẻ thực phẩm hiện tại
            const selectedCard = document.querySelector(`.food-card[data-food-id="${id}"]`);
            if (selectedCard) {
                selectedCard.classList.add('selected');
            }
            
            selectedFood = { id, name, type, calories, protein, carbs, fat };
            
            // Cập nhật form với thông tin thực phẩm
            document.getElementById('selectedFoodName').textContent = name;
            document.getElementById('selectedFoodType').textContent = type;
            document.getElementById('selectedFoodCalories').textContent = calories;
            document.getElementById('selectedFoodProtein').textContent = protein + 'g';
            document.getElementById('selectedFoodCarbs').textContent = carbs + 'g';
            document.getElementById('selectedFoodFat').textContent = fat + 'g';
            
            // Cập nhật hidden fields cho meal_item
            document.getElementById('hiddenFoodName').value = name;
            document.getElementById('hiddenFoodCalories').value = calories;
            
            // Cập nhật quantity từ input
            const quantityInput = document.querySelector('input[name="quantity"]');
            document.getElementById('hiddenFoodQuantity').value = quantityInput ? quantityInput.value : '100';
            
            // Hiển thị thông tin thực phẩm
            document.getElementById('selectedFoodInfo').style.display = 'block';
            
            // Tính toán calories ngay lập tức
            calculateTotalCalories();
        }
        
        // Chọn loại bữa ăn
        function selectMealType(mealType, element) {
            // Bỏ chọn tất cả các tùy chọn loại bữa ăn
            document.querySelectorAll('.meal-type-option').forEach(option => {
                option.classList.remove('selected');
            });
            
            // Chọn tùy chọn loại bữa ăn hiện tại
            if (element) {
                element.classList.add('selected');
            } else {
                // Tìm phần tử tương ứng với loại bữa ăn
                const mealTypeElement = document.querySelector(`.meal-type-option[data-meal-type="${mealType}"]`);
                if (mealTypeElement) {
                    mealTypeElement.classList.add('selected');
                }
            }
            
            selectedMealType = mealType;
            document.getElementById('mealType').value = mealType;
        }
        
        // Tính tổng calories
        function calculateTotalCalories() {
            const quantityInput = document.querySelector('input[name="quantity"]');
            const caloriesInput = document.getElementById('selectedFoodCalories');
            
            const quantity = quantityInput ? parseFloat(quantityInput.value) || 0 : 0;
            const calories = caloriesInput ? parseFloat(caloriesInput.textContent) || 0 : 0;
            
            // Cập nhật hidden quantity field
            if (selectedFood) {
                document.getElementById('hiddenFoodQuantity').value = quantity;
            }
            
            // Tính calories theo tỷ lệ (quantity/100g * calories)
            const totalCalories = (quantity / 100) * calories;
            
            // Hiển thị kết quả
            document.getElementById('totalCaloriesValue').textContent = Math.round(totalCalories) + ' kcal';
            document.getElementById('totalCalories').value = Math.round(totalCalories);
            
            if (totalCalories > 0) {
                document.getElementById('totalCaloriesDisplay').style.display = 'block';
            } else {
                document.getElementById('totalCaloriesDisplay').style.display = 'none';
            }
        }
        
        // Đặt lại form
        function resetForm() {
            selectedFood = null;
            selectedMealType = null;
            
            document.querySelectorAll('.food-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            document.querySelectorAll('.meal-type-option').forEach(option => {
                option.classList.remove('selected');
            });
            
            document.getElementById('selectedFoodInfo').style.display = 'none';
            document.getElementById('totalCaloriesDisplay').style.display = 'none';
            document.getElementById('mealType').value = '';
            
            // Thiết lập lại ngày giờ hiện tại
            const now = new Date();
            const localDateTime = now.toISOString().slice(0, 16);
            document.getElementById('date').value = localDateTime;
        }
        
        // Xử lý gửi form
        document.getElementById('mealForm').addEventListener('submit', function(event) {
            // Đảm bảo hidden fields được cập nhật trước khi submit
            if (selectedFood) {
                document.getElementById('hiddenFoodName').value = selectedFood.name;
                document.getElementById('hiddenFoodCalories').value = selectedFood.calories;
                const quantityInput = document.querySelector('input[name="quantity"]');
                document.getElementById('hiddenFoodQuantity').value = quantityInput ? quantityInput.value : '100';
            }
            
            // Debug: Log form data before submission
            const formData = new FormData(this);
            console.log('Form data being submitted:');
            for (let [key, value] of formData.entries()) {
                console.log(key + ': ' + value);
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