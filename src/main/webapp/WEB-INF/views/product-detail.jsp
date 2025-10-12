<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/inc/header.jsp" %>

<main class="container py-4">
  <c:if test="${empty product}">
    <div class="alert alert-warning">Sản phẩm không tồn tại.</div>
  </c:if>

  <c:if test="${not empty product}">
    <nav aria-label="breadcrumb" class="mb-3">
      <ol class="breadcrumb mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/category/${product.category_id}">Danh mục</a></li>
        <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
      </ol>
    </nav>

    <div class="row g-4">
      <div class="col-lg-6">
        <div class="bg-white rounded p-3 shadow-sm">
          <c:choose>
            <c:when test="${not empty product.image && (fn:startsWith(product.image, 'http://') || fn:startsWith(product.image, 'https://'))}">
              <img id="mainImage" src="${product.image}" alt="${product.name}" class="img-fluid w-100"/>
            </c:when>
            <c:otherwise>
              <img id="mainImage" src="${pageContext.request.contextPath}/assets/images/${product.image}" alt="${product.name}" class="img-fluid w-100"/>
            </c:otherwise>
          </c:choose>
        </div>

        <c:if test="${not empty galleryList}">
          <div class="d-flex gap-2 mt-3 flex-wrap">
            <c:forEach var="g" items="${galleryList}">
              <c:choose>
                <c:when test="${not empty g.image && (fn:startsWith(g.image, 'http://') || fn:startsWith(g.image, 'https://'))}">
                  <img src="${g.image}" class="img-thumbnail" style="height:70px;width:auto;" alt="${product.name}"/>
                </c:when>
                <c:otherwise>
                  <img src="${pageContext.request.contextPath}/assets/images/${g.image}" class="img-thumbnail" style="height:70px;width:auto;" alt="${product.name}"/>
                </c:otherwise>
              </c:choose>
            </c:forEach>
          </div>
        </c:if>
      </div>

      <div class="col-lg-6">
        <div class="h-100" style="position: sticky; top: 1rem;">
          <div class="bg-white rounded p-4 shadow-sm h-100">
            <h1 class="h4 mb-2">${product.name}</h1>
            <div class="d-flex align-items-baseline gap-3 mb-3">
              <span class="display-6 text-primary fw-bold" style="font-size:1.8rem;">
                <fmt:formatNumber value="${product.price * 1000}" type="number" />
              </span>
              <c:if test="${product.price_old != null && product.price_old > product.price}">
                <span class="text-muted text-decoration-line-through">
                  <fmt:formatNumber value="${product.price_old * 1000}" type="number" />
                </span>
                <span class="badge bg-danger-subtle text-danger">Giảm giá</span>
              </c:if>
            </div>

            <c:if test="${not empty product.description}">
              <div class="mb-4">
                <div class="small text-muted mb-1">Mô tả</div>
                <div class="text-secondary">${product.description}</div>
              </div>
            </c:if>

            <ul class="list-unstyled small text-secondary mb-3">
              <li class="mb-1"><i class="fa-solid fa-truck-fast me-2 text-success"></i>Giao nhanh trong 2-5 ngày</li>
              <li class="mb-1"><i class="fa-solid fa-shield-halved me-2 text-primary"></i>Bảo hành chính hãng</li>
              <li class="mb-1"><i class="fa-solid fa-rotate-left me-2 text-warning"></i>Đổi trả trong 7 ngày</li>
            </ul>

            <div class="d-flex align-items-center gap-2 mb-3">
              <label class="small text-muted">Số lượng</label>
              <div class="input-group" style="width: 140px;">
                <button class="btn btn-outline-secondary" type="button" onclick="var i=document.getElementById('qty'); if(i.value>1) i.value=parseInt(i.value)-1;">-</button>
                <input id="qty" type="number" class="form-control text-center" value="1" min="1" />
                <button class="btn btn-outline-secondary" type="button" onclick="var i=document.getElementById('qty'); i.value=parseInt(i.value||1)+1;">+</button>
              </div>
            </div>

            <div class="d-flex gap-2">
              <a href="#" class="btn btn-primary"><i class="fa-solid fa-cart-plus me-1"></i> Thêm vào giỏ</a>
              <a href="#" class="btn btn-outline-primary">Mua ngay</a>
              <a href="#" class="btn btn-outline-secondary">Yêu thích</a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="mt-5">
      <h2 class="h5 mb-3">Sản phẩm liên quan</h2>
      <c:choose>
        <c:when test="${empty relatedProducts}">
          <div class="alert alert-light border">Chưa có sản phẩm liên quan.</div>
        </c:when>
        <c:otherwise>
          <div class="row g-3">
            <c:forEach var="p" items="${relatedProducts}" varStatus="st">
              <c:if test="${st.index < 8}">
                <div class="col-6 col-md-3">
                  <div class="card h-100 shadow-sm">
                    <a href="${pageContext.request.contextPath}/product/${p.id}" class="text-decoration-none">
                      <c:choose>
                        <c:when test="${not empty p.image && (fn:startsWith(p.image, 'http://') || fn:startsWith(p.image, 'https://'))}">
                          <img src="${p.image}" class="card-img-top" alt="${p.name}" style="height:180px;object-fit:contain;"/>
                        </c:when>
                        <c:otherwise>
                          <img src="${pageContext.request.contextPath}/assets/images/${p.image}" class="card-img-top" alt="${p.name}" style="height:180px;object-fit:contain;"/>
                        </c:otherwise>
                      </c:choose>
                      <div class="card-body">
                        <div class="small text-truncate mb-1">${p.name}</div>
                        <div class="fw-semibold text-primary"><fmt:formatNumber value="${p.price * 1000}" type="number" /></div>
                      </div>
                    </a>
                  </div>
                </div>
              </c:if>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </c:if>
  <script>
    (function(){
      const main = document.getElementById('mainImage');
      if (!main) return;
      document.querySelectorAll('.img-thumbnail').forEach(function(th){
        th.addEventListener('click', function(){
          if (this.src) main.src = this.src;
          window.scrollTo({ top: document.querySelector('#mainImage').offsetTop - 120, behavior: 'smooth' });
        });
      });
    })();
  </script>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jsp" %>
