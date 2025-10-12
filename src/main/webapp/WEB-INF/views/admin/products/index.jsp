<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin - Products</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
</head>
<body>
<div class="container-fluid position-relative d-flex p-0">
    <%@ include file="/WEB-INF/views/admin/inc/sidebar.jsp" %>
    <div class="content">
        <%@ include file="/WEB-INF/views/admin/inc/navbar.jsp" %>

        <div class="container-fluid pt-4 px-4">
            <div class="bg-light rounded h-100 p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="mb-0">Quản trị - Sản phẩm</h3>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/products/create">
                        <i class="fa-solid fa-plus"></i> Thêm sản phẩm
                    </a>
                </div>

                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Ảnh</th>
                            <th>Tên</th>
                            <th>Danh mục</th>
                            <th>Giá</th>
                            <th>Trạng thái</th>
                            <th class="text-end">Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td>${p.id}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty p.image && (fn:startsWith(p.image, 'http://') || fn:startsWith(p.image, 'https://'))}">
                                            <img src="${p.image}" alt="${p.name}" style="height:40px"/>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/assets/images/${p.image}" alt="${p.name}" style="height:40px"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-truncate" style="max-width:240px;" title="${p.name}">${p.name}</td>
                                <td>
                                    <c:set var="catName" value=""/>
                                    <c:forEach var="c" items="${categories}">
                                        <c:if test="${c.id == p.category_id}">
                                            <c:set var="catName" value="${c.name}"/>
                                        </c:if>
                                    </c:forEach>
                                    <c:out value="${empty catName ? '—' : catName}"/>
                                </td>
                                <td>
                                    <c:out value="${p.price}"/>
                                    <c:if test="${p.price_old != null && p.price_old > p.price}">
                                        <span class="text-muted text-decoration-line-through small ms-2">${p.price_old}</span>
                                    </c:if>
                                </td>
                                <td>
                                    <a class="btn btn-sm ${p.status ? 'btn-success' : 'btn-secondary'}" href="${pageContext.request.contextPath}/admin/products/${p.id}/toggle">
                                        ${p.status ? 'Hoạt động' : 'Không hoạt động'}
                                    </a>
                                </td>
                                <td class="text-end">
                                    <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin/products/${p.id}/edit">
                                        <i class="fa-solid fa-pen-to-square"></i> Sửa
                                    </a>
                                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/products/${p.id}/delete" onclick="return confirm('Xóa sản phẩm này?');">
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty products}">
                            <tr>
                                <td colspan="7" class="text-center text-muted">Chưa có sản phẩm</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/views/admin/inc/footer.jsp" %>
    </div>
</div>
<script src="${pageContext.request.contextPath}/assets/admin/js/bootstrap.bundle.min.js"></script>
</body>
</html>