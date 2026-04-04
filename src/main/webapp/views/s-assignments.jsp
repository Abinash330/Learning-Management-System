<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Assignments | EduPro Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        body { font-family:'Inter',sans-serif; background:#f8fafc; }

        .page-hero {
            background: linear-gradient(135deg, #1e1b4b 0%, #312e81 60%, #4f46e5 100%);
            padding: 3rem 0 5.5rem; color:white;
            border-radius: 0 0 40px 40px; margin-bottom: -3.5rem;
            box-shadow: 0 15px 40px rgba(79,70,229,0.2);
        }
        .card-main {
            background: white; border-radius: 22px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid rgba(0,0,0,0.05);
        }
        .assignment-card {
            border-radius: 16px; padding: 1.25rem 1.5rem;
            border: 1.5px solid #e5e7eb; transition: all 0.3s;
            background: #fafafa;
        }
        .assignment-card:hover { border-color: #818cf8; box-shadow: 0 6px 20px rgba(79,70,229,0.1); background:white; }
        .assignment-card.submitted { border-color: #6ee7b7; background: #f0fdf4; }
        .assignment-card.graded { border-color: #6ee7b7; background: linear-gradient(135deg,#f0fdf4,#ecfdf5); }
        .assignment-card.overdue { border-color: #fca5a5; background: #fff5f5; }

        .status-badge { padding:0.35em 0.9em; border-radius:50px; font-size:0.72rem; font-weight:800; letter-spacing:0.5px; }
        .submit-area { background:#f1f5f9; border-radius:14px; padding:1.25rem; margin-top:0.75rem; border:1px solid #e2e8f0; }
        .submit-textarea { border-radius:12px; border:2px solid #e2e8f0; padding:0.75rem 1rem; font-size:0.9rem; transition:all 0.3s; resize:vertical; width:100%; }
        .submit-textarea:focus { border-color:#4f46e5; box-shadow:0 0 0 4px rgba(79,70,229,0.1); outline:none; }
        .btn-submit { background:linear-gradient(135deg,#4f46e5,#7c3aed); color:white; border:none; font-weight:700; border-radius:50px; padding:0.6rem 1.5rem; transition:all 0.3s; }
        .btn-submit:hover { transform:translateY(-2px); box-shadow:0 8px 20px rgba(79,70,229,0.3); color:white; }

        .score-bubble { width:52px;height:52px;border-radius:50%;background:linear-gradient(135deg,#10b981,#059669);color:white;display:flex;align-items:center;justify-content:center;font-weight:900;font-size:1.1rem;box-shadow:0 4px 12px rgba(16,185,129,0.3); }
        .filter-tab { border:none; background:transparent; padding:0.5rem 1rem; border-radius:50px; font-weight:600; font-size:0.85rem; cursor:pointer; transition:all 0.25s; color:#64748b; }
        .filter-tab.active { background:#4f46e5; color:white; box-shadow:0 4px 12px rgba(79,70,229,0.25); }
        .filter-tab:hover:not(.active) { background:#e0e7ff; color:#4f46e5; }

        .empty-state { text-align:center; padding:3rem; color:#9ca3af; }
    </style>
</head>
<body>
    <jsp:include page="sheader.jsp" />

    <!-- Hero -->
    <div class="page-hero text-center">
        <div class="container">
            <span class="badge px-3 py-2 rounded-pill fw-bold mb-3 d-inline-block" style="background:rgba(255,255,255,0.1);border:1px solid rgba(255,255,255,0.2);font-size:0.75rem;letter-spacing:1px;">
                <i class="bi bi-file-earmark-text me-1"></i> ASSIGNMENT PORTAL
            </span>
            <h1 class="display-6 fw-bold text-white mb-2" style="letter-spacing:-1px;">My Assignments</h1>
            <p class="text-white mb-0" style="opacity:0.75;">Submit your work and track your grades and feedback</p>
        </div>
    </div>

    <div class="container mb-5">
        <div class="card-main p-4">

            <!-- Filter Tabs -->
            <div class="d-flex gap-2 mb-4 flex-wrap">
                <button class="filter-tab active" onclick="filterCards(this,'all')" id="tab-all">All</button>
                <button class="filter-tab" onclick="filterCards(this,'pending')">⏳ Pending</button>
                <button class="filter-tab" onclick="filterCards(this,'submitted')">📤 Submitted</button>
                <button class="filter-tab" onclick="filterCards(this,'graded')">✅ Graded</button>
            </div>

            <c:choose>
                <c:when test="${empty assignments}">
                    <div class="empty-state">
                        <i class="bi bi-file-earmark-check" style="font-size:3.5rem;color:#c7d2fe;"></i>
                        <h5 class="mt-3">No assignments yet</h5>
                        <p>Your enrolled courses have no active assignments. Check back later!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div id="assignmentList">
                        <c:forEach var="a" items="${assignments}">
                            <c:choose>
                                <c:when test="${a.sub_status == 'graded'}">
                                    <c:set var="cardClass" value="graded"/>
                                    <c:set var="dataStatus" value="graded"/>
                                </c:when>
                                <c:when test="${a.sub_status == 'submitted'}">
                                    <c:set var="cardClass" value="submitted"/>
                                    <c:set var="dataStatus" value="submitted"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="cardClass" value=""/>
                                    <c:set var="dataStatus" value="pending"/>
                                </c:otherwise>
                            </c:choose>

                            <div class="assignment-card ${cardClass} mb-3" data-status="${dataStatus}">
                                <div class="d-flex align-items-start gap-3 flex-wrap">
                                    <!-- Icon -->
                                    <div style="width:48px;height:48px;border-radius:12px;background:rgba(79,70,229,0.1);display:flex;align-items:center;justify-content:center;color:#4f46e5;font-size:1.3rem;flex-shrink:0;">
                                        <i class="bi bi-file-earmark-text-fill"></i>
                                    </div>
                                    <!-- Info -->
                                    <div class="flex-fill">
                                        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-1">
                                            <div>
                                                <h6 class="fw-bold mb-0" style="font-size:0.95rem;">${a.title}</h6>
                                                <span class="small text-muted"><i class="bi bi-book me-1"></i>${a.course_title}</span>
                                            </div>
                                            <div class="d-flex gap-2 align-items-center">
                                                <span class="small text-muted"><i class="bi bi-calendar3 me-1"></i>Due: <strong>${a.due_date}</strong></span>
                                                <c:choose>
                                                    <c:when test="${a.sub_status == 'graded'}">
                                                        <span class="status-badge bg-success text-white">✔ GRADED</span>
                                                    </c:when>
                                                    <c:when test="${a.sub_status == 'submitted'}">
                                                        <span class="status-badge bg-primary text-white">📤 SUBMITTED</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge bg-warning text-dark">⏳ PENDING</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <p class="small text-muted mb-2" style="font-size:0.82rem;">${a.description}</p>

                                        <!-- Graded Result -->
                                        <c:if test="${a.sub_status == 'graded'}">
                                            <div class="d-flex align-items-center gap-3 mt-2 p-3 rounded-3" style="background:rgba(16,185,129,0.08);border:1px solid #a7f3d0;">
                                                <div class="score-bubble">${a.marks}</div>
                                                <div>
                                                    <div class="fw-bold text-success small">Score: ${a.marks}/100</div>
                                                    <div class="small text-muted">Faculty feedback coming soon</div>
                                                </div>
                                            </div>
                                        </c:if>

                                        <!-- Submit / Resubmit Form -->
                                        <c:if test="${a.sub_status != 'graded'}">
                                            <div class="submit-area">
                                                <p class="small fw-bold text-muted mb-2">
                                                    <c:choose>
                                                        <c:when test="${a.sub_status == 'submitted'}">✏️ Edit your submission:</c:when>
                                                        <c:otherwise>📝 Write your answer:</c:otherwise>
                                                    </c:choose>
                                                </p>
                                                <form action="/s-submit" method="post">
                                                    <input type="hidden" name="assignment_id" value="${a.id}">
                                                    <textarea name="answer" class="submit-textarea mb-2" rows="4"
                                                        placeholder="Type your answer, explanation, or paste a link to your work..."
                                                        required></textarea>
                                                    <button type="submit" class="btn btn-submit">
                                                        <i class="bi bi-send-fill me-2"></i>
                                                        <c:choose>
                                                            <c:when test="${a.sub_status == 'submitted'}">Update Submission</c:when>
                                                            <c:otherwise>Submit Assignment</c:otherwise>
                                                        </c:choose>
                                                    </button>
                                                </form>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div id="noResults" class="empty-state d-none">
                        <i class="bi bi-search" style="font-size:2.5rem;color:#c7d2fe;"></i>
                        <h6 class="mt-3">No assignments in this category</h6>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="sfooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterCards(btn, status) {
            document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
            btn.classList.add('active');
            const cards = document.querySelectorAll('.assignment-card');
            let visible = 0;
            cards.forEach(c => {
                const show = status === 'all' || c.getAttribute('data-status') === status;
                c.style.display = show ? '' : 'none';
                if(show) visible++;
            });
            document.getElementById('noResults').classList.toggle('d-none', visible > 0);
        }
    </script>
</body>
</html>
