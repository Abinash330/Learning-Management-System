<jsp:include page="header.jsp" />


<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="/css/bootstrap.min.css" />

<style>
    .about-hero {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 80px 20px;
        border-radius: 0 0 40px 40px;
    }
    .feature-icon {
        font-size: 2.2rem;
        color: #764ba2;
    }
</style>

<body class="bg-light">

<!-- Hero Section -->
<div class="about-hero text-center">
    <h1 class="fw-bold">About Our LMS</h1>
    <p class="lead mb-0">Learning made simple, smart & accessible</p>
</div>

<div class="container py-5">

    <!-- About Content -->
    <div class="row justify-content-center mb-5">
        <div class="col-md-9">
            <div class="card shadow border-0 rounded-4">
                <div class="card-body p-4 p-md-5">

                    <p class="fs-5">
                        Our <strong>Learning Management System (LMS)</strong> is built to
                        empower students and educators by providing a simple, secure,
                        and efficient digital learning environment.
                    </p>

                    <p class="text-muted">
                        The platform supports course management, progress tracking,
                        and seamless interaction between teachers and students,
                        ensuring a smooth learning experience.
                    </p>

                </div>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="row text-center g-4">

        <div class="col-md-4">
            <div class="card h-100 shadow-sm border-0 rounded-4">
                <div class="card-body">
                    <i class="bi bi-journal-bookmark feature-icon"></i>
                    <h5 class="fw-semibold mt-3">Course Management</h5>
                    <p class="text-muted">
                        Easily create, manage, and organize courses in one place.
                    </p>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm border-0 rounded-4">
                <div class="card-body">
                    <i class="bi bi-people feature-icon"></i>
                    <h5 class="fw-semibold mt-3">User Accounts</h5>
                    <p class="text-muted">
                        Dedicated accounts for students and teachers with secure access.
                    </p>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm border-0 rounded-4">
                <div class="card-body">
                    <i class="bi bi-graph-up-arrow feature-icon"></i>
                    <h5 class="fw-semibold mt-3">Progress Tracking</h5>
                    <p class="text-muted">
                        Track performance, progress, and achievements in real time.
                    </p>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm border-0 rounded-4">
                <div class="card-body">
                    <i class="bi bi-shield-lock feature-icon"></i>
                    <h5 class="fw-semibold mt-3">Secure Login</h5>
                    <p class="text-muted">
                        Strong authentication ensures data privacy and security.
                    </p>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm border-0 rounded-4">
                <div class="card-body">
                    <i class="bi bi-phone feature-icon"></i>
                    <h5 class="fw-semibold mt-3">Responsive Design</h5>
                    <p class="text-muted">
                        Works smoothly across mobiles, tablets, and desktops.
                    </p>
                </div>
            </div>
        </div>

    </div>

    <!-- Footer Note -->
    <div class="row mt-5">
        <div class="col text-center">
            <p class="text-muted">
                Our mission is to make learning <strong>organized, engaging, and enjoyable</strong> for everyone.
            </p>
        </div>
    </div>

</div>
<jsp:include page="footer.jsp" />

</body>
