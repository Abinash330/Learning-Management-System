<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam Monitoring | EduPro Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --glass-bg: rgba(255, 255, 255, 0.75);
            --glass-border: rgba(255, 255, 255, 0.4);
            --primary-gradient: linear-gradient(135deg, #1e293b 0%, #334155 100%);
        }

        body {
            background: #f1f5f9;
            font-family: 'Outfit', sans-serif;
        }

        .hero-section {
            background: var(--primary-gradient);
            color: white;
            padding: 60px 0 100px;
            border-radius: 0 0 40px 40px;
            margin-bottom: -60px;
        }

        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        }

        .stat-card {
            padding: 25px;
            border-radius: 20px;
            background: white;
            border: 1px solid #e2e8f0;
            transition: 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.05);
        }

        .nav-tabs {
            border-bottom: none;
            gap: 10px;
        }

        .nav-link {
            border: none !important;
            border-radius: 12px !important;
            padding: 10px 25px !important;
            font-weight: 600;
            color: #64748b;
            transition: 0.3s;
        }

        .nav-link.active {
            background: #334155 !important;
            color: white !important;
        }
    </style>
</head>
<body>
    <jsp:include page="../aheader.jsp" />

    <div class="hero-section text-center">
        <div class="container">
            <h1 class="fw-800">Exam Monitoring & Audit</h1>
            <p class="opacity-75">Oversee academic performance and system-wide exam activity</p>
        </div>
    </div>

    <div class="container pb-5">
        <!-- Stats Row -->
        <div class="row mb-5">
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <div class="small text-muted mb-1">Total Exams Created</div>
                    <div class="h2 fw-800 mb-0">${totalExams}</div>
                    <div class="small text-success"><i class="bi bi-graph-up me-1"></i> System-wide</div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <div class="small text-muted mb-1">Total Submissions</div>
                    <div class="h2 fw-800 mb-0">${totalResults}</div>
                    <div class="small text-primary"><i class="bi bi-people me-1"></i> Students Completed</div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <div class="small text-muted mb-1">Average Performance</div>
                    <div class="h2 fw-800 mb-0">78%</div>
                    <div class="small text-warning"><i class="bi bi-star-fill me-1"></i> Target: 80%</div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <c:if test="${not empty message}">
            <div class="alert alert-success border-0 rounded-4 shadow-sm mb-4 animate__animated animate__fadeIn">
                <i class="bi bi-check-circle-fill me-2"></i> ${message}
            </div>
        </c:if>
        <div class="glass-card p-4">
            <ul class="nav nav-tabs mb-4" id="monitorTabs" role="tablist">
                <li class="nav-item">
                    <button class="nav-link active" id="results-tab" data-bs-toggle="tab" data-bs-target="#results"
                        type="button">Live Submissions</button>
                </li>
                <li class="nav-item">
                    <button class="nav-link" id="audit-tab" data-bs-toggle="tab" data-bs-target="#audit"
                        type="button">Exam Audit Trail</button>
                </li>
            </ul>

            <div class="tab-content">
                <!-- Results Monitoring -->
                <div class="tab-pane fade show active" id="results">
                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead>
                                <tr class="text-muted small uppercase">
                                    <th>Student</th>
                                    <th>Exam Title</th>
                                    <th>Score</th>
                                    <th>Time Submitted</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="res" items="${results}">
                                    <tr>
                                        <td>
                                            <div class="fw-600">${res.student.name}</div>
                                            <small class="text-muted">${res.student.email}</small>
                                        </td>
                                        <td>
                                            <div class="fw-600">${res.exam.title}</div>
                                            <small class="text-muted">${res.exam.course.title}</small>
                                        </td>
                                        <td>
                                            <div class="fw-800 text-primary">${res.score} / ${res.exam.totalMarks}
                                            </div>
                                        </td>
                                        <td>
                                            <small class="text-muted">${res.submissionTime}</small>
                                        </td>
                                        <td>
                                            <span
                                                class="badge bg-success bg-opacity-10 text-success px-3 rounded-pill">Completed</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Audit Trail -->
                <div class="tab-pane fade" id="audit">
                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead>
                                <tr class="text-muted small uppercase">
                                    <th>Exam ID</th>
                                    <th>Title</th>
                                    <th>Created By (Faculty)</th>
                                    <th>Course</th>
                                    <th>Created Date</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="exam" items="${exams}">
                                    <tr>
                                        <td><code class="text-muted">#EX-${exam.id}</code></td>
                                        <td class="fw-800">${exam.title}</td>
                                        <td>
                                            <div class="fw-600">${exam.faculty.name}</div>
                                            <small class="text-muted">${exam.faculty.email}</small>
                                        </td>
                                        <td>${exam.course.title}</td>
                                        <td><small class="text-muted">${exam.createdAt}</small></td>
                                        <td class="text-end">
                                            <form action="/admin/exams/delete/${exam.id}" method="post"
                                                onsubmit="return confirm('Delete this exam as Admin?')">
                                                <button type="submit"
                                                    class="btn btn-sm btn-outline-danger rounded-pill px-3">
                                                    <i class="bi bi-trash"></i> Delete
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
        </div>
    </div>

    <jsp:include page="../afooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>