<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <jsp:include page="../fheader.jsp" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/bootstrap.min.css" />
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
            min-height: 100vh;
        }

        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.05);
        }

        .hero-section {
            background: var(--primary-gradient);
            color: white;
            padding: 60px 0 100px;
            border-radius: 0 0 40px 40px;
            margin-bottom: -60px;
        }

        .exam-btn {
            background: var(--primary-gradient);
            border: none;
            color: white;
            transition: 0.3s;
        }

        .exam-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
            color: white;
        }

        .status-badge {
            font-size: 0.75rem;
            padding: 5px 12px;
            border-radius: 20px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .status-draft {
            background: #e5e7eb;
            color: #4b5563;
        }

        .status-live {
            background: #dcfce7;
            color: #166534;
        }
    </style>

    <div class="hero-section text-center">
        <div class="container">
            <h1 class="fw-800">Exam Management</h1>
            <p class="opacity-75">Create and manage your course examinations</p>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row">
            <!-- Create Exam Sidebar -->
            <div class="col-lg-4 mb-4">
                <div class="glass-card p-4 sticky-top" style="top: 20px;">
                    <h4 class="fw-800 mb-4">Create New Exam</h4>
                    <form action="/faculty/exams/create" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-600">Exam Title</label>
                            <input type="text" name="title" class="form-control rounded-3"
                                placeholder="e.g. Midterm 2024" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-600">Course</label>
                            <select name="courseId" class="form-select rounded-3" required>
                                <c:forEach var="course" items="${courses}">
                                    <option value="${course.id}">${course.title}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="row">
                            <div class="col-6 mb-3">
                                <label class="form-label fw-600">Total Marks</label>
                                <input type="number" name="totalMarks" class="form-control rounded-3" value="100"
                                    required>
                            </div>
                            <div class="col-6 mb-3">
                                <label class="form-label fw-600">Duration (Min)</label>
                                <input type="number" name="timeLimit" class="form-control rounded-3" value="60"
                                    required>
                            </div>
                        </div>
                        <button type="submit" class="btn exam-btn w-100 rounded-pill py-2 fw-600 mt-2">
                            Create Exam & Add Questions
                        </button>
                    </form>
                </div>
            </div>

            <!-- Exam List -->
            <div class="col-lg-8">
                <div class="glass-card p-4">
                    <h4 class="fw-800 mb-4">Your Exams</h4>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success border-0 rounded-4 shadow-sm mb-4">
                            <i class="bi bi-check-circle-fill me-2"></i> ${message}
                        </div>
                    </c:if>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="text-muted">
                                <tr>
                                    <th>Exam Details</th>
                                    <th>Marks/Time</th>
                                    <th>Status</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="exam" items="${exams}">
                                    <tr>
                                        <td>
                                            <div class="fw-800">${exam.title}</div>
                                            <small class="text-muted">${exam.course.title}</small>
                                        </td>
                                        <td>
                                            <span class="badge bg-light text-dark rounded-pill">${exam.totalMarks}
                                                Marks</span><br>
                                            <small class="text-muted">${exam.timeLimit} Min</small>
                                        </td>
                                        <td>
                                            <span
                                                class="status-badge ${exam.status == 'Live' ? 'status-live' : 'status-draft'}">
                                                ${exam.status}
                                            </span>
                                        </td>
                                        <td class="text-end">
                                            <div class="d-flex justify-content-end gap-2">
                                                <a href="/faculty/exams/questions/${exam.id}"
                                                    class="btn btn-sm btn-outline-primary rounded-pill px-3">
                                                    Questions
                                                </a>
                                                <form action="/faculty/exams/status/toggle/${exam.id}" method="post">
                                                    <button type="submit"
                                                        class="btn btn-sm ${exam.status == 'Live' ? 'btn-outline-warning' : 'btn-outline-success'} rounded-pill px-3">
                                                        ${exam.status == 'Live' ? 'Deactivate' : 'Go Live'}
                                                    </button>
                                                </form>
                                                <form action="/faculty/exams/delete/${exam.id}" method="post"
                                                    onsubmit="return confirm('Delete this exam?')">
                                                    <button type="submit"
                                                        class="btn btn-sm btn-outline-danger rounded-pill px-3">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty exams}">
                                    <tr>
                                        <td colspan="4" class="text-center py-5">
                                            <img src="https://illustrations.popsy.co/gray/exam.svg"
                                                style="width: 120px;" class="mb-3 opacity-50"><br>
                                            <p class="text-muted">No exams created yet.</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../footer.jsp" />