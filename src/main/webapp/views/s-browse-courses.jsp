<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Courses | EduPro Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        body { font-family:'Inter',sans-serif; background:#f8fafc; }

        .page-hero {
            background: linear-gradient(135deg, #0f172a 0%, #3b82f6 100%);
            padding: 3rem 0 5.5rem; color:white;
            border-radius: 0 0 40px 40px; margin-bottom: -3.5rem;
            box-shadow: 0 15px 40px rgba(59, 130, 246, 0.25);
        }
        .course-card {
            background: white; border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06); border: 1px solid rgba(0,0,0,0.05);
            overflow: hidden; transition: all 0.3s ease;
            display: flex; flex-direction: column;
            position: relative;
        }
        .course-card:hover { transform: translateY(-5px); box-shadow: 0 16px 35px rgba(59, 130, 246, 0.15); }
        .course-banner {
            height: 140px; display:flex; align-items:center; justify-content:center;
            font-size:3rem; position:relative; overflow:hidden;
        }
        .course-banner::after {
            content:''; position:absolute; inset:0;
            background: linear-gradient(180deg,transparent 50%,rgba(0,0,0,0.25));
        }
        .btn-enroll { background:linear-gradient(135deg,#3b82f6,#2563eb); color:white; border:none; border-radius:50px; font-weight:700; padding:0.5rem 1.25rem; width:100%; transition:all 0.3s; }
        .btn-enroll:hover { transform:translateY(-2px); box-shadow:0 8px 18px rgba(59, 130, 246, 0.3); color:white; }
        .btn-enrolled { background:linear-gradient(135deg,#10b981,#059669); color:white; border:none; border-radius:50px; font-weight:700; padding:0.5rem 1.25rem; width:100%; text-decoration: none; display: inline-block; text-align: center; transition:all 0.3s; }
        .btn-enrolled:hover { transform:translateY(-2px); box-shadow:0 8px 18px rgba(16, 185, 129, 0.3); color:white; }
        
        .department-badge { position: absolute; top: 12px; right: 12px; z-index: 2; border-radius: 50px; padding: 0.3rem 0.8rem; font-size: 0.75rem; font-weight: 600; background: rgba(255,255,255,0.2); backdrop-filter: blur(5px); color: white; border: 1px solid rgba(255,255,255,0.3); }
        .instructor-info { display: flex; align-items: center; gap: 8px; margin-bottom: 12px; }
        .instructor-avatar { width: 24px; height: 24px; border-radius: 50%; object-fit: cover; }
    </style>
</head>
<body>
    <jsp:include page="sheader.jsp" />

    <!-- Hero -->
    <div class="page-hero text-center">
        <div class="container">
            <span class="badge px-3 py-2 rounded-pill fw-bold mb-3 d-inline-block" style="background:rgba(255,255,255,0.1);border:1px solid rgba(255,255,255,0.2);font-size:0.75rem;letter-spacing:1px;">
                <i class="bi bi-compass me-1"></i> COURSE DISCOVERY
            </span>
            <h1 class="display-6 fw-bold text-white mb-2" style="letter-spacing:-1px;">Browse Courses</h1>
            <p class="text-white mb-0" style="opacity:0.75;">Find your next learning adventure and enroll instantly.</p>
        </div>
    </div>

    <div class="container mb-5" style="margin-top: 5rem;">

        <!-- Course Cards Grid -->
        <c:choose>
            <c:when test="${empty allCourses}">
                <div class="text-center py-5">
                    <i class="bi bi-x-circle" style="font-size:4rem;color:#cbd5e1;"></i>
                    <h4 class="text-muted mt-3">No courses available</h4>
                    <p class="text-muted">Check back later or contact your administrator.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4 d-flex align-items-stretch">
                    <c:forEach var="course" items="${allCourses}" varStatus="loop">
                        <c:set var="isEnrolled" value="false" />
                        <c:forEach var="enrolledId" items="${enrolledCourseIds}">
                            <c:if test="${enrolledId == course.id}">
                                <c:set var="isEnrolled" value="true" />
                            </c:if>
                        </c:forEach>
                        
                        <div class="col-md-6 col-lg-4">
                            <div class="course-card h-100">
                                <c:if test="${course.department != null}">
                                    <div class="department-badge">
                                        <i class="bi bi-diagram-3-fill me-1"></i>${course.department.name}
                                    </div>
                                </c:if>
                                <div class="course-banner" style="background:linear-gradient(135deg, hsl(${(loop.index * 67 + 200) % 360},70%,40%), hsl(${(loop.index * 67 + 240) % 360},70%,60%));">
                                    <i class="bi ${isEnrolled ? 'bi-check-circle-fill' : 'bi-mortarboard-fill'}" style="z-index:1;font-size:2.5rem;color:rgba(255,255,255,0.7);"></i>
                                </div>
                                <div class="p-3 flex-fill d-flex flex-column">
                                    <h5 class="fw-bold mb-2 mt-1" style="font-size:1.1rem;color:#1e293b;">${course.title}</h5>
                                    
                                    <div class="instructor-info">
                                        <img src="https://ui-avatars.com/api/?name=${course.instructor != null ? course.instructor.name : 'Faculty'}&background=random" class="instructor-avatar" alt="Instructor Profile">
                                        <span class="small text-muted fw-semibold">${course.instructor != null ? course.instructor.name : 'Unknown Faculty'}</span>
                                    </div>

                                    <p class="small text-muted mb-4" style="font-size:0.85rem;flex-grow:1;display:-webkit-box;-webkit-line-clamp:3;-webkit-box-orient:vertical;overflow:hidden;">
                                        ${course.description}
                                    </p>

                                    <!-- Actions -->
                                    <c:choose>
                                        <c:when test="${isEnrolled}">
                                            <a href="/s-start-course?id=${course.id}" class="btn btn-enrolled mt-auto">
                                                <i class="bi bi-play-circle-fill me-1"></i> Go to Course
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="/s-enroll" method="POST" class="mt-auto">
                                                <input type="hidden" name="course_id" value="${course.id}">
                                                <button type="button" class="btn btn-enroll" onclick="confirmEnroll(this.form, '${course.title.replaceAll('\'', '\\\'')}')">
                                                    <i class="bi bi-plus-circle me-1"></i> Enroll Now
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="sfooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function confirmEnroll(form, courseTitle) {
            Swal.fire({
                title: 'Confirm Enrollment',
                html: 'Are you sure you want to enroll in <b>' + courseTitle + '</b>?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3b82f6',
                cancelButtonColor: '#94a3b8',
                confirmButtonText: 'Yes, Enroll Me!'
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire({
                        title: 'Enrolling...',
                        text: 'Please wait',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });
                    form.submit();
                }
            });
        }
    </script>
</body>
</html>
