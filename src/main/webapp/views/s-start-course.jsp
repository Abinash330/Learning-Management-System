<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.title} | EduPro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        body { font-family:'Inter',sans-serif; background:#f8fafc; }
        .page-hero {
            background: linear-gradient(135deg, #581c87 0%, #6d28d9 60%, #7c3aed 100%);
            padding: 3rem 0 5.5rem; color:white;
            border-radius: 0 0 40px 40px; margin-bottom: -3.5rem;
            box-shadow: 0 15px 40px rgba(109,40,217,0.25);
        }
        .nav-tabs { border-bottom: none; gap: 0.5rem; justify-content: center; margin-bottom: 2rem; }
        .nav-tabs .nav-link {
            border: none; border-radius: 50px;
            padding: 0.75rem 1.5rem; font-weight: 600;
            color: #64748b; background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }
        .nav-tabs .nav-link:hover { color: #7c3aed; transform: translateY(-2px); }
        .nav-tabs .nav-link.active {
            background: linear-gradient(135deg,#7c3aed,#4f46e5);
            color: white; box-shadow: 0 8px 20px rgba(109,40,217,0.3);
        }
        .content-card {
            background: white; border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06); border: 1px solid rgba(0,0,0,0.05);
            padding: 2rem; margin-bottom: 2rem;
        }
        .item-row {
            padding: 1rem; border-radius: 12px; border: 1px solid #f1f5f9;
            transition: all 0.2s ease; margin-bottom: 1rem;
            display: flex; align-items: center; justify-content: space-between;
        }
        .item-row:hover { background: #f8fafc; border-color: #e2e8f0; }
        .item-icon {
            width: 48px; height: 48px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem; margin-right: 1rem;
        }
        .icon-video { background: #e0e7ff; color: #4f46e5; }
        .icon-assignment { background: #fce7f3; color: #db2777; }
        .icon-exam { background: #dcfce7; color: #059669; }
        .btn-action {
            border-radius: 50px; padding: 0.5rem 1.25rem; font-weight: 600;
            transition: all 0.2s;
        }
    </style>
</head>
<body>
    <jsp:include page="sheader.jsp" />

    <!-- Hero -->
    <div class="page-hero text-center">
        <div class="container">
            <a href="/s-courses" class="btn btn-sm btn-outline-light rounded-pill mb-3" style="border:1px solid rgba(255,255,255,0.2);"><i class="bi bi-arrow-left me-1"></i> Back to Courses</a>
            <h1 class="display-6 fw-bold text-white mb-2" style="letter-spacing:-1px;">${course.title}</h1>
            <p class="text-white mb-0 mx-auto" style="opacity:0.75; max-width:600px;">${course.description}</p>
        </div>
    </div>

    <div class="container mb-5 mt-5 pt-3">
        
        <!-- Tabs -->
        <ul class="nav nav-tabs" id="courseTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="videos-tab" data-bs-toggle="tab" data-bs-target="#videos" type="button" role="tab">
                    <i class="bi bi-play-circle-fill me-2"></i>Video Lectures <span class="badge bg-light text-dark ms-1 rounded-pill">${videos.size()}</span>
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="assignments-tab" data-bs-toggle="tab" data-bs-target="#assignments" type="button" role="tab">
                    <i class="bi bi-journal-text me-2"></i>Assignments <span class="badge bg-light text-dark ms-1 rounded-pill">${assignments.size()}</span>
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="exams-tab" data-bs-toggle="tab" data-bs-target="#exams" type="button" role="tab">
                    <i class="bi bi-file-earmark-check-fill me-2"></i>Exams <span class="badge bg-light text-dark ms-1 rounded-pill">${exams.size()}</span>
                </button>
            </li>
        </ul>

        <!-- Tab Content -->
        <div class="tab-content" id="courseTabsContent">
            
            <!-- Videos Tab -->
            <div class="tab-pane fade show active" id="videos" role="tabpanel">
                <div class="content-card">
                    <h5 class="fw-bold mb-4">Course Lectures</h5>
                    <c:choose>
                        <c:when test="${empty videos}">
                            <div class="text-center py-4 text-muted">No video lectures available for this course.</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="video" items="${videos}">
                                <div class="item-row">
                                    <div class="d-flex align-items-center">
                                        <div class="item-icon icon-video"><i class="bi bi-play-fill"></i></div>
                                        <div>
                                            <h6 class="fw-bold mb-1">${video.title}</h6>
                                            <small class="text-muted"><i class="bi bi-clock me-1"></i>Duration: ${video.durationMinutes} mins</small>
                                        </div>
                                    </div>
                                    <a href="/s-watch/${video.id}" class="btn btn-outline-primary btn-action">Watch <i class="bi bi-chevron-right ms-1"></i></a>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Assignments Tab -->
            <div class="tab-pane fade" id="assignments" role="tabpanel">
                <div class="content-card">
                    <h5 class="fw-bold mb-4">Assignments</h5>
                    <c:choose>
                        <c:when test="${empty assignments}">
                            <div class="text-center py-4 text-muted">No assignments available.</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="asg" items="${assignments}">
                                <div class="item-row">
                                    <div class="d-flex align-items-center">
                                        <div class="item-icon icon-assignment"><i class="bi bi-file-text-fill"></i></div>
                                        <div>
                                            <h6 class="fw-bold mb-1">${asg.title}</h6>
                                            <small class="text-muted">Total Marks: ${asg.totalMarks}</small>
                                        </div>
                                    </div>
                                    <a href="/s-assignments" class="btn btn-outline-secondary btn-action">Go to Assignments</a>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Exams Tab -->
            <div class="tab-pane fade" id="exams" role="tabpanel">
                <div class="content-card">
                    <h5 class="fw-bold mb-4">Exams & Assessments</h5>
                    <c:choose>
                        <c:when test="${empty exams}">
                            <div class="text-center py-4 text-muted">No exams mapped to this course.</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="ex" items="${exams}">
                                <div class="item-row">
                                    <div class="d-flex align-items-center">
                                        <div class="item-icon icon-exam"><i class="bi bi-laptop"></i></div>
                                        <div>
                                            <h6 class="fw-bold mb-1">${ex.title}</h6>
                                            <small class="text-muted">Duration: ${ex.durationMinutes} mins  |  Status: <span class="badge ${ex.status == 'Live' ? 'bg-success' : 'bg-secondary'}">${ex.status}</span></small>
                                        </div>
                                    </div>
                                    <c:choose>
                                        <c:when test="${ex.status == 'Live'}">
                                            <a href="/student/exams" class="btn btn-success btn-action">Take Exam</a>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-outline-secondary btn-action" disabled>Unavailable</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>

    <jsp:include page="sfooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
