<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Cara - Thời trang & Phụ kiện</title>
  <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet" crossorigin="anonymous"/>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<style>
.shp-topbar {
  background: #55C5EA;          
  background: linear-gradient(180deg, #55C5EA 0%, #45b5da 100%);
  color: #ffffff;
}
.shp-topbar a { color: #ffffff !important; }

.shp-header {

  background: #45b5da;
  background: linear-gradient(180deg, #45b5da 0%, #35a5ca 100%);
  color: #ffffff;
  border-bottom: 1px solid #35a5ca;
  position: relative;
  z-index: 1100; 
}

.shp-header .shp-icon { color: #ffffff; }
.shp-quickcats a { color: #ffffff !important; opacity: .95; }
.shp-quickcats a:hover { opacity: 1; text-decoration: underline; }

.shp-header .dropdown-menu { z-index: 2000; }

.shp-search-input {
  background: #ffffff;
  border: 1px solid #35a5ca !important;
  box-shadow: none !important;
}
.shp-search-input:focus {
  border-color: #55C5EA !important;
  outline: 0;
  box-shadow: 0 0 0 0.2rem rgba(85,197,234,.15) !important;
}
.shp-search-btn {
  background: #55C5EA !important;   
  color: #ffffff !important;
  border: 1px solid #55C5EA !important;
}
.shp-search-btn:hover { background: #45b5da !important; border-color:#45b5da !important; }

.cat-pill { border-color: #55C5EA; }
</style>
<body class="bg-light">

<div class="shp-topbar text-white small">
  <div class="container d-flex justify-content-between align-items-center py-1">
    <div class="d-flex flex-wrap gap-3">
      <a class="text-white text-decoration-none" href="#">Kênh Người Bán</a>
      <a class="text-white text-decoration-none" href="#">Tải ứng dụng</a>
      <span class="d-none d-md-inline">|</span>
      <span class="d-none d-md-inline">Kết nối</span>
      <a class="text-white" href="#" aria-label="Facebook"><i class="fa-brands fa-facebook"></i></a>
      <a class="text-white" href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
    </div>
    <div class="d-flex flex-wrap gap-3 align-items-center">
      <a class="text-white text-decoration-none" href="#"><i class="fa-regular fa-bell me-1"></i> Thông Báo</a>
      <a class="text-white text-decoration-none" href="#"><i class="fa-regular fa-circle-question me-1"></i> Hỗ Trợ</a>
      <a class="text-white text-decoration-none d-none d-md-inline" href="#"><i class="fa-solid fa-globe me-1"></i> Tiếng Việt</a>
    </div>
  </div>
</div>

<header class="shp-header">
  <div class="container py-3">
    <div class="row g-3 align-items-center">
      <!-- Logo -->
      <div class="col-6 col-md-2 d-flex align-items-center">
        <a class="d-inline-flex align-items-center" href="${pageContext.request.contextPath}/">
          <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="Cara" style="height:40px;width:auto;">
        </a>
      </div>

      <!-- Search -->
      <div class="col-12 col-md-8 order-3 order-md-2">
        <form action="${pageContext.request.contextPath}/search" method="get" class="input-group">
  <input type="text" name="keyword" class="form-control shp-search-input"
         placeholder="Tìm sản phẩm, thương hiệu và hơn thế nữa...">
  <button class="btn btn-light shp-search-btn" type="submit">
    <i class="fa-solid fa-magnifying-glass"></i>
  </button>
</form>
        <div class="mt-2">
          <a class="btn btn-info btn-sm text-white fw-semibold" href="${pageContext.request.contextPath}/categories">
            <i class="fa-solid fa-bars"></i> Tất cả danh mục
          </a>
        </div>
        
      </div>

      <!-- Cart + User -->
      <div class="col-6 col-md-2 d-flex justify-content-end align-items-center gap-3 order-2 order-md-3">
        <c:set var="cartCount" value="0"/>
        <c:if test="${not empty sessionScope.CART}">
          <c:forEach var="line" items="${sessionScope.CART.values()}">
            <c:set var="cartCount" value="${cartCount + line.quantity}"/>
          </c:forEach>
        </c:if>
        <a class="text-white position-relative shp-icon" href="${pageContext.request.contextPath}/cart" title="Giỏ hàng">
          <i class="fa-solid fa-cart-shopping"></i>
          <span class="badge text-bg-danger position-absolute top-0 start-100 translate-middle p-1 rounded-pill">${cartCount}</span>
        </a>

        <c:choose>
          <c:when test="${sessionScope.user != null}">
            <div class="dropdown">
              <a id="userMenuToggle" class="text-white shp-icon d-flex align-items-center gap-1 text-decoration-none" href="javascript:void(0)" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fa-solid fa-user"></i>
                <i class="fa-solid fa-caret-down small"></i>
              </a>
              <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                <li><h6 class="dropdown-header">Xin chào, ${sessionScope.user.email}</h6></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Thông tin tài khoản</a></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders/mine">Đơn hàng của tôi</a></li>
                <c:if test="${sessionScope.user.role == 'admin'}">
                  <li><a class="dropdown-item fw-bold text-primary" href="${pageContext.request.contextPath}/admin/users">Quản trị</a></li>
                </c:if>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
              </ul>
            </div>
          </c:when>
          <c:otherwise>
            <a class="text-white shp-icon" href="${pageContext.request.contextPath}/login" title="Đăng nhập">
              <i class="fa-solid fa-user"></i>
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</header>

<div style="height:8px;background:#f5f5f5;"></div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>