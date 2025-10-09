<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="py-3">
    <div class="container">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
            <li class="breadcrumb-item active">${category.name}</li>
        </ol>
    </div>
</nav>

<!-- Category Header -->
<section class="py-4 bg-light">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="mb-0">
                    <i class="fas fa-th-large"></i> ${category.name}
                </h1>
                <p class="text-muted mb-0">Khám phá các sản phẩm trong danh mục này</p>
            </div>
            <div class="col-md-4 text-end">
                <c:if test="${not empty category.thumbnail}">
                    <img src="${pageContext.request.contextPath}/images/${category.thumbnail}" 
                         class="img-fluid rounded" alt="${category.name}" style="max-height: 100px;">
                </c:if>
            </div>
        </div>
    </div>
</section>

<!-- Products Grid -->
<section class="py-5">
    <div class="container">
        <div class="row">
            <c:choose>
                <c:when test="${not empty products}">
                    <c:forEach var="product" items="${products}">
                        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                            <div class="card product-card h-100 border-0 shadow-sm">
                                <div class="card-img-top bg-light d-flex align-items-center justify-content-center" 
                                     style="height: 200px;">
                                    <c:choose>
                                        <c:when test="${not empty product.image}">
                                            <img src="${pageContext.request.contextPath}/images/${product.image}" 
                                                 class="img-fluid" alt="${product.name}" style="max-height: 180px;">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-image fa-3x text-muted"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="card-body">
                                    <h6 class="card-title text-truncate" title="${product.name}">${product.name}</h6>
                                    
                                    <div class="mb-2">
                                        <c:if test="${not empty product.price_old && product.price_old > product.price}">
                                            <small class="price-old">
                                                <fmt:formatNumber value="${product.price_old}" type="currency" currencyCode="VND" />
                                            </small>
                                        </c:if>
                                        <div class="price-new">
                                            <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND" />
                                        </div>
                                    </div>
                                    
                                    <c:if test="${not empty product.description}">
                                        <p class="card-text small text-muted text-truncate">${product.description}</p>
                                    </c:if>
                                    
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">
                                            <i class="fas fa-eye"></i> ${product.view}
                                        </small>
                                        <small class="text-success">
                                            <i class="fas fa-box"></i> ${product.quantity}
                                        </small>
                                    </div>
                                </div>
                                <div class="card-footer bg-transparent border-0">
                                    <a href="${pageContext.request.contextPath}/product/${product.id}" 
                                       class="btn btn-primary w-100">
                                        <i class="fas fa-eye"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="text-center py-5">
                            <i class="fas fa-box-open fa-5x text-muted mb-4"></i>
                            <h3 class="text-muted">Chưa có sản phẩm nào</h3>
                            <p class="text-muted">Danh mục này chưa có sản phẩm. Vui lòng quay lại sau.</p>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                                <i class="fas fa-home"></i> Về trang chủ
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Pagination (có thể thêm sau) -->
        <c:if test="${not empty products && products.size() >= 12}">
            <nav aria-label="Page navigation" class="mt-5">
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1">Trước</a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#">Tiếp</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
</section>

<!-- Related Categories -->
<c:if test="${not empty categories}">
    <section class="py-5 bg-light">
        <div class="container">
            <h3 class="text-center mb-4">Danh mục khác</h3>
            <div class="row">
                <c:forEach var="cat" items="${categories}">
                    <c:if test="${cat.id != category.id}">
                        <div class="col-lg-2 col-md-3 col-sm-4 col-6 mb-3">
                            <a href="${pageContext.request.contextPath}/category/${cat.id}" 
                               class="text-decoration-none">
                                <div class="card category-card border-0 shadow-sm h-100">
                                    <div class="card-img-top bg-light d-flex align-items-center justify-content-center" 
                                         style="height: 80px;">
                                        <c:choose>
                                            <c:when test="${not empty cat.thumbnail}">
                                                <img src="${pageContext.request.contextPath}/images/${cat.thumbnail}" 
                                                     class="img-fluid" alt="${cat.name}" style="max-height: 60px;">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-image text-muted"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="card-body p-2 text-center">
                                        <small class="card-title">${cat.name}</small>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </section>
</c:if>
