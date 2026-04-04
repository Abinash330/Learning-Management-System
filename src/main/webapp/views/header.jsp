<link rel="stylesheet" href="/css/bootstrap.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
    /* Premium Header Styles */
    .premium-header {
        position: sticky;
        top: 0;
        z-index: 1030;
        background: rgba(255, 255, 255, 0.9) !important;
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.03);
        border-bottom: 1px solid rgba(255, 255, 255, 0.3);
        padding: 0.8rem 0;
        transition: all 0.3s ease;
    }

    .brand-logo-header {
        font-size: 1.7rem;
        font-weight: 900;
        letter-spacing: -0.5px;
        background: linear-gradient(135deg, #4f46e5, #ec4899);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-decoration: none !important;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .brand-logo-header i {
        background: linear-gradient(135deg, #4f46e5, #ec4899);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        font-size: 1.8rem;
    }

    .premium-nav-link {
        color: #475569 !important;
        font-weight: 600;
        font-size: 1.05rem;
        padding: 0.5rem 1.25rem !important;
        position: relative;
        transition: color 0.3s ease;
    }

    .premium-nav-link::after {
        content: '';
        position: absolute;
        width: 0;
        height: 3px;
        bottom: 2px;
        left: 50%;
        background: linear-gradient(90deg, #4f46e5, #ec4899);
        transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        transform: translateX(-50%);
        border-radius: 5px;
    }

    .premium-nav-link:hover {
        color: #4f46e5 !important;
    }

    .premium-nav-link:hover::after {
        width: 70%;
    }

    .search-pill {
        border-radius: 50px;
        padding: 0.6rem 1.2rem;
        border: 2px solid #f1f5f9;
        background: #f8fafc;
        transition: all 0.3s ease;
        font-weight: 500;
        font-size: 0.95rem;
        box-shadow: inset 0 2px 4px rgba(0,0,0,0.02);
    }

    .search-pill:focus {
        border-color: #818cf8;
        box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        background: white;
        outline: none;
    }

    .btn-login-outline {
        border-radius: 50px;
        border: 2px solid #e2e8f0;
        color: #475569;
        font-weight: 700;
        padding: 0.55rem 1.5rem;
        transition: all 0.3s ease;
        background: white;
    }

    .btn-login-outline:hover {
        background: #f8fafc;
        border-color: #cbd5e1;
        color: #1e293b;
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    }

    .btn-signup-gradient {
        border-radius: 50px;
        background: linear-gradient(135deg, #1e1b4b, #4f46e5);
        color: white;
        font-weight: 700;
        padding: 0.55rem 1.75rem;
        border: none;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(79, 70, 229, 0.2);
    }

    .btn-signup-gradient:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(79, 70, 229, 0.3);
        color: white;
    }
    
    @media (max-width: 991px) {
        .premium-header { padding: 1rem 0; }
        .brand-logo-header { margin-bottom: 1rem !important; }
        .premium-nav-link::after { display: none; }
    }
</style>

<header class="premium-header">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            
            <a href="/" class="brand-logo-header me-lg-auto mb-2 mb-lg-0">
                <i class="bi bi-mortarboard-fill"></i> EduPro
            </a>

            <ul class="nav col-12 col-lg-auto mb-3 justify-content-center mb-md-0 me-lg-3">
                <li><a href="/" class="nav-link premium-nav-link">Home</a></li>
                <li><a href="/about" class="nav-link premium-nav-link">About</a></li>
                <li><a href="/faq" class="nav-link premium-nav-link">FAQs</a></li>
                <li><a href="/contact" class="nav-link premium-nav-link">Contact</a></li>
            </ul>

            <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-4" role="search">
                <div class="position-relative">
                    <i class="bi bi-search position-absolute text-muted" style="top: 50%; left: 1.1rem; transform: translateY(-50%);"></i>
                    <input type="search" class="form-control search-pill ps-5 pe-4" placeholder="Search courses..." aria-label="Search">
                </div>
            </form>

            <div class="text-end d-flex gap-2 justify-content-center">
                <a href="/login" class="btn btn-login-outline">Log In</a>
                <a href="/register" class="btn btn-signup-gradient">Sign Up</a>
            </div>

        </div>
    </div>
</header>