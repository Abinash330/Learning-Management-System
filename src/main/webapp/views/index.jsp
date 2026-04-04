<jsp:include page="header.jsp" />
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />

<style>
    :root {
        --primary: #6366f1;
        --secondary: #f43f5e;
        --accent: #10b981;
        --glass: rgba(255, 255, 255, 0.7);
    }

    body {
        background-color: #f8fafc;
        font-family: 'Plus Jakarta Sans', sans-serif;
        overflow-x: hidden;
    }

    /* --- Enhanced Hero Section --- */
    .hero-section {
        position: relative;
        min-height: 95vh;
        display: flex;
        align-items: center;
        background: radial-gradient(circle at 0% 0%, #ffffff 0%, #eef2ff 100%);
        overflow: hidden;
        padding: 6rem 0;
    }

    /* Modern Organic Blob Shapes */
    .hero-shape-1 {
        position: absolute; width: 45vw; height: 45vw;
        top: -5vw; right: -10vw; z-index: 0;
        background: linear-gradient(45deg, rgba(99, 102, 241, 0.2), rgba(168, 85, 247, 0.2)), 
                    url('https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&q=80&w=1000');
        background-size: cover;
        background-position: center;
        border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%; /* Organic Blob */
        animation: morph 15s ease-in-out infinite;
        filter: drop-shadow(0 20px 40px rgba(0,0,0,0.1));
    }

    .hero-shape-2 {
        position: absolute; width: 35vw; height: 35vw;
        bottom: -5vw; left: -10vw; z-index: 0;
        background: linear-gradient(45deg, rgba(244, 63, 94, 0.2), rgba(251, 146, 60, 0.2)), 
                    url('https://images.unsplash.com/photo-1501504905252-473c47e087f8?auto=format&fit=crop&q=80&w=1000');
        background-size: cover;
        background-position: center;
        border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%; /* Organic Blob */
        animation: morph 20s ease-in-out infinite reverse;
        opacity: 0.7;
    }

    @keyframes morph {
        0% { border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%; transform: rotate(0deg); }
        50% { border-radius: 30% 60% 70% 40% / 50% 60% 30% 60%; transform: rotate(5deg) scale(1.05); }
        100% { border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%; transform: rotate(0deg); }
    }

    /* Glassmorphism Content Card */
    .hero-glass-card {
        background: var(--glass);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.4);
        padding: 4rem 3rem;
        border-radius: 32px;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.05);
        z-index: 2;
        position: relative;
    }

    .hero-title {
        font-size: 4.5rem; font-weight: 800; line-height: 1.1;
        background: linear-gradient(to right, #1e293b, #4f46e5);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 1.5rem;
    }

    /* Buttons with Glow */
    .btn-main {
        padding: 1.2rem 2.8rem;
        border-radius: 16px;
        font-weight: 700;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        border: none;
        text-decoration: none;
    }

    .btn-primary-glow {
        background: var(--primary);
        color: white !important;
        box-shadow: 0 10px 25px -5px rgba(99, 102, 241, 0.4);
    }

    .btn-primary-glow:hover {
        transform: translateY(-5px) scale(1.02);
        box-shadow: 0 20px 35px -5px rgba(99, 102, 241, 0.5);
    }

    /* Feature Cards Refined */
    .feature-card {
        background: white;
        border: none;
        border-radius: 30px;
        padding: 3rem 2rem;
        transition: all 0.4s ease;
        position: relative;
        overflow: hidden;
    }

    .feature-card::before {
        content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
        background: linear-gradient(90deg, var(--primary), var(--secondary));
        opacity: 0; transition: 0.3s;
    }

    .feature-card:hover {
        transform: translateY(-15px);
        box-shadow: 0 30px 60px rgba(0,0,0,0.05);
    }

    .feature-card:hover::before { opacity: 1; }

    .feature-icon-box {
        width: 70px; height: 70px;
        background: #f1f5f9;
        border-radius: 20px;
        display: flex; align-items: center; justify-content: center;
        font-size: 2rem; color: var(--primary);
        margin: 0 auto 1.5rem;
        transition: 0.4s;
    }

    .feature-card:hover .feature-icon-box {
        background: var(--primary);
        color: white;
    }

    @media (max-width: 992px) {
        .hero-title { font-size: 3rem; }
        .hero-glass-card { padding: 2rem; }
    }
</style>

<section class="hero-section">
    <div class="hero-shape-1"></div>
    <div class="hero-shape-2"></div>
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <div class="hero-glass-card hero-content">
                    <span class="badge bg-white text-primary shadow-sm px-4 py-2 rounded-pill fw-bold mb-4">
                        ✨ Learning Reimagined
                    </span>
                    <h1 class="hero-title">Unlock Your Potential with EduPro LMS</h1>
                    <p class="hero-subtitle mb-5 text-muted px-lg-5 fs-5">
                        Join 10,000+ students on a journey of discovery. Our platform combines expert-led 
                        courses with advanced tracking to help you master any skill.
                    </p>
                    <div class="d-flex gap-3 justify-content-center flex-wrap">
                        <a href="login" class="btn-main btn-primary-glow">
                            Start Learning Now <i class="bi bi-rocket-takeoff ms-2"></i>
                        </a>
                        <a href="about" class="btn-main bg-white text-dark shadow-sm border">
                            Explore Features
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="py-5 bg-white">
    <div class="container py-5">
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="feature-card text-center h-100">
                    <div class="feature-icon-box"><i class="bi bi-lightning-charge"></i></div>
                    <h4 class="fw-bold mb-3">Instant Access</h4>
                    <p class="text-muted">Start learning within seconds. Our cloud-based platform is ready whenever you are.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="feature-card text-center h-100">
                    <div class="feature-icon-box"><i class="bi bi-shield-check"></i></div>
                    <h4 class="fw-bold mb-3">Certified Quality</h4>
                    <p class="text-muted">Earn industry-recognized certificates upon completion to boost your career.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="feature-card text-center h-100">
                    <div class="feature-icon-box"><i class="bi bi-people"></i></div>
                    <h4 class="fw-bold mb-3">Community Led</h4>
                    <p class="text-muted">Engage with thousands of peers and experts in interactive discussion forums.</p>
                </div>
            </div>
            
        </div>

        <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <div class="hero-glass-card hero-content">
                    <span class="badge bg-white text-primary shadow-sm px-4 py-2 rounded-pill fw-bold mb-4">
                        ✨ Learning Reimagined
                    </span>
                    <h1 class="hero-title">Unlock Your Potential with EduPro LMS</h1>
                    <p class="hero-subtitle mb-5 text-muted px-lg-5 fs-5">
                        Join 10,000+ students on a journey of discovery. Our platform combines expert-led 
                        courses with advanced tracking to help you master any skill.
                    </p>
                    <div class="d-flex gap-3 justify-content-center flex-wrap">
                        <a href="login" class="btn-main btn-primary-glow">
                            Start Learning Now <i class="bi bi-rocket-takeoff ms-2"></i>
                        </a>
                        <a href="about" class="btn-main bg-white text-dark shadow-sm border">
                            Explore Features
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</section>

<jsp:include page="footer.jsp" />