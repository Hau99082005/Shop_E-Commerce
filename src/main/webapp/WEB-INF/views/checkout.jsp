<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/inc/header.jsp" %>

<fmt:setLocale value="vi_VN"/>
<main class="container py-4">
  <h1 class="h4 mb-3">Xác nhận đơn hàng</h1>

  <div class="row g-4">
    <div class="col-md-8">
      <div class="card">
        <div class="card-header fw-semibold">Sản phẩm trong đơn</div>
        <div class="card-body p-0">
          <table class="table mb-0">
            <thead>
              <tr>
                <th>Sản phẩm</th>
                <th class="text-center">Số lượng</th>
                <th class="text-end">Thành tiền</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="it" items="${items}">
                <tr>
                  <td>${it.product.name}</td>
                  <td class="text-center">${it.quantity}</td>
                  <td class="text-end">
                    <fmt:formatNumber value="${it.lineTotal}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <div class="col-md-4">
      <div class="card">
        <div class="card-body">
          <div class="d-flex justify-content-between border-top pt-3 mb-3">
            <span class="fw-semibold">Tổng cộng</span>
            <span class="fw-bold text-primary">
              <fmt:formatNumber value="${total}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
            </span>
          </div>
          <form method="post" action="${pageContext.request.contextPath}/checkout">
            <button type="submit" class="btn btn-success w-100">Xác nhận đặt hàng</button>
          </form>
          <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary w-100 mt-2">Quay lại giỏ hàng</a>
        </div>
      </div>
    </div>
  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jsp" %>
