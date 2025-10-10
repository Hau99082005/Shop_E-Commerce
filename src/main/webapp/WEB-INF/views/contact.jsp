<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cara</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
        integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="./assets/css/style.css">
</head>

<body>

    <header id="header">
        <a href="#"><img src="./assets/img/logo.png" class="logo" alt=""></a>
        <ul id="navbar">
            <li><a href="index.html">Home</a></li>
            <li><a href="shop.html">Shop</a></li>
            <li><a href="blog.html">Blog</a></li>
            <li><a href="about.html">About</a></li>
            <li><a class="active" href="contact.html">Contact</a></li>
            <li><a href="cart.html"><i class="fa-solid fa-bag-shopping"></i></a></li>
            <li><a href="user.html"><i class="fa-solid fa-user"></i></a></li>
        </ul>
    </header>

    <section id="page-header" class="about-header">
        <h2>#let's_talk</h2>
        <p>LEAVE A MESSAGE, We love to hear from you!</p>
    </section>

    <section id="contact" class="section-p1">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="details">
                        <span>GET IN TOUCH</span>
                        <h2>Visit one of our agency locations or contact us today</h2>
                        <h3>Head Office</h3>
                        <div>
                            <li>
                                <i class="fa-regular fa-map"></i>
                                <p>Nguyen Hue - Hue</p>
                            </li>
                            <li>
                                <i class="fa-regular fa-envelope"></i>
                                <p>contact@gmail.com</p>
                            </li>
                            <li>
                                <i class="fa-solid fa-phone"></i>
                                +84000111222
                            </li>
                            <li>
                                <i class="fa-regular fa-clock"></i>
                                <p>8AM - 21PM, Mon - Sat</p>
                            </li>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="map">
                        <iframe
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1238.156589141328!2d107.58738095850609!3d16.45748791701312!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3141a147ba6bdbff%3A0x2e605afab4951ad9!2zVHLGsOG7nW5nIENhbyDEkeG6s25nIEPDtG5nIG5naGnhu4dwIEh14bq_!5e0!3m2!1svi!2s!4v1718154662562!5m2!1svi!2s"
                            width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy"
                            referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="form-details">
        <form action="">
            <span>LEAVE A MESSAGE</span>
            <h2>We love to hear from you</h2>
            <input type="text" placeholder="Your name">
            <input type="text" placeholder="E-mail">
            <input type="text" placeholder="Subject">
            <textarea name="" id="" cols="30" rows="10" placeholder="Your Message">
            </textarea>
            <button class="normal">Submit</button>
        </form>

        <div class="people">
            <div>
                <img src="./assets/img/people/1.png" alt="">
                <p><span>John Doe</span>Marketing Manager <br> Phone: +000 111 222 33 <br> Email: contact@gmail.com</p>
            </div>
            <div>
                <img src="./assets/img/people/2.png" alt="">
                <p><span>William Smith</span>Marketing Manager <br> Phone: +000 111 222 33 <br> Email: contact@gmail.com</p>
            </div>
            <div>
                <img src="./assets/img/people/3.png" alt="">
                <p><span>Enma Stone</span>Marketing Manager <br> Phone: +000 111 222 33 <br> Email: contact@gmail.com</p>
            </div>
        </div>
    </section>

    <section id="newsletter" class="section-p1 section-m1">
        <div class="newstext">
            <h4>Sign Up For Newsletters</h4>
            <p>Get E-mail updates about our latest shop and <span>special offers</span></p>
        </div>
        <div class="form">
            <input type="text" placeholder="Your email address">
            <button class="normal">Sign up</button>
        </div>
    </section>

    <footer class="section-p1">
        <div class="col">
            <img class="logo" src="./assets/img/logo.png" alt="">
            <h4>Contact</h4>
            <p><strong>Address:</strong> Cao Dang Cong Nghiep - Hueic</p>
            <p><strong>Phone:</strong> +84000111222</p>
            <p><strong>Hours:</strong> 8AM - 21PM, Mon - Sat</p>
            <div class="follow">
                <h4>Follow us</h4>
                <div class="icon">
                    <i class="fa-brands fa-facebook-f"></i>
                    <i class="fa-brands fa-twitter"></i>
                    <i class="fa-brands fa-instagram"></i>
                    <i class="fa-brands fa-pinterest-p"></i>
                    <i class="fa-brands fa-youtube"></i>
                </div>
            </div>
        </div>
        <div class="col">
            <h4>About</h4>
            <a href="#">About us</a>
            <a href="#">Delivery Information</a>
            <a href="#">Privacy Policy</a>
            <a href="#">Terms & Conditions</a>
            <a href="#">Contact Us</a>
        </div>
        <div class="col">
            <h4>My Account</h4>
            <a href="#">Sign In</a>
            <a href="#">View Cart</a>
            <a href="#">My Wishlist</a>
            <a href="#">Track My Oder</a>
            <a href="#">Help</a>
        </div>
        <div class="col install">
            <h4>Install App</h4>
            <p>From App Store or Google Play</p>
            <div class="row">
                <img src="./assets/img/pay/app.jpg" alt="">
                <img src="./assets/img/pay/play.jpg" alt="">
            </div>
            <p>Secured Payment Gateaways</p>
            <img src="./assets/img/pay/pay.png" alt="">
        </div>
    </footer>

</body>

</html>
