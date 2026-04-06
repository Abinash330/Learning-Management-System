<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Management | EduPro Admin</title>
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

        .course-avatar { width:40px;height:40px;border-radius:10px;display:flex;align-items:center;justify-content:center;background:linear-gradient(135deg,rgba(6,182,212,0.1),rgba(14,165,233,0.1));color:#0ea5e9;font-weight:800;font-size:1rem; }

        .btn-gradient { background:linear-gradient(135deg,var(--primary),var(--secondary)); color:white; border:none; font-weight:700; padding:0.6rem 1.5rem; border-radius:50px; transition:all 0.3s; box-shadow:0 4px 15px rgba(79,70,229,0.25); }
        .btn-gradient:hover { transform:translateY(-2px); box-shadow:0 8px 25px rgba(79,70,229,0.35); color:white; }

        .fade-up { animation:fadeUp 0.6s forwards; opacity:0; }
        .d1{animation-delay:0.1s;} .d2{animation-delay:0.2s;}
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
                <i class="bi bi-collection-play-fill me-1"></i> COURSE BUILDER
            </span>
            <h1 class="display-6 fw-bold text-white mb-2" style="letter-spacing:-1px;">Course Management</h1>
            <p class="text-white mb-0" style="opacity:0.75;">Oversee, manage, and remove courses globally</p>
        </div>
    </div>

    <div class="container mb-5 fade-up d1">
        <div class="data-card">
            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                <div>
                    <h4 class="fw-bold m-0"><i class="bi bi-journals text-primary me-2"></i>Global Course List</h4>
                    <p class="text-muted small m-0">All available courses and their enrollments</p>
                </div>
                <div class="d-flex gap-2 flex-wrap">
                    <button class="btn btn-gradient shadow-sm btn-sm px-3" data-bs-toggle="modal" data-bs-target="#addCourseModal">
                        <i class="bi bi-plus-lg me-1"></i> Create Course
                    </button>
                    <a href="/adashboard" class="btn btn-sm px-3 fw-bold" style="border:2px solid #e2e8f0;border-radius:50px;color:var(--text-muted);">
                        <i class="bi bi-arrow-left me-1"></i> Dashboard
                    </a>
                </div>
            </div>

            <!-- Filter -->
            <div class="filter-bar">
                <div class="position-relative">
                    <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted" style="font-size:0.85rem;"></i>
                    <input type="text" id="courseSearchInput" class="search-input" placeholder="Search course title..." oninput="filterCourses()">
                </div>
            </div>

            <div class="table-responsive">
                <table class="table align-middle" id="courseTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Course Info</th>
                            <th>Description</th>
                            <th>Instructor</th>
                            <th>Enrollments</th>
                            <th class="text-end">Manage</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="course" items="${courses}" varStatus="loop">
                            <tr data-title="${course.title}">
                                <td class="text-muted fw-bold" style="font-size:0.8rem;">${course.id}</td>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="course-avatar"><i class="bi bi-journal-check"></i></div>
                                        <div class="fw-bold" style="font-size:0.88rem;">${course.title}</div>
                                    </div>
                                </td>
                                <td>
                                    <div class="small text-muted" style="max-width:250px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">${course.description}</div>
                                </td>
                                <td>
                                    <span class="badge bg-info bg-opacity-10 text-info fw-bold"><i class="bi bi-person-video3 me-1"></i>${empty course.instructor.name ? 'Unassigned' : course.instructor.name}</span>
                                </td>
                                <td>
                                    <span class="fw-bold text-primary">${course.enrollments}</span>
                                </td>
                                <td class="text-end">
                                    <form method="post" action="/admin-courses/delete" class="m-0 p-0 d-inline">
                                        <input type="hidden" value="${course.id}" name="id"/>
                                        <button type="submit" class="btn btn-sm btn-danger rounded-3 shadow-sm" style="font-size:0.78rem;" onclick="return confirm('DELETE this course globally? Enrollments will be cascade-deleted.');">
                                            <i class="bi bi-trash3"></i> Remove
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal for Adding Course -->
    <div class="modal fade" id="addCourseModal" tabindex="-1" aria-labelledby="addCourseModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 border-0 shadow" style="overflow:hidden;">
                <div class="modal-header bg-light border-0">
                    <h5 class="modal-title fw-bold" id="addCourseModalLabel"><i class="bi bi-plus-circle-fill text-primary me-2"></i>New Course Override</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="/admin-courses/add" method="post">
                    <div class="modal-body p-4 border-0">
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">Course Title</label>
                            <input type="text" name="title" class="form-control rounded-3" required />
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">Description</label>
                            <textarea name="description" class="form-control rounded-3" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">Assign Faculty</label>
                            <select name="instructor.id" class="form-select rounded-3" required>
                                <option value="" disabled selected>Select Faculty Member</option>
                                <c:forEach var="f" items="${facultyList}">
                                    <option value="${f.id}">${f.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer bg-light border-0">
                        <button type="button" class="btn btn-light rounded-pill" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-gradient">Create Course</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="afooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterCourses() {
            const q = document.getElementById('courseSearchInput').value.toLowerCase().trim();
            document.querySelectorAll('#courseTable tbody tr').forEach(row => {
                const text = row.getAttribute('data-title').toLowerCase();
                row.style.display = (!q || text.includes(q)) ? '' : 'none';
            });
        }
    </script>
</body>
</html>

