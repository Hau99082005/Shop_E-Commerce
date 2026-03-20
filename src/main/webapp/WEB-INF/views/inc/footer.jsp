<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<footer class="footer py-5 bg-dark text-white">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-3 col-md-6">
                <img class="logo mb-3" src="${pageContext.request.contextPath}/assets/img/logo.png" alt="Cara" style="height:50px; filter: brightness(0) invert(1);">
                <h5 class="mb-3">Liên hệ</h5>
                <p class="mb-1"><i class="fa-solid fa-location-dot me-2"></i> Cao Đẳng Công Nghiệp - Hueic</p>
                <p class="mb-1"><i class="fa-solid fa-phone me-2"></i> +84000111222</p>
                <p class="mb-3"><i class="fa-regular fa-clock me-2"></i> 8AM - 21PM, Thứ 2 - Thứ 7</p>
                <h5 class="mb-2">Theo dõi chúng tôi</h5>
                <div class="social-icons d-flex gap-3 mb-3">
                    <a href="#" class="text-white fs-5"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" class="text-white fs-5"><i class="fa-brands fa-twitter"></i></a>
                    <a href="#" class="text-white fs-5"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" class="text-white fs-5"><i class="fa-brands fa-pinterest-p"></i></a>
                    <a href="#" class="text-white fs-5"><i class="fa-brands fa-youtube"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="mb-3">Về chúng tôi</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none hover-link">Giới thiệu</a></li>
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none hover-link">Thông tin giao hàng</a></li>
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none hover-link">Chính sách bảo mật</a></li>
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none hover-link">Điều khoản & Điều kiện</a></li>
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none hover-link">Liên hệ</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="mb-3">Tài khoản của tôi</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none hover-link">Đăng nhập</a></li>
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none hover-link">Giỏ hàng</a></li>
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none hover-link">Danh sách yêu thích</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/my-orders" class="text-white text-decoration-none hover-link">Theo dõi đơn hàng</a></li>
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none hover-link">Trợ giúp</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="mb-3">Cài đặt ứng dụng</h5>
                <p class="mb-2">Từ App Store hoặc Google Play</p>
                <div class="d-flex gap-2 mb-3">
                    <img src="${pageContext.request.contextPath}/assets/img/pay/app.jpg" alt="App Store" class="img-fluid" style="height:40px; border-radius:5px;">
                    <img src="${pageContext.request.contextPath}/assets/img/pay/play.jpg" alt="Google Play" class="img-fluid" style="height:40px; border-radius:5px;">
                </div>
                <p class="mb-2">Thanh toán an toàn</p>
                <img src="${pageContext.request.contextPath}/assets/img/pay/pay.png" alt="Payment Methods" class="img-fluid" style="height:30px;">
            </div>
        </div>
        <div class="row mt-4 pt-3 border-top">
            <div class="col-12 text-center">
                <p class="mb-0">&copy; 2024 Cara - Thời trang & Phụ kiện. Tất cả các quyền được bảo lưu.</p>
            </div>
        </div>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script>
    // JavaScript để cải thiện trải nghiệm người dùng
    document.addEventListener('DOMContentLoaded', function() {
        // Thêm hiệu ứng hover cho các liên kết
        const hoverLinks = document.querySelectorAll('.hover-link');
        hoverLinks.forEach(link => {
            link.addEventListener('mouseenter', function() {
                this.style.opacity = '0.8';
                this.style.textDecoration = 'underline';
            });
            link.addEventListener('mouseleave', function() {
                this.style.opacity = '1';
                this.style.textDecoration = 'none';
            });
        });

        // Thêm hiệu ứng cho nút tìm kiếm
        const searchBtn = document.querySelector('.shp-search-btn');
        if (searchBtn) {
            searchBtn.addEventListener('mouseenter', function() {
                this.style.backgroundColor = '#0a58ca';
            });
            searchBtn.addEventListener('mouseleave', function() {
                this.style.backgroundColor = '#0d6efd';
            });
        }

        // Hiệu ứng cho logo
        const logo = document.querySelector('.logo');
        if (logo) {
            logo.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.05)';
                this.style.transition = 'transform 0.3s ease';
            });
            logo.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
            });
        }
    });
</script>
</body>
</html>