<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .faculty-footer {
        background-color: #0f172a; /* Slate 900 */
        color: #e2e8f0;
        margin-top: 5rem;
        position: relative;
        overflow: hidden;
    }

    /* Top decorative gradient border */
    .faculty-footer::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
    }

    .footer-brand {
        font-family: 'Outfit', sans-serif;
        font-weight: 700;
        font-size: 1.5rem;
        color: #fff;
        margin-bottom: 1rem;
        display: inline-block;
    }

    .footer-brand span {
        background: auto;
        color: #00f2fe;
    }

    .footer-heading {
        color: #fff;
        font-weight: 600;
        margin-bottom: 1.5rem;
        position: relative;
        padding-bottom: 0.5rem;
    }

    .footer-heading::after {
        content: '';
        position: absolute;
        left: 0;
        bottom: 0;
        width: 40px;
        height: 2px;
        background-color: #00f2fe;
    }

    .footer-link {
        color: #94a3b8;
        text-decoration: none;
        transition: all 0.3s ease;
        display: inline-block;
        padding: 0.2rem 0;
    }

    .footer-link:hover {
        color: #fff;
        transform: translateX(5px);
    }
    
    .footer-link i {
        margin-right: 8px;
        color: #4facfe;
    }

    .social-icons-wrapper {
        display: flex;
        gap: 15px;
    }

    .social-icon {
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        background-color: rgba(255, 255, 255, 0.05);
        color: #fff;
        transition: all 0.3s ease;
        text-decoration: none;
    }

    .social-icon:hover {
        background-color: #4facfe;
        color: #fff;
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(79, 172, 254, 0.4);
    }

    .footer-bottom {
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        padding: 1.5rem 0;
        margin-top: 3rem;
        background-color: #0b1120;
    }
</style>

<footer class="faculty-footer pt-5">
    <div class="container mx-auto">
        <div class="row g-4 mb-4">
            <!-- Brand Section -->
            <div class="col-lg-4 col-md-6 mb-4 mb-md-0">
                <a href="/fdashboard" class="footer-brand text-decoration-none">
                    <i class="fas fa-graduation-cap me-2 text-primary text-gradient"></i>Abhi<span>Web</span>
                </a>
                <p class="text-secondary pe-lg-5 mb-4 mt-2" style="line-height: 1.7;">
                    Empowering educators with intuitive tools and deep insights to manage courses, streamline grading, and foster student success.
                </p>
                <div class="social-icons-wrapper">
                    <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-github"></i></a>
                    <a href="#" class="social-icon"><i class="fas fa-envelope"></i></a>
                </div>
            </div>

            <!-- Teaching Tools -->
            <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                <h5 class="footer-heading">Teaching Tools</h5>
                <ul class="list-unstyled d-flex flex-column gap-2 mb-0">
                    <li><a href="/fdashboard" class="footer-link"><i class="fas fa-angle-right"></i> Dashboard</a></li>
                    <li><a href="/f-assignments" class="footer-link"><i class="fas fa-angle-right"></i> Assignments</a></li>
                    <li><a href="#" class="footer-link"><i class="fas fa-angle-right"></i> Gradebook</a></li>
                    <li><a href="#" class="footer-link"><i class="fas fa-angle-right"></i> Analytics</a></li>
                </ul>
            </div>

            <!-- Institutional -->
            <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                <h5 class="footer-heading">Institutional</h5>
                <ul class="list-unstyled d-flex flex-column gap-2 mb-0">
                    <li><a href="#" class="footer-link"><i class="fas fa-angle-right"></i> Academic Catalog</a></li>
                    <li><a href="#" class="footer-link"><i class="fas fa-angle-right"></i> Faculty Resources</a></li>
                    <li><a href="#" class="footer-link"><i class="fas fa-angle-right"></i> Department Hub</a></li>
                    <li><a href="#" class="footer-link"><i class="fas fa-angle-right"></i> IT Support</a></li>
                </ul>
            </div>

            <!-- Contact/Info -->
            <div class="col-lg-3 col-md-6">
                <h5 class="footer-heading">Need Help?</h5>
                <ul class="list-unstyled text-secondary d-flex flex-column gap-3 mb-0">
                    <li class="d-flex align-items-start">
                        <i class="fas fa-map-marker-alt mt-1 me-3 text-primary"></i>
                        <span>Tech Block 4, Main Campus<br>Faculty Wing Room 204</span>
                    </li>
                    <li class="d-flex align-items-center">
                        <i class="fas fa-phone-alt me-3 text-primary"></i>
                        <span>+1 (800) 555-0199</span>
                    </li>
                    <li class="d-flex align-items-center">
                        <i class="fas fa-headset me-3 text-primary"></i>
                        <span>faculty-support@abhiweb.edu</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <!-- Bottom Copyright -->
    <div class="footer-bottom text-center">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    <p class="mb-0 text-secondary small">&copy; 2026 AbhiWeb Education. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <ul class="list-inline mb-0 small">
                        <li class="list-inline-item"><a href="#" class="text-secondary text-decoration-none hover-white">Privacy Policy</a></li>
                        <li class="list-inline-item text-secondary mx-2">|</li>
                        <li class="list-inline-item"><a href="#" class="text-secondary text-decoration-none hover-white">Terms of Use</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer>