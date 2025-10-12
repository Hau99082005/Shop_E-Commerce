<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin - Categories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<div class="container-fluid position-relative d-flex p-0">
    <%@ include file="/WEB-INF/views/admin/inc/sidebar.jsp" %>
    <div class="content">
        <%@ include file="/WEB-INF/views/admin/inc/navbar.jsp" %>

        <div class="container-fluid pt-4 px-4">
            <div class="bg-light rounded h-100 p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="mb-0">Quản trị - Danh mục</h3>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/categories/create"> <i class="fa-solid fa-plus"></i> Thêm danh mục</a>
                </div>
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Thumbnail</th>
                            <th>Trạng thái</th>
                            <th class="text-end">Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="c" items="${categories}">
                            <tr>
                                <td>${c.id}</td>
                                <td>${c.name}</td>
                                <td>
                                    <c:if test="${not empty c.thumbnail}">
                                        <c:set var="thumbnail" value="${c.thumbnail}" />
                                        <c:choose>
                                            <c:when test="${fn:startsWith(thumbnail, 'http://') || fn:startsWith(thumbnail, 'https://')}">
  <img src="${pageContext.request.contextPath}/img-proxy?url=${fn:escapeXml(thumbnail)}"
       alt="${c.name}" style="height:40px" loading="lazy"
       onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/images/placeholder.png';" />
</c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/images/${c.thumbnail}" alt="${c.name}" style="height:40px" 
                                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/images/placeholder.png';" />
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </td>
                                <td>
                                    <div class="form-check form-switch m-0">
                                        <input class="form-check-input" type="checkbox" role="switch" 
                                               ${c.status ? 'checked' : ''}
                                               onclick="location.href='${pageContext.request.contextPath}/admin/categories/${c.id}/toggle'">
                                        <label class="form-check-label ms-2">
                                            <c:out value="${c.status ? 'Active' : 'Inactive'}" />
                                        </label>
                                    </div>
                                </td>
                                <td class="text-end">
                                    <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin/categories/${c.id}/edit"><i class="fa-solid fa-pen-to-square"></i>Sửa</a>
                                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/categories/${c.id}/delete" onclick="return confirm('Xóa danh mục này?');"><i class="fa-solid fa-trash"></i>Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty categories}">
                            <tr>
                                <td colspan="5" class="text-center text-muted">Chưa có danh mục</td>
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