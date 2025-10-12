<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin - Thêm danh mục</title>
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
                    <h3 class="mb-0">Thêm danh mục</h3>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/categories">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </a>
                </div>

                <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/admin/categories/create" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label for="name" class="form-label">Tên danh mục</label>
                        <input type="text" id="name" name="name" class="form-control" required>
                        <div class="invalid-feedback">Vui lòng nhập tên danh mục</div>
                    </div>

                    <div class="mb-3">
                        <label for="image" class="form-label">Ảnh thumbnail (bắt buộc)</label>
                        <input type="file" id="image" name="image" class="form-control" accept="image/*" required>
                        <div class="invalid-feedback">Vui lòng chọn ảnh</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label d-block">Xem trước</label>
                        <img id="preview" src="${pageContext.request.contextPath}/assets/images/placeholder.png" alt="Preview" style="height:60px">
                    </div>

                    <div class="form-check form-switch mb-4">
                        <input class="form-check-input" type="checkbox" id="status" name="status" ${category.status ? 'checked' : ''}>
                        <label class="form-check-label" for="status">Hoạt động</label>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary"><i class="fa-solid fa-floppy-disk"></i> Lưu</button>
                        <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-light">Hủy</a>
                    </div>
                </form>
            </div>
        </div>

        <%@ include file="/WEB-INF/views/admin/inc/footer.jsp" %>
    </div>
</div>
<script src="${pageContext.request.contextPath}/assets/admin/js/bootstrap.bundle.min.js"></script>
<script>
(() => {
  'use strict';
  const forms = document.querySelectorAll('.needs-validation');
  Array.from(forms).forEach(form => {
    form.addEventListener('submit', event => {
      if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();
      }
      form.classList.add('was-validated');
    }, false);
  });
})();

const input = document.getElementById('image');
if (input) {
  input.addEventListener('change', () => {
    const [file] = input.files;
    if (file) document.getElementById('preview').src = URL.createObjectURL(file);
  });
}
</script>
</body>
</html>