<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  .auth-bg { background: url('${pageContext.request.contextPath}/assets/img/blog/b2.jpg') center/cover no-repeat fixed; }
  .glass { background: rgba(255,255,255,.85); backdrop-filter: blur(6px); border: 1px solid rgba(255,255,255,.35); }
</style>

<div class="auth-bg py-5">
  <div class="container d-flex justify-content-center align-items-center" style="min-height:70vh;">
    <div class="glass rounded-4 shadow p-4" style="max-width:360px;width:100%;">
      <h4 class="text-center fw-bold mb-3">Login</h4>

      <c:if test="${not empty error}">
        <div class="alert alert-danger py-2 small" role="alert">${error}</div>
      </c:if>

      <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
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

        <div class="d-flex justify-content-between align-items-center mb-3">
          <div class="form-check">
            <input class="form-check-input" type="checkbox" id="remember">
            <label class="form-check-label small" for="remember">Remember Me</label>
          </div>
          <a class="small text-decoration-none" href="#">Forgot Password</a>
        </div>

        <button type="submit" class="btn btn-dark w-100">Login</button>
        <div class="text-center small mt-2">
          Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
        </div>
      </form>
    </div>
  </div>
</div>

<%@ include file="inc/footer.jsp" %>