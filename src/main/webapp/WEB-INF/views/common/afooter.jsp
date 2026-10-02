<link rel="stylesheet" href="/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

<style>
    /* ─── Admin Footer ─────────────────────────────── */
    .admin-footer {
        background: linear-gradient(135deg, #0d0d0d 0%, #1a0a0a 50%, #0d0d0d 100%);
        border-top: 2px solid transparent;
        border-image: linear-gradient(90deg, transparent, #C92A2A, #FF6B6B, #C92A2A, transparent) 1;
        color: #ccc;
        position: relative;
        overflow: hidden;
        margin-top: 4rem;
    }

    /* subtle grid overlay */
    .admin-footer::before {
        content: '';
        position: absolute;
        inset: 0;
        background-image:
            linear-gradient(rgba(201,42,42,0.04) 1px, transparent 1px),
            linear-gradient(90deg, rgba(201,42,42,0.04) 1px, transparent 1px);
        background-size: 40px 40px;
        pointer-events: none;
    }

    /* glowing accent blob */
    .admin-footer::after {
        content: '';
        position: absolute;
        top: -80px;
        left: 50%;
        transform: translateX(-50%);
        width: 600px;
        height: 160px;
        background: radial-gradient(ellipse at center, rgba(201,42,42,0.18) 0%, transparent 70%);
        pointer-events: none;
    }

    .admin-footer .footer-inner {
        position: relative;
        z-index: 1;
    }

    /* ─── Brand / Logo block ───────────────────────── */
    .admin-footer .brand-block .brand-logo {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        text-decoration: none;
    }

    .admin-footer .brand-block .brand-icon {
        width: 42px;
        height: 42px;
        border-radius: 10px;
        background: linear-gradient(135deg, #C92A2A, #FF6B6B);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.1rem;
        color: #fff;
        box-shadow: 0 0 18px rgba(201,42,42,0.5);
        flex-shrink: 0;
    }

    .admin-footer .brand-block .brand-name {
        font-size: 1.25rem;
        font-weight: 700;
        color: #fff;
        letter-spacing: 0.5px;
    }

    .admin-footer .brand-block .brand-name span {
        color: #FF6B6B;
    }

    .admin-footer .brand-block p {
        color: #888;
        font-size: 0.82rem;
        line-height: 1.6;
        max-width: 240px;
        margin-top: 0.7rem;
    }

    /* ─── Section headings ─────────────────────────── */
    .admin-footer .footer-heading {
        font-size: 0.7rem;
        font-weight: 700;
        letter-spacing: 2px;
        text-transform: uppercase;
        color: #FF6B6B;
        margin-bottom: 1.1rem;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .admin-footer .footer-heading::after {
        content: '';
        flex: 1;
        height: 1px;
        background: linear-gradient(90deg, rgba(201,42,42,0.5), transparent);
    }

    /* ─── Nav links ────────────────────────────────── */
    .admin-footer .footer-nav {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .admin-footer .footer-nav li {
        margin-bottom: 0.55rem;
    }

    .admin-footer .footer-nav a {
        color: #9a9a9a;
        text-decoration: none;
        font-size: 0.875rem;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.25s ease;
        padding: 2px 0;
    }

    .admin-footer .footer-nav a i {
        width: 16px;
        font-size: 0.75rem;
        color: #C92A2A;
        transition: transform 0.25s ease;
    }

    .admin-footer .footer-nav a:hover {
        color: #fff;
        padding-left: 4px;
    }

    .admin-footer .footer-nav a:hover i {
        transform: translateX(2px);
        color: #FF6B6B;
    }

    /* ─── Status indicators ────────────────────────── */
    .admin-footer .status-list {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        flex-direction: column;
        gap: 0.6rem;
    }

    .admin-footer .status-item {
        display: flex;
        align-items: center;
        gap: 10px;
        background: rgba(255,255,255,0.03);
        border: 1px solid rgba(255,255,255,0.06);
        border-radius: 8px;
        padding: 8px 12px;
        font-size: 0.82rem;
        color: #bbb;
        transition: background 0.25s;
    }

    .admin-footer .status-item:hover {
        background: rgba(255,255,255,0.06);
    }

    .admin-footer .status-dot {
        width: 9px;
        height: 9px;
        border-radius: 50%;
        flex-shrink: 0;
        position: relative;
    }

    .admin-footer .status-dot.online {
        background: #22c55e;
        box-shadow: 0 0 0 0 rgba(34,197,94,0.6);
        animation: pulse-green 2s infinite;
    }

    .admin-footer .status-dot.warning {
        background: #f59e0b;
        box-shadow: 0 0 0 0 rgba(245,158,11,0.6);
        animation: pulse-yellow 2s infinite;
    }

    @keyframes pulse-green {
        0%   { box-shadow: 0 0 0 0 rgba(34,197,94,0.6); }
        70%  { box-shadow: 0 0 0 7px rgba(34,197,94,0); }
        100% { box-shadow: 0 0 0 0 rgba(34,197,94,0); }
    }

    @keyframes pulse-yellow {
        0%   { box-shadow: 0 0 0 0 rgba(245,158,11,0.6); }
        70%  { box-shadow: 0 0 0 7px rgba(245,158,11,0); }
        100% { box-shadow: 0 0 0 0 rgba(245,158,11,0); }
    }

    .admin-footer .status-label {
        flex: 1;
    }

    .admin-footer .status-badge {
        font-size: 0.68rem;
        font-weight: 600;
        padding: 1px 7px;
        border-radius: 50px;
        background: rgba(34,197,94,0.15);
        color: #22c55e;
        border: 1px solid rgba(34,197,94,0.25);
    }

    .admin-footer .status-badge.warn {
        background: rgba(245,158,11,0.15);
        color: #f59e0b;
        border-color: rgba(245,158,11,0.25);
    }

    /* ─── Stats mini cards ─────────────────────────── */
    .admin-footer .stat-card {
        background: rgba(201,42,42,0.08);
        border: 1px solid rgba(201,42,42,0.18);
        border-radius: 10px;
        padding: 12px 14px;
        text-align: center;
        transition: all 0.3s ease;
    }

    .admin-footer .stat-card:hover {
        background: rgba(201,42,42,0.14);
        border-color: rgba(255,107,107,0.35);
        transform: translateY(-2px);
    }

    .admin-footer .stat-card .stat-num {
        font-size: 1.4rem;
        font-weight: 700;
        color: #FF6B6B;
        line-height: 1;
    }

    .admin-footer .stat-card .stat-lbl {
        font-size: 0.68rem;
        color: #777;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-top: 3px;
    }

    /* ─── Divider strip ────────────────────────────── */
    .admin-footer .footer-bottom {
        border-top: 1px solid rgba(255,255,255,0.07);
        margin-top: 2rem;
        padding-top: 1.5rem;
        padding-bottom: 1.5rem;
    }

    .admin-footer .footer-bottom .copyright {
        font-size: 0.8rem;
        color: #666;
        margin: 0;
    }

    .admin-footer .footer-bottom .copyright a {
        color: #888;
        text-decoration: none;
        transition: color 0.2s;
    }

    .admin-footer .footer-bottom .copyright a:hover {
        color: #FF6B6B;
    }

    .admin-footer .restricted-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: rgba(201,42,42,0.15);
        border: 1px solid rgba(201,42,42,0.35);
        color: #FF6B6B;
        font-size: 0.7rem;
        font-weight: 700;
        letter-spacing: 1.5px;
        text-transform: uppercase;
        padding: 3px 10px;
        border-radius: 4px;
    }

    .admin-footer .social-links {
        display: flex;
        gap: 8px;
    }

    .admin-footer .social-links a {
        width: 32px;
        height: 32px;
        border-radius: 8px;
        background: rgba(255,255,255,0.05);
        border: 1px solid rgba(255,255,255,0.08);
        display: flex;
        align-items: center;
        justify-content: center;
        color: #777;
        font-size: 0.8rem;
        text-decoration: none;
        transition: all 0.25s ease;
    }

    .admin-footer .social-links a:hover {
        background: rgba(201,42,42,0.2);
        border-color: rgba(201,42,42,0.4);
        color: #FF6B6B;
        transform: translateY(-2px);
    }

    /* Storage bar */
    .storage-bar-wrap {
        margin-top: 4px;
    }

    .storage-bar-bg {
        height: 4px;
        border-radius: 2px;
        background: rgba(255,255,255,0.08);
        overflow: hidden;
    }

    .storage-bar-fill {
        height: 100%;
        width: 45%;
        border-radius: 2px;
        background: linear-gradient(90deg, #22c55e, #16a34a);
    }
</style>

<footer class="admin-footer">
    <div class="container footer-inner py-5">

        <div class="row g-4">

            <!-- ── Brand Column ───────────────────────── -->
            <div class="col-12 col-md-4 col-lg-3">
                <div class="brand-block">
                    <a href="/adashboard" class="brand-logo mb-3 d-inline-flex">
                        <div class="brand-icon"><i class="fa fa-shield-halved"></i></div>
                        <span class="brand-name ms-2">LMS <span>Admin</span></span>
                    </a>
                    <p>Centralized control for the Learning Management System. Restricted to authorized personnel only.</p>

                    <!-- Stat cards row -->
                    <div class="row g-2 mt-1">
                        <div class="col-4">
                            <div class="stat-card">
                                <div class="stat-num" id="footer-user-count">–</div>
                                <div class="stat-lbl">Users</div>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="stat-card">
                                <div class="stat-num" id="footer-course-count">–</div>
                                <div class="stat-lbl">Courses</div>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="stat-card">
                                <div class="stat-num" id="footer-notice-count">–</div>
                                <div class="stat-lbl">Notices</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ── Admin Tools ────────────────────────── -->
            <div class="col-6 col-md-3 col-lg-3 offset-lg-1">
                <div class="footer-heading"><i class="fa fa-toolbox"></i> Admin Tools</div>
                <ul class="footer-nav">
                    <li><a href="/adashboard"><i class="fa fa-gauge-high"></i> Control Panel</a></li>
                    <li><a href="/users"><i class="fa fa-users-gear"></i> User Management</a></li>
                    <li><a href="/addnotice"><i class="fa fa-bell"></i> Notice Settings</a></li>
                    <li><a href="#"><i class="fa fa-scroll"></i> System Logs</a></li>
                    <li><a href="#"><i class="fa fa-lock"></i> Access Control</a></li>
                    <li><a href="#"><i class="fa fa-chart-bar"></i> Analytics</a></li>
                </ul>
            </div>

            <!-- ── Quick Links ────────────────────────── -->
            <div class="col-6 col-md-3 col-lg-2">
                <div class="footer-heading"><i class="fa fa-link"></i> Quick Links</div>
                <ul class="footer-nav">
                    <li><a href="#"><i class="fa fa-circle-question"></i> Help Center</a></li>
                    <li><a href="#"><i class="fa fa-file-shield"></i> Privacy Policy</a></li>
                    <li><a href="#"><i class="fa fa-file-contract"></i> Terms of Use</a></li>
                    <li><a href="/contact"><i class="fa fa-headset"></i> Support</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Documentation</a></li>
                </ul>
            </div>

            <!-- ── Server Status ──────────────────────── -->
            <div class="col-12 col-md-4 col-lg-3">
                <div class="footer-heading"><i class="fa fa-server"></i> Server Status</div>
                <ul class="status-list">
                    <li class="status-item">
                        <span class="status-dot online"></span>
                        <span class="status-label">Database</span>
                        <span class="status-badge">Online</span>
                    </li>
                    <li class="status-item">
                        <span class="status-dot online"></span>
                        <span class="status-label">Web Server</span>
                        <span class="status-badge">Active</span>
                    </li>
                    <li class="status-item">
                        <span class="status-dot online"></span>
                        <span class="status-label">Auth Service</span>
                        <span class="status-badge">Running</span>
                    </li>
                    <li class="status-item">
                        <span class="status-dot warning"></span>
                        <span class="status-label">Storage</span>
                        <span class="status-badge warn">45%</span>
                    </li>
                </ul>
                <!-- Storage bar -->
                <div class="storage-bar-wrap mt-3">
                    <div class="d-flex justify-content-between mb-1" style="font-size:0.72rem;color:#666;">
                        <span>Disk Usage</span><span>22.5 GB / 50 GB</span>
                    </div>
                    <div class="storage-bar-bg">
                        <div class="storage-bar-fill"></div>
                    </div>
                </div>
            </div>

        </div>

        <!-- ── Footer Bottom Bar ───────────────────── -->
        <div class="footer-bottom">
            <div class="d-flex flex-column flex-sm-row align-items-center justify-content-between gap-3">

                <div class="d-flex align-items-center gap-3 flex-wrap">
                    <p class="copyright mb-0">
                        © 2026 <a href="#">LMS Admin Systems</a>. All rights reserved.
                    </p>
                    <span class="restricted-badge">
                        <i class="fa fa-shield"></i> Restricted Access
                    </span>
                </div>

                <div class="d-flex align-items-center gap-3">
                    <span style="font-size:0.72rem;color:#555;">v2.4.1 &nbsp;|&nbsp; Build #2026.04</span>
                    <div class="social-links">
                        <a href="#" title="GitHub"><i class="fab fa-github"></i></a>
                        <a href="#" title="Email"><i class="fa fa-envelope"></i></a>
                        <a href="#" title="Documentation"><i class="fa fa-book-open"></i></a>
                    </div>
                </div>

            </div>
        </div>

    </div><!-- /container -->
</footer>

<script>
    /* ── Pull live counts if the dashboard already has them ─── */
    (function () {
        function tryFillCount(id, storageKey) {
            var el = document.getElementById(id);
            if (!el) return;
            var val = sessionStorage.getItem(storageKey);
            if (val) { el.textContent = val; return; }
            /* fallback: fetch a simple JSON endpoint if it exists */
        }
        tryFillCount('footer-user-count',   'lms_total_users');
        tryFillCount('footer-course-count', 'lms_total_courses');
        tryFillCount('footer-notice-count', 'lms_total_notices');
    })();
</script>