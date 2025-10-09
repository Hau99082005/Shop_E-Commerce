<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Cara</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <style>
        /* Category Card Styles */
        .category-card {
            transition: transform 0.3s;
            overflow: hidden;
        }
        .category-card:hover {
            transform: translateY(-5px);
        }
        .category-img-container {
            height: 180px;
            overflow: hidden;
        }
        .category-img-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }
        .category-card:hover img {
            transform: scale(1.05);
        }
        
        /* Product Card Styles */
        .product-card {
            transition: transform 0.3s;
            overflow: hidden;
        }
        .product-card:hover {
            transform: translateY(-5px);
        }
        .product-img-container {
            height: 200px;
            overflow: hidden;
            position: relative;
        }
        .product-img-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }
        .product-card:hover img {
            transform: scale(1.05);
        }
        .product-title {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .discount-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #ff4d4f;
            color: white;
            padding: 2px 8px;
            border-radius: 4px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<!-- Header -->
<jsp:include page="includes/header.jsp" />

<!-- Main Content -->
<!-- Hero Section with Banner Carousel -->
<section class="p-0">
    <div id="bannerCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <c:forEach var="banner" items="${banners}" varStatus="status">
                <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="${status.index}" 
                        class="${status.index == 0 ? 'active' : ''}" aria-current="${status.index == 0 ? 'true' : 'false'}" 
                        aria-label="Slide ${status.index + 1}"></button>
            </c:forEach>
        </div>
        <div class="carousel-inner">
            <c:choose>
                <c:when test="${not empty banners}">
                    <c:forEach var="banner" items="${banners}" varStatus="status">
                        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                            <img src="${pageContext.request.contextPath}/assets/img/banners/${banner.image}" 
                                 class="d-block w-100" alt="${banner.title}" 
                                 onerror="this.src='${pageContext.request.contextPath}/assets/img/banner.jpg'"
                                 style="height: 300px; object-fit: cover;">
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="carousel-item active">
                        <img src="${pageContext.request.contextPath}/assets/img/banner.jpg" 
                             class="d-block w-100" alt="Default Banner" style="height: 300px; object-fit: cover;">
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#bannerCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#bannerCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</section>

<!-- Categories Section -->
<section class="py-4">
    <div class="container">
        <div class="row row-cols-2 row-cols-md-5 g-4">
            <c:forEach var="category" items="${categories}">
                <div class="col">
                    <div class="card h-100 border-0">
                        <img src="${pageContext.request.contextPath}/images/${category.thumbnail}" 
                             class="card-img-top" alt="${category.name}" 
                             onerror="this.src='${pageContext.request.contextPath}/images/default-category.jpg'"
                             style="height: 150px; object-fit: contain;">
                        <div class="card-body text-center p-2">
                            <a href="${pageContext.request.contextPath}/category/${category.id}" class="text-decoration-none">
                                <div class="bg-primary bg-opacity-10 text-primary rounded-pill py-1 px-2">
                                    ${category.name}
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- Featured Products Section -->
<section class="py-4">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold">Sản phẩm nổi bật</h3>
            <a href="${pageContext.request.contextPath}/products" class="text-decoration-none">Xem tất cả</a>
        </div>
        <div class="row row-cols-2 row-cols-md-4 g-4">
            <c:forEach var="product" items="${products}" begin="0" end="3">
                <div class="col">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="position-relative">
                            <img src="${pageContext.request.contextPath}/images/${product.image}" 
                                 class="card-img-top" alt="${product.name}"
                                 onerror="this.src='${pageContext.request.contextPath}/images/default-product.jpg'"
                                 style="height: 200px; object-fit: contain;">
                            <c:if test="${product.price_old != null && product.price_old > product.price}">
                                <div class="position-absolute top-0 start-0 bg-danger text-white px-2 py-1 m-2 rounded-pill">
                                    <small>-<fmt:formatNumber value="${(product.price_old - product.price) / product.price_old * 100}" maxFractionDigits="0"/>%</small>
                                </div>
                            </c:if>
                        </div>
                        <div class="card-body p-3">
                            <h6 class="card-title product-title">${product.name}</h6>
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <div>
                                    <c:choose>
                                        <c:when test="${product.price_old != null && product.price_old > product.price}">
                                            <span class="text-muted text-decoration-line-through me-2" style="font-size: 0.9rem;">
                                                <fmt:formatNumber value="${product.price_old * 1000}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </span>
                                            <span class="text-danger fw-bold">
                                                <fmt:formatNumber value="${product.price * 1000}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-danger fw-bold">
                                                <fmt:formatNumber value="${product.price * 1000}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="text-warning">
                                    <i class="fas fa-star"></i>
                                    <span>5.0</span>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/product/${product.id}" class="btn btn-sm btn-outline-primary">Chi tiết</a>
                                <button class="btn btn-sm btn-success add-to-cart-btn" 
                                        data-product-id="${product.id}" 
                                        data-product-name="${product.name}" 
                                        data-product-price="${product.price}">
                                    <i class="fas fa-cart-plus"></i> Thêm
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- New Arrivals Section -->
<section class="py-4">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold">Sản phẩm mới</h3>
            <a href="${pageContext.request.contextPath}/products?sort=newest" class="text-decoration-none">Xem tất cả</a>
        </div>
        <div class="row row-cols-2 row-cols-md-4 g-4">
            <c:forEach var="product" items="${products}" begin="4" end="7">
                <div class="col">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="position-relative">
                            <img src="${pageContext.request.contextPath}/images/${product.image}" 
                                 class="card-img-top" alt="${product.name}"
                                 onerror="this.src='${pageContext.request.contextPath}/images/default-product.jpg'"
                                 style="height: 200px; object-fit: contain;">
                            <c:if test="${product.price_old != null && product.price_old > product.price}">
                                <div class="position-absolute top-0 start-0 bg-danger text-white px-2 py-1 m-2 rounded-pill">
                                    <small>-<fmt:formatNumber value="${(product.price_old - product.price) / product.price_old * 100}" maxFractionDigits="0"/>%</small>
                                </div>
                            </c:if>
                        </div>
                        <div class="card-body p-3">
                            <h6 class="card-title product-title">${product.name}</h6>
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <div>
                                    <c:choose>
                                        <c:when test="${product.price_old != null && product.price_old > product.price}">
                                            <span class="text-muted text-decoration-line-through me-2" style="font-size: 0.9rem;">
                                                <fmt:formatNumber value="${product.price_old * 1000}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </span>
                                            <span class="text-danger fw-bold">
                                                <fmt:formatNumber value="${product.price * 1000}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-danger fw-bold">
                                                <fmt:formatNumber value="${product.price * 1000}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="text-warning">
                                    <i class="fas fa-star"></i>
                                    <span>5.0</span>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/product/${product.id}" class="btn btn-sm btn-outline-primary">Chi tiết</a>
                                <button class="btn btn-sm btn-success add-to-cart-btn" 
                                        data-product-id="${product.id}" 
                                        data-product-name="${product.name}" 
                                        data-product-price="${product.price}">
                                    <i class="fas fa-cart-plus"></i> Thêm
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- Repair Services Section -->
<section class="py-4 bg-light">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h3 class="fw-bold mb-3">Dịch vụ sửa chữa</h3>
                <p class="mb-4">Chúng tôi cung cấp dịch vụ sửa chữa chuyên nghiệp cho tất cả các sản phẩm điện tử. Đội ngũ kỹ thuật viên giàu kinh nghiệm sẽ giúp bạn khắc phục mọi vấn đề.</p>
                <ul class="list-unstyled mb-4">
                    <li class="mb-2"><i class="fas fa-check-circle text-primary me-2"></i> Sửa chữa nhanh chóng</li>
                    <li class="mb-2"><i class="fas fa-check-circle text-primary me-2"></i> Bảo hành dài hạn</li>
                    <li class="mb-2"><i class="fas fa-check-circle text-primary me-2"></i> Linh kiện chính hãng</li>
                    <li class="mb-2"><i class="fas fa-check-circle text-primary me-2"></i> Giá cả hợp lý</li>
                </ul>
                <a href="${pageContext.request.contextPath}/services" class="btn btn-primary">Tìm hiểu thêm</a>
            </div>
            <div class="col-md-6">
                <img src="${pageContext.request.contextPath}/images/repair-service.jpg" 
                     class="img-fluid rounded shadow" 
                     alt="Dịch vụ sửa chữa"
                     onerror="this.src='https://via.placeholder.com/600x400?text=Dịch+vụ+sửa+chữa'">
            </div>
        </div>
    </div>
</section>

<!-- Promotional Banners -->
<section class="py-4">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-6">
                <div class="card border-0 rounded shadow overflow-hidden">
                    <div class="row g-0 align-items-center">
                        <div class="col-5">
                            <img src="${pageContext.request.contextPath}/images/promo-1.jpg" 
                                 class="img-fluid" 
                                 alt="Khuyến mãi"
                                 onerror="this.src='https://via.placeholder.com/300x200?text=Khuyến+mãi'">
                        </div>
                        <div class="col-7 p-4">
                            <h4 class="fw-bold">Giảm giá 50%</h4>
                            <p class="mb-3">Cho tất cả sản phẩm mới trong tháng này</p>
                            <a href="${pageContext.request.contextPath}/products?sale=true" class="btn btn-sm btn-outline-primary">Mua ngay</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card border-0 rounded shadow overflow-hidden">
                    <div class="row g-0 align-items-center">
                        <div class="col-5">
                            <img src="${pageContext.request.contextPath}/images/promo-2.jpg" 
                                 class="img-fluid" 
                                 alt="Khuyến mãi"
                                 onerror="this.src='https://via.placeholder.com/300x200?text=Khuyến+mãi'">
                        </div>
                        <div class="col-7 p-4">
                            <h4 class="fw-bold">Miễn phí vận chuyển</h4>
                            <p class="mb-3">Cho đơn hàng trên 500.000₫</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-sm btn-outline-primary">Mua ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>


<!-- Footer -->
<jsp:include page="includes/footer.jsp" />

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom Scripts -->
<script>
    // Add to cart functionality
    document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-product-id');
            // Add to cart logic here
            alert('Đã thêm sản phẩm vào giỏ hàng!');
        });
    });
</script>

</body>
</html>
