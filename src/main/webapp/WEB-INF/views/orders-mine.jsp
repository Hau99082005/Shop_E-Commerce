<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="inc/header.jsp" %>

<div class="container my-4">
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
      <li class="breadcrumb-item active" aria-current="page">Đơn hàng của tôi</li>
    </ol>
  </nav>

  <div class="card shadow-sm">
    <div class="card-header bg-white border-0">
      <h5 class="mb-0 fw-bold"><i class="fa-solid fa-receipt me-2"></i>Đơn hàng của tôi</h5>
    </div>
    <div class="card-body">
      <c:choose>
        <c:when test="${empty orders}">
          <div class="text-center text-muted py-5">
            Chưa có đơn hàng nào.
          </div>
        </c:when>
        <c:otherwise>
          <div class="table-responsive">
            <table class="table align-middle">
              <thead>
                <tr>
                  <th scope="col">Mã đơn</th>
                  <th scope="col">Trạng thái</th>
                  <th scope="col">Ngày tạo</th>
                  <th scope="col" class="text-end">Hành động</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="o" items="${orders}">
                  <tr>
                    <td class="fw-semibold">${o.code}</td>
                    <td>
                      <span class="badge ${o.status ? 'text-bg-success' : 'text-bg-secondary'}">
                        ${o.status ? 'Đang xử lý' : 'Đã hủy'}
                      </span>
                    </td>
                    <td>${empty o.createdAt ? '-' : o.createdAt}</td>
                    <td class="text-end">
                      <a class="btn btn-outline-info btn-sm" href="${pageContext.request.contextPath}/checkout/success/${o.code}">
                        <i class="fa-regular fa-eye me-1"></i> Xem chi tiết
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<%@ include file="inc/footer.jsp" %>