<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>Admin - Users</title>
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
          <h4 class="m-0">Quản trị - Người dùng</h4>
          <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/">Về trang chủ</a>
        </div>
        <div class="table-responsive">
          <table class="table table-hover align-middle">
            <thead class="table-light">
              <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Tên</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Created At</th>
                <th class="text-end">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="u" items="${users}">
                <tr>
                  <td>${u.id}</td>
                  <td>${u.email}</td>
                  <td><c:out value="${u.name}" /></td>
                  <td>${u.phone}</td>
                  <td>
                    <span class="badge rounded-pill ${u.role == 'admin' ? 'border border-primary text-primary bg-transparent' : 'border border-secondary text-secondary bg-transparent'}">
                      <i class="fa ${u.role == 'admin' ? 'fa-user-shield' : 'fa-user'} me-1"></i>
                      ${u.role}
                    </span>
                  </td>
                  <td>${u.createdAt}</td>
                  <td class="text-end">
                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/users/${u.id}/delete" onclick="return confirm('Xóa user #${u.id}?');">Xóa</a>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty users}">
                <tr><td colspan="7" class="text-center text-muted">Chưa có user</td></tr>
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