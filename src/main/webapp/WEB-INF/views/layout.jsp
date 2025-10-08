<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle}" default="Cara" /></title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <style>
        /* Category Cards */
        .category-card {
            transition: all 0.3s ease;
            border: 1px solid transparent;
        }
        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15) !important;
            border-color: #007bff;
        }
        
        /* Product Cards */
        .product-card {
            transition: all 0.3s ease;
            border: 1px solid transparent;
        }
        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15) !important;
            border-color: #007bff;
        }
        
        /* Product Image Hover Effects */
        .product-card .card-img-top:hover .transition-opacity {
            opacity: 1 !important;
        }
        
        .product-card:hover .card-img-top img {
            transform: scale(1.05);
        }
        
        /* Price Styling */
        .price-old {
            text-decoration: line-through;
            color: #999;
        }
        .price-new {
            color: #ee4d2d;
            font-weight: bold;
        }
        
        /* Navbar */
        .navbar-brand {
            font-weight: bold;
            color: #ee4d2d !important;
        }
        
        /* Filter Sidebar */
        .sticky-top {
            position: sticky !important;
            top: 20px;
        }
        
        /* List Group Items */
        .list-group-item-action:hover {
            background-color: #f8f9fa;
            border-color: #dee2e6;
        }
        
        /* Buttons */
        .btn {
            transition: all 0.2s ease;
        }
        
        .btn:hover {
            transform: translateY(-1px);
        }
        
        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .product-card {
                margin-bottom: 1rem;
            }
            
            .sticky-top {
                position: relative !important;
                top: auto !important;
            }
        }
        
        @media (max-width: 576px) {
            .product-card .card-img-top {
                height: 180px !important;
            }
            
            .product-card .card-img-top img {
                max-height: 160px !important;
            }
        }
        
        /* Loading Animation */
        .transition-transform {
            transition: transform 0.3s ease;
        }
        
        .transition-opacity {
            transition: opacity 0.3s ease;
        }
        
        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }
        
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        
        ::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 4px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: #a8a8a8;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-shopping-cart"></i> Shopee Clone
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/products">Sản phẩm</a>
                    </li>
                </ul>
                
                <!-- Search Form -->
                <form class="d-flex" action="/products" method="get">
                    <input class="form-control me-2" type="search" name="search" placeholder="Tìm kiếm sản phẩm..." 
                           value="${search}">
                    <button class="btn btn-outline-success" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main>
        <c:choose>
            <c:when test="${not empty contentPage}">
                <jsp:include page="${contentPage}" />
            </c:when>
            <c:otherwise>
                <!-- Default content will be included by individual pages -->
                <div class="container py-5">
                    <div class="alert alert-info">
                        <h4>Chào mừng đến với Shopee Clone!</h4>
                        <p>Trang web đang được phát triển. Vui lòng truy cập <a href="/products">danh sách sản phẩm</a> để xem giao diện hoàn chỉnh.</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>Shopee Clone</h5>
                    <p>Ứng dụng mua sắm trực tuyến</p>
                </div>
                <div class="col-md-6 text-end">
                    <p>&copy; 2025 Shopee Clone. Tất cả quyền được bảo lưu.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        // Product card hover effects
        document.addEventListener('DOMContentLoaded', function() {
            const productCards = document.querySelectorAll('.product-card');
            
            productCards.forEach(card => {
                const overlay = card.querySelector('.transition-opacity');
                
                card.addEventListener('mouseenter', function() {
                    if (overlay) {
                        overlay.style.opacity = '1';
                    }
                });
                
                card.addEventListener('mouseleave', function() {
                    if (overlay) {
                        overlay.style.opacity = '0';
                    }
                });
            });
            
            // Filter collapse toggle for mobile
            const filterToggle = document.querySelector('[data-bs-target="#filterCollapse"]');
            if (filterToggle) {
                filterToggle.addEventListener('click', function() {
                    const icon = this.querySelector('i');
                    const collapse = document.querySelector('#filterCollapse');
                    
                    if (collapse.classList.contains('show')) {
                        icon.className = 'fas fa-chevron-down';
                    } else {
                        icon.className = 'fas fa-chevron-up';
                    }
                });
            }
            
            // Smooth scroll for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
        });
    </script>
</body>
</html>
