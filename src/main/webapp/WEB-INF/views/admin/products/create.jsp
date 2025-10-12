<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin - Thêm sản phẩm</title>
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
            <div class="bg-light rounded p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="mb-0">Thêm sản phẩm</h3>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/products">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </a>
                </div>

                <form action="${pageContext.request.contextPath}/admin/products/create" method="post" enctype="multipart/form-data">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Tên sản phẩm</label>
                            <input type="text" class="form-control" name="name" required />
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Giá</label>
                            <input type="number" step="0.01" min="0" class="form-control" name="price" required />
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Giá cũ</label>
                            <input type="number" step="0.01" min="0" class="form-control" name="price_old" />
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Số lượng</label>
                            <input type="number" min="0" class="form-control" name="quantity" value="0" required />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Danh mục</label>
                            <select class="form-select" name="category_id" required>
                                <option value="" disabled selected>-- Chọn danh mục --</option>
                                <c:forEach var="c" items="${categories}">
                                    <option value="${c.id}">${c.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <label class="form-label">Ảnh</label>
                            <input type="file" class="form-control" name="image" accept="image/*" required />
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description" rows="5"></textarea>
                        </div>
                        <div class="col-md-12">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="status" id="status" checked />
                                <label class="form-check-label" for="status">Kích hoạt</label>
                            </div>
                        </div>
                    </div>
                    <div class="mt-4">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa-solid fa-floppy-disk"></i> Lưu
                        </button>
                        <a class="btn btn-outline-secondary ms-2" href="${pageContext.request.contextPath}/admin/products">Hủy</a>
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
