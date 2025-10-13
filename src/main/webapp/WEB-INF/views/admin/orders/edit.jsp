<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin - ${mode == 'create' ? 'Tạo' : 'Sửa'} đơn hàng</title>
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
                <h3 class="mb-3">${mode == 'create' ? 'Tạo' : 'Sửa'} đơn hàng</h3>

                <c:choose>
                    <c:when test="${mode == 'create'}">
                        <form method="post" action="${pageContext.request.contextPath}/admin/orders/create">
                    </c:when>
                    <c:otherwise>
                        <form method="post" action="${pageContext.request.contextPath}/admin/orders/${order.id}/edit">
                    </c:otherwise>
                </c:choose>

                    <div class="mb-3">
                        <label class="form-label">Mã đơn</label>
                        <input type="text" name="code" class="form-control" value="${order.code}" ${mode == 'edit' ? '' : ''} />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Người dùng</label>
                        <select name="userId" class="form-select">
                            <option value="0" ${order.userId == 0 ? 'selected' : ''}>-- Chọn người dùng --</option>
                            <c:forEach var="u" items="${users}">
                                <option value="${u.id}" ${u.id == order.userId ? 'selected' : ''}>
                                    <c:out value="${not empty u.name ? u.name : u.email}"/>
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Trạng thái</label>
                        <select name="status" class="form-select">
                            <option value="true" ${order.status ? 'selected' : ''}>Đang xử lý</option>
                            <option value="false" ${!order.status ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">Lưu</button>
                        <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-secondary">Hủy</a>
                    </div>
                </form>
            </div>
        </div>

        <%@ include file="/WEB-INF/views/admin/inc/footer.jsp" %>
    </div>
</div>
<script src="${pageContext.request.contextPath}/assets/admin/js/bootstrap.bundle.min.js"></script>
</body>
</html>
