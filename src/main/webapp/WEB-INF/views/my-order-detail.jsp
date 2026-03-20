<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="inc/header.jsp" %>
<fmt:setLocale value="vi_VN"/>

<div class="container my-4">
  <nav aria-label="breadcrumb" class="mb-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/my-orders">Đơn hàng của tôi</a></li>
      <li class="breadcrumb-item active">${order.code}</li>
    </ol>
  </nav>

  <div class="card shadow-sm mb-3">
    <div class="card-header bg-white d-flex justify-content-between align-items-center">
      <span class="fw-bold">Chi tiết đơn hàng #${order.code}</span>
      <c:choose>
        <c:when test="${order.processed}">
          <span class="badge bg-success fs-6">Đã xử lý</span>
        </c:when>
        <c:when test="${order.status}">
          <span class="badge bg-warning text-dark fs-6">Đang xử lý</span>
        </c:when>
        <c:otherwise>
          <span class="badge bg-secondary fs-6">Đã hủy</span>
        </c:otherwise>
      </c:choose>
    </div>

    <div class="card-body p-0">
      <c:forEach var="it" items="${items}">
        <c:set var="prod" value="${productsMap[it.productId]}"/>
        <div class="d-flex align-items-center gap-3 p-3 border-bottom">
          <c:choose>
            <c:when test="${not empty prod.image && (fn:startsWith(prod.image,'http://') || fn:startsWith(prod.image,'https://'))}">
              <img src="${prod.image}" alt="${prod.name}" style="width:80px;height:80px;object-fit:contain;border:1px solid #eee;border-radius:6px;">
            </c:when>
            <c:when test="${not empty prod.image}">
              <img src="${pageContext.request.contextPath}/assets/images/${prod.image}" alt="${prod.name}" style="width:80px;height:80px;object-fit:contain;border:1px solid #eee;border-radius:6px;">
            </c:when>
            <c:otherwise>
              <div style="width:80px;height:80px;background:#f3f4f6;border-radius:6px;display:flex;align-items:center;justify-content:center;">
                <i class="fa-solid fa-image text-muted"></i>
              </div>
            </c:otherwise>
          </c:choose>
          <div class="flex-grow-1">
            <div class="fw-semibold">${not empty prod.name ? prod.name : it.productId}</div>
            <div class="text-muted small">x${it.quantity}</div>
          </div>
          <div class="text-end">
            <div class="text-muted small text-decoration-line-through">
              <fmt:formatNumber value="${it.price * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫
            </div>
            <div class="fw-bold text-danger">
              <fmt:formatNumber value="${it.price * it.quantity * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫
            </div>
          </div>
        </div>
      </c:forEach>
    </div>

    <div class="card-footer bg-white">
      <div class="d-flex justify-content-between align-items-center">
        <span class="text-muted small">Ngày đặt: ${order.createdAt}</span>
        <div class="text-end">
          <span class="text-muted me-2">Tổng cộng:</span>
          <span class="fw-bold text-danger fs-5">
            <fmt:formatNumber value="${total * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫
          </span>
        </div>
      </div>
    </div>
  </div>

  <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-secondary btn-sm">
    <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
  </a>
</div>

<%@ include file="inc/footer.jsp" %>
