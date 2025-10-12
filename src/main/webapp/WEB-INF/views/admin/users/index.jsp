<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/inc/header.jsp" %>

<div class="container my-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h4 class="m-0">Quản trị - Người dùng</h4>
    <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/">Về trang chủ</a>
  </div>

  <div class="card shadow-sm">
    <div class="card-body">
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
                <td><span class="badge ${u.role == 'admin' ? 'text-bg-primary' : 'text-bg-secondary'}">${u.role}</span></td>
                <td>${u.createdAt}</td>
                <td class="text-end">
                  <a class="btn btn-sm btn-outline-danger"
                     href="${pageContext.request.contextPath}/admin/users/${u.id}/delete"
                     onclick="return confirm('Xóa user #${u.id}?');">
                    Xóa
                  </a>
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
</div>

<%@ include file="/WEB-INF/views/inc/footer.jsp" %>