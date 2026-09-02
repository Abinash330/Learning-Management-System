<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notice Board — Admin | EduPro LMS</title>
    <meta name="description" content="Manage all institutional notices — add, edit, target and delete notices for students and faculty.">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary: #4f46e5;
            --secondary: #ec4899;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --bg: #f0f4ff;
            --card: #ffffff;
            --text: #1e293b;
            --muted: #64748b;
            --border: rgba(79,70,229,0.12);
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); }
        body.dark-mode {
            --bg: #0f172a; --card: #1e293b; --text: #e2e8f0; --muted: #94a3b8;
            --border: rgba(255,255,255,0.08);
        }

        /* ── Page Shell ── */
        .page-wrapper { min-height: 100vh; background: linear-gradient(135deg, #e0e7ff 0%, #f0f4ff 50%, #fce7f3 100%); }
        body.dark-mode .page-wrapper { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); }

        /* ── Hero Banner ── */
        .notice-hero {
            background: linear-gradient(135deg, var(--primary) 0%, #7c3aed 50%, var(--secondary) 100%);
            padding: 2.5rem 0;
            color: white;
            position: relative;
            overflow: hidden;
        }
        .notice-hero::before {
            content: '';
            position: absolute; inset: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.04'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
        }
        .notice-hero h1 { font-size: 2rem; font-weight: 800; }
        .notice-hero p { opacity: 0.85; font-size: 1rem; }

        /* ── Stat Cards ── */
        .stat-card {
            background: var(--card);
            border-radius: 16px;
            padding: 1.25rem 1.5rem;
            border: 1px solid var(--border);
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            display: flex; align-items: center; gap: 1rem;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .stat-card:hover { transform: translateY(-3px); box-shadow: 0 8px 30px rgba(79,70,229,0.12); }
        .stat-icon {
            width: 52px; height: 52px; border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem; flex-shrink: 0;
        }
        .stat-num { font-size: 1.6rem; font-weight: 800; line-height: 1; }
        .stat-label { font-size: 0.8rem; color: var(--muted); font-weight: 500; margin-top: 2px; }

        /* ── Add Notice Card ── */
        .add-card {
            background: var(--card);
            border-radius: 20px;
            border: 1px solid var(--border);
            box-shadow: 0 4px 30px rgba(79,70,229,0.07);
            overflow: hidden;
        }
        .add-card-header {
            background: linear-gradient(135deg, var(--primary), #7c3aed);
            padding: 1.25rem 1.75rem;
            color: white;
        }
        .add-card-body { padding: 1.75rem; }

        /* ── Form Controls ── */
        .form-control, .form-select {
            background: #f8fafc;
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            padding: 0.65rem 1rem;
            font-size: 0.92rem;
            transition: all 0.3s;
            color: var(--text);
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(79,70,229,0.1);
            background: white;
        }
        body.dark-mode .form-control, body.dark-mode .form-select {
            background: #0f172a; border-color: rgba(255,255,255,0.1); color: #e2e8f0;
        }
        .form-label { font-weight: 600; font-size: 0.85rem; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 6px; }

        /* Audience Selector */
        .audience-pills { display: flex; gap: 0.5rem; flex-wrap: wrap; }
        .audience-pill input[type="radio"] { display: none; }
        .audience-pill label {
            padding: 0.45rem 1rem; border-radius: 50px; border: 2px solid #e2e8f0;
            font-size: 0.82rem; font-weight: 600; cursor: pointer; transition: all 0.25s;
            display: flex; align-items: center; gap: 6px; color: var(--muted);
        }
        .audience-pill input[type="radio"]:checked + label {
            color: white; border-color: transparent;
        }
        .audience-pill.all input:checked + label { background: linear-gradient(135deg, #4f46e5, #7c3aed); }
        .audience-pill.student input:checked + label { background: linear-gradient(135deg, #10b981, #059669); }
        .audience-pill.faculty input:checked + label { background: linear-gradient(135deg, #f59e0b, #d97706); }

        /* File Drop Zone */
        .file-drop {
            border: 2px dashed #c7d2fe;
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: #f5f7ff;
            color: var(--muted);
        }
        .file-drop:hover { border-color: var(--primary); background: #eef2ff; }
        .file-drop i { font-size: 2rem; color: var(--primary); margin-bottom: 0.5rem; display: block; }
        body.dark-mode .file-drop { border-color: rgba(79,70,229,0.4); background: rgba(79,70,229,0.05); }

        /* ── Notice Table / Cards ── */
        .notices-container {
            background: var(--card);
            border-radius: 20px;
            border: 1px solid var(--border);
            box-shadow: 0 4px 30px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        .notices-header {
            padding: 1.25rem 1.75rem;
            display: flex; align-items: center; justify-content: space-between;
            border-bottom: 1px solid var(--border);
        }
        .notice-row {
            display: flex; align-items: flex-start; gap: 1rem;
            padding: 1.25rem 1.75rem;
            border-bottom: 1px solid var(--border);
            transition: background 0.2s;
            animation: fadeIn 0.4s ease;
        }
        .notice-row:last-child { border-bottom: none; }
        .notice-row:hover { background: rgba(79,70,229,0.03); }
        @keyframes fadeIn { from { opacity:0; transform: translateY(8px); } to { opacity:1; transform:translateY(0); } }

        .notice-icon-wrap {
            width: 48px; height: 48px; border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.2rem; flex-shrink: 0;
        }
        .notice-body { flex: 1; min-width: 0; }
        .notice-title { font-weight: 700; font-size: 0.97rem; margin-bottom: 4px; }
        .notice-desc { font-size: 0.85rem; color: var(--muted); margin-bottom: 8px; line-height: 1.5; }
        .notice-meta { display: flex; align-items: center; gap: 0.75rem; flex-wrap: wrap; }

        /* Audience Badges */
        .badge-audience {
            padding: 0.3rem 0.75rem; border-radius: 50px; font-size: 0.72rem; font-weight: 700;
            letter-spacing: 0.5px; text-transform: uppercase;
        }
        .badge-ALL { background: linear-gradient(135deg,#4f46e5,#7c3aed); color: white; }
        .badge-STUDENT { background: linear-gradient(135deg,#10b981,#059669); color: white; }
        .badge-FACULTY { background: linear-gradient(135deg,#f59e0b,#d97706); color: white; }
        .badge-null { background: #e2e8f0; color: #64748b; }

        .notice-date { font-size: 0.78rem; color: var(--muted); display: flex; align-items: center; gap: 4px; }
        .notice-creator { font-size: 0.78rem; color: var(--muted); display: flex; align-items: center; gap: 4px; }
        .file-badge { background: #eff6ff; color: #2563eb; padding: 0.25rem 0.6rem; border-radius: 6px; font-size: 0.73rem; font-weight: 600; display: flex; align-items: center; gap: 4px; }

        .notice-actions { display: flex; gap: 0.5rem; flex-shrink: 0; margin-top: 2px; }
        .btn-notice-del {
            width: 34px; height: 34px; border-radius: 8px; border: none;
            background: rgba(239,68,68,0.1); color: var(--danger);
            display: flex; align-items: center; justify-content: center;
            cursor: pointer; transition: all 0.25s; font-size: 0.9rem;
        }
        .btn-notice-del:hover { background: var(--danger); color: white; transform: scale(1.05); }

        /* ── Empty State ── */
        .empty-state { text-align: center; padding: 4rem 2rem; color: var(--muted); }
        .empty-state i { font-size: 4rem; display: block; margin-bottom: 1rem; opacity: 0.4; }

        /* ── Filter Bar ── */
        .filter-bar { display: flex; gap: 0.5rem; flex-wrap: wrap; }
        .filter-btn {
            padding: 0.35rem 0.9rem; border-radius: 50px;
            border: 1.5px solid #e2e8f0; background: transparent;
            font-size: 0.8rem; font-weight: 600; cursor: pointer; transition: all 0.2s;
            color: var(--muted);
        }
        .filter-btn.active, .filter-btn:hover { border-color: var(--primary); color: var(--primary); background: rgba(79,70,229,0.07); }

        /* ── Responsive ── */
        @media (max-width: 768px) {
            .notice-hero h1 { font-size: 1.5rem; }
            .notice-row { flex-direction: column; }
            .notice-actions { margin-top: 0.75rem; }
        }

        /* Btn */
        .btn-primary-grad {
            background: linear-gradient(135deg, var(--primary), #7c3aed);
            border: none; color: white; font-weight: 700; border-radius: 10px;
            padding: 0.6rem 1.5rem; transition: all 0.3s;
        }
        .btn-primary-grad:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(79,70,229,0.35); color: white; }
    </style>
</head>
<body>
<div class="page-wrapper">
    <%@ include file="aheader.jsp" %>

    <!-- ── Hero ── -->
    <div class="notice-hero">
        <div class="container position-relative">
            <div class="row align-items-center">
                <div class="col">
                    <div class="d-flex align-items-center gap-3 mb-2">
                        <div style="background:rgba(255,255,255,0.2);border-radius:14px;padding:0.6rem 0.9rem;">
                            <i class="bi bi-broadcast fs-3"></i>
                        </div>
                        <div>
                            <h1 class="mb-0">Notice Board</h1>
                            <p class="mb-0 mt-1">Publish and manage all institutional announcements</p>
                        </div>
                    </div>
                </div>
                <div class="col-auto">
                    <a href="/adashboard" class="btn btn-light btn-sm rounded-pill px-3">
                        <i class="bi bi-arrow-left me-1"></i> Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container py-4">
        <!-- ── Stats ── -->
        <div class="row g-3 mb-4">
            <c:set var="totalNotices" value="${notices.size()}" />
            <c:set var="allCount" value="0"/>
            <c:set var="studentCount" value="0"/>
            <c:set var="facultyCount" value="0"/>
            <c:forEach var="n" items="${notices}">
                <c:if test="${n.targetAudience == 'ALL' or n.targetAudience == null}"><c:set var="allCount" value="${allCount + 1}"/></c:if>
                <c:if test="${n.targetAudience == 'STUDENT'}"><c:set var="studentCount" value="${studentCount + 1}"/></c:if>
                <c:if test="${n.targetAudience == 'FACULTY'}"><c:set var="facultyCount" value="${facultyCount + 1}"/></c:if>
            </c:forEach>

            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(79,70,229,0.12);color:#4f46e5;"><i class="bi bi-megaphone-fill"></i></div>
                    <div>
                        <div class="stat-num">${notices.size()}</div>
                        <div class="stat-label">Total Notices</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(16,185,129,0.12);color:#10b981;"><i class="bi bi-mortarboard-fill"></i></div>
                    <div>
                        <div class="stat-num">${studentCount}</div>
                        <div class="stat-label">For Students</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(245,158,11,0.12);color:#f59e0b;"><i class="bi bi-person-video3"></i></div>
                    <div>
                        <div class="stat-num">${facultyCount}</div>
                        <div class="stat-label">For Faculty</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon" style="background:rgba(239,68,68,0.12);color:#ef4444;"><i class="bi bi-globe2"></i></div>
                    <div>
                        <div class="stat-num">${allCount}</div>
                        <div class="stat-label">For Everyone</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- ── Add Notice Form ── -->
            <div class="col-lg-4">
                <div class="add-card sticky-top" style="top:80px;">
                    <div class="add-card-header">
                        <h5 class="mb-0 fw-700"><i class="bi bi-plus-circle me-2"></i>Publish New Notice</h5>
                        <p class="mb-0 small opacity-75 mt-1">Announce to your selected audience</p>
                    </div>
                    <div class="add-card-body">
                        <form action="/admin-notices/add" method="POST" enctype="multipart/form-data">

                            <div class="mb-3">
                                <label class="form-label">Notice Title *</label>
                                <input type="text" name="title" class="form-control" placeholder="e.g. Semester Exam Schedule" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Description *</label>
                                <textarea name="description" class="form-control" rows="4" placeholder="Provide full details of the notice..." required></textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Target Audience *</label>
                                <div class="audience-pills mt-2">
                                    <div class="audience-pill all">
                                        <input type="radio" name="targetAudience" id="aud_all" value="ALL" checked>
                                        <label for="aud_all"><i class="bi bi-globe2"></i> Everyone</label>
                                    </div>
                                    <div class="audience-pill student">
                                        <input type="radio" name="targetAudience" id="aud_student" value="STUDENT">
                                        <label for="aud_student"><i class="bi bi-mortarboard"></i> Students</label>
                                    </div>
                                    <div class="audience-pill faculty">
                                        <input type="radio" name="targetAudience" id="aud_faculty" value="FACULTY">
                                        <label for="aud_faculty"><i class="bi bi-person-video3"></i> Faculty</label>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Attach File (Optional)</label>
                                <div class="file-drop" onclick="document.getElementById('noticeFile').click()">
                                    <i class="bi bi-cloud-arrow-up"></i>
                                    <div class="fw-600" style="font-size:0.9rem;">Click to upload</div>
                                    <small>PDF, DOC, PNG, JPG up to 10MB</small>
                                    <div id="fileNameDisplay" class="mt-2 text-primary fw-600" style="font-size:0.85rem;"></div>
                                </div>
                                <input type="file" id="noticeFile" name="file" class="d-none" onchange="showFileName(this)">
                            </div>

                            <button type="submit" class="btn btn-primary-grad w-100">
                                <i class="bi bi-send-fill me-2"></i> Publish Notice
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- ── Notice List ── -->
            <div class="col-lg-8">
                <div class="notices-container">
                    <div class="notices-header">
                        <div>
                            <h5 class="mb-1 fw-700"><i class="bi bi-list-ul me-2 text-primary"></i>All Notices</h5>
                            <small class="text-muted">${notices.size()} notice(s) published</small>
                        </div>
                        <div class="filter-bar" id="filterBar">
                            <button class="filter-btn active" onclick="filterNotices('ALL', this)">All</button>
                            <button class="filter-btn" onclick="filterNotices('STUDENT', this)">Students</button>
                            <button class="filter-btn" onclick="filterNotices('FACULTY', this)">Faculty</button>
                            <button class="filter-btn" onclick="filterNotices('EVERYONE', this)">Everyone</button>
                        </div>
                    </div>

                    <c:if test="${empty notices}">
                        <div class="empty-state">
                            <i class="bi bi-megaphone"></i>
                            <h5 class="fw-700 mb-2">No notices yet</h5>
                            <p class="text-muted">Publish your first notice using the form.</p>
                        </div>
                    </c:if>

                    <div id="noticeListBody">
                        <c:forEach var="n" items="${notices}">
                            <c:set var="aud" value="${n.targetAudience != null ? n.targetAudience : 'ALL'}"/>
                            <div class="notice-row" data-audience="${aud}">
                                <!-- Icon -->
                                <div class="notice-icon-wrap
                                    <c:choose>
                                        <c:when test="${aud == 'STUDENT'}">bg-success-subtle text-success</c:when>
                                        <c:when test="${aud == 'FACULTY'}">bg-warning-subtle text-warning</c:when>
                                        <c:otherwise>bg-primary-subtle text-primary</c:otherwise>
                                    </c:choose>">
                                    <c:choose>
                                        <c:when test="${aud == 'STUDENT'}"><i class="bi bi-mortarboard-fill"></i></c:when>
                                        <c:when test="${aud == 'FACULTY'}"><i class="bi bi-person-video3"></i></c:when>
                                        <c:otherwise><i class="bi bi-megaphone-fill"></i></c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Body -->
                                <div class="notice-body">
                                    <div class="notice-title">${n.title}</div>
                                    <div class="notice-desc">${n.description}</div>
                                    <div class="notice-meta">
                                        <span class="badge-audience badge-${aud}">
                                            <c:choose>
                                                <c:when test="${aud == 'STUDENT'}">Students</c:when>
                                                <c:when test="${aud == 'FACULTY'}">Faculty</c:when>
                                                <c:otherwise>Everyone</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span class="notice-date"><i class="bi bi-calendar3"></i> ${n.noticeDate}</span>
                                        <c:if test="${n.createdBy != null}">
                                            <span class="notice-creator"><i class="bi bi-person-circle"></i> ${n.createdBy.name}</span>
                                        </c:if>
                                        <c:if test="${n.fileName != null}">
                                            <a href="/download/notice/${n.id}" class="file-badge text-decoration-none">
                                                <i class="bi bi-paperclip"></i> ${n.fileName}
                                            </a>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Actions -->
                                <div class="notice-actions">
                                    <form action="/admin-notices/delete" method="POST" onsubmit="return confirmDelete(event)">
                                        <input type="hidden" name="id" value="${n.id}">
                                        <button type="submit" class="btn-notice-del" title="Delete Notice">
                                            <i class="bi bi-trash3-fill"></i>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function showFileName(input) {
        const el = document.getElementById('fileNameDisplay');
        if (input.files && input.files[0]) {
            el.innerHTML = '<i class="bi bi-check-circle-fill me-1"></i>' + input.files[0].name;
        }
    }

    function confirmDelete(e) {
        e.preventDefault();
        const form = e.target;
        Swal.fire({
            title: 'Delete Notice?',
            text: 'This action cannot be undone.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#ef4444',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Yes, delete it!',
            background: document.body.classList.contains('dark-mode') ? '#1e293b' : '#fff',
            color: document.body.classList.contains('dark-mode') ? '#e2e8f0' : '#1e293b',
        }).then(result => {
            if (result.isConfirmed) form.submit();
        });
        return false;
    }

    function filterNotices(type, btn) {
        document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');

        document.querySelectorAll('.notice-row').forEach(row => {
            const aud = row.dataset.audience;
            let show = false;
            if (type === 'ALL') show = true;
            else if (type === 'EVERYONE') show = (aud === 'ALL' || !aud);
            else show = (aud === type);
            row.style.display = show ? '' : 'none';
        });
    }
</script>
</body>
</html>
