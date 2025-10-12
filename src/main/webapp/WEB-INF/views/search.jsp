<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"/>
  <title>Kết quả tìm kiếm</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/css/bootstrap.min.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/css/style.css"/>
</head>
<body>
<div class="container py-4">
  <h1 class="h4 mb-3">Tìm kiếm sản phẩm</h1>

  <form class="row g-2 mb-4" method="get" action="${pageContext.request.contextPath}/search">
    <div class="col-md-6">
      <input type="text" class="form-control" name="keyword" placeholder="Nhập từ khóa..."
             value="${fn:escapeXml(keyword)}"/>
    </div>
    <div class="col-md-4">
      <select class="form-select" name="categoryId">
        <option value="0" ${categoryId == null || categoryId == 0 ? 'selected' : ''}>Tất cả danh mục</option>
        <c:forEach var="c" items="${categories}">
          <option value="${c.id}" ${categoryId != null && categoryId == c.id ? 'selected' : ''}>${c.name}</option>
        </c:forEach>
      </select>
    </div>
    <div class="col-md-2 d-grid">
      <button type="submit" class="btn btn-primary">Tìm kiếm</button>
    </div>
  </form>

  <c:choose>
    <c:when test="${empty productList}">
      <div class="alert alert-info">Không tìm thấy sản phẩm phù hợp.</div>
    </c:when>
    <c:otherwise>
      <div class="table-responsive">
        <table class="table align-middle">
          <thead>
          <tr>
            <th>Ảnh</th>
            <th>Tên</th>
            <th>Giá</th>
            <th></th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="p" items="${productList}">
            <tr>
              <td style="width:80px">
                <c:choose>
                  <c:when test="${not empty p.image && (fn:startsWith(p.image, 'http://') || fn:startsWith(p.image, 'https://'))}">
                    <img src="${p.image}" alt="${p.name}" style="height:60px"/>
                  </c:when>
                  <c:otherwise>
                    <img src="${pageContext.request.contextPath}/assets/images/${p.image}" alt="${p.name}" style="height:60px"/>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <a href="${pageContext.request.contextPath}/product/${p.id}" class="text-decoration-none">
                  ${p.name}
                </a>
              </td>
              <td>
                ${p.price}
                <c:if test="${p.price_old != null && p.price_old > p.price}">
                  <span class="text-muted text-decoration-line-through small ms-2">${p.price_old}</span>
                </c:if>
              </td>
              <td class="text-end">
                <a href="${pageContext.request.contextPath}/product/${p.id}" class="btn btn-sm btn-outline-primary">
                  Xem chi tiết
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

<script src="${pageContext.request.contextPath}/assets/admin/js/bootstrap.bundle.min.js"></script>
</body>
</html>