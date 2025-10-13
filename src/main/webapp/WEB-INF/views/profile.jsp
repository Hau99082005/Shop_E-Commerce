<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shop.developer.modules.users.models.User,com.shop.developer.Profile" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="inc/header.jsp" %>
<%
    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    Profile p = Profile.fromUser(u);
    request.setAttribute("profile", p);
%>

<style>
  .pf-card { border:1px solid #e5e7eb; }
  .pf-head { border-bottom:1px solid #e5e7eb; }
  .pf-avatar { width:72px; height:72px; border-radius:999px; object-fit:cover; background:#fafafa; border:1px solid #e5e7eb; }
  .pf-label { font-size: .8rem; color:#6b7280; text-transform:uppercase; letter-spacing:.04em; }
  .pf-value { font-weight:600; color:#111827; }
</style>

<div class="container my-4">
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
      <li class="breadcrumb-item active" aria-current="page">Thông tin tài khoản</li>
    </ol>
  </nav>

  <div class="row justify-content-center">
    <div class="col-12 col-lg-9">
      <div class="card shadow-sm rounded-3 pf-card">
        <div class="card-header bg-white border-0 pb-0">
          <h5 class="mb-0 fw-bold"><i class="fa-regular fa-user me-2"></i>Thông tin tài khoản</h5>
        </div>
        <div class="card-body pf-head d-flex align-items-center gap-3">
          <img class="pf-avatar" src="${empty profile.image ? 'https://via.placeholder.com/72x72?text=U' : profile.image}" alt="Avatar">
          <div class="flex-grow-1">
            <h5 class="mb-1 fw-bold">${empty profile.name ? 'Người dùng' : profile.name}</h5>
            <div class="text-muted small">${profile.email}</div>
          </div>
          <a href="#" class="btn btn-outline-info btn-sm"><i class="fa-regular fa-pen-to-square me-1"></i>Chỉnh sửa</a>
        </div>

        <div class="card-body">
          <div class="row g-3">
            <div class="col-md-6">
              <div class="border rounded-3 p-3 bg-light">
                <div class="pf-label mb-1"><i class="fa-regular fa-id-badge me-1"></i>Họ và tên</div>
                <div class="pf-value">${empty profile.name ? '-' : profile.name}</div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="border rounded-3 p-3 bg-light">
                <div class="pf-label mb-1"><i class="fa-regular fa-envelope me-1"></i>Email</div>
                <div class="pf-value">${empty profile.email ? '-' : profile.email}</div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="border rounded-3 p-3 bg-light">
                <div class="pf-label mb-1"><i class="fa-solid fa-phone me-1"></i>Số điện thoại</div>
                <div class="pf-value">${empty profile.phone ? '-' : profile.phone}</div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="border rounded-3 p-3 bg-light">
                <div class="pf-label mb-1"><i class="fa-solid fa-location-dot me-1"></i>Địa chỉ</div>
                <div class="pf-value">${empty profile.address ? '-' : profile.address}</div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="border rounded-3 p-3 bg-light">
                <div class="pf-label mb-1"><i class="fa-solid fa-user-shield me-1"></i>Vai trò</div>
                <div class="pf-value text-capitalize">${empty profile.role ? '-' : profile.role}</div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="border rounded-3 p-3 bg-light">
                <div class="pf-label mb-1"><i class="fa-regular fa-hashtag me-1"></i>Mã người dùng</div>
                <div class="pf-value">${profile.id}</div>
              </div>
            </div>
          </div>
        </div>

        <div class="card-footer bg-white text-muted small d-flex justify-content-between">
          <span>Ngày tạo: ${empty profile.createdAt ? '-' : profile.createdAt}</span>
          <span>Cập nhật: ${empty profile.updatedAt ? '-' : profile.updatedAt}</span>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="inc/footer.jsp" %>
