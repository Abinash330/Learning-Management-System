<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Courses | EduPro Student</title>
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
        .course-card {
            background: white; border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06); border: 1px solid rgba(0,0,0,0.05);
            overflow: hidden; transition: all 0.3s ease;
            display: flex; flex-direction: column;
        }
        .course-card:hover { transform: translateY(-5px); box-shadow: 0 16px 35px rgba(109,40,217,0.12); }
        .course-banner {
            height: 140px; display:flex; align-items:center; justify-content:center;
            font-size:3rem; position:relative; overflow:hidden;
        }
        .course-banner::after {
            content:''; position:absolute; inset:0;
            background: linear-gradient(180deg,transparent 50%,rgba(0,0,0,0.25));
        }
        .progress-track {
            height: 10px; border-radius: 50px; background: #e5e7eb; overflow: hidden;
        }
        .progress-fill {
            height: 100%; border-radius: 50px;
            background: linear-gradient(90deg, #7c3aed, #4f46e5);
            transition: width 1.2s cubic-bezier(0.4,0,0.2,1);
        }
        .progress-fill.completed {
            background: linear-gradient(90deg, #10b981, #059669);
        }
        .btn-update { border:2px solid #7c3aed; color:#7c3aed; background:transparent; border-radius:50px; font-weight:700; font-size:0.8rem; padding:0.35rem 1rem; transition:all 0.25s; }
        .btn-update:hover { background:#7c3aed; color:white; }
        .btn-resume { background:linear-gradient(135deg,#7c3aed,#4f46e5); color:white; border:none; border-radius:50px; font-weight:700; padding:0.5rem 1.25rem; width:100%; transition:all 0.3s; }
        .btn-resume:hover { transform:translateY(-2px); box-shadow:0 8px 18px rgba(109,40,217,0.3); color:white; }
        .completed-badge { background:linear-gradient(135deg,#10b981,#059669); color:white; border:none; border-radius:50px; font-weight:700; padding:0.5rem 1.25rem; width:100%; }
        .stat-mini { background:white; border-radius:14px; padding:1rem; box-shadow:0 2px 10px rgba(0,0,0,0.05); text-align:center; }
        .modal-content { border-radius:20px; overflow:hidden; }
    </style>
</head>
<body>
    <jsp:include page="sheader.jsp" />

    <!-- Hero -->
    <div class="page-hero text-center">
        <div class="container">
            <span class="badge px-3 py-2 rounded-pill fw-bold mb-3 d-inline-block" style="background:rgba(255,255,255,0.1);border:1px solid rgba(255,255,255,0.2);font-size:0.75rem;letter-spacing:1px;">
                <i class="bi bi-book-fill me-1"></i> MY LEARNING
            </span>
            <h1 class="display-6 fw-bold text-white mb-2" style="letter-spacing:-1px;">My Courses</h1>
            <p class="text-white mb-0" style="opacity:0.75;">Track your enrollment progress and continue learning</p>
        </div>
    </div>

    <div class="container mb-5">

        <!-- Quick Stats -->
        <div class="row g-3 mb-4">
            <div class="col-4">
                <div class="stat-mini">
                    <div class="fw-bold" style="font-size:1.5rem;color:#7c3aed;">${courses.size()}</div>
                    <div class="small text-muted">Enrolled</div>
                </div>
            </div>
            <div class="col-4">
                <div class="stat-mini">
                    <div class="fw-bold" id="completedStat" style="font-size:1.5rem;color:#10b981;">0</div>
                    <div class="small text-muted">Completed</div>
                </div>
            </div>
            <div class="col-4">
                <div class="stat-mini">
                    <div class="fw-bold" id="inProgressStat" style="font-size:1.5rem;color:#f59e0b;">0</div>
                    <div class="small text-muted">In Progress</div>
                </div>
            </div>
        </div>

        <!-- Course Cards Grid -->
        <c:choose>
            <c:when test="${empty courses}">
                <div class="text-center py-5">
                    <i class="bi bi-book-half" style="font-size:4rem;color:#c4b5fd;"></i>
                    <h4 class="text-muted mt-3">No enrolled courses yet</h4>
                    <p class="text-muted">Browse our catalog and enroll in a course to get started!</p>
                    <a href="/s-search" class="btn btn-resume d-inline-block mt-2" style="width:auto;padding:0.7rem 2rem;">Browse Courses</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4" id="courseGrid">
                    <c:forEach var="course" items="${courses}" varStatus="loop">
                        <c:set var="prog" value="${course.progress != null ? course.progress : 0}" />
                        <!-- Determine banner color cycle -->
                        <c:set var="colors" value="#4f46e5,#7c3aed,#0891b2,#065f46,#9d174d,#b45309" />
                        <div class="col-md-6 col-lg-4" data-progress="${prog}">
                            <div class="course-card h-100">
                                <div class="course-banner" style="background:linear-gradient(135deg, hsl(${(loop.index * 47 + 220) % 360},70%,30%), hsl(${(loop.index * 47 + 260) % 360},70%,50%));">
                                    <span style="z-index:1;font-size:2.5rem;">📚</span>
                                </div>
                                <div class="p-3 flex-fill d-flex flex-column">
                                    <h6 class="fw-bold mb-1 mt-1" style="font-size:0.92rem;">${course.title}</h6>
                                    <p class="small text-muted mb-3" style="font-size:0.78rem;flex-grow:1;overflow:hidden;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;">${course.description}</p>

                                    <!-- Progress Bar -->
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <span class="small fw-bold text-muted" style="font-size:0.78rem;">Progress</span>
                                        <span class="fw-bold small" style="color:${prog >= 100 ? '#10b981' : '#7c3aed'};font-size:0.82rem;">${prog}%</span>
                                    </div>
                                    <div class="progress-track mb-3">
                                        <div class="progress-fill ${prog >= 100 ? 'completed' : ''}" style="width:0%" data-target="${prog}"></div>
                                    </div>

                                    <!-- Actions -->
                                    <c:choose>
                                        <c:when test="${prog >= 100}">
                                            <button class="completed-badge mb-2"><i class="bi bi-patch-check-fill me-2"></i>Completed!</button>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/s-start-course?id=${course.id}" class="btn btn-resume mb-2">
                                                <i class="bi bi-play-fill me-1"></i> Continue Learning
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                    <button class="btn-update"
                                        onclick="openProgressModal(${course.id}, '${course.title}', ${prog})">
                                        <i class="bi bi-pencil me-1"></i> Update Progress
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Update Progress Modal -->
    <div class="modal fade" id="progressModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content shadow-lg">
                <div class="modal-header border-0 px-4 pt-4 pb-2">
                    <h5 class="modal-title fw-bold" id="progressModalTitle">Update Progress</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body px-4 pb-4">
                    <form action="/s-update-progress" method="post" id="progressForm">
                        <input type="hidden" name="course_id" id="modalCourseId">
                        <label class="small fw-bold text-muted mb-2 d-block">Progress: <span id="sliderVal">0</span>%</label>
                        <input type="range" name="progress" id="progressSlider" min="0" max="100" value="0"
                            class="form-range mb-3" style="accent-color:#7c3aed;">
                        <button type="submit" class="btn btn-resume">
                            <i class="bi bi-check-lg me-1"></i> Save Progress
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="sfooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Animate progress bars on load
        window.addEventListener('load', () => {
            let completed = 0, inProgress = 0;
            document.querySelectorAll('.progress-fill').forEach(bar => {
                const target = parseInt(bar.getAttribute('data-target') || '0');
                setTimeout(() => { bar.style.width = target + '%'; }, 200);
                const p = parseInt(bar.closest('[data-progress]').getAttribute('data-progress'));
                if(p >= 100) completed++;
                else if(p > 0) inProgress++;
            });
            document.getElementById('completedStat').textContent = completed;
            document.getElementById('inProgressStat').textContent = inProgress;
        });

        // Progress modal
        const modal    = new bootstrap.Modal(document.getElementById('progressModal'));
        const slider   = document.getElementById('progressSlider');
        const sliderV  = document.getElementById('sliderVal');
        slider.addEventListener('input', () => sliderV.textContent = slider.value);

        function openProgressModal(courseId, title, current) {
            document.getElementById('progressModalTitle').textContent = '✏️ ' + title;
            document.getElementById('modalCourseId').value = courseId;
            slider.value = current;
            sliderV.textContent = current;
            modal.show();
        }
    </script>
</body>
</html>
