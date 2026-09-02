<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notice Board — Faculty | EduPro LMS</title>
    <meta name="description" content="View announcements from admin and post notices for your students.">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary: #7c3aed;
            --accent: #f59e0b;
            --success: #10b981;
            --danger: #ef4444;
            --bg: #f5f3ff;
            --card: #fff;
            --text: #1e293b;
            --muted: #64748b;
            --border: rgba(124,58,237,0.12);
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); }
        body.dark-mode {
            --bg: #0f172a; --card: #1e293b; --text: #e2e8f0;
            --muted: #94a3b8; --border: rgba(255,255,255,0.08);
            background: var(--bg) !important; color: var(--text) !important;
        }
        body.dark-mode .notices-panel,
        body.dark-mode .form-card { background: #1e293b !important; border-color: rgba(255,255,255,0.08) !important; }
        body.dark-mode .notice-item { border-color: rgba(255,255,255,0.06) !important; }
        body.dark-mode .form-control, body.dark-mode .form-select { background: #0f172a !important; color: #e2e8f0 !important; border-color: rgba(255,255,255,0.12) !important; }
        body.dark-mode .tab-pill { color: #94a3b8 !important; border-color: rgba(255,255,255,0.1) !important; }
        body.dark-mode .tab-pill.active { background: var(--primary) !important; color: white !important; }
        body.dark-mode h1,body.dark-mode h5,body.dark-mode .notice-title { color: #e2e8f0 !important; }
        body.dark-mode .stat-card { background: #1e293b !important; border-color: rgba(255,255,255,0.08) !important; }
        body.dark-mode .file-drop { border-color: rgba(124,58,237,0.4) !important; background: rgba(124,58,237,0.05) !important; }

        .page-wrapper { min-height: 100vh; }

        /* ── Hero ── */
        .faculty-hero {
            background: linear-gradient(135deg, #7c3aed 0%, #4f46e5 50%, #2563eb 100%);
            padding: 2.5rem 0; color: white; position: relative; overflow: hidden;
        }
        .faculty-hero::after {
            content: ''; position: absolute; right: -60px; top: -60px;
            width: 300px; height: 300px; border-radius: 50%;
            background: rgba(255,255,255,0.05);
        }
        .faculty-hero h1 { font-size: 1.9rem; font-weight: 800; }

        /* ── Stat Cards ── */
        .stat-card {
            background: var(--card); border-radius: 16px; padding: 1.2rem 1.4rem;
            border: 1px solid var(--border); box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            display: flex; align-items: center; gap: 1rem; transition: transform 0.3s;
        }
        .stat-card:hover { transform: translateY(-3px); }
        .stat-icon {
            width: 48px; height: 48px; border-radius: 13px;
            display: flex; align-items: center; justify-content: center; font-size: 1.3rem; flex-shrink: 0;
        }
        .stat-num { font-size: 1.5rem; font-weight: 800; line-height: 1; }
        .stat-lbl { font-size: 0.78rem; color: var(--muted); font-weight: 500; margin-top: 2px; }

        /* ── Tabs ── */
        .tab-nav { display: flex; gap: 0.5rem; margin-bottom: 1.5rem; }
        .tab-pill {
            padding: 0.5rem 1.25rem; border-radius: 50px;
            border: 1.5px solid #e2e8f0; font-size: 0.85rem; font-weight: 600;
            cursor: pointer; background: transparent; transition: all 0.25s; color: var(--muted);
        }
        .tab-pill.active { background: var(--primary); color: white; border-color: var(--primary); }

        /* ── Panels ── */
        .notices-panel {
            background: var(--card); border-radius: 20px; border: 1px solid var(--border);
            box-shadow: 0 4px 30px rgba(0,0,0,0.05); overflow: hidden;
        }
        .panel-header {
            padding: 1.2rem 1.5rem; border-bottom: 1px solid var(--border);
            display: flex; align-items: center; justify-content: space-between;
        }

        /* ── Notice Items ── */
        .notice-item {
            display: flex; align-items: flex-start; gap: 1rem;
            padding: 1.2rem 1.5rem; border-bottom: 1px solid var(--border);
            transition: background 0.2s; animation: fadeUp 0.35s ease;
        }
        .notice-item:last-child { border-bottom: none; }
        .notice-item:hover { background: rgba(124,58,237,0.03); }
        @keyframes fadeUp { from { opacity:0; transform:translateY(6px); } to { opacity:1; transform:translateY(0); } }

        .notice-icon-wrap {
            width: 44px; height: 44px; border-radius: 12px; flex-shrink: 0;
            display: flex; align-items: center; justify-content: center; font-size: 1.1rem;
        }
        .notice-title { font-weight: 700; font-size: 0.95rem; margin-bottom: 4px; }
        .notice-desc { font-size: 0.84rem; color: var(--muted); line-height: 1.55; margin-bottom: 8px; }
        .notice-meta { display: flex; align-items: center; gap: 0.6rem; flex-wrap: wrap; }
        .badge-date { font-size: 0.75rem; color: var(--muted); display: flex; align-items: center; gap: 4px; }
        .badge-from { font-size: 0.75rem; color: var(--muted); display: flex; align-items: center; gap: 4px; }
        .badge-aud {
            padding: 0.25rem 0.7rem; border-radius: 50px; font-size: 0.7rem; font-weight: 700;
            letter-spacing: 0.5px; text-transform: uppercase;
        }
        .badge-ALL { background: linear-gradient(135deg,#4f46e5,#7c3aed); color:white; }
        .badge-FACULTY { background: linear-gradient(135deg,#f59e0b,#d97706); color:white; }
        .badge-STUDENT { background: linear-gradient(135deg,#10b981,#059669); color:white; }
        .file-link {
            padding: 0.25rem 0.6rem; border-radius: 6px; font-size: 0.73rem; font-weight: 600;
            background: #eff6ff; color: #2563eb; text-decoration: none; display: flex; align-items: center; gap: 4px;
        }
        .file-link:hover { background: #dbeafe; }

        /* Delete btn for own notices */
        .btn-del-sm {
            width: 32px; height: 32px; border-radius: 8px; border: none; flex-shrink: 0;
            background: rgba(239,68,68,0.1); color: #ef4444;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer; transition: all 0.25s; font-size: 0.85rem;
        }
        .btn-del-sm:hover { background: #ef4444; color: white; transform: scale(1.08); }

        /* ── Form Card ── */
        .form-card {
            background: var(--card); border-radius: 20px; border: 1px solid var(--border);
            box-shadow: 0 4px 30px rgba(0,0,0,0.04); overflow: hidden;
        }
        .form-card-header {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            padding: 1.2rem 1.5rem; color: white;
        }
        .form-card-body { padding: 1.5rem; }
        .form-label { font-weight: 600; font-size: 0.82rem; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 6px; }
        .form-control, .form-select {
            border: 1.5px solid #e2e8f0; border-radius: 10px; padding: 0.62rem 1rem;
            font-size: 0.92rem; transition: all 0.3s;
        }
        .form-control:focus, .form-select:focus { border-color: #f59e0b; box-shadow: 0 0 0 4px rgba(245,158,11,0.1); }
        .file-drop {
            border: 2px dashed #fde68a; border-radius: 12px; padding: 1.2rem;
            text-align: center; cursor: pointer; transition: all 0.3s; background: #fffbeb; color: var(--muted);
        }
        .file-drop:hover { border-color: #f59e0b; background: #fef3c7; }
        .file-drop i { font-size: 1.8rem; color: #f59e0b; margin-bottom: 0.4rem; display: block; }
        .btn-publish {
            background: linear-gradient(135deg, #f59e0b, #d97706); border: none;
            color: white; font-weight: 700; border-radius: 10px; padding: 0.6rem 1.5rem;
            width: 100%; transition: all 0.3s;
        }
        .btn-publish:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(245,158,11,0.35); }

        /* ── Empty State ── */
        .empty-state { padding: 3rem 2rem; text-align: center; color: var(--muted); }
        .empty-state i { font-size: 3.5rem; display: block; margin-bottom: 1rem; opacity: 0.35; }

        @media (max-width: 768px) {
            .faculty-hero h1 { font-size: 1.4rem; }
            .notice-item { flex-direction: column; }
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <%@ include file="fheader.jsp" %>

    <!-- Hero -->
    <div class="faculty-hero">
        <div class="container position-relative">
            <div class="row align-items-center">
                <div class="col">
                    <div class="d-flex align-items-center gap-3 mb-1">
                        <div style="background:rgba(255,255,255,0.2);border-radius:14px;padding:0.55rem 0.85rem;">
                            <i class="bi bi-bell-fill fs-3"></i>
                        </div>
                        <div>
                            <h1 class="mb-0">Notice Board</h1>
                            <p class="mb-0 mt-1 opacity-85" style="font-size:0.95rem;">Stay updated and post notices for your students</p>
                        </div>
                    </div>
                </div>
                <div class="col-auto">
                    <a href="/fdashboard" class="btn btn-light btn-sm rounded-pill px-3">
                        <i class="bi bi-arrow-left me-1"></i> Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container py-4">

        <!-- Stats -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-4">
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(124,58,237,0.12);color:#7c3aed;"><i class="bi bi-bell-fill"></i></div>
                    <div>
                        <div class="stat-num">${myNotices.size()}</div>
                        <div class="stat-lbl">Received Notices</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4">
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(245,158,11,0.12);color:#f59e0b;"><i class="bi bi-send-fill"></i></div>
                    <div>
                        <div class="stat-num">${createdNotices.size()}</div>
                        <div class="stat-lbl">Notices I Posted</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4">
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(16,185,129,0.12);color:#10b981;"><i class="bi bi-mortarboard-fill"></i></div>
                    <div>
                        <div class="stat-num">${createdNotices.size()}</div>
                        <div class="stat-lbl">Student Notices</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left: Lists with Tabs -->
            <div class="col-lg-7">
                <!-- Tab Navigation -->
                <div class="tab-nav">
                    <button class="tab-pill active" id="tab-received" onclick="switchTab('received', this)">
                        <i class="bi bi-inbox-fill me-1"></i> Notices for Me
                        <span class="badge bg-primary rounded-pill ms-1" style="font-size:0.65rem;">${myNotices.size()}</span>
                    </button>
                    <button class="tab-pill" id="tab-created" onclick="switchTab('created', this)">
                        <i class="bi bi-send me-1"></i> My Posts
                        <span class="badge bg-warning text-dark rounded-pill ms-1" style="font-size:0.65rem;">${createdNotices.size()}</span>
                    </button>
                </div>

                <!-- Received Notices Panel -->
                <div id="panel-received" class="notices-panel">
                    <div class="panel-header">
                        <div>
                            <h5 class="mb-0 fw-bold"><i class="bi bi-inbox me-2 text-primary"></i>Notices for You</h5>
                            <small class="text-muted">From Admin — for Faculty &amp; Everyone</small>
                        </div>
                    </div>
                    <c:if test="${empty myNotices}">
                        <div class="empty-state">
                            <i class="bi bi-inbox"></i>
                            <h6 class="fw-bold">No notices received yet</h6>
                            <p>You'll see admin notices here when published.</p>
                        </div>
                    </c:if>
                    <c:forEach var="n" items="${myNotices}">
                        <c:set var="aud" value="${n.targetAudience != null ? n.targetAudience : 'ALL'}"/>
                        <div class="notice-item">
                            <div class="notice-icon-wrap
                                <c:choose>
                                    <c:when test="${aud=='FACULTY'}">bg-warning-subtle text-warning</c:when>
                                    <c:otherwise>bg-primary-subtle text-primary</c:otherwise>
                                </c:choose>">
                                <c:choose>
                                    <c:when test="${aud=='FACULTY'}"><i class="bi bi-person-video3"></i></c:when>
                                    <c:otherwise><i class="bi bi-megaphone-fill"></i></c:otherwise>
                                </c:choose>
                            </div>
                            <div style="flex:1;min-width:0;">
                                <div class="notice-title">${n.title}</div>
                                <div class="notice-desc">${n.description}</div>
                                <div class="notice-meta">
                                    <span class="badge-aud badge-${aud}">
                                        <c:choose>
                                            <c:when test="${aud=='FACULTY'}">Faculty</c:when>
                                            <c:otherwise>Everyone</c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span class="badge-date"><i class="bi bi-calendar3"></i> ${n.noticeDate}</span>
                                    <c:if test="${n.createdBy != null}">
                                        <span class="badge-from"><i class="bi bi-person-circle"></i> ${n.createdBy.name}</span>
                                    </c:if>
                                    <c:if test="${n.fileName != null}">
                                        <a href="/download/notice/${n.id}" class="file-link">
                                            <i class="bi bi-download"></i> ${n.fileName}
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Created Notices Panel (hidden by default) -->
                <div id="panel-created" class="notices-panel" style="display:none;">
                    <div class="panel-header">
                        <div>
                            <h5 class="mb-0 fw-bold"><i class="bi bi-send me-2 text-warning"></i>Your Student Notices</h5>
                            <small class="text-muted">Notices you published for students</small>
                        </div>
                    </div>
                    <c:if test="${empty createdNotices}">
                        <div class="empty-state">
                            <i class="bi bi-send"></i>
                            <h6 class="fw-bold">You haven't posted any notices</h6>
                            <p>Use the form to publish a notice for your students.</p>
                        </div>
                    </c:if>
                    <c:forEach var="n" items="${createdNotices}">
                        <div class="notice-item">
                            <div class="notice-icon-wrap bg-success-subtle text-success">
                                <i class="bi bi-mortarboard-fill"></i>
                            </div>
                            <div style="flex:1;min-width:0;">
                                <div class="notice-title">${n.title}</div>
                                <div class="notice-desc">${n.description}</div>
                                <div class="notice-meta">
                                    <span class="badge-aud badge-STUDENT">Students</span>
                                    <span class="badge-date"><i class="bi bi-calendar3"></i> ${n.noticeDate}</span>
                                    <c:if test="${n.fileName != null}">
                                        <a href="/download/notice/${n.id}" class="file-link">
                                            <i class="bi bi-download"></i> ${n.fileName}
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                            <form action="/faculty-notices/delete" method="POST" onsubmit="return confirmDel(event)">
                                <input type="hidden" name="id" value="${n.id}">
                                <button type="submit" class="btn-del-sm" title="Delete">
                                    <i class="bi bi-trash3-fill"></i>
                                </button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Right: Post a Notice form -->
            <div class="col-lg-5">
                <div class="form-card sticky-top" style="top:80px;">
                    <div class="form-card-header">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-send-fill me-2"></i>Post Notice for Students</h5>
                        <p class="mb-0 small opacity-85 mt-1">Your notice will be visible to all enrolled students</p>
                    </div>
                    <div class="form-card-body">
                        <form action="/faculty-notices/add" method="POST" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label class="form-label">Title *</label>
                                <input type="text" name="title" class="form-control" placeholder="e.g. Assignment Deadline Extended" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Notice Content *</label>
                                <textarea name="description" class="form-control" rows="5"
                                    placeholder="Write the full notice content here..." required></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Attach a File (Optional)</label>
                                <div class="file-drop" onclick="document.getElementById('facFile').click()">
                                    <i class="bi bi-cloud-arrow-up"></i>
                                    <div style="font-size:0.88rem;font-weight:600;">Click to upload file</div>
                                    <small>PDF, DOC, PNG up to 10MB</small>
                                    <div id="facFileDisplay" class="mt-1 text-warning fw-bold" style="font-size:0.82rem;"></div>
                                </div>
                                <input type="file" id="facFile" name="file" class="d-none" onchange="showFacFile(this)">
                            </div>
                            <div class="alert alert-info py-2 px-3" style="font-size:0.82rem;border-radius:10px;">
                                <i class="bi bi-info-circle me-1"></i>
                                This notice will be visible to <strong>Students only</strong>. Admins can also see it.
                            </div>
                            <button type="submit" class="btn btn-publish mt-1">
                                <i class="bi bi-send-fill me-2"></i> Post Notice
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function switchTab(tab, btn) {
        document.querySelectorAll('.tab-pill').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        document.getElementById('panel-received').style.display = (tab === 'received') ? '' : 'none';
        document.getElementById('panel-created').style.display  = (tab === 'created')  ? '' : 'none';
    }

    function showFacFile(input) {
        const el = document.getElementById('facFileDisplay');
        if (input.files && input.files[0]) {
            el.innerHTML = '<i class="bi bi-check-circle-fill me-1"></i>' + input.files[0].name;
        }
    }

    function confirmDel(e) {
        e.preventDefault();
        const form = e.target;
        Swal.fire({
            title: 'Delete this notice?',
            text: 'Students will no longer see it.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#ef4444',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Delete',
            background: document.body.classList.contains('dark-mode') ? '#1e293b' : '#fff',
            color: document.body.classList.contains('dark-mode') ? '#e2e8f0' : '#1e293b',
        }).then(r => { if (r.isConfirmed) form.submit(); });
        return false;
    }
</script>
</body>
</html>
