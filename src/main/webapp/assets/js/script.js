// Main JavaScript file for Shopee Clone
document.addEventListener('DOMContentLoaded', function() {
    
    // Initialize all components
    initProductCards();
    initFilters();
    initSearch();
    initNavigation();
    
    // Product card hover effects
    function initProductCards() {
        const productCards = document.querySelectorAll('.product-card');
        
        productCards.forEach(card => {
            // Add hover effects
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
                this.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.12)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
                this.style.boxShadow = '0 2px 12px rgba(0, 0, 0, 0.08)';
            });
            
            // Add to cart functionality
            const addToCartBtn = card.querySelector('.btn-add-cart');
            if (addToCartBtn) {
                addToCartBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    addToCart(card);
                });
            }
        });
    }
    
    // Filter functionality
    function initFilters() {
        const filterButtons = document.querySelectorAll('.btn-outline-secondary');
        const categoryLinks = document.querySelectorAll('.list-group-item-action');
        
        // Price filter buttons
        filterButtons.forEach(btn => {
            btn.addEventListener('click', function() {
                // Remove active class from siblings
                filterButtons.forEach(b => b.classList.remove('active'));
                // Add active class to clicked button
                this.classList.add('active');
                
                // Apply filter logic here
                const priceRange = this.textContent.trim();
                filterByPrice(priceRange);
            });
        });
        
        // Category filter
        categoryLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                // Remove active class from siblings
                categoryLinks.forEach(l => l.classList.remove('active'));
                // Add active class to clicked link
                this.classList.add('active');
            });
        });
    }
    
    // Search functionality
    function initSearch() {
        const searchForm = document.querySelector('form[action="/products"]');
        const searchInput = document.querySelector('input[name="search"]');
        
        if (searchForm && searchInput) {
            searchForm.addEventListener('submit', function(e) {
                const searchTerm = searchInput.value.trim();
                if (searchTerm === '') {
                    e.preventDefault();
                    alert('Vui lòng nhập từ khóa tìm kiếm');
                    searchInput.focus();
                }
            });
            
            // Add search suggestions (optional)
            searchInput.addEventListener('input', function() {
                const term = this.value.trim();
                if (term.length > 2) {
                    // Implement search suggestions here
                    showSearchSuggestions(term);
                }
            });
        }
    }
    
    // Navigation functionality
    function initNavigation() {
        // Mobile menu toggle
        const navbarToggler = document.querySelector('.navbar-toggler');
        const navbarCollapse = document.querySelector('.navbar-collapse');
        
        if (navbarToggler && navbarCollapse) {
            navbarToggler.addEventListener('click', function() {
                navbarCollapse.classList.toggle('show');
            });
        }
        
        // Smooth scroll for anchor links
        const anchorLinks = document.querySelectorAll('a[href^="#"]');
        anchorLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    }
    
    // Add to cart function
    function addToCart(productCard) {
        const productTitle = productCard.querySelector('.card-title').textContent;
        const productPrice = productCard.querySelector('.price-new').textContent;
        
        // Show success message
        showNotification(`Đã thêm "${productTitle}" vào giỏ hàng`, 'success');
        
        // Update cart count (if exists)
        updateCartCount();
        
        // Add to localStorage (for demo)
        const cartItem = {
            title: productTitle,
            price: productPrice,
            timestamp: Date.now()
        };
        
        let cart = JSON.parse(localStorage.getItem('cart') || '[]');
        cart.push(cartItem);
        localStorage.setItem('cart', JSON.stringify(cart));
    }
    
    // Filter by price range
    function filterByPrice(priceRange) {
        const products = document.querySelectorAll('.product-card');
        
        products.forEach(product => {
            const priceText = product.querySelector('.price-new').textContent;
            const price = parsePrice(priceText);
            
            let shouldShow = false;
            
            switch(priceRange) {
                case 'Dưới 100.000₫':
                    shouldShow = price < 100000;
                    break;
                case '100.000₫ - 500.000₫':
                    shouldShow = price >= 100000 && price <= 500000;
                    break;
                case '500.000₫ - 1.000.000₫':
                    shouldShow = price >= 500000 && price <= 1000000;
                    break;
                case 'Trên 1.000.000₫':
                    shouldShow = price > 1000000;
                    break;
                default:
                    shouldShow = true;
            }
            
            product.style.display = shouldShow ? 'block' : 'none';
        });
    }
    
    // Parse price from text
    function parsePrice(priceText) {
        return parseInt(priceText.replace(/[^\d]/g, ''));
    }
    
    // Show notification
    function showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.textContent = message;
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: ${type === 'success' ? '#28a745' : '#007bff'};
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            z-index: 1000;
            animation: slideIn 0.3s ease;
        `;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.style.animation = 'slideOut 0.3s ease';
            setTimeout(() => {
                document.body.removeChild(notification);
            }, 300);
        }, 3000);
    }
    
    // Update cart count
    function updateCartCount() {
        const cartBadge = document.querySelector('.badge');
        if (cartBadge) {
            const currentCount = parseInt(cartBadge.textContent) || 0;
            cartBadge.textContent = currentCount + 1;
        }
    }
    
    // Show search suggestions
    function showSearchSuggestions(term) {
        // This would typically make an AJAX call to get suggestions
        console.log('Search suggestions for:', term);
    }
    
    // Loading state
    function showLoading(element) {
        element.classList.add('loading');
        element.style.opacity = '0.7';
        element.style.pointerEvents = 'none';
    }
    
    function hideLoading(element) {
        element.classList.remove('loading');
        element.style.opacity = '1';
        element.style.pointerEvents = 'auto';
    }
    
    // Utility functions
    function debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }
    
    function throttle(func, limit) {
        let inThrottle;
        return function() {
            const args = arguments;
            const context = this;
            if (!inThrottle) {
                func.apply(context, args);
                inThrottle = true;
                setTimeout(() => inThrottle = false, limit);
            }
        }
    }
    
});

// Add CSS animations
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
    
    .notification {
        font-family: 'Inter', sans-serif;
        font-weight: 500;
    }
    
    .loading {
        position: relative;
    }
    
    .loading::after {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 20px;
        height: 20px;
        margin: -10px 0 0 -10px;
        border: 2px solid #f3f3f3;
        border-top: 2px solid #ee4d2d;
        border-radius: 50%;
        animation: spin 1s linear infinite;
    }
    
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    
    .active {
        background-color: #ee4d2d !important;
        color: white !important;
        border-color: #ee4d2d !important;
    }
`;
document.head.appendChild(style);
