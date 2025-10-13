<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="bg-light py-3">
  <div class="container">

    <div class="text-center mb-3">
      <h4 class="fw-bold m-0">Danh Mục Sản Phẩm</h4>
      <div class="text-muted">Khám phá các danh mục đa dạng của chúng tôi</div>
    </div>

    <div class="row g-3">
      <c:forEach var="cat" items="${categories}">
        <div class="col-6 col-md-4 col-lg-3">
          <a href="${pageContext.request.contextPath}/shop?categoryId=${cat.id}" class="text-decoration-none">
            <div class="bg-white rounded-4 shadow-sm p-2 h-100 d-flex flex-column" style="border:1px solid #55C5EA;">
              <div class="ratio ratio-4x3 rounded-3 overflow-hidden mb-2">
                <c:choose>
                  <c:when test="${not empty cat.thumbnail && (fn:startsWith(cat.thumbnail,'http://') || fn:startsWith(cat.thumbnail,'https://'))}">
                    <img src="${cat.thumbnail}" alt="${cat.name}" class="w-100 h-100" style="object-fit:cover"
                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/hero4.png'">
                  </c:when>
                  <c:otherwise>
                    <img src="${pageContext.request.contextPath}/assets/images/${cat.thumbnail}" alt="${cat.name}" class="w-100 h-100" style="object-fit:cover"
                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/hero4.png'">
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="text-center fw-semibold text-dark small flex-grow-0">${cat.name}</div>
            </div>
          </a>
        </div>
      </c:forEach>

      <c:if test="${empty categories}">
        <div class="col-12">
          <div class="bg-white rounded-3 shadow-sm p-5 text-center text-muted">
            Chưa có danh mục để hiển thị.
          </div>
        </div>
      </c:if>
    </div>

  </div>
</div>

<%@ include file="inc/footer.jsp" %>