<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="inc/header.jsp" %>

<div class="container my-4">
  <div class="bg-white rounded-3 shadow-sm p-4">
    <h3 class="mb-3">Thanh toán thành công</h3>
    <p class="text-muted mb-1">Mã đơn hàng: <strong>${order.code}</strong></p>
    <p class="text-muted">Trạng thái:
      <c:choose>
        <c:when test="${order.processed}">
          <span class="badge bg-success">Đã xử lý</span>
        </c:when>
        <c:when test="${order.status}">
          <span class="badge bg-warning text-dark">Đang xử lý</span>
        </c:when>
        <c:otherwise>
          <span class="badge bg-secondary">Đã hủy</span>
        </c:otherwise>
      </c:choose>
    </p>

    <hr/>

    <h5 class="mt-3 mb-3">Sản phẩm trong đơn</h5>
    <div class="table-responsive">
      <table class="table align-middle">
        <thead>
          <tr>
            <th>#</th>
            <th>Sản phẩm</th>
            <th class="text-end">Đơn giá</th>
            <th class="text-center">Số lượng</th>
            <th class="text-end">Thành tiền</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="it" items="${items}" varStatus="st">
            <tr>
              <td>${st.index + 1}</td>
             <td>
  <c:choose>
    <c:when test="${not empty productsMap && productsMap[it.productId] != null}">
      ${productsMap[it.productId]}
    </c:when>
    <c:otherwise>
      ${it.productId}
    </c:otherwise>
  </c:choose>
</td>
              <td class="text-end"><fmt:formatNumber value="${it.price * 1000}" type="currency" currencySymbol=""/>đ</td>
              <td class="text-center">${it.quantity}</td>
              <td class="text-end"><fmt:formatNumber value="${it.price * it.quantity * 1000}" type="currency" currencySymbol=""/>đ</td>
            </tr>
          </c:forEach>
          <c:if test="${empty items}">
            <tr>
              <td colspan="5" class="text-center text-muted">Không có sản phẩm.</td>
            </tr>
          </c:if>
        </tbody>
        <tfoot>
          <tr>
            <th colspan="4" class="text-end">Tổng cộng</th>
            <th class="text-end text-danger h6 m-0"><fmt:formatNumber value="${total * 1000}" type="currency" currencySymbol=""/>đ</th>
          </tr>
        </tfoot>
      </table>
    </div>

    <div class="d-flex gap-2 mt-3">
      <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Về trang chủ</a>
      <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-primary">Xem đơn hàng của tôi</a>
      <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary">Tiếp tục mua sắm</a>
    </div>
  </div>
</div>

<%@ include file="inc/footer.jsp" %>
