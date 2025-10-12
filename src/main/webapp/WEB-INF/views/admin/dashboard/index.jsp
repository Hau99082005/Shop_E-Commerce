<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Admin Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <style>
    body { background: #f5f7fb; }
    .navbar-brand { font-weight: 700; }
    .card { border: 0; box-shadow: 0 1px 3px rgba(0,0,0,.08); }
    .list-group-item { display: flex; justify-content: space-between; align-items: center; }
    .muted { color: #6c757d; }
    .footer { color:#6c757d; font-size: .9rem; }
  </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
      <a class="navbar-brand" href="/admin">Admin</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item"><a class="nav-link" href="/admin/banners">Banners</a></li>
          <li class="nav-item"><a class="nav-link" href="/admin/products">Products</a></li>
          <li class="nav-item"><a class="nav-link" href="/admin/users">Users</a></li>
        </ul>
        <a class="btn btn-outline-light btn-sm" href="/logout">Logout</a>
      </div>
    </div>
  </nav>

  <div class="container py-4">
    <div class="row mb-4">
      <div class="col-12">
        <h1 class="h3 mb-0">Admin Dashboard</h1>
        <p class="muted">Welcome, admin.</p>
      </div>
    </div>

    <div class="row g-3">
      <div class="col-md-4">
        <div class="card">
          <div class="card-body">
            <div class="d-flex justify-content-between align-items-center">
              <div>
                <div class="text-uppercase text-muted small">Banners</div>
                <h4 class="mb-0"><a href="/admin/banners" class="stretched-link text-decoration-none">Manage</a></h4>
              </div>
              <span class="badge bg-primary">Admin</span>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card">
          <div class="card-body">
            <div class="d-flex justify-content-between align-items-center">
              <div>
                <div class="text-uppercase text-muted small">Products</div>
                <h4 class="mb-0"><a href="/admin/products" class="stretched-link text-decoration-none">Manage</a></h4>
              </div>
              <span class="badge bg-success">Admin</span>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card">
          <div class="card-body">
            <div class="d-flex justify-content-between align-items-center">
              <div>
                <div class="text-uppercase text-muted small">Users</div>
                <h4 class="mb-0"><a href="/admin/users" class="stretched-link text-decoration-none">Manage</a></h4>
              </div>
              <span class="badge bg-warning text-dark">Admin</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="row mt-4">
      <div class="col-12">
        <div class="card">
          <div class="card-header bg-white">
            <h5 class="mb-0">Categories</h5>
          </div>
          <div class="card-body p-0">
            <c:choose>
              <c:when test="${empty categories}">
                <div class="p-3 text-center text-muted">No categories found.</div>
              </c:when>
              <c:otherwise>
                <ul class="list-group list-group-flush">
                  <c:forEach var="c" items="${categories}">
                    <li class="list-group-item">
                      <span>${c.name}</span>
                      <span class="badge bg-light text-dark">${c.status ? 'Active' : 'Inactive'}</span>
                    </li>
                  </c:forEach>
                </ul>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </div>

    <div class="text-center mt-4 footer">&copy; <script>document.write(new Date().getFullYear())</script> Admin Panel</div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>