<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin - Banners</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<div class="container-fluid position-relative d-flex p-0">
    <%@ include file="/WEB-INF/views/admin/inc/sidebar.jsp" %>
    <div class="content">
        <%@ include file="/WEB-INF/views/admin/inc/navbar.jsp" %>

        <div class="container-fluid pt-4 px-4">
            <div class="bg-light rounded h-100 p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="mb-0">Quản trị - Banner</h3>
                    <!-- Thêm mới (nếu sau này có route) -->
                     <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/banners/create">
                        <i class="fa-solid fa-plus"></i> Thêm banner
                    </a> 
                </div>

                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Ảnh</th>
                            <th>Trạng thái</th>
                            <th class="text-end">Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="b" items="${banners}">
                            <tr>
                                <td>${b.id}</td>
                                <td>
                                    <c:if test="${not empty b.image}">
                                        <c:set var="imgUrl" value="${b.image}" />
                                        <c:choose>
                                            <c:when test="${fn:startsWith(imgUrl, 'http://') || fn:startsWith(imgUrl, 'https://')}">
                                                <img src="${pageContext.request.contextPath}/img-proxy?url=${fn:escapeXml(imgUrl)}"
                                                     alt="${b.title}" style="height:40px" loading="lazy"
                                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/images/placeholder.png';" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/images/${b.image}"
                                                     alt="${b.title}" style="height:40px"
                                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/images/hero4.png';" />
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </td>
                                <td>
                                    <div class="form-check form-switch m-0">
                                        <input class="form-check-input" type="checkbox" role="switch"
                                               ${b.status ? 'checked' : ''}
                                               onclick="location.href='${pageContext.request.contextPath}/admin/banners/${b.id}/toggle'">
                                        <label class="form-check-label ms-2">
                                            <c:out value="${b.status ? 'Active' : 'Inactive'}" />
                                        </label>
                                    </div>
                                </td>
                                <td class="text-end">
                                    <!-- Các route edit/delete/toggle nếu sau này bạn tạo -->
                                    
                                    <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin/banners/${b.id}/edit">
                                        <i class="fa-solid fa-pen-to-square"></i> Sửa
                                    </a>
                                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/banners/${b.id}/delete"
                                       onclick="return confirm('Xóa banner này?');">
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </a>
                                    
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty banners}">
                            <tr>
                                <td colspan="5" class="text-center text-muted">Chưa có banner</td>
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