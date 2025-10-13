<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/inc/header.jsp" %>

<fmt:setLocale value="vi_VN"/>
<main class="container py-4">
  <h1 class="h4 mb-3">Giỏ hàng</h1>

  <c:choose>
    <c:when test="${empty items}">
      <div class="alert alert-info">Giỏ hàng của bạn đang trống.</div>
      <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">Tiếp tục mua sắm</a>
    </c:when>
    <c:otherwise>
      <div class="table-responsive">
        <table class="table align-middle">
          <thead>
            <tr>
              <th style="width:48px"></th>
              <th>Sản phẩm</th>
              <th class="text-end" style="width:140px">Đơn giá</th>
              <th class="text-center" style="width:160px">Số lượng</th>
              <th class="text-end" style="width:160px">Thành tiền</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="it" items="${items}">
              <tr>
                <td>
                  <form method="post" action="${pageContext.request.contextPath}/cart/delete">
                    <input type="hidden" name="productId" value="${it.product.id}"/>
                    <button type="submit" class="btn btn-sm btn-outline-danger" title="Xóa">
                      <i class="fa-regular fa-circle-xmark"></i>
                    </button>
                  </form>
                </td>
                <td>
                  <div class="d-flex align-items-center gap-2">
                    <c:choose>
                      <c:when test="${not empty it.product.image && (fn:startsWith(it.product.image, 'http://') || fn:startsWith(it.product.image, 'https://'))}">
                        <img src="${it.product.image}" alt="${it.product.name}" style="height:56px;width:56px;object-fit:contain"/>
                      </c:when>
                      <c:otherwise>
                        <img src="${pageContext.request.contextPath}/assets/images/${it.product.image}" alt="${it.product.name}" style="height:56px;width:56px;object-fit:contain"/>
                      </c:otherwise>
                    </c:choose>
                    <div>
                      <div class="fw-semibold">${it.product.name}</div>
                    </div>
                  </div>
                </td>
                <td class="text-end">
                  <fmt:formatNumber value="${it.product.price * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
                </td>
                <td class="text-center">
                  <form method="post" action="${pageContext.request.contextPath}/cart/update" class="d-inline-flex align-items-center justify-content-center gap-2">
                    <input type="hidden" name="productId" value="${it.product.id}"/>
                    <input type="number" name="quantity" class="form-control form-control-sm text-center" style="width: 80px;" min="1" value="${it.quantity}"/>
                    <button type="submit" class="btn btn-sm btn-outline-primary">Cập nhật</button>
                  </form>
                </td>
                <td class="text-end">
                  <fmt:formatNumber value="${it.lineTotal}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <div class="row mt-3 g-3">
        <div class="col-md-6">
          <a href="${pageContext.request.contextPath}/shop" class="btn btn-outline-secondary">Tiếp tục mua sắm</a>
        </div>
        <div class="col-md-6">
          <div class="card ms-md-auto" style="max-width: 420px;">
            <div class="card-body">
              <div class="d-flex justify-content-between mb-2">
                <span>Tổng số lượng</span>
                <strong>${totalQuantity}</strong>
              </div>
              <div class="d-flex justify-content-between mb-2">
                <span>Tạm tính</span>
                <strong><fmt:formatNumber value="${total}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</strong>
              </div>
              <div class="d-flex justify-content-between mb-3 small text-muted">
                <span>Vận chuyển</span>
                <span>Miễn phí</span>
              </div>
              <div class="d-flex justify-content-between border-top pt-3">
                <span class="fw-semibold">Tổng</span>
                <span class="fw-bold text-primary"><fmt:formatNumber value="${total}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
              </div>
              <a href="#" class="btn btn-primary w-100 mt-3">Thanh toán</a>
            </div>
          </div>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jsp" %>
