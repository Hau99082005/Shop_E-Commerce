<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="bg-light py-3">
  <div class="container">

    <!-- Banner - Carousel -->
    <div class="mb-3">
      <div id="mainBannerCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
          <c:choose>
            <c:when test="${not empty banners}">
              <c:forEach var="b" items="${banners}" varStatus="st">
                <button type="button"
                        data-bs-target="#mainBannerCarousel"
                        data-bs-slide-to="${st.index}"
                        class="${st.first ? 'active' : ''}"
                        aria-current="${st.first ? 'true' : 'false'}"
                        aria-label="Slide ${st.index + 1}"></button>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <button type="button" data-bs-target="#mainBannerCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
              <button type="button" data-bs-target="#mainBannerCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
              <button type="button" data-bs-target="#mainBannerCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </c:otherwise>
          </c:choose>
        </div>

        <div class="carousel-inner rounded-3 shadow-sm" style="border: 2px solid #55C5EA;">
          <c:choose>
            <c:when test="${not empty banners}">
              <c:forEach var="b" items="${banners}" varStatus="st">
                <div class="carousel-item ${st.first ? 'active' : ''}">
                  <div class="ratio ratio-21x9">
                    <c:choose>
                      <c:when test="${not empty b.image && (fn:startsWith(b.image, 'http://') || fn:startsWith(b.image, 'https://'))}">
                        <img src="${b.image}"
                             alt="${b.title}" class="w-100 h-100" style="object-fit:cover"
                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/banner/b1.jpg'">
                      </c:when>
                      <c:otherwise>
                        <img src="${pageContext.request.contextPath}/assets/img/banner/${b.image}"
                             alt="${b.title}" class="w-100 h-100" style="object-fit:cover"
                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/banner/b1.jpg'">
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <div class="carousel-item active">
                <div class="ratio ratio-21x9">
                  <img src="${pageContext.request.contextPath}/assets/img/banner/b1.jpg"
                       alt="Banner" class="w-100 h-100" style="object-fit:cover">
                </div>
              </div>
              <div class="carousel-item">
                <div class="ratio ratio-21x9">
                  <img src="${pageContext.request.contextPath}/assets/img/banner/b2.jpg" 
                       alt="Banner" class="w-100 h-100" style="object-fit:cover">
                </div>
              </div>
              <div class="carousel-item">
                <div class="ratio ratio-21x9">
                  <img src="${pageContext.request.contextPath}/assets/img/banner/b3.jpg" 
                       alt="Banner" class="w-100 h-100" style="object-fit:cover">
                </div>
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <button class="carousel-control-prev" type="button" data-bs-target="#mainBannerCarousel" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#mainBannerCarousel" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>
    </div>

    <!-- Categories -->
    <div class="container my-3">
      <div class="bg-white rounded-3 shadow-sm p-3" style="border: 1px solid #55C5EA;">
        <div class="row g-3 row-cols-3 row-cols-sm-5 row-cols-md-7 row-cols-lg-10">
          <c:forEach var="category" items="${categories}">
            <div class="col">
              <a href="${pageContext.request.contextPath}/category/${category.id}" class="text-decoration-none d-flex flex-column align-items-center">
                <div class="rounded-circle overflow-hidden d-flex align-items-center justify-content-center cat-pill" style="border: 2px solid #55C5EA; background: #f0f9ff; width: 60px; height: 60px;">
                  <c:choose>
                    <c:when test="${not empty category.thumbnail}">
                      <c:choose>
                        <c:when test="${fn:startsWith(category.thumbnail, 'http://') || fn:startsWith(category.thumbnail, 'https://')}">
                          <img src="${category.thumbnail}"
                               alt="${category.name}" class="w-100 h-100" style="object-fit:cover"
                               onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/hero4.png'">
                        </c:when>
                        <c:otherwise>
                          <img src="${pageContext.request.contextPath}/assets/images/${category.thumbnail}"
                               alt="${category.name}" class="w-100 h-100" style="object-fit:cover"
                               onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/hero4.png'">
                        </c:otherwise>
                      </c:choose>
                    </c:when>
                    <c:otherwise>
                      <img src="${pageContext.request.contextPath}/assets/img/hero4.png"
                           alt="${category.name}" class="w-100 h-100" style="object-fit:cover">
                    </c:otherwise>
                  </c:choose>
                </div>
                <div class="small text-dark mt-2 text-center text-truncate" style="max-width:100px; color: #55C5EA !important;">${category.name}</div>
              </a>
            </div>
          </c:forEach>
        </div>
      </div>
    </div>

    <!-- Featured Products -->
    <div class="mb-2 d-flex align-items-center justify-content-between">
      <h5 class="m-0 fw-bold">Gợi ý hôm nay</h5>
    </div>

    <div class="row g-3">
      <c:forEach var="product" items="${products}">
        <div class="col-6 col-sm-4 col-md-3 col-lg-2">
          <a href="${pageContext.request.contextPath}/product/${product.id}" class="text-decoration-none">
            <div class="card h-100 shadow-sm">
              <div class="position-relative">
                <div class="ratio ratio-1x1">
                  <c:choose>
                    <c:when test="${not empty product.image && (fn:startsWith(product.image, 'http://') || fn:startsWith(product.image, 'https://'))}">
                      <img src="${product.image}"
                           alt="${product.name}" class="w-100 h-100" style="object-fit:cover"
                           onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/products/f1.jpg'">
                    </c:when>
                    <c:otherwise>
                      <img src="${pageContext.request.contextPath}/assets/images/${product.image}"
                           alt="${product.name}" class="w-100 h-100" style="object-fit:cover"
                           onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/products/f1.jpg'">
                    </c:otherwise>
                  </c:choose>
                </div>
                <c:if test="${product.price_old != null && product.price_old > product.price}">
                  <span class="position-absolute top-0 start-0 m-2 badge bg-danger">
                    -<fmt:formatNumber value="${(product.price_old - product.price) / product.price_old * 100}" maxFractionDigits="0"/>%
                  </span>
                </c:if>
              </div>
              <div class="card-body p-2">
                <div class="small text-muted text-truncate">
                  <c:set var="catName" value="" />
                  <c:forEach var="cat" items="${categories}">
                    <c:if test="${cat.id == product.category_id}">
                      <c:set var="catName" value="${cat.name}" />
                    </c:if>
                  </c:forEach>
                  <c:choose>
                    <c:when test="${not empty catName}">
                      <a href="${pageContext.request.contextPath}/category/${product.category_id}" class="text-decoration-none text-secondary">${catName}</a>
                    </c:when>
                    <c:otherwise>
                      <span class="text-secondary">Danh mục</span>
                    </c:otherwise>
                  </c:choose>
                </div>
                <div class="small text-dark fw-semibold text-truncate" title="${product.name}">${product.name}</div>
                <div class="text-warning small my-1">
                  <i class="fa-solid fa-star"></i>
                  <i class="fa-solid fa-star"></i>
                  <i class="fa-solid fa-star"></i>
                  <i class="fa-solid fa-star"></i>
                  <i class="fa-solid fa-star"></i>
                </div>
                <div class="d-flex align-items-center gap-2">
                  <span class="text-danger fw-bold">
                    <fmt:formatNumber value="${product.price * 1000}" type="currency" currencySymbol=""/>đ
                  </span>
                  <c:if test="${product.price_old != null && product.price_old > product.price}">
                    <span class="text-muted text-decoration-line-through small">
                      <fmt:formatNumber value="${product.price_old * 1000}" type="currency" currencySymbol=""/>đ
                    </span>
                  </c:if>
                </div>
              </div>
            </div>
          </a>
        </div>
      </c:forEach>

      <c:if test="${empty products}">
        <div class="col-12">
          <div class="bg-white rounded-3 shadow-sm p-5 text-center text-muted">
            Chưa có sản phẩm để hiển thị.
          </div>
        </div>
      </c:if>
    </div>

    <!-- New Arrivals -->
    <div class="mt-5 mb-2 d-flex align-items-center justify-content-between">
      <h5 class="m-0 fw-bold">Hàng mới về</h5>
      <a href="${pageContext.request.contextPath}/products" class="small">Xem tất cả</a>
    </div>

    <div class="row g-3">
      <c:forEach var="product" items="${products}">
        <div class="col-6 col-sm-4 col-md-3 col-lg-2">
          <a href="${pageContext.request.contextPath}/product/${product.id}" class="text-decoration-none">
            <div class="card h-100 shadow-sm">
              <div class="ratio ratio-1x1">
                <c:choose>
                  <c:when test="${not empty product.image && (fn:startsWith(product.image, 'http://') || fn:startsWith(product.image, 'https://'))}">
                    <img src="${product.image}"
                         alt="${product.name}" class="w-100 h-100" style="object-fit:cover"
                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/products/n1.jpg'">
                  </c:when>
                  <c:otherwise>
                    <img src="${pageContext.request.contextPath}/assets/images/${product.image}"
                         alt="${product.name}" class="w-100 h-100" style="object-fit:cover"
                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/products/n1.jpg'">
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="card-body p-2">
                <div class="small text-muted text-truncate">
                  <c:set var="catName" value="" />
                  <c:forEach var="cat" items="${categories}">
                    <c:if test="${cat.id == product.category_id}">
                      <c:set var="catName" value="${cat.name}" />
                    </c:if>
                  </c:forEach>
                  <c:choose>
                    <c:when test="${not empty catName}">
                      <a href="${pageContext.request.contextPath}/category/${product.category_id}" class="text-decoration-none text-secondary">${catName}</a>
                    </c:when>
                    <c:otherwise>
                      <span class="text-secondary">Danh mục</span>
                    </c:otherwise>
                  </c:choose>
                </div>
                <div class="small text-dark fw-semibold text-truncate" title="${product.name}">${product.name}</div>
                <div class="d-flex align-items-center gap-2">
                  <span class="text-danger fw-bold">
                    <fmt:formatNumber value="${product.price * 1000}" type="currency" currencySymbol=""/>đ
                  </span>
                  <c:if test="${product.price_old != null && product.price_old > product.price}">
                    <span class="text-muted text-decoration-line-through small">
                      <fmt:formatNumber value="${product.price_old * 1000}" type="currency" currencySymbol=""/>đ
                    </span>
                  </c:if>
                </div>
              </div>
            </div>
          </a>
        </div>
      </c:forEach>
    </div>

  </div>
</div>

<%@ include file="inc/footer.jsp" %>