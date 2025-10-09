<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : 'Cara'}</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">

    <!-- App CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Scoped CSS for Tiki-like header -->
    <style>
        /* ===== Tiki-like Header (scoped) ===== */
        .promo-bar { background:#e8f9e9; color:#0a8f4a; font-size:13px; padding:8px 0; border-bottom:1px solid #d8f0da; }
        .promo-bar a { color:#00aa55; font-weight:600; text-decoration:none; }

        .tiki-header { background:#fff; border-bottom:1px solid #e8e8e8; }
        .tiki-header .container { display:flex; align-items:center; gap:16px; padding:12px 0; }

        .brand { display:flex; align-items:center; text-decoration:none; }
        .brand .logo { color:#1ba8ff; font-weight:800; font-size:28px; letter-spacing:-.5px; line-height:1; }
        .brand .tagline { color:#808089; font-size:12px; margin-left:6px; }

        .tiki-search { flex:1; }
        .tiki-search .input-group { border:1.5px solid #1ba8ff; border-radius:10px; overflow:hidden; background:#fff; }
        .tiki-search .form-control { border:none; box-shadow:none; height:44px; padding-left:44px; }
        .tiki-search .search-icon { position:absolute; left:12px; top:50%; transform:translateY(-50%); color:#808089; font-size:16px; }
        .tiki-search .btn-search { background:#1ba8ff; color:#fff; border:none; padding:0 16px; font-weight:600; }
        .tiki-search .btn-search:hover { background:#0d7ec7; }

        .quick-links { display:flex; align-items:center; gap:16px; margin:0; list-style:none; }
        .quick-links .nav-link { color:#38383d; text-decoration:none; font-size:14px; display:flex; align-items:center; gap:8px; position:relative; }
        .quick-links .nav-link:hover { color:#1ba8ff; }
        .quick-links .badge { position:absolute; top:-6px; right:-10px; font-size:11px; }

        .subnav { background:#fff; border-bottom:1px solid #e8e8e8; }
        .subnav .container { display:flex; justify-content:space-between; align-items:center; padding:10px 0; gap:12px; }
        .subnav .links { display:flex; flex-wrap:wrap; gap:14px; }
        .subnav .links a { color:#38383d; text-decoration:none; font-size:14px; }
        .subnav .links a:hover { color:#1ba8ff; }
        .subnav .location { color:#808089; font-size:14px; }
        .subnav .location i { color:#1ba8ff; margin-right:6px; }

        @media (max-width: 991.98px) {
            .tiki-search .form-control { height:40px; }
            .tiki-header .container { gap:10px; }
            .brand .logo { font-size:22px; }
            .quick-links { gap:10px; }
            .subnav .container { flex-direction:column; align-items:flex-start; }
        }
    </style>

    <!-- Top Promo Bar -->
    <div class="promo-bar text-center">
        Freeship đơn từ 45k, giảm nhiều hơn cùng <a href="#">FREESHIP XTRA</a>
    </div>

    <!-- Main Header -->
    <header>
        <div class="tiki-header">
            <div class="container">
                <!-- Brand -->
            <a class="brand" href="${pageContext.request.contextPath}/">
+                    <img class="logo-img" src="${pageContext.request.contextPath}/assets/img/logo.png" alt="Cara Logo" />
+                </a>

                <!-- Search Bar -->
                <form class="tiki-search position-relative" action="${pageContext.request.contextPath}/products" method="get">
                    <i class="fas fa-magnifying-glass search-icon"></i>
                    <div class="input-group">
                        <input class="form-control" type="search" name="search" placeholder="Freeship đơn từ 45k" value="${search}">
                        <button class="btn btn-search" type="submit">Tìm kiếm</button>
                    </div>
                </form>

                <!-- Quick Links -->
                <ul class="quick-links">
                    <li>
                        <a class="nav-link" href="${pageContext.request.contextPath}/">
                            <i class="fas fa-house"></i>
                            <span class="d-none d-md-inline">Trang chủ</span>
                        </a>
                    </li>
                    <li>
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-user"></i>
                            <span class="d-none d-md-inline">Tài khoản</span>
                        </a>
                    </li>
                    <li>
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart" style="padding-right:18px;">
                            <i class="fas fa-cart-shopping"></i>
                            <span class="d-none d-md-inline">Giỏ hàng</span>
                            <span class="badge bg-danger rounded-pill"><c:out value="${empty cartCount ? 0 : cartCount}"/></span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Secondary Nav (categories + location) -->
        <div class="subnav">
            <div class="container">
                <div class="links">
                    <!-- Static shortcuts like Tiki -->
                    <a href="#">điện gia dụng</a>
                    <a href="#">xe cộ</a>
                    <a href="#">mẹ & bé</a>
                    <a href="#">khỏe đẹp</a>
                    <a href="#">nhà cửa</a>
                    <a href="#">sách</a>
                    <a href="#">thể thao</a>

                    <!-- Dynamic categories (from backend) -->
                    <c:if test="${not empty categories}">
                        <c:forEach var="category" items="${categories}">
                            <a href="${pageContext.request.contextPath}/category/${category.id}">${category.name}</a>
                        </c:forEach>
                    </c:if>
                </div>
                <div class="location">
                    <i class="fas fa-location-dot"></i>
                    Giao đến: <c:out value="${empty deliveryAddress ? 'TP. Huế, P. Vĩnh Ninh, Thừa Thiên Huế' : deliveryAddress}"/>
                </div>
            </div>
        </div>
    </header>
</body>
</html>