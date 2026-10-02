<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="/css/bootstrap.min.css" />

<style>
    .premium-footer {
        background: linear-gradient(180deg, #0f172a 0%, #020617 100%);
        color: #e2e8f0;
        padding-top: 5rem;
        padding-bottom: 2rem;
        position: relative;
        font-family: 'Inter', system-ui, -apple-system, sans-serif;
        overflow: hidden;
    }

    /* Abstract Glow */
    .footer-glow {
        position: absolute;
        width: 300px;
        height: 300px;
        background: radial-gradient(circle, rgba(79,70,229,0.15) 0%, rgba(255,255,255,0) 70%);
        top: 0;
        left: 50%;
        transform: translateX(-50%);
        pointer-events: none;
    }

    .footer-heading {
        color: #f8fafc;
        font-weight: 700;
        margin-bottom: 1.5rem;
        font-size: 1.15rem;
        letter-spacing: 0.5px;
    }

    .footer-brand {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 1.8rem;
        font-weight: 800;
        letter-spacing: -0.5px;
        background: linear-gradient(135deg, #818cf8, #f472b6);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 1rem;
        text-decoration: none;
    }
    .footer-brand i { background: linear-gradient(135deg, #818cf8, #f472b6); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }

    .premium-footer p {
        color: #94a3b8;
        line-height: 1.7;
    }

    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .footer-links li {
        margin-bottom: 0.75rem;
    }

    .footer-links a {
        color: #94a3b8;
        text-decoration: none;
        transition: all 0.3s ease;
        display: inline-block;
    }

    .footer-links a:hover {
        color: #818cf8;
        transform: translateX(5px);
    }

    /* Newsletter */
    .newsletter-box {
        position: relative;
        margin-top: 1rem;
    }
    .newsletter-input {
        background: rgba(255,255,255,0.05);
        border: 1px solid rgba(255,255,255,0.1);
        color: white;
        padding: 0.8rem 1rem;
        border-radius: 12px;
        transition: all 0.3s ease;
    }
    .newsletter-input:focus {
        background: rgba(255,255,255,0.1);
        border-color: #818cf8;
        box-shadow: 0 0 0 3px rgba(129, 140, 248, 0.2);
        color: white;
        outline: none;
    }
    .newsletter-input::placeholder {
        color: rgba(255,255,255,0.4);
    }
    
    .btn-subscribe {
        background: linear-gradient(135deg, #4f46e5, #ec4899);
        color: white;
        border: none;
        border-radius: 12px;
        padding: 0.8rem 1.5rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    .btn-subscribe:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(236, 72, 153, 0.3);
        color: white;
    }

    .footer-bottom {
        border-top: 1px solid rgba(255,255,255,0.05);
        padding-top: 2.5rem;
        margin-top: 4rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
    }

    .social-icons {
        display: flex;
        gap: 1rem;
    }
    .social-icons a {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
        background: rgba(255,255,255,0.05);
        color: #94a3b8;
        border-radius: 50%;
        text-decoration: none;
        transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }
    .social-icons a:hover {
        background: linear-gradient(135deg, #4f46e5, #ec4899);
        color: white;
        transform: translateY(-5px) scale(1.1);
        box-shadow: 0 10px 20px rgba(236,72,153,0.2);
    }
    
    @media (max-width: 991px) {
        .footer-bottom { flex-direction: column; text-align: center; gap: 1.5rem; }
    }
</style>

<footer class="premium-footer">
    <div class="footer-glow"></div>
    <div class="container position-relative z-index-1">
        <div class="row">
            
            <!-- Brand & Description -->
            <div class="col-lg-4 col-md-6 mb-5 mb-lg-0 pe-lg-5">
                <a href="/" class="footer-brand">
                    <i class="bi bi-mortarboard-fill"></i> EduPro
                </a>
                <p>Empowering students and professionals worldwide with transformative online education, expert mentors, and interactive learning environments.</p>
                <div class="social-icons mt-4">
                    <a href="#"><i class="bi bi-twitter-x"></i></a>
                    <a href="#"><i class="bi bi-facebook"></i></a>
                    <a href="#"><i class="bi bi-instagram"></i></a>
                    <a href="#"><i class="bi bi-linkedin"></i></a>
                    <a href="#"><i class="bi bi-youtube"></i></a>
                </div>
            </div>

            <!-- Links Sections -->
            <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                <h5 class="footer-heading">Platform</h5>
                <ul class="footer-links">
                    <li><a href="/courses">All Courses</a></li>
                    <li><a href="/pricing">Pricing</a></li>
                    <li><a href="/features">Features</a></li>
                    <li><a href="/certificates">Certificates</a></li>
                </ul>
            </div>

            <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                <h5 class="footer-heading">Company</h5>
                <ul class="footer-links">
                    <li><a href="/about">About Us</a></li>
                    <li><a href="/contact">Contact</a></li>
                    <li><a href="/careers">Careers</a></li>
                    <li><a href="/faq">FAQs</a></li>
                </ul>
            </div>

            <!-- Newsletter -->
            <div class="col-lg-4 col-md-6">
                <h5 class="footer-heading">Stay Updated</h5>
                <p>Subscribe to our newsletter for the latest courses, offers, and tech insights.</p>
                <div class="newsletter-box d-flex gap-2">
                    <input type="email" class="form-control newsletter-input flex-grow-1" placeholder="Your email address">
                    <button class="btn btn-subscribe flex-shrink-0" type="button">Subscribe</button>
                </div>
            </div>

        </div>

        <!-- Copyright -->
        <div class="footer-bottom">
            <p class="mb-0 text-muted">&copy; 2026 EduPro Learning Management System. All rights reserved.</p>
            <div class="d-flex flex-wrap justify-content-center gap-3 mt-3 mt-md-0">
                <a href="/privacy" class="text-muted text-decoration-none hover-text-white">Privacy Policy</a>
                <span class="text-muted d-none d-md-inline">•</span>
                <a href="/terms" class="text-muted text-decoration-none hover-text-white">Terms of Service</a>
                <span class="text-muted d-none d-md-inline">•</span>
                <a href="/cookies" class="text-muted text-decoration-none hover-text-white">Cookie Policy</a>
            </div>
        </div>
    </div>
</footer>

<style>
    .hover-text-white { transition: color 0.3s; }
    .hover-text-white:hover { color: white !important; text-decoration: underline !important; }
</style>