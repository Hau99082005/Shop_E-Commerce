<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="py-3">
    <div class="container">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
            <li class="breadcrumb-item active">${product.name}</li>
        </ol>
    </div>
</nav>

<!-- Product Detail -->
<section class="py-5">
    <div class="container">
        <div class="row">
            <!-- Product Image -->
            <div class="col-lg-6 mb-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-4">
                        <div class="text-center">
                            <c:choose>
                                <c:when test="${not empty product.image}">
                                    <img src="${pageContext.request.contextPath}/images/${product.image}" 
                                         class="img-fluid rounded" alt="${product.name}" style="max-height: 400px;">
                                </c:when>
                                <c:otherwise>
                                    <div class="bg-light d-flex align-items-center justify-content-center" 
                                         style="height: 400px;">
                                        <i class="fas fa-image fa-5x text-muted"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Product Info -->
            <div class="col-lg-6">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body p-4">
                        <h1 class="h2 mb-3">${product.name}</h1>
                        
                        <!-- Price -->
                        <div class="mb-4">
                            <c:if test="${not empty product.price_old && product.price_old > product.price}">
                                <div class="d-flex align-items-center mb-2">
                                    <span class="price-old me-3">
                                        <fmt:formatNumber value="${product.price_old * 1000}" type="currency" currencyCode="VND" />
                                    </span>
                                    <span class="badge bg-danger">
                                        <fmt:formatNumber value="${((product.price_old - product.price) / product.price_old) * 100}" 
                                                         maxFractionDigits="0" />% OFF
                                    </span>
                                </div>
                            </c:if>
                            <h3 class="price-new mb-0">
                                <fmt:formatNumber value="${product.price * 1000}" type="currency" currencyCode="VND" />
                            </h3>
                        </div>
                        
                        <!-- Product Stats -->
                        <div class="row mb-4">
                            <div class="col-6">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-eye text-muted me-2"></i>
                                    <span>${product.view} lượt xem</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-box text-success me-2"></i>
                                    <span class="text-success">${product.quantity} sản phẩm</span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Description -->
                        <c:if test="${not empty product.description}">
                            <div class="mb-4">
                                <h5>Mô tả sản phẩm</h5>
                                <p class="text-muted">${product.description}</p>
                            </div>
                        </c:if>
                        
                        <!-- Created Date -->
                        <div class="mb-4">
                            <small class="text-muted">
                                <i class="fas fa-calendar"></i> 
                                Đăng ngày: <fmt:formatDate value="${product.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                            </small>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="d-grid gap-2">
                            <button class="btn btn-primary btn-lg" type="button">
                                <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
                            </button>
                            <button class="btn btn-outline-danger btn-lg" type="button">
                                <i class="fas fa-heart"></i> Yêu thích
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Product Details Tabs -->
        <div class="row mt-5">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white">
                        <ul class="nav nav-tabs card-header-tabs" id="productTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="description-tab" data-bs-toggle="tab" 
                                        data-bs-target="#description" type="button" role="tab">
                                    <i class="fas fa-info-circle"></i> Mô tả chi tiết
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="specs-tab" data-bs-toggle="tab" 
                                        data-bs-target="#specs" type="button" role="tab">
                                    <i class="fas fa-list"></i> Thông số kỹ thuật
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" 
                                        data-bs-target="#reviews" type="button" role="tab">
                                    <i class="fas fa-star"></i> Đánh giá
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="card-body">
                        <div class="tab-content" id="productTabsContent">
                            <div class="tab-pane fade show active" id="description" role="tabpanel">
                                <c:choose>
                                    <c:when test="${not empty product.description}">
                                        <p>${product.description}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-muted">Chưa có mô tả chi tiết cho sản phẩm này.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="tab-pane fade" id="specs" role="tabpanel">
                                <div class="row">
                                    <div class="col-md-6">
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>ID sản phẩm:</strong></td>
                                                <td>${product.id}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Danh mục:</strong></td>
                                                <td>ID ${product.category_id}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Trạng thái:</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${product.status}">
                                                            <span class="badge bg-success">Đang bán</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-danger">Ngừng bán</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Số lượng:</strong></td>
                                                <td>${product.quantity}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Lượt xem:</strong></td>
                                                <td>${product.view}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Ngày tạo:</strong></td>
                                                <td><fmt:formatDate value="${product.createdAt}" pattern="dd/MM/yyyy" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="reviews" role="tabpanel">
                                <div class="text-center py-5">
                                    <i class="fas fa-star fa-3x text-muted mb-3"></i>
                                    <h5 class="text-muted">Chưa có đánh giá nào</h5>
                                    <p class="text-muted">Hãy là người đầu tiên đánh giá sản phẩm này!</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Related Products -->
<c:if test="${not empty relatedProducts}">
    <section class="py-5 bg-light">
        <div class="container">
            <h3 class="text-center mb-5">Sản phẩm liên quan</h3>
            <div class="row">
                <c:forEach var="relatedProduct" items="${relatedProducts}">
                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                        <div class="card product-card h-100 border-0 shadow-sm">
                            <div class="card-img-top bg-light d-flex align-items-center justify-content-center" 
                                 style="height: 200px;">
                                <c:choose>
                                    <c:when test="${not empty relatedProduct.image}">
                                        <img src="${pageContext.request.contextPath}/images/${relatedProduct.image}" 
                                             class="img-fluid" alt="${relatedProduct.name}" style="max-height: 180px;">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-image fa-3x text-muted"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="card-body">
                                <h6 class="card-title text-truncate" title="${relatedProduct.name}">${relatedProduct.name}</h6>
                                
                                <div class="mb-2">
                                    <c:if test="${not empty relatedProduct.price_old && relatedProduct.price_old > relatedProduct.price}">
                                        <small class="price-old">
                                            <fmt:formatNumber value="${relatedProduct.price_old}" type="currency" currencyCode="VND" />
                                        </small>
                                    </c:if>
                                    <div class="price-new">
                                        <fmt:formatNumber value="${relatedProduct.price}" type="currency" currencyCode="VND" />
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer bg-transparent border-0">
                                <a href="${pageContext.request.contextPath}/product/${relatedProduct.id}" 
                                   class="btn btn-primary w-100">
                                    <i class="fas fa-eye"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>
</c:if>
