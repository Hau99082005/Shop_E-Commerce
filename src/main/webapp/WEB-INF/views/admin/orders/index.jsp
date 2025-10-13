<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin - Orders</title>
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
                    <h3 class="mb-0">Quản trị - Đơn hàng</h3>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/orders/create">
                        <i class="fa-solid fa-plus"></i> Tạo đơn hàng
                    </a>
                </div>

                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Mã đơn</th>
                            <th>Người dùng</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
                            <th class="text-end">Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td>${o.id}</td>
                                <td>${o.code}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty usersMap && usersMap[o.userId] != null}">
                                            ${usersMap[o.userId]}
                                        </c:when>
                                        <c:otherwise>
                                            ${o.userId}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="badge ${o.status ? 'bg-success' : 'bg-secondary'}">
                                        ${o.status ? 'Đang xử lý' : 'Đã hủy'}
                                    </span>
                                </td>
                                <td>${o.createdAt}</td>
                                <td class="text-end">
                                    <a class="btn btn-sm btn-outline-info" href="${pageContext.request.contextPath}/admin/orders/${o.id}">
                                        <i class="fa-solid fa-list"></i> Xem đơn hàng
                                    </a>
                                    <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin/orders/${o.id}/edit">
                                        <i class="fa-solid fa-pen-to-square"></i> Sửa
                                    </a>
                                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/orders/${o.id}/delete" onclick="return confirm('Xóa đơn hàng này?');">
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty orders}">
                            <tr>
                                <td colspan="6" class="text-center text-muted">Chưa có đơn hàng</td>
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
