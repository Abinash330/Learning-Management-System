<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics Engine | EduPro Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

    <style>
        :root { --primary:#4f46e5; --secondary:#ec4899; --dark-bg:#0f172a; --body-bg:#f1f5f9; --text-main:#1e293b; --text-muted:#64748b; }
        body { background:var(--body-bg); font-family:'Inter',system-ui,sans-serif; color:var(--text-main); }

        .page-hero {
            background: linear-gradient(135deg,#0f172a 0%,#1e1b4b 60%,#312e81 100%);
            padding: 3.5rem 0 6rem; color: white;
            border-radius: 0 0 40px 40px;
            margin-bottom: -4rem;
            box-shadow: 0 20px 50px rgba(15,23,42,0.2);
            position: relative; overflow: hidden;
        }
        .hero-circle { position:absolute; border-radius:50%; filter:blur(50px); }
        .hc1 { width:250px;height:250px;background:rgba(79,70,229,0.2);top:-50px;right:8%; }
        .hc2 { width:200px;height:200px;background:rgba(236,72,153,0.15);bottom:-50px;left:5%; }

        .data-card {
            background: white; border-radius: 24px; padding: 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid rgba(0,0,0,0.05);
            height: 100%;
        }

        .stat-badge {
            display: inline-flex; align-items: center; justify-content: center;
            width: 60px; height: 60px; border-radius: 16px;
            font-size: 1.5rem; flex-shrink: 0;
        }

        .fade-up { animation:fadeUp 0.6s forwards; opacity:0; }
        .d1{animation-delay:0.1s;} .d2{animation-delay:0.2s;} .d3{animation-delay:0.3s;}
        @keyframes fadeUp { 0%{opacity:0;transform:translateY(20px);} 100%{opacity:1;transform:translateY(0);} }
    </style>
</head>
<body>
    <jsp:include page="aheader.jsp" />

    <!-- Hero -->
    <div class="page-hero text-center">
        <div class="hero-circle hc1"></div>
        <div class="hero-circle hc2"></div>
        <div class="container position-relative">
            <span class="badge px-3 py-2 rounded-pill fw-bold mb-3 d-inline-block" style="background:rgba(255,255,255,0.1);border:1px solid rgba(255,255,255,0.2);letter-spacing:1px;font-size:0.75rem;">
                <i class="bi bi-pie-chart-fill me-1"></i> ANALYTICS ENGINE
            </span>
            <h1 class="display-6 fw-bold text-white mb-2" style="letter-spacing:-1px;">Platform Metrics</h1>
            <p class="text-white mb-0" style="opacity:0.75;">Extensive statistics & engagement tracking</p>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row g-4 mb-4 fade-up d1">
            <div class="col-12 d-flex justify-content-end">
                <a href="/adashboard" class="btn btn-sm px-4 py-2 fw-bold bg-white shadow-sm" style="border:1px solid #e2e8f0;border-radius:50px;color:var(--text-muted);">
                    <i class="bi bi-arrow-left me-1"></i> Return to Dashboard
                </a>
            </div>

            <!-- Total Users -->
            <div class="col-lg-3 col-md-6">
                <div class="data-card d-flex align-items-center gap-3 p-4">
                    <div class="stat-badge bg-primary bg-opacity-10 text-primary">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div>
                        <div class="small fw-bold text-muted text-uppercase" style="font-size:0.7rem;letter-spacing:1px;">Global Users</div>
                        <div class="fw-bold text-dark" style="font-size:2rem;line-height:1;">${totalUsers}</div>
                    </div>
                </div>
            </div>

            <!-- Active Users -->
            <div class="col-lg-3 col-md-6">
                <div class="data-card d-flex align-items-center gap-3 p-4">
                    <div class="stat-badge bg-success bg-opacity-10 text-success">
                        <i class="bi bi-person-check-fill"></i>
                    </div>
                    <div>
                        <div class="small fw-bold text-muted text-uppercase" style="font-size:0.7rem;letter-spacing:1px;">Active Users</div>
                        <div class="fw-bold text-dark" style="font-size:2rem;line-height:1;">${activeUsers}</div>
                    </div>
                </div>
            </div>

            <!-- Total Courses -->
            <div class="col-lg-3 col-md-6">
                <div class="data-card d-flex align-items-center gap-3 p-4">
                    <div class="stat-badge" style="background:rgba(245,158,11,0.1);color:#f59e0b;">
                        <i class="bi bi-journal-album"></i>
                    </div>
                    <div>
                        <div class="small fw-bold text-muted text-uppercase" style="font-size:0.7rem;letter-spacing:1px;">Total Courses</div>
                        <div class="fw-bold text-dark" style="font-size:2rem;line-height:1;">${totalCourses}</div>
                    </div>
                </div>
            </div>

            <!-- Enrollments -->
            <div class="col-lg-3 col-md-6">
                <div class="data-card d-flex align-items-center gap-3 p-4">
                    <div class="stat-badge" style="background:rgba(6,182,212,0.1);color:#06b6d4;">
                        <i class="bi bi-rocket-takeoff-fill"></i>
                    </div>
                    <div>
                        <div class="small fw-bold text-muted text-uppercase" style="font-size:0.7rem;letter-spacing:1px;">Enrollments</div>
                        <div class="fw-bold text-dark" style="font-size:2rem;line-height:1;">${totalEnrollments}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 fade-up d2">
            <!-- Main Chart Area -->
            <div class="col-lg-8">
                <div class="data-card">
                    <h5 class="fw-bold mb-1"><i class="bi bi-bar-chart-fill text-primary"></i> Course Popularity</h5>
                    <p class="text-muted small mb-4">Top 5 courses based on global student enrollments</p>
                    <canvas id="courseChart" style="max-height:350px;"></canvas>
                </div>
            </div>

            <!-- Breakdown -->
            <div class="col-lg-4">
                <div class="data-card">
                    <h5 class="fw-bold mb-1"><i class="bi bi-info-square-fill text-info"></i> Breakdown</h5>
                    <p class="text-muted small mb-4">Data directly extracted</p>
                    
                    <c:forEach var="stat" items="${courseStats}" varStatus="loop">
                        <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom">
                            <span class="small fw-bold">${stat.title}</span>
                            <span class="badge bg-primary rounded-pill px-3 py-2 shadow-sm">${stat.count} enrolls</span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty courseStats}">
                        <p class="text-muted text-center pt-4">No course data available yet.</p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Hidden data points for Chart.js -->
    <c:forEach var="stat" items="${courseStats}">
        <input type="hidden" class="chart-label" value="${stat.title}">
        <input type="hidden" class="chart-data" value="${stat.count}">
    </c:forEach>

    <jsp:include page="afooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var labels = Array.from(document.querySelectorAll('.chart-label')).map(el => el.value);
            var data = Array.from(document.querySelectorAll('.chart-data')).map(el => el.value);

            if (data.length > 0) {
                var ctx = document.getElementById('courseChart').getContext('2d');
                var gradient = ctx.createLinearGradient(0, 0, 0, 400);
                gradient.addColorStop(0, 'rgba(79, 70, 229, 0.8)');
                gradient.addColorStop(1, 'rgba(79, 70, 229, 0.2)');

                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Enrollments',
                            data: data,
                            backgroundColor: gradient,
                            borderRadius: 8,
                            barThickness: 45
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: { legend: { display: false } },
                        scales: {
                            y: { beginAtZero: true, grid: { borderDash: [4, 4] } },
                            x: { grid: { display: false } }
                        }
                    }
                });
            }
        });
    </script>
</body>
</html>
