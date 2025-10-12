<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin - Thêm Banner</title>
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
                    <h3 class="mb-0">Thêm Banner</h3>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/banners">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </a>
                </div>

                <form class="row g-3"
                      method="post"
                      action="${pageContext.request.contextPath}/admin/banners/create"
                      enctype="multipart/form-data">
                    <div class="col-12">
                        <label class="form-label">Tiêu đề</label>
                        <input type="text" name="name" class="form-control" value="${banner.title}" required />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Ảnh</label>
                        <input type="file" name="image" class="form-control" accept="image/*" required />
                        <div class="form-text">Chọn ảnh banner (khuyến nghị tỉ lệ ngang lớn).</div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label d-block">Trạng thái</label>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="statusSwitch" name="status" ${banner.status ? 'checked' : ''}/>
                            <label class="form-check-label" for="statusSwitch">
                                <c:out value="${banner.status ? 'Active' : 'Inactive'}" />
                            </label>
                        </div>
                    </div>

                    <div class="col-12 d-flex justify-content-end gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa-solid fa-plus"></i> Tạo
                        </button>
                        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/banners">
                            Hủy
                        </a>
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