<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignments | EduPro Faculty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        :root { --green: #10b981; --dark: #064e3b; }
        body { font-family:'Inter',sans-serif; background:#f0fdf4; }

        .page-hero {
            background: linear-gradient(135deg, #064e3b 0%, #065f46 60%, #047857 100%);
            padding: 3rem 0 5.5rem; color: white;
            border-radius: 0 0 40px 40px; margin-bottom: -3.5rem;
            box-shadow: 0 15px 40px rgba(6,78,59,0.25);
        }
        .card-custom {
            background: white; border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }
        .card-custom:hover { transform: translateY(-3px); box-shadow: 0 12px 30px rgba(16,185,129,0.1); }

        .stat-pill {
            border-radius: 14px; padding: 1rem 1.25rem;
            display: flex; align-items: center; gap: 0.75rem;
        }
        .badge-status { padding: 0.4em 0.9em; border-radius: 50px; font-size: 0.75rem; font-weight: 700; }
        .btn-green { background: linear-gradient(135deg,#10b981,#059669); color:white; border:none; font-weight:700; border-radius:50px; padding:0.6rem 1.5rem; transition:all 0.3s; box-shadow:0 4px 12px rgba(16,185,129,0.25); }
        .btn-green:hover { transform:translateY(-2px); box-shadow:0 8px 20px rgba(16,185,129,0.35); color:white; }

        .table { border-collapse:separate; border-spacing:0 8px; margin-top:-8px; }
        .table thead th { border:none; color:#6b7280; font-size:0.75rem; text-transform:uppercase; letter-spacing:1px; font-weight:700; padding:0.75rem 1rem; }
        .table tbody tr { background:#f9fafb; transition:all 0.2s; }
        .table tbody tr:hover { background:white; box-shadow:0 4px 12px rgba(16,185,129,0.08); }
        .table tbody td { border:none!important; padding:0.9rem 1rem; vertical-align:middle; }
        .table tbody td:first-child { border-radius:12px 0 0 12px; }
        .table tbody td:last-child { border-radius:0 12px 12px 0; }

        .modal-content { border-radius: 20px; overflow:hidden; }
        .input-custom { border-radius:12px; border:2px solid #e5e7eb; padding:0.75rem 1rem; font-weight:500; transition:all 0.3s; }
        .input-custom:focus { border-color:#10b981; box-shadow:0 0 0 4px rgba(16,185,129,0.1); outline:none; }

        .empty-state { text-align:center; padding:3rem; color:#9ca3af; }
        .grade-form { background:#f0fdf4; border-radius:14px; padding:1.25rem; border:1px solid #d1fae5; margin-top:0.75rem; }
    </style>
</head>
<body>
    <jsp:include page="fheader.jsp" />

    <!-- Hero -->
    <div class="page-hero text-center">
        <div class="container">
            <span class="badge px-3 py-2 rounded-pill fw-bold mb-3 d-inline-block" style="background:rgba(255,255,255,0.1);border:1px solid rgba(255,255,255,0.2);font-size:0.75rem;letter-spacing:1px;">
                <i class="bi bi-file-earmark-text me-1"></i> ASSIGNMENT CENTER
            </span>
            <h1 class="display-6 fw-bold text-white mb-2" style="letter-spacing:-1px;">Manage Assignments</h1>
            <p class="text-white mb-0" style="opacity:0.75;">Create assignments, review submissions, and provide grades &amp; feedback</p>
        </div>
    </div>

    <div class="container mb-5">

        <!-- Stat Row -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="card-custom stat-pill" style="background:rgba(16,185,129,0.06);">
                    <div style="width:48px;height:48px;background:rgba(16,185,129,0.15);border-radius:12px;display:flex;align-items:center;justify-content:center;color:#10b981;font-size:1.4rem;">
                        <i class="bi bi-file-earmark-text-fill"></i>
                    </div>
                    <div>
                        <div class="fw-bold" style="font-size:1.6rem;">${assignments.size()}</div>
                        <div class="small text-muted">Total Assignments</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card-custom stat-pill" style="background:rgba(245,158,11,0.06);">
                    <div style="width:48px;height:48px;background:rgba(245,158,11,0.15);border-radius:12px;display:flex;align-items:center;justify-content:center;color:#f59e0b;font-size:1.4rem;">
                        <i class="bi bi-hourglass-split"></i>
                    </div>
                    <div>
                        <div class="fw-bold" style="font-size:1.6rem;">${pendingSubmissions.size()}</div>
                        <div class="small text-muted">Pending to Grade</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card-custom stat-pill" style="background:rgba(79,70,229,0.06);">
                    <div style="width:48px;height:48px;background:rgba(79,70,229,0.15);border-radius:12px;display:flex;align-items:center;justify-content:center;color:#4f46e5;font-size:1.4rem;">
                        <i class="bi bi-journals"></i>
                    </div>
                    <div>
                        <div class="fw-bold" style="font-size:1.6rem;">${myCourses.size()}</div>
                        <div class="small text-muted">Your Courses</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left: Assignment List -->
            <div class="col-lg-7">
                <div class="card-custom p-4 mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                        <div>
                            <h5 class="fw-bold m-0"><i class="bi bi-list-check me-2 text-success"></i>Your Assignments</h5>
                            <p class="text-muted small m-0">All assignments you've created</p>
                        </div>
                        <button class="btn btn-green btn-sm px-4" data-bs-toggle="modal" data-bs-target="#createModal">
                            <i class="bi bi-plus-lg me-1"></i> New Assignment
                        </button>
                    </div>

                    <c:choose>
                        <c:when test="${empty assignments}">
                            <div class="empty-state">
                                <i class="bi bi-file-earmark-plus" style="font-size:3rem;color:#d1fae5;"></i>
                                <h6 class="mt-3">No assignments yet</h6>
                                <p class="small">Click "New Assignment" to create your first one.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table align-middle">
                                    <thead><tr>
                                        <th>Assignment</th><th>Course</th><th>Due Date</th><th>Submissions</th>
                                    </tr></thead>
                                    <tbody>
                                        <c:forEach var="a" items="${assignments}">
                                            <tr>
                                                <td>
                                                    <div class="fw-bold" style="font-size:0.88rem;">${a.title}</div>
                                                    <div class="small text-muted" style="max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${a.description}</div>
                                                </td>
                                                <td><span class="badge bg-success bg-opacity-10 text-success" style="font-size:0.75rem;">${a.course_title}</span></td>
                                                <td>
                                                    <span class="small fw-bold text-danger"><i class="bi bi-calendar3 me-1"></i>${a.due_date}</span>
                                                </td>
                                                <td>
                                                    <span class="badge bg-warning bg-opacity-15 text-warning">${a.submission_count} submitted</span><br>
                                                    <span class="badge bg-success bg-opacity-10 text-success mt-1">${a.graded_count} graded</span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Right: Pending Submissions to Grade -->
            <div class="col-lg-5">
                <div class="card-custom p-4">
                    <h5 class="fw-bold mb-1"><i class="bi bi-pencil-square me-2 text-warning"></i>Grade Submissions</h5>
                    <p class="text-muted small mb-3">Student answers awaiting your review</p>

                    <c:choose>
                        <c:when test="${empty pendingSubmissions}">
                            <div class="empty-state">
                                <i class="bi bi-check2-all" style="font-size:3rem;color:#d1fae5;"></i>
                                <h6 class="mt-3 text-success">All caught up!</h6>
                                <p class="small">No pending submissions to grade.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="sub" items="${pendingSubmissions}">
                                <div class="card-custom p-3 mb-3">
                                    <div class="d-flex align-items-start gap-2 mb-2">
                                        <div style="width:36px;height:36px;border-radius:10px;background:rgba(16,185,129,0.1);display:flex;align-items:center;justify-content:center;color:#10b981;font-weight:800;flex-shrink:0;">
                                            ${sub.student_name.substring(0,1).toUpperCase()}
                                        </div>
                                        <div>
                                            <div class="fw-bold" style="font-size:0.85rem;">${sub.student_name}</div>
                                            <div class="small text-muted" style="font-size:0.75rem;">${sub.assignment_title}</div>
                                        </div>
                                        <span class="badge bg-warning ms-auto" style="font-size:0.65rem;">PENDING</span>
                                    </div>
                                    <div class="small text-dark p-2 rounded-2 mb-2" style="background:#f9fafb;border:1px solid #e5e7eb;font-size:0.8rem;max-height:80px;overflow-y:auto;">
                                        ${sub.answer}
                                    </div>
                                    <form action="/f-grade" method="post">
                                        <input type="hidden" name="submission_id" value="${sub.id}">
                                        <div class="grade-form">
                                            <div class="row g-2">
                                                <div class="col-4">
                                                    <input type="number" name="marks" class="form-control input-custom" placeholder="Marks" min="0" max="100" required style="font-size:0.85rem;padding:0.5rem 0.75rem;">
                                                </div>
                                                <div class="col-8">
                                                    <input type="text" name="feedback" class="form-control input-custom" placeholder="Feedback..." required style="font-size:0.85rem;padding:0.5rem 0.75rem;">
                                                </div>
                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-green w-100" style="padding:0.5rem;font-size:0.85rem;">
                                                        <i class="bi bi-check-lg me-1"></i> Submit Grade
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Create Assignment Modal -->
    <div class="modal fade" id="createModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow-lg">
                <div class="modal-header border-0 pb-0 px-4 pt-4" style="background:#f0fdf4;">
                    <h5 class="modal-title fw-bold d-flex align-items-center gap-2">
                        <div style="width:40px;height:40px;background:rgba(16,185,129,0.15);border-radius:10px;display:flex;align-items:center;justify-content:center;color:#10b981;font-size:1.1rem;">
                            <i class="bi bi-plus-circle-fill"></i>
                        </div>
                        Create New Assignment
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4" style="background:#f0fdf4;">
                    <form action="/f-create-assignment" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold small">Select Course</label>
                            <select name="course_id" class="form-select input-custom" required>
                                <option value="" disabled selected>-- Choose a course --</option>
                                <c:forEach var="course" items="${myCourses}">
                                    <option value="${course.id}">${course.title}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold small">Assignment Title</label>
                            <input type="text" name="title" class="form-control input-custom" placeholder="e.g., Midterm Project" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold small">Description / Instructions</label>
                            <textarea name="description" class="form-control input-custom" rows="4" placeholder="Describe the task clearly..." required></textarea>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-bold small">Due Date</label>
                            <input type="date" name="due_date" class="form-control input-custom" required>
                        </div>
                        <button type="submit" class="btn btn-green w-100 py-3">
                            <i class="bi bi-send-fill me-2"></i> Publish Assignment
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="ffooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
