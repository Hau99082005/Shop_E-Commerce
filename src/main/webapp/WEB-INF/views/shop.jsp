<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/inc/header.jsp" %>

<fmt:setLocale value="vi_VN"/>
<main class="container py-4">
  <div class="d-flex align-items-center justify-content-between mb-3">
    <h1 class="h4 mb-0">Cửa hàng</h1>
    <form class="d-flex gap-2" method="get" action="${pageContext.request.contextPath}/shop">
      <select class="form-select" name="categoryId" style="min-width:260px">
        <option value="0" ${categoryId == null || categoryId == 0 ? 'selected' : ''}>Tất cả danh mục</option>
        <c:forEach var="c" items="${categories}">
          <option value="${c.id}" ${categoryId != null && categoryId == c.id ? 'selected' : ''}>${c.name}</option>
        </c:forEach>
      </select>
      <button class="btn btn-primary" type="submit">Lọc</button>
    </form>
  </div>

  <c:choose>
    <c:when test="${empty productList}">
      <div class="alert alert-info">Chưa có sản phẩm phù hợp.</div>
    </c:when>
    <c:otherwise>
      <div class="row g-3">
        <c:forEach var="p" items="${productList}">
          <div class="col-6 col-md-4 col-lg-3">
            <div class="card h-100 shadow-sm">
              <c:choose>
                <c:when test="${not empty p.image && (fn:startsWith(p.image, 'http://') || fn:startsWith(p.image, 'https://'))}">
                  <img src="${p.image}" class="card-img-top" alt="${p.name}" style="object-fit:contain;height:180px">
                </c:when>
                <c:otherwise>
                  <img src="${pageContext.request.contextPath}/assets/images/${p.image}" class="card-img-top" alt="${p.name}" style="object-fit:contain;height:180px">
                </c:otherwise>
              </c:choose>
              <div class="card-body d-flex flex-column">
                <h6 class="card-title flex-grow-1 text-truncate">${p.name}</h6>
                <div>
                  <span class="fw-semibold text-primary">
                    <fmt:formatNumber value="${p.price * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
                  </span>
                  <c:if test="${p.price_old != null && p.price_old > p.price}">
                    <span class="text-muted text-decoration-line-through small ms-2">
                      <fmt:formatNumber value="${p.price_old * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
                    </span>
                  </c:if>
                </div>
              </div>
              <div class="card-footer bg-white border-0 pt-0 d-grid gap-2">
                <a href="${pageContext.request.contextPath}/product/${p.id}" class="btn btn-sm btn-outline-primary">Xem chi tiết</a>
                <form method="post" action="${pageContext.request.contextPath}/cart/add" class="d-grid">
                  <input type="hidden" name="productId" value="${p.id}"/>
                  <input type="hidden" name="quantity" value="1"/>
                  <button type="submit" class="btn btn-sm btn-primary"><i class="fa-solid fa-cart-plus me-1"></i> Thêm vào giỏ</button>
                </form>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>

      <c:if test="${numberPage > 1}">
        <nav class="mt-4" aria-label="Pagination">
          <ul class="pagination justify-content-center">
            <li class="page-item ${page <= 1 ? 'disabled' : ''}">
              <a class="page-link" href="${pageContext.request.contextPath}/shop?page=${page-1}&categoryId=${categoryId != null ? categoryId : 0}">Trước</a>
            </li>
            <c:forEach var="i" begin="1" end="${numberPage}">
              <li class="page-item ${i == page ? 'active' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/shop?page=${i}&categoryId=${categoryId != null ? categoryId : 0}">${i}</a>
              </li>
            </c:forEach>
            <li class="page-item ${page >= numberPage ? 'disabled' : ''}">
              <a class="page-link" href="${pageContext.request.contextPath}/shop?page=${page+1}&categoryId=${categoryId != null ? categoryId : 0}">Sau</a>
            </li>
          </ul>
        </nav>
      </c:if>
    </c:otherwise>
  </c:choose>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jsp" %>
