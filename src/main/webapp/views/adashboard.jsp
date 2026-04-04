<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Portal | EduPro LMS</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #4f46e5;
            --secondary: #ec4899;
            --dark-bg: #0f172a;
            --card-bg: #ffffff;
            --body-bg: #f1f5f9;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border-color: rgba(0,0,0,0.06);
        }

        * { box-sizing: border-box; }

        body {
            background-color: var(--body-bg);
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            color: var(--text-main);
            overflow-x: hidden;
            transition: background 0.3s, color 0.3s;
        }

        /* ── Hero ── */
        .admin-hero {
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 60%, #312e81 100%);
            padding: 4.5rem 0 7rem;
            position: relative; z-index: 0; overflow: hidden;
            border-radius: 0 0 40px 40px;
            margin-bottom: -4.5rem;
            box-shadow: 0 20px 50px rgba(15,23,42,0.2);
        }
        .hero-orb {
            position: absolute; border-radius: 50%; filter: blur(60px); z-index: -1;
        }
        .orb-1 { width:400px;height:400px; background:rgba(79,70,229,0.25); top:-100px;right:5%; animation:floatOrb 12s infinite alternate ease-in-out; }
        .orb-2 { width:300px;height:300px; background:rgba(236,72,153,0.18); bottom:-80px;left:3%; animation:floatOrb 15s infinite alternate-reverse ease-in-out; }
        .orb-3 { width:200px;height:200px; background:rgba(34,211,238,0.12); top:30%;left:40%; animation:floatOrb 10s infinite alternate ease-in-out; }
        @keyframes floatOrb { 0%{transform:translateY(0) scale(1);} 100%{transform:translateY(30px) scale(1.08);} }

        .hero-badge {
            background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2);
            color: white; border-radius: 50px; padding: 0.4rem 1.2rem; font-size: 0.8rem; font-weight: 700;
            letter-spacing: 1px; display: inline-block; margin-bottom: 1rem;
            backdrop-filter: blur(10px);
        }

        /* ── Glass Cards ── */
        .glass-card {
            background: var(--card-bg);
            border-radius: 20px;
            border: 1px solid var(--border-color);
            box-shadow: 0 4px 20px rgba(0,0,0,0.04);
            transition: all 0.35s cubic-bezier(0.175,0.885,0.32,1.275);
            position: relative; overflow: hidden;
        }
        .glass-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(79,70,229,0.1);
            border-color: rgba(79,70,229,0.15);
        }

        /* ── Stat Cards ── */
        .stat-card .stat-icon-wrapper {
            width: 56px; height: 56px; border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem; transition: all 0.35s ease; flex-shrink: 0;
        }
        .stat-card:hover .stat-icon-wrapper { transform: scale(1.12) rotate(6deg); }
        .stat-number { font-size: 2rem; font-weight: 900; line-height: 1; }
        .stat-card-accent { position: absolute; right: -20px; top: -20px; width: 100px; height: 100px; border-radius: 50%; opacity: 0.06; }

        /* ── Chart Section ── */
        .chart-card { position: relative; }
        .chart-card canvas { max-height: 240px; }

        /* ── Table ── */
        .table-container {
            background: var(--card-bg); border-radius: 24px; padding: 1.5rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.04); border: 1px solid var(--border-color);
        }
        .table { margin-bottom: 0; border-collapse: separate; border-spacing: 0 8px; margin-top: -8px; }
        .table thead th {
            border: none; background: transparent; color: var(--text-muted);
            font-weight: 700; font-size: 0.75rem; text-transform: uppercase;
            letter-spacing: 1px; padding: 0.75rem 1.25rem;
        }
        .table tbody tr { background: #f8fafc; transition: all 0.25s ease; }
        .table tbody tr:hover { background: white; box-shadow: 0 4px 15px rgba(79,70,229,0.07); transform: scale(1.005); }
        .table tbody td { border: none !important; padding: 1rem 1.25rem; vertical-align: middle; }
        .table tbody td:first-child { border-radius: 14px 0 0 14px; }
        .table tbody td:last-child { border-radius: 0 14px 14px 0; }

        /* ── Search Filter Bar ── */
        .filter-bar { background: #f8fafc; border-radius: 14px; padding: 1rem 1.25rem; border: 1px solid #e2e8f0; margin-bottom: 1.25rem; }
        .search-input { border-radius: 50px; border: 1.5px solid #e2e8f0; padding: 0.5rem 1rem 0.5rem 2.5rem; background: white; width: 100%; font-weight: 500; font-size: 0.9rem; transition: all 0.3s; }
        .search-input:focus { border-color: var(--primary); box-shadow: 0 0 0 4px rgba(79,70,229,0.1); outline: none; }
        .filter-btn { border-radius: 50px; padding: 0.4rem 1rem; font-weight: 700; font-size: 0.78rem; border: 2px solid #e2e8f0; background: white; color: var(--text-muted); cursor: pointer; transition: all 0.25s; }
        .filter-btn.active, .filter-btn:hover { background: var(--primary); border-color: var(--primary); color: white; }

        /* ── Avatars & Badges ── */
        .user-avatar {
            width: 42px; height: 42px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            background: linear-gradient(135deg, rgba(79,70,229,0.1), rgba(236,72,153,0.1));
            color: var(--primary); font-size: 1.1rem; font-weight: 800; flex-shrink: 0;
        }
        .modern-badge {
            padding: 0.35em 0.85em; font-weight: 700; border-radius: 50px; font-size: 0.72rem; letter-spacing: 0.5px;
        }

        /* ── Timeline Activity ── */
        .timeline-item { position: relative; padding-left: 2rem; margin-bottom: 1.2rem; }
        .timeline-item::before { content:''; position:absolute; left:0; top:0; height:100%; width:2px; background:#e2e8f0; }
        .timeline-item:last-child::before { height: 50%; }
        .timeline-dot {
            position:absolute; left:-5px; top:6px; width:12px; height:12px;
            border-radius:50%; background:var(--primary); border:3px solid white; box-shadow:0 0 0 2px #e2e8f0;
        }

        /* ── Op Cards ── */
        .op-card {
            border: 2px solid transparent; transition: all 0.3s ease; padding: 1.75rem;
            background: #f8fafc; border-radius: 18px; text-align: center;
        }
        .op-card:hover {
            background: white; border-color: rgba(79,70,229,0.2);
            box-shadow: 0 15px 30px rgba(0,0,0,0.06); transform: translateY(-5px);
        }

        /* ── Notice & Contact Panels ── */
        .panel-item {
            border-radius: 12px; padding: 1rem; border: 1px solid #e2e8f0;
            background: #f8fafc; margin-bottom: 0.75rem; transition: all 0.25s;
        }
        .panel-item:hover { background: white; border-color: rgba(79,70,229,0.2); box-shadow: 0 4px 12px rgba(0,0,0,0.04); }
        .panel-item:last-child { margin-bottom: 0; }

        /* ── Buttons ── */
        .btn-gradient {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white; border: none; font-weight: 700; padding: 0.65rem 1.75rem; border-radius: 50px;
            transition: all 0.3s ease; box-shadow: 0 4px 15px rgba(79,70,229,0.25);
        }
        .btn-gradient:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(79,70,229,0.35); color: white; }
        .btn-outline-custom {
            border: 2px solid #e2e8f0; border-radius: 50px; font-weight: 600;
            padding: 0.5rem 1rem; color: var(--text-main); background: white; transition: all 0.3s ease;
        }
        .btn-outline-custom:hover { background: #f8fafc; border-color: #cbd5e1; transform: translateY(-2px); }

        /* ── Section Titles ── */
        .section-title { font-weight: 900; font-size: 1.2rem; display: flex; align-items: center; gap: 0.5rem; }
        .section-subtitle { font-size: 0.82rem; color: var(--text-muted); margin-top: 0.2rem; }

        /* ── Animations ── */
        .fade-up { animation: fadeUp 0.6s forwards; opacity: 0; }
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        .delay-4 { animation-delay: 0.4s; }
        @keyframes fadeUp { 0%{opacity:0;transform:translateY(28px);} 100%{opacity:1;transform:translateY(0);} }

        /* ── Progress Bar ── */
        .custom-progress { height: 8px; border-radius: 10px; overflow: hidden; background: #e2e8f0; }
        .custom-progress-bar { height: 100%; border-radius: 10px; background: linear-gradient(90deg, var(--primary), var(--secondary)); transition: width 1.5s ease; width: 0; }

        /* ── Dark mode overrides ── */
        body.dark-mode { background: #0f172a !important; color: #e2e8f0 !important; }
        body.dark-mode .glass-card { background: #1e293b !important; border-color: rgba(255,255,255,0.07) !important; }
        body.dark-mode .table-container { background: #1e293b !important; border-color: rgba(255,255,255,0.07) !important; }
        body.dark-mode .table tbody tr { background: #0f172a !important; }
        body.dark-mode .table tbody tr:hover { background: #1e293b !important; }
        body.dark-mode .table tbody td, body.dark-mode .table thead th { color: #cbd5e1 !important; }
        body.dark-mode .op-card, body.dark-mode .panel-item, body.dark-mode .filter-bar { background: #1e293b !important; border-color: rgba(255,255,255,0.08) !important; }
        body.dark-mode .op-card:hover, body.dark-mode .panel-item:hover { background: #0f172a !important; }
        body.dark-mode .search-input { background: #1e293b !important; border-color: rgba(255,255,255,0.1) !important; color: #e2e8f0 !important; }
        body.dark-mode .filter-btn { background: #1e293b !important; border-color: rgba(255,255,255,0.1) !important; color: #94a3b8 !important; }
        body.dark-mode .filter-btn.active { background: var(--primary) !important; border-color: var(--primary) !important; color: white !important; }
        body.dark-mode h1,body.dark-mode h2,body.dark-mode h3,body.dark-mode h4,body.dark-mode h5,body.dark-mode h6,body.dark-mode .text-dark,body.dark-mode .fw-bold { color: #e2e8f0 !important; }
        body.dark-mode .text-muted { color: #94a3b8 !important; }
        body.dark-mode .stat-number { color: #f1f5f9 !important; }
        body.dark-mode .timeline-dot { border-color: #1e293b !important; }
        body.dark-mode .btn-outline-custom { background: #1e293b !important; border-color: rgba(255,255,255,0.1) !important; color: #e2e8f0 !important; }
    </style>
</head>

<body>
    <jsp:include page="aheader.jsp" />

    <!-- ════ HERO ════ -->
    <div class="admin-hero text-center">
        <div class="hero-orb orb-1"></div>
        <div class="hero-orb orb-2"></div>
        <div class="hero-orb orb-3"></div>
        <div class="container fade-up delay-1">
            <span class="hero-badge"><i class="bi bi-shield-lock-fill me-1"></i> Systems Control</span>
            <h1 class="display-5 fw-bold text-white mb-3" style="letter-spacing:-1px;">Administrator Portal</h1>
            <p class="lead text-white mx-auto" style="max-width:580px;opacity:0.75;">
                Oversee operations, manage users, publish notices, and monitor analytics — all in real time.
            </p>
        </div>
    </div>

    <!-- ════ MAIN CONTENT ════ -->
    <div class="container mb-5">

        <!-- ── STAT CARDS ROW ── -->
        <div class="row g-4 mb-5 fade-up delay-2">

            <!-- Active Users -->
            <div class="col-xl col-md-6 col-6">
                <div class="glass-card stat-card p-4 h-100">
                    <div class="stat-card-accent" style="background:var(--primary);"></div>
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="stat-icon-wrapper bg-primary bg-opacity-10 text-primary">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <div>
                            <div class="small fw-bold text-muted text-uppercase" style="font-size:0.7rem;letter-spacing:1px;">Active Users</div>
                            <div class="stat-number text-dark" data-counter="${activeUsersCount}">0</div>
                        </div>
                    </div>
                    <div class="small text-success fw-bold"><i class="bi bi-arrow-up-right-circle-fill me-1"></i> Live from DB</div>
                </div>
            </div>

            <!-- Faculty -->
            <div class="col-xl col-md-6 col-6">
                <div class="glass-card stat-card p-4 h-100">
                    <div class="stat-card-accent" style="background:#06b6d4;"></div>
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="stat-icon-wrapper bg-info bg-opacity-10 text-info">
                            <i class="bi bi-person-video3"></i>
                        </div>
                        <div>
                            <div class="small fw-bold text-muted text-uppercase" style="font-size:0.7rem;letter-spacing:1px;">Faculty</div>
                            <div class="stat-number text-dark" data-counter="${facultyCount}">0</div>
                        </div>
                    </div>
                    <div class="small text-success fw-bold"><i class="bi bi-arrow-up-right-circle-fill me-1"></i> Live from DB</div>
                </div>
            </div>

            <!-- Students -->
            <div class="col-xl col-md-6 col-6">
                <div class="glass-card stat-card p-4 h-100">
                    <div class="stat-card-accent" style="background:#10b981;"></div>
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="stat-icon-wrapper" style="background:rgba(16,185,129,0.1);color:#10b981;">
                            <i class="bi bi-mortarboard-fill"></i>
                        </div>
                        <div>
                            <div class="small fw-bold text-muted text-uppercase" style="font-size:0.7rem;letter-spacing:1px;">Students</div>
                            <div class="stat-number text-dark" data-counter="${studentCount}">0</div>
                        </div>
                    </div>
                    <div class="small text-success fw-bold"><i class="bi bi-arrow-up-right-circle-fill me-1"></i> Live from DB</div>
                </div>
            </div>

            <!-- Total Courses -->
            <div class="col-xl col-md-6 col-6">
                <div class="glass-card stat-card p-4 h-100">
                    <div class="stat-card-accent" style="background:#f59e0b;"></div>
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="stat-icon-wrapper" style="background:rgba(245,158,11,0.1);color:#f59e0b;">
                            <i class="bi bi-journal-album"></i>
                        </div>
                        <div>
                            <div class="small fw-bold text-muted text-uppercase" style="font-size:0.7rem;letter-spacing:1px;">Courses</div>
                            <div class="stat-number text-dark" data-counter="${totalCourses}">0</div>
                        </div>
                    </div>
                    <div class="small text-muted fw-bold"><i class="bi bi-dash-circle-fill me-1"></i> Live from DB</div>
                </div>
            </div>

            <!-- Pending Approvals -->
            <div class="col-xl col-md-6 col-6">
                <div class="glass-card stat-card p-4 h-100" style="border: 2px solid rgba(239,68,68,0.25);">
                    <div class="stat-card-accent" style="background:#ef4444;"></div>
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="stat-icon-wrapper bg-danger bg-opacity-10 text-danger">
                            <i class="bi bi-hourglass-split"></i>
                        </div>
                        <div>
                            <div class="small fw-bold text-muted text-uppercase" style="font-size:0.7rem;letter-spacing:1px;">Pending</div>
                            <div class="stat-number text-dark" data-counter="${pendingCount}">0</div>
                        </div>
                    </div>
                    <div class="small text-warning fw-bold"><i class="bi bi-exclamation-triangle-fill me-1"></i> Awaiting Approval</div>
                </div>
            </div>

        </div>

        <!-- ── CHARTS ROW ── -->
        <div class="row g-4 mb-5 fade-up delay-3">

            <!-- Role Distribution Donut -->
            <div class="col-lg-5">
                <div class="glass-card chart-card p-4 h-100">
                    <div class="section-title mb-1"><i class="bi bi-pie-chart-fill text-primary"></i> Role Distribution</div>
                    <div class="section-subtitle mb-3">Breakdown of user roles in the system</div>
                    <canvas id="roleChart"></canvas>
                    <div class="d-flex justify-content-center gap-3 mt-3 flex-wrap">
                        <span class="small fw-bold"><span class="me-1" style="color:#4f46e5;">●</span>Admin: ${adminCount}</span>
                        <span class="small fw-bold"><span class="me-1" style="color:#06b6d4;">●</span>Faculty: ${facultyCount}</span>
                        <span class="small fw-bold"><span class="me-1" style="color:#10b981;">●</span>Students: ${studentCount}</span>
                    </div>
                </div>
            </div>

            <!-- System Overview + Progress -->
            <div class="col-lg-7">
                <div class="glass-card p-4 h-100">
                    <div class="section-title mb-1"><i class="bi bi-bar-chart-fill text-secondary"></i> System Overview</div>
                    <div class="section-subtitle mb-4">Platform health and usage metrics</div>

                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-1">
                            <span class="fw-bold small">Total Users Registered</span>
                            <span class="fw-bold small text-primary">${totalUsers}</span>
                        </div>
                        <div class="custom-progress"><div class="custom-progress-bar" data-width="100"></div></div>
                    </div>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-1">
                            <span class="fw-bold small">Active Users (Approved)</span>
                            <span class="fw-bold small text-success">${activeUsersCount}</span>
                        </div>
                        <div class="custom-progress"><div class="custom-progress-bar" style="background:linear-gradient(90deg,#10b981,#059669);" data-width="80"></div></div>
                    </div>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-1">
                            <span class="fw-bold small">Total Enrollments</span>
                            <span class="fw-bold small text-info">${totalEnrollments}</span>
                        </div>
                        <div class="custom-progress"><div class="custom-progress-bar" style="background:linear-gradient(90deg,#06b6d4,#0891b2);" data-width="65"></div></div>
                    </div>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-1">
                            <span class="fw-bold small">Total Courses</span>
                            <span class="fw-bold small text-warning">${totalCourses}</span>
                        </div>
                        <div class="custom-progress"><div class="custom-progress-bar" style="background:linear-gradient(90deg,#f59e0b,#d97706);" data-width="45"></div></div>
                    </div>
                    <div class="mb-2">
                        <div class="d-flex justify-content-between mb-1">
                            <span class="fw-bold small">Pending Approvals</span>
                            <span class="fw-bold small text-danger">${pendingCount}</span>
                        </div>
                        <div class="custom-progress"><div class="custom-progress-bar" style="background:linear-gradient(90deg,#ef4444,#dc2626);" data-width="20"></div></div>
                    </div>

                    <!-- Quick numbers row -->
                    <div class="row g-3 mt-3">
                        <div class="col-4">
                            <div class="text-center p-3 rounded-3" style="background:#f0fdf4;">
                                <div class="fw-bold text-success fs-5">${activeUsersCount}</div>
                                <div class="small text-muted">Online Ready</div>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="text-center p-3 rounded-3" style="background:#eff6ff;">
                                <div class="fw-bold text-primary fs-5">${totalEnrollments}</div>
                                <div class="small text-muted">Enrolled</div>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="text-center p-3 rounded-3" style="background:#fff7ed;">
                                <div class="fw-bold text-warning fs-5">${totalCourses}</div>
                                <div class="small text-muted">Courses</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ── USER TABLE + ACTIVITY (Left 8, Right 4) ── -->
        <div class="row g-4 mb-5 fade-up delay-4">

            <!-- Left: User Directory -->
            <div class="col-lg-8">
                <div class="table-container">
                    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                        <div>
                            <div class="section-title"><i class="bi bi-file-earmark-person-fill text-primary"></i> User Directory</div>
                            <div class="section-subtitle">Approve, suspend, or manage platform members</div>
                        </div>
                        <button class="btn btn-gradient shadow-sm btn-sm px-4" data-bs-toggle="modal" data-bs-target="#addUserModal">
                            <i class="bi bi-plus-lg me-1"></i> Provision User
                        </button>
                    </div>

                    <!-- Filter Bar -->
                    <div class="filter-bar">
                        <div class="row g-2 align-items-center">
                            <div class="col-md-5">
                                <div class="position-relative">
                                    <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted" style="font-size:0.85rem;"></i>
                                    <input type="text" id="userSearchInput" class="search-input" placeholder="Search by name or email..." style="padding-left:2.2rem;">
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="d-flex gap-2 flex-wrap">
                                    <button class="filter-btn active" onclick="filterTable('all',this)">All</button>
                                    <button class="filter-btn" onclick="filterTable('Admin',this)"><i class="bi bi-shield-fill me-1"></i>Admin</button>
                                    <button class="filter-btn" onclick="filterTable('Faculty',this)"><i class="bi bi-person-video3 me-1"></i>Faculty</button>
                                    <button class="filter-btn" onclick="filterTable('Student',this)"><i class="bi bi-mortarboard me-1"></i>Student</button>
                                    <button class="filter-btn" onclick="filterTable('pending',this)"><i class="bi bi-hourglass me-1"></i>Pending</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table align-middle" id="userTable">
                            <thead>
                                <tr>
                                    <th>Account Details</th>
                                    <th>Role &amp; Status</th>
                                    <th>Activity</th>
                                    <th class="text-end">Manage</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${users_master}">
                                    <tr data-role="${user.role}" data-status="${user.status}" data-name="${user.name}" data-email="${user.email}">
                                        <td>
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="user-avatar shadow-sm">
                                                    ${user.name.substring(0,1).toUpperCase()}
                                                </div>
                                                <div>
                                                    <div class="fw-bold">${user.name}</div>
                                                    <div class="small text-muted"><i class="bi bi-envelope me-1"></i>${user.email}</div>
                                                    <div class="small text-muted"><i class="bi bi-telephone me-1"></i>${user.mobile}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="mb-1">
                                                <c:choose>
                                                    <c:when test="${user.role == 'Admin'}">
                                                        <span class="modern-badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25">ADMIN</span>
                                                    </c:when>
                                                    <c:when test="${user.role == 'Faculty'}">
                                                        <span class="modern-badge bg-info bg-opacity-10 text-info border border-info border-opacity-25">FACULTY</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="modern-badge bg-success bg-opacity-10 text-success border border-success border-opacity-25">STUDENT</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <c:choose>
                                                    <c:when test="${user.status == 1}">
                                                        <span class="modern-badge bg-success bg-opacity-10 text-success"><i class="bi bi-check-circle-fill me-1"></i>Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="modern-badge bg-warning bg-opacity-15 text-warning"><i class="bi bi-exclamation-triangle-fill me-1"></i>Pending</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.is_online == 1}">
                                                    <span class="badge rounded-pill bg-success px-2 py-1">
                                                        <div class="spinner-grow spinner-grow-sm text-light me-1" role="status" style="width:0.45rem;height:0.45rem;"></div> Online
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge rounded-pill bg-secondary px-2 py-1">
                                                        <i class="bi bi-circle-fill me-1" style="font-size:0.4rem;vertical-align:middle;"></i> Offline
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end">
                                            <div class="dropdown">
                                                <button class="btn btn-light rounded-circle shadow-sm" type="button" data-bs-toggle="dropdown" style="width:36px;height:36px;">
                                                    <i class="bi bi-three-dots-vertical"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end shadow border-0 rounded-4 p-2 mt-2">
                                                    <form method="post" action="/adashboard" class="m-0 p-0">
                                                        <input type="hidden" value="${user.email}" name="email"/>
                                                        <li>
                                                            <c:choose>
                                                                <c:when test="${user.status == 1}">
                                                                    <button type="submit" name="btn" value="deactivate" class="dropdown-item rounded-3 text-warning fw-semibold py-2">
                                                                        <i class="bi bi-pause-circle-fill me-2"></i> Suspend Access
                                                                    </button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <button type="submit" name="btn" value="activate" class="dropdown-item rounded-3 text-success fw-semibold py-2">
                                                                        <i class="bi bi-check-circle-fill me-2"></i> Approve Account
                                                                    </button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </li>
                                                        <li><hr class="dropdown-divider my-1"></li>
                                                        <li>
                                                            <button type="submit" name="btn" value="delete" class="dropdown-item rounded-3 text-danger fw-semibold py-2"
                                                                onclick="return confirm('Permanently delete this user? This cannot be undone.');">
                                                                <i class="bi bi-trash3-fill me-2"></i> Delete User
                                                            </button>
                                                        </li>
                                                    </form>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <!-- No results message -->
                        <div id="noUsersMsg" class="text-center py-4 d-none">
                            <i class="bi bi-search text-muted" style="font-size:2rem;"></i>
                            <p class="text-muted mt-2">No users match your filter.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right: Activity + Security -->
            <div class="col-lg-4">

                <!-- Activity Feed -->
                <div class="glass-card p-4 mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="section-title"><i class="bi bi-activity text-primary"></i> Recent Members</div>
                        <span class="badge bg-danger rounded-pill px-2 py-1 shadow-sm"><i class="bi bi-record-circle-fill me-1"></i>LIVE</span>
                    </div>
                    <c:choose>
                        <c:when test="${not empty recentUsers}">
                            <c:forEach var="ru" items="${recentUsers}">
                                <div class="timeline-item">
                                    <div class="timeline-dot
                                        <c:choose>
                                            <c:when test='${ru.role == "Admin"}'> bg-danger</c:when>
                                            <c:when test='${ru.role == "Faculty"}'> bg-info</c:when>
                                            <c:otherwise> bg-success</c:otherwise>
                                        </c:choose>">
                                    </div>
                                    <h6 class="fw-bold mb-0" style="font-size:0.88rem;">${ru.name}</h6>
                                    <p class="small text-muted mb-1" style="font-size:0.78rem;">${ru.email}</p>
                                    <c:choose>
                                        <c:when test="${ru.role == 'Admin'}"><span class="modern-badge bg-danger bg-opacity-10 text-danger" style="font-size:0.68rem;">Admin</span></c:when>
                                        <c:when test="${ru.role == 'Faculty'}"><span class="modern-badge bg-info bg-opacity-10 text-info" style="font-size:0.68rem;">Faculty</span></c:when>
                                        <c:otherwise><span class="modern-badge bg-success bg-opacity-10 text-success" style="font-size:0.68rem;">Student</span></c:otherwise>
                                    </c:choose>
                                    &nbsp;
                                    <c:choose>
                                        <c:when test="${ru.status == 1}"><span class="modern-badge bg-success bg-opacity-10 text-success" style="font-size:0.68rem;">Active</span></c:when>
                                        <c:otherwise><span class="modern-badge bg-warning bg-opacity-15 text-warning" style="font-size:0.68rem;">Pending</span></c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted small text-center py-3">No recent users found.</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Security Status -->
                <div class="glass-card text-white p-4 text-center mb-4" style="background:linear-gradient(135deg,#4f46e5,#3730a3)!important;border:none;box-shadow:0 15px 30px rgba(79,70,229,0.3);">
                    <div style="width:70px;height:70px;background:rgba(255,255,255,0.15);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:2rem;margin:0 auto 1rem;">
                        <i class="bi bi-shield-lock-fill"></i>
                    </div>
                    <h5 class="fw-bold text-white mb-2">Security Status</h5>
                    <p class="small text-white mb-4" style="opacity:0.75;">All admin routes protected. Role-based access control active.</p>
                    <div class="d-flex justify-content-center gap-3 mb-3">
                        <div class="text-center">
                            <div class="fw-bold text-white">${totalUsers}</div>
                            <div class="small" style="opacity:0.7;">Users</div>
                        </div>
                        <div style="width:1px;background:rgba(255,255,255,0.2);"></div>
                        <div class="text-center">
                            <div class="fw-bold text-white">${pendingCount}</div>
                            <div class="small" style="opacity:0.7;">Pending</div>
                        </div>
                        <div style="width:1px;background:rgba(255,255,255,0.2);"></div>
                        <div class="text-center">
                            <div class="fw-bold text-white">99.9%</div>
                            <div class="small" style="opacity:0.7;">Uptime</div>
                        </div>
                    </div>
                    <span class="badge bg-success px-3 py-2 rounded-pill fw-bold"><i class="bi bi-check-circle-fill me-1"></i>All Systems Healthy</span>
                </div>
            </div>
        </div>

        <!-- ── PLATFORM OPS ── -->
        <div class="row g-4 mb-5 fade-up delay-3">
            <div class="col-12">
                <div class="section-title mb-4"><i class="bi bi-grid-1x2-fill text-primary"></i> Platform Operations</div>
            </div>
            <div class="col-md-3 col-6">
                <div class="op-card">
                    <div class="stat-icon-wrapper mx-auto mb-3" style="background:rgba(99,102,241,0.1);color:#6366f1;">
                        <i class="bi bi-database-fill-gear"></i>
                    </div>
                    <h5 class="fw-bold mb-1" style="font-size:1rem;">Database Access</h5>
                    <p class="text-muted small mb-3">Manage raw SQL tables and system logs.</p>
                    <a href="/users" class="btn btn-outline-custom w-100">Open Console</a>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="op-card">
                    <div class="stat-icon-wrapper mx-auto mb-3" style="background:rgba(6,182,212,0.1);color:#06b6d4;">
                        <i class="bi bi-collection-play-fill"></i>
                    </div>
                    <h5 class="fw-bold mb-1" style="font-size:1rem;">Course Builder</h5>
                    <p class="text-muted small mb-3">Construct learning modules globally.</p>
                    <button class="btn btn-outline-custom w-100">Manage Courses</button>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="op-card">
                    <div class="stat-icon-wrapper mx-auto mb-3" style="background:rgba(20,184,166,0.1);color:#14b8a6;">
                        <i class="bi bi-pie-chart-fill"></i>
                    </div>
                    <h5 class="fw-bold mb-1" style="font-size:1rem;">Analytics Engine</h5>
                    <p class="text-muted small mb-3">View engagement &amp; traffic reports.</p>
                    <button class="btn btn-outline-custom w-100">View Metrics</button>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="op-card">
                    <div class="stat-icon-wrapper mx-auto mb-3" style="background:rgba(249,115,22,0.1);color:#f97316;">
                        <i class="bi bi-broadcast-pin"></i>
                    </div>
                    <h5 class="fw-bold mb-1" style="font-size:1rem;">Announcements</h5>
                    <p class="text-muted small mb-3">Broadcast global portal notices.</p>
                    <a href="/addnotice" class="btn btn-outline-custom w-100">Post Notice</a>
                </div>
            </div>
        </div>

        <!-- ── NOTICES + CONTACT INBOX ── -->
        <div class="row g-4 mb-5 fade-up delay-4">

            <!-- Notice History -->
            <div class="col-lg-6">
                <div class="glass-card p-4 h-100">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="section-title"><i class="bi bi-megaphone-fill text-warning"></i> Notice History</div>
                        <a href="/addnotice" class="btn btn-sm btn-gradient px-3">+ New</a>
                    </div>
                    <c:choose>
                        <c:when test="${not empty recentNotices}">
                            <c:forEach var="notice" items="${recentNotices}">
                                <div class="panel-item">
                                    <div class="d-flex align-items-start gap-2">
                                        <div class="mt-1" style="min-width:28px;height:28px;background:rgba(245,158,11,0.1);border-radius:8px;display:flex;align-items:center;justify-content:center;color:#f59e0b;font-size:0.85rem;">
                                            <i class="bi bi-megaphone-fill"></i>
                                        </div>
                                        <div>
                                            <div class="fw-bold" style="font-size:0.88rem;">${notice.title}</div>
                                            <div class="small text-muted" style="font-size:0.78rem;">
                                                <c:out value="${notice.description}" />
                                            </div>
                                            <div class="small text-primary fw-bold mt-1" style="font-size:0.73rem;">
                                                <i class="bi bi-calendar3 me-1"></i>${notice.notice_date}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4">
                                <i class="bi bi-megaphone text-muted" style="font-size:2.5rem;"></i>
                                <p class="text-muted mt-2 small">No notices published yet.</p>
                                <a href="/addnotice" class="btn btn-sm btn-gradient">Publish First Notice</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Contact Inbox -->
            <div class="col-lg-6">
                <div class="glass-card p-4 h-100">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="section-title"><i class="bi bi-envelope-fill text-primary"></i> Contact Inbox</div>
                        <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill fw-bold">
                            <c:choose>
                                <c:when test="${not empty recentContacts}">${recentContacts.size()} msgs</c:when>
                                <c:otherwise>0 msgs</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <c:choose>
                        <c:when test="${not empty recentContacts}">
                            <c:forEach var="contact" items="${recentContacts}">
                                <div class="panel-item">
                                    <div class="d-flex align-items-start gap-2">
                                        <div style="min-width:36px;height:36px;background:linear-gradient(135deg,rgba(79,70,229,0.1),rgba(236,72,153,0.1));border-radius:10px;display:flex;align-items:center;justify-content:center;color:var(--primary);font-weight:800;font-size:1rem;flex-shrink:0;">
                                            ${contact.name.substring(0,1).toUpperCase()}
                                        </div>
                                        <div style="min-width:0;">
                                            <div class="fw-bold" style="font-size:0.88rem;">${contact.name}
                                                <span class="text-muted fw-normal" style="font-size:0.78rem;">— ${contact.subject}</span>
                                            </div>
                                            <div class="small text-muted" style="font-size:0.78rem;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">
                                                ${contact.message}
                                            </div>
                                            <div class="small text-muted mt-1" style="font-size:0.73rem;"><i class="bi bi-envelope me-1"></i>${contact.email}</div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4">
                                <i class="bi bi-inbox text-muted" style="font-size:2.5rem;"></i>
                                <p class="text-muted mt-2 small">No contact messages received yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

    </div>

    <!-- ════ PROVISION USER MODAL ════ -->
    <div class="modal fade" id="addUserModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg" style="border-radius:24px;overflow:hidden;">
                <div class="modal-header border-0 pb-0 pt-4 px-4 bg-light">
                    <h5 class="modal-title fw-bold text-dark d-flex align-items-center">
                        <div class="stat-icon-wrapper bg-primary bg-opacity-10 text-primary me-3" style="width:42px;height:42px;border-radius:12px;font-size:1.1rem;">
                            <i class="bi bi-person-plus-fill"></i>
                        </div>
                        Provision Account
                    </h5>
                    <button type="button" class="btn-close rounded-circle bg-white shadow-sm p-3 position-relative" style="top:-8px;right:0;" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4 pt-3 bg-light">
                    <form action="/admin-add" method="post">
                        <div class="mb-3 form-floating">
                            <input type="text" name="name" class="form-control border-0 rounded-4 shadow-sm px-4" id="pName" placeholder="Full Name" required>
                            <label for="pName" class="px-4 text-muted"><i class="bi bi-person me-2"></i>Full Name</label>
                        </div>
                        <div class="mb-3 form-floating">
                            <input type="email" name="email" class="form-control border-0 rounded-4 shadow-sm px-4" id="pEmail" placeholder="Email Address" required>
                            <label for="pEmail" class="px-4 text-muted"><i class="bi bi-envelope-at me-2"></i>Email Address</label>
                        </div>
                        <div class="row g-3 mb-3">
                            <div class="col-md-6 form-floating">
                                <input type="text" name="mobile" class="form-control border-0 rounded-4 shadow-sm px-4" id="pPhone" placeholder="Mobile" required>
                                <label for="pPhone" class="px-4 text-muted ms-2"><i class="bi bi-phone me-2"></i>Mobile</label>
                            </div>
                            <div class="col-md-6 form-floating">
                                <input type="password" name="password" class="form-control border-0 rounded-4 shadow-sm px-4" id="pPass" placeholder="Password" required>
                                <label for="pPass" class="px-4 text-muted ms-2"><i class="bi bi-lock me-2"></i>Password</label>
                            </div>
                        </div>
                        <div class="mb-4 form-floating">
                            <select name="role" class="form-select border-0 rounded-4 shadow-sm px-4 fw-bold" id="pRole" required>
                                <option value="" disabled selected>Select assigned role...</option>
                                <option value="Student">Student (Standard Access)</option>
                                <option value="Faculty">Faculty (Instructor Access)</option>
                                <option value="Admin">Administrator (Full Access)</option>
                            </select>
                            <label for="pRole" class="px-4 text-muted"><i class="bi bi-shield-check me-2"></i>Account Role</label>
                        </div>
                        <button type="submit" class="btn btn-gradient w-100 py-3 shadow">
                            Create User Identity <i class="bi bi-arrow-right-short fs-5 ms-1" style="vertical-align:middle;"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="afooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // ── Animated Number Counters ──
        document.querySelectorAll('[data-counter]').forEach(el => {
            const target = parseInt(el.getAttribute('data-counter')) || 0;
            let current = 0;
            const duration = 1500;
            const stepTime = Math.max(10, Math.floor(duration / (target || 1)));
            const increment = Math.ceil(target / (duration / stepTime));
            const timer = setInterval(() => {
                current = Math.min(current + increment, target);
                el.textContent = current.toLocaleString();
                if (current >= target) clearInterval(timer);
            }, stepTime);
        });

        // ── Progress Bars Animate ──
        window.addEventListener('load', () => {
            document.querySelectorAll('.custom-progress-bar').forEach(bar => {
                const w = bar.getAttribute('data-width') || '0';
                setTimeout(() => { bar.style.width = w + '%'; }, 400);
            });
        });

        // ── Role Distribution Donut Chart ──
        (function() {
            const ctx = document.getElementById('roleChart');
            if (!ctx) return;
            const adminVal   = parseInt('${adminCount}')   || 0;
            const facultyVal = parseInt('${facultyCount}') || 0;
            const studentVal = parseInt('${studentCount}') || 0;
            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Admin', 'Faculty', 'Student'],
                    datasets: [{
                        data: [adminVal, facultyVal, studentVal],
                        backgroundColor: ['#ef4444', '#06b6d4', '#10b981'],
                        borderWidth: 0,
                        hoverOffset: 8
                    }]
                },
                options: {
                    responsive: true, maintainAspectRatio: true,
                    cutout: '65%',
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            callbacks: {
                                label: ctx => ` ${ctx.label}: ${ctx.raw} users`
                            }
                        }
                    }
                }
            });
        })();

        // ── User Table Live Search ──
        document.getElementById('userSearchInput').addEventListener('input', function() {
            applyFilters();
        });

        let activeRole = 'all';
        function filterTable(role, btn) {
            activeRole = role;
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            if(btn) btn.classList.add('active');
            applyFilters();
        }

        function applyFilters() {
            const q = document.getElementById('userSearchInput').value.toLowerCase().trim();
            const rows = document.querySelectorAll('#userTable tbody tr');
            let visible = 0;
            rows.forEach(row => {
                const name   = (row.getAttribute('data-name')  || '').toLowerCase();
                const email  = (row.getAttribute('data-email') || '').toLowerCase();
                const role   = row.getAttribute('data-role')  || '';
                const status = row.getAttribute('data-status')|| '';
                const matchSearch = !q || name.includes(q) || email.includes(q);
                const matchRole = activeRole === 'all'
                    || (activeRole === 'pending' && status === '0')
                    || role.toLowerCase() === activeRole.toLowerCase();
                if(matchSearch && matchRole) { row.style.display=''; visible++; }
                else { row.style.display='none'; }
            });
            document.getElementById('noUsersMsg').classList.toggle('d-none', visible > 0);
        }
    </script>
</body>
</html>