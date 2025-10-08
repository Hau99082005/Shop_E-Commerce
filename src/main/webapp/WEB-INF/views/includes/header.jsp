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
    
    <!-- Custom CSS -->
    <link href="/assets/css/style.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Custom CSS for header -->
    <style>
        .header-top {
            background-color: #0dcaf0;
            color: white;
            padding: 0.5rem 0;
        }
        .main-header {
            background-color: #0dcaf0;
            padding: 0.5rem 0;
        }
        .main-header .navbar-brand {
            font-size: 2rem;
            font-weight: bold;
            font-style: italic;
            color: white;
        }
        .main-header .nav-link {
            color: white;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: all 0.3s;
        }
        .main-header .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 4px;
        }
        .search-form .form-control {
            border-radius: 20px 0 0 20px;
            border: none;
        }
        .search-form .btn {
            border-radius: 0 20px 20px 0;
            background-color: white;
            color: #0dcaf0;
            border: none;
        }
        .user-actions .nav-link {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            padding: 0.5rem;
        }
        .user-actions .nav-link i {
            font-size: 1.2rem;
            margin-bottom: 0.25rem;
        }
    </style>

    <!-- Navigation -->
    <header>
        <div class="main-header">
            <div class="container">
                <nav class="navbar navbar-expand-lg">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                        Cara
                    </a>
                    
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/">
                                    <i class="fas fa-home me-1"></i>Trang chủ
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/products">
                                    <i class="fas fa-box me-1"></i>Sản phẩm
                                </a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-th-large me-1"></i>Danh mục
                                </a>
                                <ul class="dropdown-menu">
                                    <c:forEach var="category" items="${categories}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/${category.id}">${category.name}</a></li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </ul>
                        
                        <!-- Search Form -->
                        <form class="d-flex search-form mx-auto" action="${pageContext.request.contextPath}/products" method="get">
                            <input class="form-control" type="search" name="search" 
                                   placeholder="Tìm kiếm sản phẩm..." value="${search}" style="width: 300px;">
                            <button class="btn" type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                        
                        <!-- User Actions -->
                        <ul class="navbar-nav ms-3 user-actions">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-user"></i>
                                    <span>Đăng nhập</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link position-relative" href="${pageContext.request.contextPath}/cart">
                                    <i class="fas fa-shopping-cart"></i>
                                    <span>Giỏ hàng</span>
                                    <span class="position-absolute top-0 start-75 translate-middle badge rounded-pill bg-danger">
                                        0
                                    </span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
    </header>
