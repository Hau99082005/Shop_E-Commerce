<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Tất cả sản phẩm" />
<jsp:include page="includes/header.jsp" />

<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="py-2 bg-light">
    <div class="container">
        <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
            <li class="breadcrumb-item active">Sản phẩm</li>
        </ol>
    </div>
</nav>

<!-- Page Header -->
<section class="py-3">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-7 col-sm-12 mb-3 mb-md-0">
                <h1 class="h2 mb-0">
                    <i class="fas fa-box me-2"></i> Tất cả sản phẩm
                </h1>
                <p class="text-muted mb-0">
                    <c:choose>
                        <c:when test="${not empty search}">
                            Kết quả tìm kiếm cho: "<strong>${search}</strong>"
                        </c:when>
                        <c:otherwise>
                            Khám phá tất cả sản phẩm của chúng tôi
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            <div class="col-lg-4 col-md-5 col-sm-12 text-end">
                <div class="d-flex justify-content-end align-items-center">
                    <span class="text-muted me-2">Hiển thị:</span>
                    <select class="form-select form-select-sm" style="width: auto;">
                        <option value="12">12 sản phẩm</option>
                        <option value="24">24 sản phẩm</option>
                        <option value="48">48 sản phẩm</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Main Content -->
<section class="py-4">
    <div class="container">
        <div class="row">
            <!-- Sidebar Filter (Left) -->
            <div class="col-lg-3 col-md-4 mb-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-filter me-2"></i> Bộ lọc</h5>
                    </div>
                    
                    <!-- Categories -->
                    <div class="card-body">
                        <h6 class="fw-bold mb-3">Danh mục</h6>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item px-0">
                                <a href="/products" class="d-flex align-items-center text-decoration-none text-dark">
                                    <i class="fas fa-th-large me-2 text-primary"></i>Tất cả danh mục
                                </a>
                            </li>
                            <c:forEach var="category" items="${categories}">
                                <li class="list-group-item px-0">
                                    <a href="/category/${category.id}" class="d-flex align-items-center text-decoration-none text-dark">
                                        <i class="fas fa-folder me-2 text-primary"></i>${category.name}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    
                    <!-- Price Range -->
                    <div class="card-body border-top">
                        <h6 class="fw-bold mb-3">Khoảng giá</h6>
                        <div class="d-grid gap-2">
                            <button class="btn btn-outline-secondary btn-sm">Dưới 100.000₫</button>
                            <button class="btn btn-outline-secondary btn-sm">100.000₫ - 500.000₫</button>
                            <button class="btn btn-outline-secondary btn-sm">500.000₫ - 1.000.000₫</button>
                            <button class="btn btn-outline-secondary btn-sm">Trên 1.000.000₫</button>
                        </div>
                    </div>
                    
                    <!-- Status -->
                    <div class="card-body border-top">
                        <h6 class="fw-bold mb-3">Trạng thái</h6>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="inStock" checked>
                            <label class="form-check-label" for="inStock">
                                <i class="fas fa-box me-1 text-success"></i>Còn hàng
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="onSale">
                            <label class="form-check-label" for="onSale">
                                <i class="fas fa-percent me-1 text-danger"></i>Đang giảm giá
                            </label>
                        </div>
                    </div>
                </div>
            </div>
                
            <!-- Main Content (Right) -->
            <div class="col-lg-9 col-md-8">
                <!-- Products Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="mb-1">Tất cả sản phẩm</h4>
                        <p class="text-muted mb-0">
                            <c:choose>
                                <c:when test="${not empty search}">
                                    Kết quả tìm kiếm cho: "<strong>${search}</strong>"
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-info">${products.size()} sản phẩm</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div>
                        <div class="d-flex align-items-center">
                            <span class="text-muted me-2">Sắp xếp:</span>
                            <select class="form-select form-select-sm" style="width: auto;">
                                <option value="default">Mặc định</option>
                                <option value="price-low">Giá thấp đến cao</option>
                                <option value="price-high">Giá cao đến thấp</option>
                                <option value="name">Tên A-Z</option>
                                <option value="newest">Mới nhất</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <!-- Products Grid -->
                <c:choose>
                    <c:when test="${not empty products}">
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 row-cols-lg-3 g-4">
                            <c:forEach var="product" items="${products}">
                                <div class="col">
                                    <div class="card h-100 border-0 shadow-sm product-card">
                                        <!-- Product Image -->
                                        <div class="position-relative">
                                            <c:choose>
                                                <c:when test="${not empty product.image}">
                                                    <img src="/images/${product.image}" 
                                                         class="card-img-top" alt="${product.name}" style="height: 200px; object-fit: cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="card-img-top bg-light d-flex align-items-center justify-content-center" style="height: 200px;">
                                                        <i class="fas fa-image fa-3x text-muted"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <!-- Discount Badge -->
                                            <c:if test="${not empty product.price_old && product.price_old > product.price}">
                                                <div class="position-absolute top-0 end-0 bg-danger text-white m-2 px-2 py-1 rounded-pill">
                                                    <fmt:formatNumber value="${((product.price_old - product.price) / product.price_old) * 100}" 
                                                                     maxFractionDigits="0" />% OFF
                                                </div>
                                            </c:if>
                                        </div>
                                        
                                        <!-- Product Info -->
                                        <div class="card-body">
                                            <h5 class="card-title text-truncate" title="${product.name}">${product.name}</h5>
                                            
                                            <!-- Price -->
                                            <div class="mb-2">
                                                <c:if test="${not empty product.price_old && product.price_old > product.price}">
                                                    <span class="text-decoration-line-through text-muted me-2">
                                                        <fmt:formatNumber value="${product.price_old * 1000}" type="currency" currencyCode="VND" />
                                                    </span>
                                                </c:if>
                                                <span class="fw-bold text-danger">
                                                    <fmt:formatNumber value="${product.price * 1000}" type="currency" currencyCode="VND" />
                                                </span>
                                            </div>
                                            
                                            <!-- Stats -->
                                            <div class="d-flex justify-content-between text-muted small mb-3">
                                                <span>
                                                    <i class="fas fa-eye me-1"></i>${product.view} lượt xem
                                                </span>
                                                <span>
                                                    <i class="fas fa-box me-1"></i>${product.quantity} sản phẩm
                                                </span>
                                            </div>
                                            
                                            <!-- Actions -->
                                            <div class="d-grid gap-2">
                                                <a href="/product/${product.id}" class="btn btn-outline-primary btn-sm">
                                                    <i class="fas fa-eye me-1"></i> Xem chi tiết
                                                </a>
                                                <button class="btn btn-primary btn-sm" type="button">
                                                    <i class="fas fa-shopping-cart me-1"></i> Thêm giỏ hàng
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Pagination -->
                        <c:if test="${products.size() >= 12}">
                            <div class="d-flex justify-content-center mt-5">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" tabindex="-1">
                                                <i class="fas fa-chevron-left me-1"></i> Trước
                                            </a>
                                        </li>
                                        <li class="page-item active">
                                            <a class="page-link" href="#">1</a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="#">2</a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="#">3</a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="#">
                                                Tiếp <i class="fas fa-chevron-right ms-1"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <div class="mb-4">
                                <i class="fas fa-search fa-4x text-muted"></i>
                            </div>
                            <h3 class="mb-3">
                                <c:choose>
                                    <c:when test="${not empty search}">
                                        Không tìm thấy sản phẩm nào
                                    </c:when>
                                    <c:otherwise>
                                        Chưa có sản phẩm nào
                                    </c:otherwise>
                                </c:choose>
                            </h3>
                            <p class="text-muted mb-4">
                                <c:choose>
                                    <c:when test="${not empty search}">
                                        Không có sản phẩm nào phù hợp với từ khóa "${search}". Hãy thử tìm kiếm với từ khóa khác.
                                    </c:when>
                                    <c:otherwise>
                                        Hiện tại chưa có sản phẩm nào. Vui lòng quay lại sau.
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a href="/" class="btn btn-primary">
                                <i class="fas fa-home me-2"></i> Về trang chủ
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>

<jsp:include page="includes/footer.jsp" />
