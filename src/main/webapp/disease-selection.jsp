<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tình trạng sức khỏe - Health Diary</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2563eb;
            --primary-hover: #1d4ed8;
            --secondary-color: #64748b;
            --success-color: #10b981;
            --danger-color: #ef4444;
            --warning-color: #f59e0b;
            --background-light: #f8fafc;
            --background-gradient: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 50%, #e0e7ff 100%);
            --white: #ffffff;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
            --border-radius: 12px;
            --border-radius-lg: 16px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: var(--background-gradient);
            min-height: 100vh;
            color: var(--gray-800);
            line-height: 1.6;
        }

        /* Navigation */
        .navbar {
            background: var(--white);
            backdrop-filter: blur(20px);
            padding: 1rem 0;
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-brand {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
            transition: var(--transition);
        }

        .nav-brand i {
            margin-right: 0.5rem;
            font-size: 1.75rem;
        }

        .nav-brand:hover {
            transform: translateY(-1px);
        }

        .nav-menu {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .nav-menu a {
            color: var(--gray-600);
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius);
            transition: var(--transition);
            position: relative;
        }

        .nav-menu a:hover {
            color: var(--primary-color);
            background: var(--gray-50);
        }

        .nav-menu a.active {
            color: var(--primary-color);
            background: var(--gray-50);
        }

        /* Main Container */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .page-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--gray-800);
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, var(--primary-color), #7c3aed);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .page-subtitle {
            font-size: 1.125rem;
            color: var(--gray-600);
            max-width: 600px;
            margin: 0 auto;
        }

        /* Alert Messages */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
            border: 1px solid transparent;
        }

        .alert i {
            font-size: 1.25rem;
        }

        .alert-success {
            background: #ecfdf5;
            color: #065f46;
            border-color: #a7f3d0;
        }

        .alert-danger {
            background: #fef2f2;
            color: #991b1b;
            border-color: #fecaca;
        }

        /* Current Diseases Section */
        .current-diseases {
            background: var(--white);
            border-radius: var(--border-radius-lg);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
        }

        .current-diseases h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--gray-800);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .disease-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
        }

        .disease-tag {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
            color: var(--white);
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .disease-tag:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
        }

        .remove-disease {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: var(--white);
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
            font-size: 0.875rem;
        }

        .remove-disease:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.1);
        }

        /* Form Container */
        .form-container {
            background: var(--white);
            border-radius: var(--border-radius-lg);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
        }

        .form-header {
            margin-bottom: 2rem;
        }

        .form-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--gray-800);
            margin-bottom: 0.5rem;
        }

        .form-description {
            color: var(--gray-600);
            font-size: 1rem;
        }

        /* Disease Categories */
        .disease-category {
            margin-bottom: 2rem;
            background: var(--gray-50);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            border: 1px solid var(--gray-200);
        }

        .category-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1.25rem;
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--gray-800);
        }

        .category-icon {
            font-size: 1.5rem;
            width: 40px;
            height: 40px;
            background: var(--white);
            border-radius: var(--border-radius);
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--shadow-sm);
        }

        /* Disease Items */
        .disease-grid {
            display: grid;
            gap: 1rem;
        }

        .disease-item {
            background: var(--white);
            border: 2px solid var(--gray-200);
            border-radius: var(--border-radius);
            padding: 1.25rem;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: flex-start;
            gap: 1rem;
        }

        .disease-item:hover {
            border-color: var(--primary-color);
            box-shadow: var(--shadow-md);
            transform: translateY(-2px);
        }

        .disease-item.selected {
            border-color: var(--primary-color);
            background: #eff6ff;
        }

        .disease-checkbox {
            margin-top: 0.125rem;
            width: 20px;
            height: 20px;
            accent-color: var(--primary-color);
            cursor: pointer;
        }

        .disease-info {
            flex: 1;
        }

        .disease-name {
            font-weight: 600;
            color: var(--gray-800);
            margin-bottom: 0.25rem;
            font-size: 1rem;
        }

        .disease-description {
            color: var(--gray-600);
            font-size: 0.875rem;
            line-height: 1.4;
        }

        /* Buttons */
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            border: none;
            outline: none;
        }

        .btn-primary {
            background: var(--primary-color);
            color: var(--white);
            box-shadow: var(--shadow-sm);
            width: 100%;
            padding: 1rem 2rem;
            font-size: 1.125rem;
            margin: 2rem 0;
        }

        .btn-primary:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background: var(--gray-100);
            color: var(--gray-700);
            border: 1px solid var(--gray-300);
        }

        .btn-secondary:hover {
            background: var(--gray-200);
            transform: translateY(-1px);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        /* Loading State */
        .loading {
            position: relative;
            pointer-events: none;
        }

        .loading::after {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid transparent;
            border-top: 2px solid var(--white);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                gap: 1rem;
                padding: 0 1rem;
            }

            .nav-menu {
                gap: 1rem;
                flex-wrap: wrap;
                justify-content: center;
            }

            .main-content {
                padding: 1rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .current-diseases,
            .form-container {
                padding: 1.5rem;
            }

            .disease-category {
                padding: 1rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            .disease-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .disease-checkbox {
                margin-top: 0;
            }
        }

        /* Animations */
        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .slide-up {
            animation: slideUp 0.4s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="dashboard" class="nav-brand">
                <i class="fas fa-heart-pulse"></i>
                Health Diary
            </a>
            <div class="nav-menu">
                <a href="dashboard"><i class="fas fa-home"></i> Trang chủ</a>
                <a href="disease-management" class="active"><i class="fas fa-stethoscope"></i> Tình trạng sức khỏe</a>
                <a href="profile"><i class="fas fa-user"></i> Hồ sơ</a>
                <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Page Header -->
        <header class="page-header fade-in">
            <h1 class="page-title">Quản lý tình trạng sức khỏe</h1>
            <p class="page-subtitle">
                Cập nhật và theo dõi tình trạng sức khỏe của bạn để nhận được lời khuyên phù hợp nhất
            </p>
        </header>

        <!-- Alert Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger fade-in">
                <i class="fas fa-exclamation-circle"></i>
                ${error}
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success fade-in">
                <i class="fas fa-check-circle"></i>
                ${success}
            </div>
        </c:if>

        <!-- Current Diseases -->
        <c:if test="${not empty userDiseases}">
            <section class="current-diseases slide-up">
                <h3>
                    <i class="fas fa-clipboard-list"></i>
                    Tình trạng hiện tại
                </h3>
                <div class="disease-tags">
                    <c:forEach items="${userDiseases}" var="disease">
                        <span class="disease-tag">
                            ${disease.name}
                            <button type="button" class="remove-disease" 
                                    onclick="removeDisease('${disease.id}')" 
                                    title="Xóa tình trạng này">
                                <i class="fas fa-times"></i>
                            </button>
                        </span>
                    </c:forEach>
                </div>
            </section>
        </c:if>

        <!-- Disease Selection Form -->
        <section class="form-container slide-up">
            <div class="form-header">
                <h2 class="form-title">Chọn tình trạng sức khỏe</h2>
                <p class="form-description">
                    Vui lòng chọn các tình trạng sức khỏe mà bạn đang gặp phải để hệ thống có thể đưa ra những gợi ý và lời khuyên phù hợp nhất.
                </p>
            </div>

            <form action="disease-management" method="post" id="diseaseForm">
                <!-- Cardiovascular Diseases -->
                <div class="disease-category">
                    <div class="category-header">
                        <div class="category-icon">
                            <i class="fas fa-heartbeat" style="color: #ef4444;"></i>
                        </div>
                        Bệnh tim mạch
                    </div>
                    <div class="disease-grid">
                        <label class="disease-item" for="hypertension">
                            <input type="checkbox" id="hypertension" name="diseases" value="hypertension" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Cao huyết áp</div>
                                <div class="disease-description">Huyết áp cao hơn mức bình thường (≥140/90 mmHg)</div>
                            </div>
                        </label>
                        <label class="disease-item" for="diabetes">
                            <input type="checkbox" id="diabetes" name="diseases" value="diabetes" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Tiểu đường</div>
                                <div class="disease-description">Rối loạn chuyển hóa glucose, đường huyết cao</div>
                            </div>
                        </label>
                        <label class="disease-item" for="heart_disease">
                            <input type="checkbox" id="heart_disease" name="diseases" value="heart_disease" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Bệnh tim</div>
                                <div class="disease-description">Các vấn đề về tim mạch, bệnh mạch vành</div>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- Respiratory Diseases -->
                <div class="disease-category">
                    <div class="category-header">
                        <div class="category-icon">
                            <i class="fas fa-lungs" style="color: #06b6d4;"></i>
                        </div>
                        Bệnh hô hấp
                    </div>
                    <div class="disease-grid">
                        <label class="disease-item" for="asthma">
                            <input type="checkbox" id="asthma" name="diseases" value="asthma" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Hen suyễn</div>
                                <div class="disease-description">Viêm đường hô hấp mãn tính, khó thở</div>
                            </div>
                        </label>
                        <label class="disease-item" for="copd">
                            <input type="checkbox" id="copd" name="diseases" value="copd" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Bệnh phổi tắc nghẽn mãn tính (COPD)</div>
                                <div class="disease-description">Tắc nghẽn luồng khí thở, ho mãn tính</div>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- Digestive Diseases -->
                <div class="disease-category">
                    <div class="category-header">
                        <div class="category-icon">
                            <i class="fas fa-stomach" style="color: #f59e0b;"></i>
                        </div>
                        Bệnh tiêu hóa
                    </div>
                    <div class="disease-grid">
                        <label class="disease-item" for="gastritis">
                            <input type="checkbox" id="gastritis" name="diseases" value="gastritis" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Viêm dạ dày</div>
                                <div class="disease-description">Viêm niêm mạc dạ dày, đau bụng trên</div>
                            </div>
                        </label>
                        <label class="disease-item" for="ulcer">
                            <input type="checkbox" id="ulcer" name="diseases" value="ulcer" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Loét dạ dày</div>
                                <div class="disease-description">Tổn thương niêm mạc dạ dày hoặc tá tràng</div>
                            </div>
                        </label>
                        <label class="disease-item" for="ibs">
                            <input type="checkbox" id="ibs" name="diseases" value="ibs" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Hội chứng ruột kích thích</div>
                                <div class="disease-description">Rối loạn chức năng ruột, đau bụng, tiêu chảy</div>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- Musculoskeletal Diseases -->
                <div class="disease-category">
                    <div class="category-header">
                        <div class="category-icon">
                            <i class="fas fa-bone" style="color: #8b5cf6;"></i>
                        </div>
                        Bệnh cơ xương khớp
                    </div>
                    <div class="disease-grid">
                        <label class="disease-item" for="arthritis">
                            <input type="checkbox" id="arthritis" name="diseases" value="arthritis" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Viêm khớp</div>
                                <div class="disease-description">Viêm các khớp xương, đau và cứng khớp</div>
                            </div>
                        </label>
                        <label class="disease-item" for="osteoporosis">
                            <input type="checkbox" id="osteoporosis" name="diseases" value="osteoporosis" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Loãng xương</div>
                                <div class="disease-description">Giảm mật độ xương, dễ gãy xương</div>
                            </div>
                        </label>
                        <label class="disease-item" for="back_pain">
                            <input type="checkbox" id="back_pain" name="diseases" value="back_pain" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Đau lưng</div>
                                <div class="disease-description">Đau vùng lưng, có thể lan xuống chân</div>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- Mental Health -->
                <div class="disease-category">
                    <div class="category-header">
                        <div class="category-icon">
                            <i class="fas fa-brain" style="color: #10b981;"></i>
                        </div>
                        Sức khỏe tâm thần
                    </div>
                    <div class="disease-grid">
                        <label class="disease-item" for="anxiety">
                            <input type="checkbox" id="anxiety" name="diseases" value="anxiety" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Lo âu</div>
                                <div class="disease-description">Cảm giác lo lắng, căng thẳng quá mức</div>
                            </div>
                        </label>
                        <label class="disease-item" for="depression">
                            <input type="checkbox" id="depression" name="diseases" value="depression" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Trầm cảm</div>
                                <div class="disease-description">Rối loạn tâm trạng, buồn chán kéo dài</div>
                            </div>
                        </label>
                        <label class="disease-item" for="insomnia">
                            <input type="checkbox" id="insomnia" name="diseases" value="insomnia" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Mất ngủ</div>
                                <div class="disease-description">Khó ngủ, ngủ không ngon hoặc thức giấc sớm</div>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- Other Conditions -->
                <div class="disease-category">
                    <div class="category-header">
                        <div class="category-icon">
                            <i class="fas fa-plus-circle" style="color: #64748b;"></i>
                        </div>
                        Tình trạng khác
                    </div>
                    <div class="disease-grid">
                        <label class="disease-item" for="obesity">
                            <input type="checkbox" id="obesity" name="diseases" value="obesity" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Béo phì</div>
                                <div class="disease-description">Thừa cân nghiêm trọng, BMI ≥ 30</div>
                            </div>
                        </label>
                        <label class="disease-item" for="allergies">
                            <input type="checkbox" id="allergies" name="diseases" value="allergies" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Dị ứng</div>
                                <div class="disease-description">Phản ứng quá mẫn với các chất gây dị ứng</div>
                            </div>
                        </label>
                        <label class="disease-item" for="thyroid">
                            <input type="checkbox" id="thyroid" name="diseases" value="thyroid" class="disease-checkbox">
                            <div class="disease-info">
                                <div class="disease-name">Bệnh tuyến giáp</div>
                                <div class="disease-description">Rối loạn chức năng tuyến giáp (cường/suy giáp)</div>
                            </div>
                        </label>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary" id="submitBtn">
                    <i class="fas fa-save"></i>
                    Lưu tình trạng sức khỏe
                </button>
            </form>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="dashboard" class="btn btn-secondary">
                    <i class="fas fa-home"></i>
                    Về trang chủ
                </a>
                <a href="profile" class="btn btn-secondary">
                    <i class="fas fa-user-edit"></i>
                    Cập nhật hồ sơ
                </a>
            </div>
        </section>
    </main>

    <script>
        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            // Check if user is logged in
            <c:if test="${empty user}">
            window.location.href = "login";
            </c:if>

            // Mark checked diseases from user's current conditions
            <c:if test="${not empty userDiseases}">
                <c:forEach items="${userDiseases}" var="disease">
                    const checkbox = document.getElementById('${disease.id}');
                    if (checkbox) {
                        checkbox.checked = true;
                        checkbox.parentElement.classList.add('selected');
                    }
                </c:forEach>
            </c:if>

            // Add event listeners for disease items
            document.querySelectorAll('.disease-item').forEach(item => {
                item.addEventListener('click', function(e) {
                    if (e.target.tagName !== 'INPUT') {
                        const checkbox = this.querySelector('.disease-checkbox');
                        checkbox.checked = !checkbox.checked;
                        this.classList.toggle('selected', checkbox.checked);
                    }
                });
            });
        });

        // Function to remove a disease
        function removeDisease(diseaseId) {
            if (confirm('Bạn có chắc chắn muốn xóa tình trạng này khỏi hồ sơ của bạn?')) {
                fetch('remove-disease', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `diseaseId=${diseaseId}`
                })
                .then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        alert('Có lỗi xảy ra khi xóa tình trạng. Vui lòng thử lại.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi xóa tình trạng. Vui lòng thử lại.');
                });
            }
        }

        // Form submission handling
        document.getElementById('diseaseForm').addEventListener('submit', function(e) {
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.disabled = true;
            submitBtn.classList.add('loading');
            submitBtn.innerHTML = '<i class="fas fa-spinner"></i> Đang lưu...';
        });

        // Show loading state when submitting
        document.getElementById('diseaseForm').addEventListener('submit', function() {
            const checkboxes = document.querySelectorAll('.disease-checkbox:checked');
            if (checkboxes.length === 0) {
                if (!confirm('Bạn chưa chọn bất kỳ tình trạng nào. Bạn có chắc muốn tiếp tục?')) {
                    event.preventDefault();
                    return false;
                }
            }
            return true;
        });

        // Animation for elements when they come into view
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('fade-in');
                    observer.unobserve(entry.target);
                }
            });
        }, {
            threshold: 0.1
        });

        document.querySelectorAll('.disease-category, .action-buttons').forEach(el => {
            observer.observe(el);
        });

        // Responsive adjustments
        function handleResize() {
            const navMenu = document.querySelector('.nav-menu');
            if (window.innerWidth < 768) {
                navMenu.classList.add('mobile-menu');
            } else {
                navMenu.classList.remove('mobile-menu');
            }
        }

        window.addEventListener('resize', handleResize);
        handleResize();
    </script>
</body>
</html>