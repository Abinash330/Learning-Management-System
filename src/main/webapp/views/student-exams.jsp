<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Exams | EduPro Student</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --glass-bg: rgba(255, 255, 255, 0.75);
            --glass-border: rgba(255, 255, 255, 0.4);
            --primary-gradient: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
        }

        body {
            background: radial-gradient(circle at top right, #f3f4f6, #e5e7eb);
            font-family: 'Outfit', sans-serif;
        }

        .hero-section {
            background: var(--primary-gradient);
            color: white;
            padding: 80px 0 120px;
            border-radius: 0 0 40px 40px;
            margin-bottom: -60px;
        }

        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            transition: 0.3s;
        }

        .exam-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .btn-take {
            background: var(--primary-gradient);
            border: none;
            color: white;
            font-weight: 600;
        }

        .btn-take:hover {
            color: white;
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
        }
    </style>
</head>
<body>
    <jsp:include page="sheader.jsp" />

    <div class="hero-section text-center">
        <div class="container">
            <h1 class="fw-800">My Examinations</h1>
            <p class="opacity-75">View and take active exams for your enrolled courses</p>
        </div>
    </div>

    <div class="container pb-5">
        <c:if test="${not empty message}">
            <div class="alert alert-success border-0 rounded-4 shadow-sm mb-4">
                <i class="bi bi-check-circle-fill me-2"></i> ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger border-0 rounded-4 shadow-sm mb-4">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
            </div>
        </c:if>

        <div class="row">
            <c:forEach var="exam" items="${exams}">
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="glass-card p-4 h-100 exam-card d-flex flex-column">
                        <div class="d-flex justify-content-between mb-3">
                            <span class="badge bg-light text-primary rounded-pill px-3">${exam.course.title}</span>
                            <div class="text-muted small"><i class="bi bi-clock me-1"></i>${exam.timeLimit} Min</div>
                        </div>
                        <h4 class="fw-800 mb-2">${exam.title}</h4>
                        <p class="text-muted small mb-4">Faculty: ${exam.faculty.name}</p>

                        <div class="mt-auto">
                            <c:choose>
                                <c:when test="${not empty resultsMap[exam.id]}">
                                    <div class="p-3 bg-light rounded-4 text-center">
                                        <div class="small text-muted">Result</div>
                                        <div class="h4 fw-800 text-success mb-0">${resultsMap[exam.id].score} / ${exam.totalMarks}</div>
                                        <span class="badge bg-success bg-opacity-10 text-success mt-2">Completed</span>
                                        <a href="/student/exams/review/${exam.id}" class="btn btn-sm btn-outline-primary rounded-pill mt-3 w-100">Review Exam</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <a href="/student/exams/portal/${exam.id}"
                                        class="btn btn-take w-100 rounded-pill py-2">
                                        Start Examination
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty exams}">
                <div class="col-12 text-center py-5">
                    <img src="https://illustrations.popsy.co/gray/exam.svg" style="width: 200px;"
                        class="mb-4 opacity-75">
                    <h3 class="fw-800 text-muted">No Active Exams</h3>
                    <p class="text-muted">Check back later or contact your instructor for exam schedules.</p>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="sfooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>