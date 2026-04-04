<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - AbhiWeb</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="/css/style.css" rel="stylesheet">
        <style>
            .dashboard-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 3rem 0;
                border-radius: 0 0 20px 20px;
                margin-bottom: 2rem;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .dashboard-card {
                transition: transform 0.3s ease;
                cursor: pointer;
            }

            .dashboard-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
            }

            .progress {
                height: 10px;
                border-radius: 5px;
            }

            .course-img {
                height: 150px;
                object-fit: cover;
                border-radius: 10px 10px 0 0;
                background-color: #eee;
            }

            .activity-item {
                border-left: 2px solid #ddd;
                padding-left: 15px;
                position: relative;
            }

            .activity-item::before {
                content: '';
                width: 10px;
                height: 10px;
                background: #667eea;
                border-radius: 50%;
                position: absolute;
                left: -6px;
                top: 5px;
            }
        </style>
    </head>

    <body>

        <!-- Header -->
        <jsp:include page="sheader.jsp" />

        <!-- Dashboard Hero -->
        <div class="dashboard-header text-center">
            <div class="container">
                <h1 class="display-5 fw-bold">Hello, ${name}!</h1>
                <p class="lead mb-0">Welcome back to your learning dashboard. Overview of your progress.</p>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container mb-5">

            <!-- Stats Row -->
            <div class="row mb-5">
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card border-0 shadow-sm rounded-4 h-100 dashboard-card">
                        <div class="card-body d-flex align-items-center">
                            <div class="bg-primary text-white rounded-circle p-3 me-3">
                                <i class="fas fa-book-reader fa-lg"></i>
                            </div>
                            <div>
                                <h6 class="text-muted mb-0">Courses Enrolled</h6>
                                <h3 class="fw-bold mb-0">${enrolledCount}</h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card border-0 shadow-sm rounded-4 h-100 dashboard-card">
                        <div class="card-body d-flex align-items-center">
                            <div class="bg-success text-white rounded-circle p-3 me-3">
                                <i class="fas fa-check-circle fa-lg"></i>
                            </div>
                            <div>
                                <h6 class="text-muted mb-0">Completed</h6>
                                <h3 class="fw-bold mb-0">${completedCount}</h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card border-0 shadow-sm rounded-4 h-100 dashboard-card">
                        <div class="card-body d-flex align-items-center">
                            <div class="bg-warning text-white rounded-circle p-3 me-3">
                                <i class="fas fa-certificate fa-lg"></i>
                            </div>
                            <div>
                                <h6 class="text-muted mb-0">Certificates</h6>
                                <h3 class="fw-bold mb-0">1</h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card border-0 shadow-sm rounded-4 h-100 dashboard-card">
                        <div class="card-body d-flex align-items-center">
                            <div class="bg-info text-white rounded-circle p-3 me-3">
                                <i class="fas fa-clock fa-lg"></i>
                            </div>
                            <div>
                                <h6 class="text-muted mb-0">Hours Spent</h6>
                                <h3 class="fw-bold mb-0">12.5</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Ongoing Courses -->
                <div class="col-lg-8">
                    <h4 class="fw-bold mb-4"><i class="fas fa-play-circle me-2 text-primary"></i>Continue Learning</h4>
                    
                    <div class="card border-0 shadow-sm rounded-4 mb-3 p-3">
                        <h5 class="fw-bold text-center">Progress Overview</h5>
                        <canvas id="progressChart" style="max-height: 250px;"></canvas>
                    </div>

                    <div class="card border-0 shadow-sm rounded-4 mb-3">
                        <div class="row g-0 align-items-center">
                            <div class="col-md-3">
                                <div class="bg-dark text-white d-flex align-items-center justify-content-center h-100 p-4 rounded-start"
                                    style="min-height: 120px;">
                                    <i class="fab fa-java fa-3x"></i>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="card-body">
                                    <h5 class="card-title fw-bold">Advanced Java Programming</h5>
                                    <p class="card-text text-muted small">Chapter 4: Streams & Lambda Expressions</p>
                                    <div class="progress mb-2">
                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 65%"
                                            aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">65% Complete</small>
                                        <a href="/s-start-course" class="btn btn-sm btn-primary rounded-pill px-3">Resume</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm rounded-4 mb-3">
                        <div class="row g-0 align-items-center">
                            <div class="col-md-3">
                                <div class="bg-warning text-dark d-flex align-items-center justify-content-center h-100 p-4 rounded-start"
                                    style="min-height: 120px;">
                                    <i class="fab fa-js fa-3x"></i>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="card-body">
                                    <h5 class="card-title fw-bold">Modern JavaScript (ES6+)</h5>
                                    <p class="card-text text-muted small">Module 2: Async/Await</p>
                                    <div class="progress mb-2">
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 30%"
                                            aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">30% Complete</small>
                                        <a href="/s-start-course" class="btn btn-sm btn-warning text-white rounded-pill px-3">Resume</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm rounded-4 mb-3">
                        <div class="row g-0 align-items-center">
                            <div class="col-md-3">
                                <div class="bg-info text-white d-flex align-items-center justify-content-center h-100 p-4 rounded-start"
                                    style="min-height: 120px;">
                                    <i class="fab fa-react fa-3x"></i>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="card-body">
                                    <h5 class="card-title fw-bold">React JS for Beginners</h5>
                                    <p class="card-text text-muted small">Introduction to Components</p>
                                    <div class="progress mb-2">
                                        <div class="progress-bar bg-info" role="progressbar" style="width: 10%"
                                            aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">10% Complete</small>
                                        <a href="/s-start-course" class="btn btn-sm btn-info text-white rounded-pill px-3">Resume</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Sidebar -->
                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm rounded-4 mb-4">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-3">Recent Activity</h5>
                            <div class="activity-item pb-3 mb-3">
                                <small class="text-muted d-block">Today, 10:30 AM</small>
                                <strong>Completed Quiz</strong> for Java Basics.
                            </div>
                            <div class="activity-item pb-3 mb-3">
                                <small class="text-muted d-block">Yesterday, 4:15 PM</small>
                                <strong>Watched Lecture</strong> on Spring MVC.
                            </div>
                            <div class="activity-item">
                                <small class="text-muted d-block">Feb 09, 2:00 PM</small>
                                <strong>Joined Course</strong> Modern JavaScript.
                            </div>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm rounded-4 bg-primary text-white p-4 text-center"
                        style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                        <i class="fas fa-medal fa-3x mb-3 text-warning"></i>
                        <h5 class="fw-bold">Go Premium</h5>
                        <p class="small mb-3">Unlock all certificates and advanced projects.</p>
                        <a href="/s-premium" class="btn btn-light text-primary fw-bold rounded-pill w-100">Upgrade Now</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="sfooter.jsp" />

        <!-- Bootstrap Bundle JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Chart JS -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                var ctx = document.getElementById('progressChart').getContext('2d');
                var enrolled = "${enrolledCount}" || 0;
                var completed = "${completedCount}" || 0;
                
                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: ['Completed', 'In Progress'],
                        datasets: [{
                            data: [completed, Math.max(0, enrolled - completed)],
                            backgroundColor: ['#28a745', '#667eea'],
                            borderWidth: 0
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { position: 'bottom' }
                        }
                    }
                });
            });
        </script>
    </body>

    </html>