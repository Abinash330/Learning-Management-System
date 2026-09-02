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
        }

        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.05);
        }

        .question-card {
            border-left: 5px solid #6366f1;
            transition: 0.3s;
        }

        .question-card:hover {
            transform: translateX(5px);
        }

        .option-input {
            border-radius: 12px;
        }

        .btn-gradient {
            background: var(--primary-gradient);
            border: none;
            color: white;
            font-weight: 600;
        }

        .btn-gradient:hover {
            color: white;
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
        }
    </style>

    <div class="container py-5">
        <div class="mb-4 d-flex justify-content-between align-items-center">
            <div>
                <h2 class="fw-800 mb-1">Add Questions to ${exam.title}</h2>
                <p class="text-muted">${exam.course.title} | ${exam.totalMarks} Total Marks</p>
            </div>
            <a href="/faculty/exams" class="btn btn-outline-secondary rounded-pill px-4">
                <i class="bi bi-arrow-left me-2"></i>Back to Exams
            </a>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success border-0 rounded-4 shadow-sm mb-4 animate__animated animate__fadeIn">
                <i class="bi bi-check-circle-fill me-2"></i> ${message}
            </div>
        </c:if>

        <div class="row">
            <!-- Question Form -->
            <div class="col-lg-5 mb-4">
                <div class="glass-card p-4 sticky-top" style="top: 20px;">
                    <h4 class="fw-800 mb-4" id="formTitle">Add Question</h4>
                    <form action="/faculty/exams/questions/save" method="post" id="questionForm">
                        <input type="hidden" name="examId" value="${exam.id}">
                        <input type="hidden" name="questionId" id="qId">

                        <div class="mb-3">
                            <label class="form-label fw-600">Question Text</label>
                            <textarea name="text" id="qText" class="form-control rounded-3" rows="3" required
                                placeholder="Type your question here..."></textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-600">Marks for this question</label>
                            <input type="number" name="marks" id="qMarks" class="form-control rounded-3" value="1"
                                required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-600 d-block mb-3">Options (Select the correct one)</label>

                            <div class="input-group mb-2">
                                <div class="input-group-text bg-transparent border-0">
                                    <input class="form-check-input mt-0" type="radio" name="correctOptionIndex"
                                        value="0" required>
                                </div>
                                <input type="text" name="options" class="form-control option-input"
                                    placeholder="Option A" required>
                            </div>

                            <div class="input-group mb-2">
                                <div class="input-group-text bg-transparent border-0">
                                    <input class="form-check-input mt-0" type="radio" name="correctOptionIndex"
                                        value="1">
                                </div>
                                <input type="text" name="options" class="form-control option-input"
                                    placeholder="Option B" required>
                            </div>

                            <div class="input-group mb-2">
                                <div class="input-group-text bg-transparent border-0">
                                    <input class="form-check-input mt-0" type="radio" name="correctOptionIndex"
                                        value="2">
                                </div>
                                <input type="text" name="options" class="form-control option-input"
                                    placeholder="Option C" required>
                            </div>

                            <div class="input-group mb-2">
                                <div class="input-group-text bg-transparent border-0">
                                    <input class="form-check-input mt-0" type="radio" name="correctOptionIndex"
                                        value="3">
                                </div>
                                <input type="text" name="options" class="form-control option-input"
                                    placeholder="Option D" required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-gradient w-100 rounded-pill py-2 mt-2">
                            Save Question
                        </button>
                        <button type="button" onclick="resetForm()" class="btn btn-light w-100 rounded-pill py-2 mt-2">
                            Reset Form
                        </button>
                    </form>
                </div>
            </div>

            <!-- Question List -->
            <div class="col-lg-7">
                <div class="glass-card p-4">
                    <h4 class="fw-800 mb-4">Saved Questions (${questions.size()})</h4>
                    <div id="qList">
                        <c:forEach var="q" items="${questions}" varStatus="status">
                            <div class="glass-card p-3 mb-3 question-card">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div class="fw-600">Q${status.count}. ${q.text}</div>
                                    <span class="badge bg-light text-primary rounded-pill">${q.marks} Marks</span>
                                </div>
                                <!-- Needs logic to fetch options for each question from backend if we want to show them here -->
                                <div class="d-flex gap-2 mt-3">
                                    <button class="btn btn-sm btn-light rounded-pill px-3"
                                        onclick="editQuestion(${q.id}, '${q.text}', ${q.marks})">
                                        <i class="bi bi-pencil me-1"></i>Edit
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger rounded-pill px-3">
                                        <i class="bi bi-trash me-1"></i>Delete
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty questions}">
                            <div class="text-center py-5">
                                <p class="text-muted">No questions added yet.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function resetForm() {
            document.getElementById('formTitle').innerText = 'Add Question';
            document.getElementById('qId').value = '';
            document.getElementById('qText').value = '';
            document.getElementById('qMarks').value = 1;
            document.getElementById('questionForm').reset();
        }

        function editQuestion(id, text, marks) {
            document.getElementById('formTitle').innerText = 'Edit Question';
            document.getElementById('qId').value = id;
            document.getElementById('qText').value = text;
            document.getElementById('qMarks').value = marks;

            fetch('/faculty/exams/questions/' + id + '/options')
                .then(res => res.json())
                .then(options => {
                    const inputs = document.querySelectorAll('input[name="options"]');
                    const radios = document.querySelectorAll('input[name="correctOptionIndex"]');

                    inputs.forEach(input => input.value = '');
                    radios.forEach(radio => radio.checked = false);

                    options.forEach((opt, index) => {
                        if (index < inputs.length) {
                            inputs[index].value = opt.text;
                            radios[index].checked = opt.isCorrect;
                        }
                    });
                })
                .catch(err => console.error("Error fetching options:", err));
        }
    </script>

    <jsp:include page="../footer.jsp" />