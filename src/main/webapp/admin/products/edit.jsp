<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit products</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <link href="${pageContext.request.contextPath}/assets/admin/img/favicon.ico" rel="icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/admin/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/css/style.css" rel="stylesheet">
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../inc/sidebar.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <%@ include file="../inc/navbar.jsp" %>

        <div class="container-fluid">
            <!-- Debug info -->
            <div class="alert alert-info">
                <strong>Debug:</strong> Product ID: ${product.id}, Name: ${product.name}, Categories: ${categoryList.size()}
            </div>
            
            <c:if test="${empty product}">
                <div class="alert alert-danger">Không có dữ liệu sản phẩm để hiển thị.</div>
            </c:if>

            <form action="EditProductServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="productId" value="${product.id}">

                <div class="form-group">
                    <label>Current main image</label>
                    <div class="mb-2">
                        <c:if test="${not empty product.image}">
                            <img class="p-thumbnail" style="max-height:120px" src="${product.image}" alt="main"/>
                        </c:if>
                        <c:if test="${empty product.image}">
                            <span class="text-muted">Chưa có ảnh chính</span>
                        </c:if>
                    </div>

                    <label>Gallery images</label>
                    <div class="row">
                        <c:if test="${not empty product.galleries}">
                            <c:forEach items="${product.galleries}" var="photo">
                                <div class="col-md-3 mb-2">
                                    <img class="p-thumbnail" style="max-height:120px" src="${photo.image}" alt="gallery"/>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty product.galleries}">
                            <div class="col-12 text-muted">Chưa có ảnh trong gallery</div>
                        </c:if>
                    </div>
                </div>

                <div class="form-group">
                    <label>Upload gallery (nhiều ảnh)</label>
                    <input type="file" name="photos" multiple="multiple" />
                </div>

                <div class="form-group">
                    <label>Main image URL</label>
                    <input type="text" name="image" class="form-control" placeholder="https://..." value="${product.image}">
                    <small class="form-text text-muted">Để trống để giữ ảnh hiện tại.</small>
                </div>

                <div class="form-group">
                    <label>Name</label>
                    <input type="text" name="name" class="form-control" placeholder="Enter name" value="${product.name}">
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <input type="text" name="description" class="form-control" placeholder="Enter Description" value="${product.description}">
                </div>

                <div class="form-group">
                    <label>Category</label>
                    <select name="categoryId" class="form-control">
                        <c:forEach items="${categoryList}" var="cat">
                            <option <c:if test="${cat.id == product.category_id}">selected</c:if> value="${cat.id}">
                                ${cat.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Price</label>
                    <input type="number" name="price" min="0" step="0.01" class="form-control" placeholder="Enter Price" value="${product.price}">
                </div>

                <div class="form-group">
                    <label>Price old</label>
                    <input type="number" name="price_old" min="0" step="0.01" class="form-control" placeholder="Enter Price old" value="${product.price_old}">
                </div>

                <div class="form-group">
                    <label>Quantity</label>
                    <input type="number" name="quantity" min="0" class="form-control" placeholder="Enter Quantity" value="${product.quantity}">
                </div>

                <div class="form-group">
                    <label>Views</label>
                    <input type="number" name="view" min="0" class="form-control" placeholder="Enter Views" value="${product.view}">
                </div>

                <div class="form-group form-check">
                    <input type="checkbox" name="status" value="true" class="form-check-input" id="statusCheckbox"
                           <c:if test="${product.status}">checked</c:if>>
                    <label class="form-check-label" for="statusCheckbox">Active (Hiển thị)</label>
                </div>

                <div class="form-text text-muted mb-2">
                    <c:out value="${errorMessage}" />
                    <c:if test="${not empty requestScope.errorMessage}">
                        <c:out value="${requestScope.errorMessage}" />
                    </c:if>
                    <c:remove var="errorMessage" scope="session" />
                </div>

                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>

        <%@ include file="/admin/inc/footer.jsp" %>
    </div>
</div>

<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/chart/chart.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/easing/easing.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/waypoints/waypoints.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/owlcarousel/owl.carousel.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/tempusdominus/js/moment.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/tempusdominus/js/moment-timezone.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="${pageContext.request.contextPath}/assets/admin/js/main.js"></script>
</body>
</html>