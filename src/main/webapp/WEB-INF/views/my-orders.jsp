<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="inc/header.jsp" %>
<fmt:setLocale value="vi_VN"/>

<div class="container my-4">
  <nav aria-label="breadcrumb" class="mb-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
      <li class="breadcrumb-item active">Đơn hàng của tôi</li>
    </ol>
  </nav>

  <h4 class="mb-3 fw-bold">Đơn hàng của tôi</h4>

  <c:choose>
    <c:when test="${empty orders}">
      <div class="text-center py-5">
        <i class="fa-regular fa-folder-open fa-3x text-muted mb-3"></i>
        <p class="text-muted">Bạn chưa có đơn hàng nào.</p>
        <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">Mua sắm ngay</a>
      </div>
    </c:when>
    <c:otherwise>
      <c:forEach var="o" items="${orders}">
        <div class="card mb-3 shadow-sm">
          <div class="card-header d-flex justify-content-between align-items-center bg-white">
            <span class="text-muted small">Mã đơn: <strong>${o.code}</strong></span>
            <div class="d-flex align-items-center gap-2">
              <c:choose>
                <c:when test="${o.processed}">
                  <span class="badge bg-success">Đã xử lý</span>
                </c:when>
                <c:when test="${o.status}">
                  <span class="badge bg-warning text-dark">Đang xử lý</span>
                </c:when>
                <c:otherwise>
                  <span class="badge bg-secondary">Đã hủy</span>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
          <div class="card-body d-flex justify-content-between align-items-center">
            <div>
              <div class="text-muted small mb-1">
                <i class="fa-regular fa-clock me-1"></i>${o.createdAt}
              </div>
              <div class="small">
                <span class="me-3"><i class="fa-solid fa-box me-1"></i>${countMap[o.id]} sản phẩm</span>
                <span class="fw-bold text-danger">
                  <fmt:formatNumber value="${totalsMap[o.id] * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫
                </span>
              </div>
            </div>
            <a href="${pageContext.request.contextPath}/my-orders/${o.id}" class="btn btn-outline-primary btn-sm">
              Xem chi tiết
            </a>
          </div>
        </div>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</div>

<%@ include file="inc/footer.jsp" %>
