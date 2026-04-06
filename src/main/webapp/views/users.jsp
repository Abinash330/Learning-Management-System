<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Center | EduPro Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
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

        .mini-stat-card {
            background: white; border-radius: 18px; padding: 1.25rem 1.5rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid rgba(0,0,0,0.05);
            display: flex; align-items: center; gap: 1rem;
            transition: all 0.3s ease;
        }
        .mini-stat-card:hover { transform: translateY(-4px); box-shadow: 0 12px 30px rgba(79,70,229,0.1); }
        .mini-icon { width:48px;height:48px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.3rem;flex-shrink:0; }

        .data-card {
            background: white; border-radius: 24px; padding: 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid rgba(0,0,0,0.05);
        }

        .filter-bar { background:#f8fafc; border-radius:14px; padding:1rem 1.25rem; border:1px solid #e2e8f0; margin-bottom:1.25rem; }
        .search-input { border-radius:50px; border:1.5px solid #e2e8f0; padding:0.5rem 1rem 0.5rem 2.5rem; background:white; width:100%; font-weight:500; font-size:0.9rem; transition:all 0.3s; }
        .search-input:focus { border-color:var(--primary); box-shadow:0 0 0 4px rgba(79,70,229,0.1); outline:none; }

        .table { margin-bottom:0; border-collapse:separate; border-spacing:0 8px; margin-top:-8px; }
        .table thead th { border:none; background:transparent; color:var(--text-muted); font-weight:700; font-size:0.75rem; text-transform:uppercase; letter-spacing:1px; padding:0.75rem 1.25rem; }
        .table tbody tr { background:#f8fafc; transition:all 0.25s ease; }
        .table tbody tr:hover { background:white; box-shadow:0 4px 15px rgba(79,70,229,0.07); transform:scale(1.003); }
        .table tbody td { border:none!important; padding:1rem 1.25rem; vertical-align:middle; }
        .table tbody td:first-child { border-radius:14px 0 0 14px; }
        .table tbody td:last-child { border-radius:0 14px 14px 0; }

        .user-avatar { width:40px;height:40px;border-radius:10px;display:flex;align-items:center;justify-content:center;background:linear-gradient(135deg,rgba(79,70,229,0.1),rgba(236,72,153,0.1));color:var(--primary);font-weight:800;font-size:1rem; }
        .modern-badge { padding:0.3em 0.8em; font-weight:700; border-radius:50px; font-size:0.72rem; letter-spacing:0.5px; }

        .btn-gradient { background:linear-gradient(135deg,var(--primary),var(--secondary)); color:white; border:none; font-weight:700; padding:0.6rem 1.5rem; border-radius:50px; transition:all 0.3s; box-shadow:0 4px 15px rgba(79,70,229,0.25); }
        .btn-gradient:hover { transform:translateY(-2px); box-shadow:0 8px 25px rgba(79,70,229,0.35); color:white; }

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
                <i class="bi bi-database-fill-gear me-1"></i> SQL CONSOLE
            </span>
            <h1 class="display-6 fw-bold text-white mb-2" style="letter-spacing:-1px;">Data Center</h1>
            <p class="text-white mb-0" style="opacity:0.75;">Full user directory &mdash; manage, edit, and control all platform accounts</p>
        </div>
    </div>

    <div class="container mb-5">

        <!-- Mini Stat Cards -->
        <div class="row g-3 mb-4 fade-up d1">
            <div class="col-md-3 col-6">
                <div class="mini-stat-card">
                    <div class="mini-icon" style="background:rgba(79,70,229,0.1);color:#4f46e5;"><i class="bi bi-people-fill"></i></div>
                    <div>
                        <div class="fw-bold" style="font-size:1.5rem;" id="totalCount">—</div>
                        <div class="small text-muted">Total Users</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="mini-stat-card">
                    <div class="mini-icon" style="background:rgba(16,185,129,0.1);color:#10b981;"><i class="bi bi-check-circle-fill"></i></div>
                    <div>
                        <div class="fw-bold" style="font-size:1.5rem;" id="activeCount">—</div>
                        <div class="small text-muted">Active</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="mini-stat-card">
                    <div class="mini-icon" style="background:rgba(245,158,11,0.1);color:#f59e0b;"><i class="bi bi-hourglass-split"></i></div>
                    <div>
                        <div class="fw-bold" style="font-size:1.5rem;" id="pendingCount">—</div>
                        <div class="small text-muted">Pending</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="mini-stat-card">
                    <div class="mini-icon" style="background:rgba(239,68,68,0.1);color:#ef4444;"><i class="bi bi-wifi"></i></div>
                    <div>
                        <div class="fw-bold" style="font-size:1.5rem;" id="onlineCount">—</div>
                        <div class="small text-muted">Online Now</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Data Table Card -->
        <div class="data-card fade-up d2">

            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                <div>
                    <h4 class="fw-bold m-0"><i class="bi bi-table text-primary me-2"></i>SQL Table: <span class="text-primary">user_master</span></h4>
                    <p class="text-muted small m-0">Full platform directory. Direct database view.</p>
                </div>
                <div class="d-flex gap-2 flex-wrap">
                    <button onclick="exportCSV()" class="btn btn-gradient shadow-sm btn-sm px-3">
                        <i class="bi bi-download me-1"></i> Export CSV
                    </button>
                    <a href="/adashboard" class="btn btn-sm px-3 fw-bold" style="border:2px solid #e2e8f0;border-radius:50px;color:var(--text-muted);">
                        <i class="bi bi-arrow-left me-1"></i> Dashboard
                    </a>
                </div>
            </div>

            <!-- Filter Bar -->
            <div class="filter-bar">
                <div class="d-flex gap-3 align-items-center flex-wrap">
                    <div class="position-relative" style="flex:1;min-width:200px;">
                        <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted" style="font-size:0.85rem;"></i>
                        <input type="text" id="dcSearchInput" class="search-input" placeholder="Search name, email, role..." style="padding-left:2.2rem;">
                    </div>
                    <div class="d-flex gap-2 flex-wrap">
                        <select id="roleFilter" class="form-select rounded-pill border-2 fw-bold" style="font-size:0.82rem;padding:0.4rem 0.9rem;border-color:#e2e8f0;max-width:130px;" onchange="applyDCFilter()">
                            <option value="">All Roles</option>
                            <option value="Admin">Admin</option>
                            <option value="Faculty">Faculty</option>
                            <option value="Student">Student</option>
                        </select>
                        <select id="statusFilter" class="form-select rounded-pill border-2 fw-bold" style="font-size:0.82rem;padding:0.4rem 0.9rem;border-color:#e2e8f0;max-width:130px;" onchange="applyDCFilter()">
                            <option value="">All Status</option>
                            <option value="1">Active</option>
                            <option value="0">Pending</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table align-middle" id="dcTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Account</th>
                            <th>Mobile</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Online</th>
                            <th class="text-end">SQL Ops</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users_master}" varStatus="loop">
                            <tr data-role="${user.role}" data-status="${user.status}" data-name="${user.name}" data-email="${user.email}">
                                <td class="text-muted fw-bold" style="font-size:0.8rem;">#${loop.index + 1}</td>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="user-avatar">${user.name.substring(0,1).toUpperCase()}</div>
                                        <div>
                                            <div class="fw-bold" style="font-size:0.88rem;">${user.name}</div>
                                            <div class="small text-muted" style="font-size:0.75rem;">${user.email}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="small text-muted">${user.mobile}</td>
                                <td>
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
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.status == 1}">
                                            <span class="modern-badge bg-success bg-opacity-10 text-success"><i class="bi bi-check-circle-fill me-1"></i>Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="modern-badge bg-warning bg-opacity-15 text-warning"><i class="bi bi-clock-fill me-1"></i>Pending</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.isOnline == 1}">
                                            <span class="badge rounded-pill bg-success px-2">
                                                <div class="spinner-grow spinner-grow-sm text-light me-1" style="width:0.4rem;height:0.4rem;"></div> Online
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge rounded-pill bg-secondary px-2">Offline</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end">
                                    <form method="post" action="/users" class="m-0 p-0 d-inline">
                                        <input type="hidden" value="${user.email}" name="email"/>
                                        <button type="submit" name="btn" value="edit"
                                            class="btn btn-sm btn-primary rounded-3 shadow-sm me-1" style="font-size:0.78rem;">
                                            <i class="bi bi-pencil-square"></i> Edit
                                        </button>
                                        <button type="submit" name="btn" value="delete"
                                            class="btn btn-sm btn-danger rounded-3 shadow-sm" style="font-size:0.78rem;"
                                            onclick="return confirm('DELETE this user permanently?');">
                                            <i class="bi bi-trash3"></i> Del
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div id="dcNoResults" class="text-center py-4 d-none">
                    <i class="bi bi-search text-muted" style="font-size:2rem;"></i>
                    <p class="text-muted mt-2">No users match your filter.</p>
                </div>
            </div>

            <div class="text-center mt-3">
                <span class="text-muted small"><i class="bi bi-info-circle me-1"></i>Showing all results from <code>user_master</code>. Queries run by controller mapping.</span>
            </div>
        </div>

    </div>

    <jsp:include page="afooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // ── Compute mini stat counts from table rows ──
        window.addEventListener('DOMContentLoaded', () => {
            const rows = document.querySelectorAll('#dcTable tbody tr');
            let total = 0, active = 0, pending = 0, online = 0;
            rows.forEach(r => {
                total++;
                if(r.getAttribute('data-status') === '1') active++;
                else pending++;
            });
            // Online count from spinner badges
            document.querySelectorAll('#dcTable .spinner-grow').forEach(() => online++);
            document.getElementById('totalCount').textContent   = total;
            document.getElementById('activeCount').textContent  = active;
            document.getElementById('pendingCount').textContent = pending;
            document.getElementById('onlineCount').textContent  = online;
        });

        // ── Live Search + Filter ──
        document.getElementById('dcSearchInput').addEventListener('input', applyDCFilter);

        function applyDCFilter() {
            const q      = document.getElementById('dcSearchInput').value.toLowerCase().trim();
            const role   = document.getElementById('roleFilter').value;
            const status = document.getElementById('statusFilter').value;
            const rows   = document.querySelectorAll('#dcTable tbody tr');
            let visible  = 0;
            rows.forEach(row => {
                const name    = (row.getAttribute('data-name')  || '').toLowerCase();
                const email   = (row.getAttribute('data-email') || '').toLowerCase();
                const rRole   = row.getAttribute('data-role')   || '';
                const rStatus = row.getAttribute('data-status') || '';
                const mSearch = !q      || name.includes(q) || email.includes(q) || rRole.toLowerCase().includes(q);
                const mRole   = !role   || rRole === role;
                const mStatus = !status || rStatus === status;
                if(mSearch && mRole && mStatus){ row.style.display=''; visible++; }
                else { row.style.display='none'; }
            });
            document.getElementById('dcNoResults').classList.toggle('d-none', visible > 0);
        }

        // ── CSV Export ──
        function exportCSV() {
            const rows = document.querySelectorAll('#dcTable tbody tr');
            let csv = 'Name,Email,Mobile,Role,Status\n';
            rows.forEach(row => {
                if(row.style.display === 'none') return;
                const name  = row.getAttribute('data-name')  || '';
                const email = row.getAttribute('data-email') || '';
                const tds   = row.querySelectorAll('td');
                const mobile = tds[2] ? tds[2].textContent.trim() : '';
                const role   = row.getAttribute('data-role')   || '';
                const status = row.getAttribute('data-status') === '1' ? 'Active' : 'Pending';
                csv += `"${name}","${email}","${mobile}","${role}","${status}"\n`;
            });
            const blob = new Blob([csv], {type:'text/csv'});
            const a    = document.createElement('a');
            a.href     = URL.createObjectURL(blob);
            a.download = 'edupro_users.csv';
            a.click();
        }
    </script>
</body>
</html>
