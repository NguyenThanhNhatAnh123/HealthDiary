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
            background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 50%, #fecfef 100%);
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
            box-shadow: 0 2px 20px rgba(255, 154, 158, 0.1);
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

        .breadcrumb .separator {
            color: #f48fb1;
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
            box-shadow: 0 8px 32px rgba(233, 30, 99, 0.12);
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
            background: linear-gradient(90deg, #e91e63, #f48fb1, #e91e63);
        }

        /* Section Headers */
        .section-header {
            color: #e91e63;
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
            background: #fce4ec;
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

        /* Form Controls */
        input[type="datetime-local"], 
        input[type="number"], 
        input[type="text"], 
        select, 
        textarea {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #fce4ec;
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
            border-color: #e91e63;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(233, 30, 99, 0.1);
            transform: translateY(-1px);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        select {
            cursor: pointer;
        }

        /* Meal Type Selector */
        .meal-type-selector {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 15px;
            margin: 15px 0;
        }

        .meal-type-option {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px 15px;
            border: 2px solid #fce4ec;
            border-radius: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
            text-align: center;
        }

        .meal-type-option:hover {
            border-color: #e91e63;
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(233, 30, 99, 0.2);
        }

        .meal-type-option.selected {
            border-color: #e91e63;
            background: #fce4ec;
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(233, 30, 99, 0.3);
        }

        .meal-emoji {
            font-size: 32px;
            margin-bottom: 8px;
        }

        .meal-type-option div:last-child {
            font-weight: 600;
            color: #424242;
            font-size: 14px;
        }

        /* Food Items */
        .food-items-container {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
            border: 2px solid #fce4ec;
        }

        .food-item {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 2px 8px rgba(233, 30, 99, 0.1);
            border-left: 4px solid #e91e63;
            transition: all 0.3s ease;
        }

        .food-item:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 16px rgba(233, 30, 99, 0.15);
        }

        .food-item:last-child {
            margin-bottom: 0;
        }

        .food-item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .food-item-title {
            font-weight: 600;
            color: #e91e63;
            font-size: 16px;
        }

        .remove-food-btn {
            background: linear-gradient(135deg, #f44336, #e57373);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .remove-food-btn:hover {
            background: linear-gradient(135deg, #d32f2f, #f44336);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
        }

        .food-input-group {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 15px;
            align-items: end;
        }

        .food-input-group input,
        .food-input-group select {
            margin-bottom: 0;
        }

        .food-input-group label {
            font-size: 12px;
            margin-bottom: 5px;
            color: #666;
            font-weight: 500;
        }

        /* Total Calories Display */
        .total-calories {
            background: linear-gradient(135deg, #fce4ec, #f8bbd9);
            padding: 25px;
            border-radius: 16px;
            margin: 25px 0;
            text-align: center;
            border: 2px solid #f48fb1;
            box-shadow: 0 4px 16px rgba(233, 30, 99, 0.1);
        }

        .total-calories-label {
            color: #e91e63;
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 8px;
        }

        .total-calories-value {
            font-size: 32px;
            font-weight: 700;
            color: #e91e63;
            text-shadow: 1px 1px 2px rgba(233, 30, 99, 0.1);
        }

        /* Buttons */
        .button-group {
            display: flex;
            gap: 16px;
            justify-content: center;
            margin-top: 40px;
            padding-top: 24px;
            border-top: 1px solid #fce4ec;
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
            background: linear-gradient(135deg, #e91e63, #f48fb1);
            color: #fff;
            box-shadow: 0 4px 15px rgba(233, 30, 99, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(233, 30, 99, 0.4);
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

        .btn-add {
            background: linear-gradient(135deg, #4caf50, #66bb6a);
            color: white;
            padding: 12px 24px;
            font-size: 14px;
            margin: 15px 0;
            width: 100%;
        }

        .btn-add:hover {
            background: linear-gradient(135deg, #388e3c, #4caf50);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
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

        /* Empty state */
        .empty-food-state {
            text-align: center;
            padding: 40px 20px;
            color: #666;
        }

        .empty-food-state i {
            font-size: 48px;
            color: #f48fb1;
            margin-bottom: 16px;
        }

        /* Food suggestions */
        .food-suggestions {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 2px solid #fce4ec;
            border-top: none;
            border-radius: 0 0 8px 8px;
            max-height: 200px;
            overflow-y: auto;
            z-index: 1000;
            display: none;
        }

        .food-suggestion {
            padding: 12px 15px;
            cursor: pointer;
            border-bottom: 1px solid #fce4ec;
            transition: all 0.3s ease;
        }

        .food-suggestion:hover {
            background: #fce4ec;
        }

        .food-suggestion:last-child {
            border-bottom: none;
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

            .meal-type-selector {
                grid-template-columns: repeat(2, 1fr);
            }

            .food-input-group {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        /* Loading animation */
        .btn-primary:active {
            transform: translateY(0);
        }

        /* Hover effects */
        .form-group:hover label {
            color: #c2185b;
        }

        .form-group:focus-within label {
            color: #c2185b;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-utensils"></i> Ghi nhận bữa ăn</h1>
            <div class="breadcrumb">
                <a href="dashboard">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <span class="separator">•</span>
                <a href="calorie-tracking">
                    <i class="fas fa-chart-line"></i> Theo dõi Calorie
                </a>
                <span class="separator">•</span>
                <span style="color: #666;">Ghi nhận bữa ăn</span>
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

            <!-- Meal Form -->
            <form action="meal" method="post" id="mealForm">
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

                <div class="form-group">
                    <label>Loại bữa ăn <span class="required">*</span></label>
                    <div class="meal-type-selector">
                        <div class="meal-type-option" onclick="selectMealType('breakfast')" tabindex="0">
                            <div class="meal-emoji">🌅</div>
                            <div>Bữa sáng</div>
                        </div>
                        <div class="meal-type-option" onclick="selectMealType('lunch')" tabindex="0">
                            <div class="meal-emoji">☀️</div>
                            <div>Bữa trưa</div>
                        </div>
                        <div class="meal-type-option" onclick="selectMealType('dinner')" tabindex="0">
                            <div class="meal-emoji">🌙</div>
                            <div>Bữa tối</div>
                        </div>
                        <div class="meal-type-option" onclick="selectMealType('snack')" tabindex="0">
                            <div class="meal-emoji">🍿</div>
                            <div>Ăn vặt</div>
                        </div>
                    </div>
                    <input type="hidden" id="mealType" name="mealType" value="" required>
                </div>

                <!-- Food Items Section -->
                <div class="section-header">
                    <i class="fas fa-apple-alt"></i>
                    Thực phẩm
                </div>

                <div class="form-group">
                    <div class="food-items-container" id="foodItemsContainer">
                        <div class="empty-food-state" id="emptyFoodState">
                            <i class="fas fa-utensils"></i>
                            <div>Chưa có thực phẩm nào được thêm</div>
                            <div style="font-size: 14px; margin-top: 8px;">Nhấn nút "Thêm thực phẩm" để bắt đầu</div>
                        </div>
                    </div>
                    <button type="button" class="btn btn-add" onclick="addFoodItem()">
                        <i class="fas fa-plus"></i>
                        Thêm thực phẩm
                    </button>
                </div>

                <div class="total-calories" id="totalCaloriesDisplay" style="display: none;">
                    <div class="total-calories-label">
                        <i class="fas fa-fire"></i> Tổng calorie
                    </div>
                    <div class="total-calories-value" id="totalCaloriesValue">0 kcal</div>
                </div>

                <!-- Additional Information -->
                <div class="section-header">
                    <i class="fas fa-sticky-note"></i>
                    Thông tin bổ sung
                </div>

                <div class="form-group">
                    <label for="notes">Ghi chú</label>
                    <textarea id="notes" name="notes" placeholder="Mô tả chi tiết về bữa ăn, cảm nhận, địa điểm..."></textarea>
                </div>

                <!-- Buttons -->
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Lưu bữa ăn
                    </button>
                    <a href="calorie-tracking" class="btn btn-secondary">
                        <i class="fas fa-chart-line"></i>
                        Xem theo dõi
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
        let foodItemCount = 0;
        
        // Food samples from admin database
        const foodSamples = [
            <c:forEach var="food" items="${foodSamples}" varStatus="status">
                { 
                    name: '${fn:escapeXml(food.foodName)}', 
                    calories: ${food.calories}, 
                    unit: 'g',
                    protein: ${food.protein},
                    carbs: ${food.carbs},
                    fat: ${food.fat}
                }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        // Fallback food samples if none from database
        if (foodSamples.length === 0) {
            foodSamples.push(
                { name: 'Cơm trắng', calories: 130, unit: 'g', protein: 2.7, carbs: 28, fat: 0.3 },
                { name: 'Phở bò', calories: 350, unit: 'tô', protein: 25, carbs: 45, fat: 8 },
                { name: 'Bánh mì', calories: 250, unit: 'ổ', protein: 8, carbs: 45, fat: 3 },
                { name: 'Trứng gà', calories: 70, unit: 'quả', protein: 6, carbs: 1, fat: 5 },
                { name: 'Chuối', calories: 90, unit: 'quả', protein: 1, carbs: 23, fat: 0.3 },
                { name: 'Táo', calories: 80, unit: 'quả', protein: 0.5, carbs: 21, fat: 0.3 },
                { name: 'Sữa tươi', calories: 60, unit: 'ml', protein: 3, carbs: 5, fat: 3 },
                { name: 'Thịt heo', calories: 250, unit: 'g', protein: 26, carbs: 0, fat: 15 },
                { name: 'Thịt gà', calories: 165, unit: 'g', protein: 31, carbs: 0, fat: 3.6 },
                { name: 'Cá thu', calories: 150, unit: 'g', protein: 25, carbs: 0, fat: 5 }
            );
        }

        function selectMealType(mealType) {
            // Remove selected class from all options
            document.querySelectorAll('.meal-type-option').forEach(option => {
                option.classList.remove('selected');
            });
            
            // Add selected class to clicked option
            event.currentTarget.classList.add('selected');
            
            // Set hidden input value
            document.getElementById('mealType').value = mealType;
        }
        
        function addFoodItem() {
            foodItemCount++;
            const container = document.getElementById('foodItemsContainer');
            const emptyState = document.getElementById('emptyFoodState');
            
            if (emptyState) {
                emptyState.style.display = 'none';
            }
            
            const foodItem = document.createElement('div');
            foodItem.className = 'food-item';
            foodItem.id = `foodItem${foodItemCount}`;
            
            foodItem.innerHTML = `
                <div class="food-item-header">
                    <div class="food-item-title">Thực phẩm ${foodItemCount}</div>
                    <button type="button" class="remove-food-btn" onclick="removeFoodItem(${foodItemCount})">
                        <i class="fas fa-trash"></i> Xóa
                    </button>
                </div>
                <div class="food-input-group">
                    <div>
                        <label>Tên thực phẩm</label>
                        <div style="position: relative;">
                            <input type="text" name="foodName" placeholder="Nhập tên thực phẩm" 
                                   onkeyup="showFoodSuggestions(this, ${foodItemCount})" required>
                            <div class="food-suggestions" id="suggestions_${foodItemCount}"></div>
                        </div>
                    </div>
                    <div>
                        <label>Số lượng</label>
                        <input type="number" name="foodQuantity" min="0" step="0.1" 
                               placeholder="Số lượng" onchange="calculateTotalCalories()" required>
                    </div>
                    <div>
                        <label>Đơn vị</label>
                        <select name="foodUnit" required>
                            <option value="">Chọn đơn vị</option>
                            <option value="g">gram (g)</option>
                            <option value="kg">kilogram (kg)</option>
                            <option value="ml">mililít (ml)</option>
                            <option value="l">lít (l)</option>
                            <option value="quả">quả</option>
                            <option value="tô">tô</option>
                            <option value="chén">chén</option>
                            <option value="muỗng">muỗng</option>
                            <option value="lát">lát</option>
                            <option value="miếng">miếng</option>
                            <option value="ổ">ổ</option>
                            <option value="lon">lon</option>
                        </select>
                    </div>
                    <div>
                        <label>Calories (kcal)</label>
                        <input type="number" name="foodCalories" min="0" 
                               placeholder="Calories" onchange="calculateTotalCalories()" required>
                    </div>
                </div>
            `;
            
            container.appendChild(foodItem);
            calculateTotalCalories();
        }
        
        function removeFoodItem(itemId) {
            const item = document.getElementById(`foodItem${itemId}`);
            if (item) {
                item.remove();
                calculateTotalCalories();
                
                // Show empty state if no food items
                const container = document.getElementById('foodItemsContainer');
                const foodItems = container.querySelectorAll('.food-item');
                if (foodItems.length === 0) {
                    document.getElementById('emptyFoodState').style.display = 'block';
                }
            }
        }
        
        function showFoodSuggestions(input, itemId) {
            const query = input.value.toLowerCase();
            const suggestionsDiv = document.getElementById(`suggestions_${itemId}`);
            
            if (query.length < 2) {
                suggestionsDiv.style.display = 'none';
                return;
            }
            
            const filteredFoods = foodSamples.filter(food => 
                food.name.toLowerCase().includes(query)
            );
            
            if (filteredFoods.length === 0) {
                suggestionsDiv.style.display = 'none';
                return;
            }
            
            suggestionsDiv.innerHTML = filteredFoods.map(food => `
                <div class="food-suggestion" onclick="selectFoodSuggestion('${food.name}', ${food.calories}, '${food.unit}', ${itemId})">
                    ${food.name} - ${food.calories} kcal/${food.unit}
                </div>
            `).join('');
            
            suggestionsDiv.style.display = 'block';
        }
        
        function selectFoodSuggestion(name, calories, unit, itemId) {
            const foodItem = document.getElementById(`foodItem${itemId}`);
            foodItem.querySelector('input[name="foodName"]').value = name;
            foodItem.querySelector('input[name="foodCalories"]').value = calories;
            foodItem.querySelector('select[name="foodUnit"]').value = unit;
            foodItem.querySelector('input[name="foodQuantity"]').value = 1;
            
            document.getElementById(`suggestions_${itemId}`).style.display = 'none';
            calculateTotalCalories();
        }
        
        function calculateTotalCalories() {
            let totalCalories = 0;
            const foodItems = document.querySelectorAll('.food-item');
            
            foodItems.forEach(item => {
                const quantity = parseFloat(item.querySelector('input[name="foodQuantity"]').value) || 0;
                const calories = parseFloat(item.querySelector('input[name="foodCalories"]').value) || 0;
                totalCalories += quantity * calories;
            });
            
            const totalDisplay = document.getElementById('totalCaloriesDisplay');
            const totalValue = document.getElementById('totalCaloriesValue');
            
            if (totalCalories > 0) {
                totalDisplay.style.display = 'block';
                totalValue.textContent = Math.round(totalCalories) + ' kcal';
            } else {
                totalDisplay.style.display = 'none';
            }
        }
        
        // Add keyboard support for meal type options
        document.querySelectorAll('.meal-type-option').forEach(option => {
            option.addEventListener('keypress', function(e) {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    this.click();
                }
            });
        });
        
        // Form validation
        document.getElementById('mealForm').addEventListener('submit', function(e) {
            const mealType = document.getElementById('mealType').value;
            const foodItems = document.querySelectorAll('.food-item');
            
            if (!mealType) {
                e.preventDefault();
                alert('Vui lòng chọn loại bữa ăn');
                return false;
            }
            
            if (foodItems.length === 0) {
                e.preventDefault();
                alert('Vui lòng thêm ít nhất một thực phẩm');
                return false;
            }
            
            // Validate each food item
            let isValid = true;
            foodItems.forEach(item => {
                const foodName = item.querySelector('input[name="foodName"]').value;
                const quantity = item.querySelector('input[name="foodQuantity"]').value;
                const unit = item.querySelector('select[name="foodUnit"]').value;
                const calories = item.querySelector('input[name="foodCalories"]').value;
                
                if (!foodName || !quantity || !unit || !calories) {
                    isValid = false;
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin cho tất cả các thực phẩm');
                return false;
            }
            
            return true;
        });
        
        // Close suggestions when clicking outside
        document.addEventListener('click', function(e) {
            if (!e.target.closest('.food-suggestions') && !e.target.matches('input[name="foodName"]')) {
                document.querySelectorAll('.food-suggestions').forEach(suggestion => {
                    suggestion.style.display = 'none';
                });
            }
        });
        
        // Check if user is logged in
        <c:if test="${empty user}">
            window.location.href = 'login';
        </c:if>
        
        // Add first food item automatically if empty
        window.onload = function() {
            const container = document.getElementById('foodItemsContainer');
            const foodItems = container.querySelectorAll('.food-item');
            
            if (foodItems.length === 0) {
                addFoodItem();
            }
        };
    </script>
</body>
</html>