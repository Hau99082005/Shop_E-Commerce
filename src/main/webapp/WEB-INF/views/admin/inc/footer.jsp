<!-- Footer Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded-top p-4">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                            &copy; <a href="#">Your Site Name</a>, All Right Reserved.
                        </div>
                        <div class="col-12 col-sm-6 text-center text-sm-end">
                           
                            Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                        </br>
                        Distributed By <a class="border-bottom" href="https://themewagon.com" target="_blank">ThemeWagon</a>
                        </div>
                    </div>
                </div>
            </div>
            <script>
  document.addEventListener('click', function (e) {
    const t = e.target.closest('.sidebar-toggler');
    if (!t) return;
    e.preventDefault();
    var sidebar = document.querySelector('.sidebar');
    var content = document.querySelector('.content');
    if (sidebar) sidebar.classList.toggle('open');
    if (content) content.classList.toggle('open');
  });
</script>
            
            <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJ+Y7B1dGmJRAkycuHAHRg32OmUc5G5r9Oo8Q=" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
            <script src="${pageContext.request.contextPath}/assets/admin/lib/easing/easing.min.js"></script>
            <script src="${pageContext.request.contextPath}/assets/admin/lib/waypoints/waypoints.min.js"></script>
            <script src="${pageContext.request.contextPath}/assets/admin/js/main.js"></script>