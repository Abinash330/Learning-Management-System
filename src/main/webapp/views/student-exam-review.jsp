<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review ${exam.title} | Exam Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    
    <style>
        :root {
            --glass-bg: rgba(255, 255, 255, 0.85);
            --primary-gradient: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
            --accent-color: #8b5cf6;
            --success-color: #10b981;
            --danger-color: #ef4444;
        }

        body {
            background: #f8fafc;
            font-family: 'Outfit', sans-serif;
            color: #1e293b;
        }

        .portal-header {
            background: white;
            border-bottom: 1px solid #e2e8f0;
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .score-box {
            background: #f0fdf4;
            color: #166534;
            padding: 8px 15px;
            border-radius: 12px;
            font-weight: 800;
            font-size: 1.2rem;
            display: inline-flex;
            align-items: center;
        }

        .question-card {
            background: white;
            border-radius: 24px;
            border: 1px solid #e2e8f0;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.02);
            margin-bottom: 30px;
        }

        .option-item {
            background: #f1f5f9;
            border-radius: 16px;
            padding: 15px 20px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            border: 2px solid transparent;
        }

        .option-item.correct {
            background: #ecfdf5;
            border-color: var(--success-color);
            color: #065f46;
        }

        .option-item.incorrect {
            background: #fef2f2;
            border-color: var(--danger-color);
            color: #991b1b;
        }

        .question-num {
            width: 40px;
            height: 40px;
            background: #f1f5f9;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            color: var(--accent-color);
        }

        .btn-portal {
            border-radius: 14px;
            padding: 12px 25px;
            font-weight: 700;
            transition: 0.3s;
        }
    </style>
</head>
<body>

    <header class="portal-header shadow-sm">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <img src="/img/logo.png" height="30" class="me-3 d-none d-md-block" onerror="this.src='https://illustrations.popsy.co/gray/book.svg'">
                <div>
                    <div class="fw-800 h5 mb-0">${exam.title} - Review</div>
                    <small class="text-muted">${exam.course.title}</small>
                </div>
            </div>
            
            <div class="d-flex align-items-center gap-4">
                <div class="score-box">
                    <i class="bi bi-trophy-fill me-2"></i>
                    <span>Score: ${result.score} / ${exam.totalMarks}</span>
                </div>
                <a href="/student/exams" class="btn btn-secondary btn-portal">
                    Back to Dashboard
                </a>
            </div>
        </div>
    </header>

    <div class="container py-5 mt-2">
        <c:forEach var="q" items="${questions}" varStatus="status">
            <c:set var="studentSelectedId" value="${selectedOptionsMap[q.id]}" />
            
            <div class="question-card animate__animated animate__fadeInUp" style="animation-delay: ${status.index * 0.1}s">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="d-flex align-items-center">
                        <div class="question-num me-3">Q${status.count}</div>
                        <h5 class="fw-600 mb-0">${q.text}</h5>
                    </div>
                    <span class="badge bg-light text-primary rounded-pill px-3 py-2">${q.marks} Marks</span>
                </div>
                
                <div class="option-container mt-3">
                    <c:forEach var="opt" items="${questionOptions[q.id]}">
                        <c:choose>
                            <c:when test="${opt.isCorrect}">
                                <!-- The Correct Option -->
                                <div class="option-item correct fw-600">
                                    <i class="bi bi-check-circle-fill text-success me-3 fs-5"></i>
                                    <span class="flex-grow-1">${opt.text}</span>
                                    <c:if test="${studentSelectedId == opt.id}">
                                        <span class="badge bg-success ms-2">Your Answer</span>
                                    </c:if>
                                </div>
                            </c:when>
                            <c:when test="${!opt.isCorrect && studentSelectedId == opt.id}">
                                <!-- The Incorrect Option Chosen by Student -->
                                <div class="option-item incorrect fw-600">
                                    <i class="bi bi-x-circle-fill text-danger me-3 fs-5"></i>
                                    <span class="flex-grow-1">${opt.text}</span>
                                    <span class="badge bg-danger ms-2">Your Answer</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Other Options -->
                                <div class="option-item">
                                    <i class="bi bi-circle text-muted me-3 fs-5"></i>
                                    <span>${opt.text}</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${empty studentSelectedId}">
                        <div class="mt-3 text-danger fw-600">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> You did not answer this question.
                        </div>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
