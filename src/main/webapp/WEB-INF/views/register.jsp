<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  .auth-bg { background: url('${pageContext.request.contextPath}/assets/img/blog/b1.jpg') center/cover no-repeat fixed; }
  .glass { background: rgba(255,255,255,.85); backdrop-filter: blur(6px); border: 1px solid rgba(255,255,255,.35); }
</style>

<div class="auth-bg py-5">
  <div class="container d-flex justify-content-center align-items-center" style="min-height:70vh;">
    <div class="glass rounded-4 shadow p-4" style="max-width:380px;width:100%;">
      <h4 class="text-center fw-bold mb-3">Registration</h4>
      <c:if test="${not empty error}">
        <div class="alert alert-danger py-2 small" role="alert">${error}</div>
      </c:if>
      <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate>
        <div class="mb-2">
          <label class="form-label small">Họ tên</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
            <input type="text" name="name" class="form-control" placeholder="vui lòng nhập tên của bạn">
          </div>
        </div>
        <div class="mb-2">
          <label class="form-label small">Số điện thoại</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
            <input type="text" name="phone" class="form-control" required>
          </div>
        </div>
        <div class="mb-2">
          <label class="form-label small">Email</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
            <input type="email" name="email" class="form-control" required>
          </div>
        </div>
        <div class="mb-2">
          <label class="form-label small">Password</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
            <input type="password" name="password" class="form-control" required>
          </div>
        </div>
        <div class="mb-2">
          <label class="form-label small">Repeat Password</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
            <input type="password" name="confirm" class="form-control" required>
          </div>
        </div>
        <div class="mb-2">
          <label class="form-label small">Role</label>
          <select name="role" class="form-select">
            <option value="user">user</option>
            <option value="admin">admin</option>
          </select>
        </div>
        <div class="form-check mb-3">
          <input class="form-check-input" type="checkbox" value="1" id="agree" required>
          <label class="form-check-label small" for="agree">I agree to all statements in Terms of Service</label>
        </div>
        <button type="submit" class="btn btn-dark w-100">Register</button>
        <div class="text-center small mt-2">Already have an Account? <a href="${pageContext.request.contextPath}/login">Login</a></div>
      </form>
    </div>
  </div>
</div>

<%@ include file="inc/footer.jsp" %>
