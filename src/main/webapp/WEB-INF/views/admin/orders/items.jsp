<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin - Chi tiết đơn hàng</title>
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
                    <h3 class="mb-0">Đơn hàng #${order.id} - ${order.code}</h3>
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/orders">Quay lại</a>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-3">
                        <div class="small text-muted">Người dùng</div>
                        <div class="fw-semibold">${userName}</div>
                    </div>
                    <div class="col-md-3">
                        <div class="small text-muted">Trạng thái</div>
                        <div>
                            <span class="badge ${order.status ? 'bg-success' : 'bg-secondary'}">${order.status ? 'Đang xử lý' : 'Đã hủy'}</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="small text-muted">Ngày tạo</div>
                        <div class="fw-semibold">${order.createdAt}</div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Product</th>
                            <th class="text-end">Đơn giá</th>
                            <th class="text-center">Số lượng</th>
                            <th class="text-end">Thành tiền</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="it" items="${items}" varStatus="st">
                            <tr>
                                <td>${st.index + 1}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty productsMap && productsMap[it.productId] != null}">
                                            ${productsMap[it.productId]}
                                        </c:when>
                                        <c:otherwise>
                                            ${it.productId}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end"><fmt:formatNumber value="${it.price * 1000}" type="currency" currencySymbol=""/>đ</td>
                                <td class="text-center">${it.quantity}</td>
                                <td class="text-end"><fmt:formatNumber value="${it.price * it.quantity * 1000}" type="currency" currencySymbol=""/>đ</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty items}">
                            <tr>
                                <td colspan="5" class="text-center text-muted">Không có sản phẩm</td>
                            </tr>
                        </c:if>
                        </tbody>
                        <tfoot>
                        <tr>
                            <th colspan="4" class="text-end">Tổng cộng</th>
                            <th class="text-end text-danger h6 m-0"><fmt:formatNumber value="${total * 1000}" type="currency" currencySymbol=""/>đ</th>
                        </tr>
                        </tfoot>
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
