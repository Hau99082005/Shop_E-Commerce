<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin - Sửa Banner</title>
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
                    <h3 class="mb-0">Sửa Banner</h3>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/banners">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </a>
                </div>

                <form class="row g-3"
                      method="post"
                      action="${pageContext.request.contextPath}/admin/banners/${banner.id}/edit"
                      enctype="multipart/form-data">
                    <div class="col-12">
                        <label class="form-label">Tiêu đề</label>
                        <input type="text" name="title" class="form-control" value="${banner.title}" required />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Ảnh hiện tại</label>
                        <div class="d-flex align-items-center gap-3">
                            <c:choose>
                                <c:when test="${not empty banner.image}">

                                    <c:set var="imgUrl" value="${banner.image}" />

                                    <c:choose>
                                        <c:when test="${fn:startsWith(imgUrl, 'http://') || fn:startsWith(imgUrl, 'https://')}">
                                            <img src="${pageContext.request.contextPath}/img-proxy?url=${fn:escapeXml(imgUrl)}"
                                                 alt="${banner.title}" style="height:80px"
                                                 onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/images/placeholder.png';" />
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/assets/images/${banner.image}"
                                                 alt="${banner.title}" style="height:80px"
                                                 onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/images/hero4.png';" />
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Chưa có ảnh</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <input type="hidden" name="oldImage" value="${banner.image}" />

                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Tải ảnh mới</label>
                        <input type="file" name="image" class="form-control" accept="image/*" />
                        <div class="form-text">Chọn ảnh mới nếu muốn thay đổi.</div>
                    </div>

                    <div class="col-12">
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="statusSwitch"
                                   name="status" ${banner.status ? 'checked' : ''}/>

                            <label class="form-check-label" for="statusSwitch">
                                <c:out value="${banner.status ? 'Active' : 'Inactive'}" />

                            </label>
                        </div>
                    </div>

                    <div class="col-12 d-flex justify-content-end gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa-solid fa-floppy-disk"></i> Lưu
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