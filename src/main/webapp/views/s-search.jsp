<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search | EduPro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        body { font-family:'Inter',sans-serif; background:#f8fafc; }
        .search-hero {
            background: linear-gradient(135deg,#1e1b4b 0%,#312e81 60%,#4338ca 100%);
            padding: 3rem 0 2.5rem; text-align:center; color:white;
            border-radius: 0 0 30px 30px;
        }
        .search-box { max-width:620px; margin:0 auto; }
        .search-input-main { border-radius:50px 0 0 50px; border:none; padding:1rem 1.5rem; font-size:1rem; font-weight:500; }
        .search-btn-main { border-radius:0 50px 50px 0; background:#4f46e5; border:none; color:white; padding:1rem 1.5rem; font-weight:700; }
        .search-btn-main:hover { background:#3730a3; }

        .result-tab { border:none; background:transparent; padding:0.5rem 1.25rem; border-radius:50px; font-weight:700; font-size:0.85rem; color:#64748b; cursor:pointer; transition:all 0.25s; }
        .result-tab.active { background:linear-gradient(135deg,#4f46e5,#7c3aed); color:white; box-shadow:0 4px 12px rgba(79,70,229,0.3); }
        .result-tab:hover:not(.active) { background:#e0e7ff; color:#4f46e5; }

        .result-card { background:white; border-radius:16px; padding:1.25rem 1.5rem; box-shadow:0 2px 12px rgba(0,0,0,0.05); border:1px solid rgba(0,0,0,0.05); transition:all 0.3s; }
        .result-card:hover { transform:translateY(-3px); box-shadow:0 10px 25px rgba(79,70,229,0.1); border-color:#c7d2fe; }

        .course-icon { width:50px;height:50px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.3rem;flex-shrink:0; }
        .btn-enroll { background:linear-gradient(135deg,#4f46e5,#7c3aed); color:white; border:none; border-radius:50px; padding:0.4rem 1.1rem; font-weight:700; font-size:0.82rem; transition:all 0.3s; }
        .btn-enroll:hover { transform:translateY(-2px); box-shadow:0 6px 15px rgba(79,70,229,0.3); color:white; }

        .empty-state { text-align:center; padding:4rem 2rem; color:#94a3b8; }
        .count-badge { background:#e0e7ff; color:#4f46e5; border-radius:50px; padding:0.25em 0.75em; font-size:0.78rem; font-weight:700; }
    </style>
</head>
<body>
    <jsp:include page="sheader.jsp" />

    <!-- Search Hero -->
    <div class="search-hero">
        <div class="container">
            <h1 class="fw-bold mb-1" style="letter-spacing:-1px;">🔍 Search EduPro</h1>
            <p style="opacity:0.75;" class="mb-4">Find courses, notices, and resources across the platform</p>
            <form action="/s-search" method="get" class="search-box">
                <div class="input-group shadow-lg">
                    <input type="text" name="q" class="form-control search-input-main" value="${query}" placeholder="Search courses, notices, topics...">
                    <button type="submit" class="btn search-btn-main"><i class="bi bi-search me-1"></i> Search</button>
                </div>
            </form>
        </div>
    </div>

    <div class="container py-5">
        <c:if test="${not empty query}">
            <!-- Result Summary -->
            <div class="d-flex align-items-center gap-3 mb-4 flex-wrap">
                <h5 class="m-0 fw-bold">Results for <span class="text-primary">"${query}"</span></h5>
                <span class="count-badge">${courses.size()} courses</span>
                <span class="count-badge">${notices.size()} notices</span>
            </div>

            <!-- Tabs -->
            <div class="d-flex gap-2 mb-4 flex-wrap">
                <button class="result-tab active" onclick="switchTab(this,'courses')">
                    <i class="bi bi-book me-1"></i> Courses (${courses.size()})
                </button>
                <button class="result-tab" onclick="switchTab(this,'notices')">
                    <i class="bi bi-megaphone me-1"></i> Notices (${notices.size()})
                </button>
            </div>

            <!-- Courses Results -->
            <div id="tab-courses">
                <c:choose>
                    <c:when test="${empty courses}">
                        <div class="empty-state">
                            <i class="bi bi-book-half" style="font-size:3rem;color:#c7d2fe;"></i>
                            <h5 class="mt-3">No courses found</h5>
                            <p>Try different keywords or browse all courses.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3">
                            <c:forEach var="course" items="${courses}" varStatus="loop">
                                <div class="col-md-6 col-lg-4">
                                    <div class="result-card h-100">
                                        <div class="d-flex gap-3 align-items-start">
                                            <div class="course-icon" style="background:hsl(${(loop.index * 61 + 230)%360},70%,92%);color:hsl(${(loop.index * 61 + 230)%360},70%,40%);">
                                                📚
                                            </div>
                                            <div class="flex-fill">
                                                <h6 class="fw-bold mb-1" style="font-size:0.92rem;">${course.title}</h6>
                                                <p class="small text-muted mb-2" style="font-size:0.8rem;overflow:hidden;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;">${course.description}</p>
                                                <div class="d-flex gap-2 flex-wrap align-items-center">
                                                    <a href="/s-start-course?id=${course.id}" class="btn btn-enroll">
                                                        <i class="bi bi-play-fill me-1"></i> Start Course
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Notices Results -->
            <div id="tab-notices" style="display:none;">
                <c:choose>
                    <c:when test="${empty notices}">
                        <div class="empty-state">
                            <i class="bi bi-megaphone" style="font-size:3rem;color:#c7d2fe;"></i>
                            <h5 class="mt-3">No notices found</h5>
                            <p>No notices match your search term.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3">
                            <c:forEach var="notice" items="${notices}">
                                <div class="col-md-6">
                                    <div class="result-card">
                                        <div class="d-flex gap-3 align-items-start">
                                            <div class="course-icon" style="background:#fef3c7;color:#d97706;font-size:1.2rem;">
                                                📢
                                            </div>
                                            <div>
                                                <h6 class="fw-bold mb-1" style="font-size:0.9rem;">${notice.title}</h6>
                                                <p class="small text-muted mb-1">${notice.description}</p>
                                                <span class="small text-muted"><i class="bi bi-calendar3 me-1"></i>${notice.noticeDate}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${empty query}">
            <div class="empty-state">
                <i class="bi bi-search" style="font-size:4rem;color:#c7d2fe;"></i>
                <h4 class="mt-3 fw-bold">What are you looking for?</h4>
                <p class="text-muted">Enter keywords above to search across courses, notices, and more.</p>
            </div>
        </c:if>
    </div>

    <jsp:include page="sfooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function switchTab(btn, tabId) {
            document.querySelectorAll('.result-tab').forEach(t => t.classList.remove('active'));
            btn.classList.add('active');
            ['courses','notices'].forEach(id => {
                document.getElementById('tab-' + id).style.display = id === tabId ? '' : 'none';
            });
        }
    </script>
</body>
</html>

