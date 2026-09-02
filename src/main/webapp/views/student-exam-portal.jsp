<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${exam.title} | Secure Exam Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    
    <style>
        :root {
            --glass-bg: rgba(255, 255, 255, 0.9);
            --primary-gradient: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            --danger-gradient: linear-gradient(135deg, #ef4444 0%, #b91c1c 100%);
            --accent-color: #6366f1;
            --sidebar-width: 300px;
        }

        body {
            background: #f1f5f9;
            font-family: 'Outfit', sans-serif;
            color: #0f172a;
            user-select: none;
            -webkit-user-select: none;
            overflow-x: hidden;
        }

        /* Fullscreen Overlay Style */
        #startOverlay, #violationOverlay, #submittingOverlay {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: white;
            z-index: 9999;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 20px;
        }

        #violationOverlay {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            display: none;
        }

        #submittingOverlay {
            background: rgba(79, 70, 229, 0.9);
            color: white;
            display: none;
        }

        .portal-header {
            background: white;
            border-bottom: 2px solid #e2e8f0;
            padding: 12px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            backdrop-filter: blur(8px);
        }

        .timer-box {
            padding: 10px 20px;
            border-radius: 14px;
            font-weight: 800;
            font-size: 1.25rem;
            display: inline-flex;
            align-items: center;
            transition: all 0.5s ease;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .timer-safe { background: #f0fdf4; color: #166534; }
        .timer-warning { background: #fffbeb; color: #92400e; }
        .timer-danger { background: #fef2f2; color: #991b1b; border: 2px solid #ef4444; }

        .question-card {
            background: white;
            border-radius: 28px;
            border: 1px solid #e2e8f0;
            padding: 45px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05);
            display: none;
            min-height: 400px;
        }

        .question-card.active {
            display: block;
        }

        .option-item {
            background: #f8fafc;
            border-radius: 18px;
            padding: 18px 24px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            border: 2px solid transparent;
        }

        .option-item:hover {
            transform: translateX(8px);
            background: #f1f5f9;
        }

        .option-item.selected {
            background: #eef2ff;
            border-color: var(--accent-color);
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.1);
        }

        .option-item input { display: none; }

        .nav-btn {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            cursor: pointer;
            margin: 6px;
            transition: 0.2s;
        }

        .nav-btn.answered { background: #dcfce7; color: #166534; border-color: #86efac; }
        .nav-btn.active { 
            background: var(--accent-color); 
            color: white; 
            border-color: var(--accent-color); 
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
            transform: scale(1.1);
        }

        .progress-pill {
            background: #f1f5f9;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            color: #64748b;
        }

        .btn-portal {
            border-radius: 16px;
            padding: 14px 32px;
            font-weight: 700;
            letter-spacing: -0.01em;
            transition: all 0.3s;
        }

        .btn-primary-portal {
            background: var(--primary-gradient);
            border: none;
            color: white;
            box-shadow: 0 8px 15px rgba(79, 70, 229, 0.25);
        }

        .btn-primary-portal:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 20px rgba(79, 70, 229, 0.35);
        }
        
        /* Pulse for last minute */
        .pulse-danger {
            animation: pulse-red 1s infinite alternate;
        }
        
        @keyframes pulse-red {
            from { box-shadow: 0 0 5px #ef4444; }
            to { box-shadow: 0 0 20px #ef4444; }
        }
    </style>
</head>
<body oncontextmenu="return false;">

<!-- START OVERLAY -->
<div id="startOverlay">
    <div class="animate__animated animate__zoomIn">
        <img src="https://illustrations.popsy.co/gray/work-from-home.svg" style="width: 280px;" class="mb-4">
        <h1 class="fw-800 mb-3">Welcome to the Exam Portal</h1>
        <p class="text-muted mb-4 mx-auto" style="max-width: 500px;">
            To ensure a fair testing environment, this exam requires <b>Fullscreen Mode</b>. 
            Exiting fullscreen or switching tabs will be flagged as a security violation.
        </p>
        <button type="button" class="btn btn-primary-portal btn-portal px-5" onclick="enterFullscreen()">
            I Understand, Start Exam
        </button>
    </div>
</div>

<!-- VIOLATION OVERLAY -->
<div id="violationOverlay">
    <div class="animate__animated animate__headShake">
        <i class="bi bi-exclamation-triangle-fill text-danger display-1 mb-4"></i>
        <h2 class="fw-800">Security Violation!</h2>
        <p class="text-muted mb-4" id="violationMessage">Please return to Fullscreen mode to continue.</p>
        <button type="button" class="btn btn-danger btn-portal" onclick="enterFullscreen()">
            Resume Exam
        </button>
    </div>
</div>

<!-- SUBMITTING OVERLAY -->
<div id="submittingOverlay">
    <div class="spinner-border mb-4" style="width: 4rem; height: 4rem;" role="status"></div>
    <h2 class="fw-800">Submitting Your Answers...</h2>
    <p>Please wait while we secure your responses. Do not close this window.</p>
</div>

<form id="examForm" action="/student/exams/submit" method="post">
    <input type="hidden" name="examId" value="${exam.id}">

    <header class="portal-header shadow-sm">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <div class="bg-primary text-white p-2 rounded-3 me-3">
                    <i class="bi bi-journal-text h4 mb-0"></i>
                </div>
                <div>
                    <div class="fw-800 h5 mb-0">${exam.title}</div>
                    <div class="d-flex align-items-center gap-2">
                        <small class="text-muted">${exam.course.title}</small>
                        <span class="progress-pill" id="progressText">0 / ${questions.size()} Answered</span>
                    </div>
                </div>
            </div>
            
            <div class="d-flex align-items-center gap-4">
                <div id="timerContainer" class="timer-box timer-safe">
                    <i class="bi bi-clock-fill me-2"></i>
                    <span id="timer">${exam.timeLimit}:00</span>
                </div>
                <button type="button" class="btn btn-danger btn-portal d-none d-md-block" data-bs-toggle="modal" data-bs-target="#submitModal">
                    Finish Exam
                </button>
            </div>
        </div>
    </header>

    <div class="container py-5 mt-2">
        <div class="row">
            <!-- Sidebar Navigation -->
            <div class="col-lg-3 mb-4 order-lg-2">
                <div class="bg-white p-4 rounded-4 border shadow-sm sticky-top" style="top: 100px;">
                    <h6 class="fw-800 mb-3 text-uppercase small tracking-wider">Navigation</h6>
                    <div class="d-flex flex-wrap mb-4" id="navigator">
                        <c:forEach var="q" items="${questions}" varStatus="status">
                            <div class="nav-btn" data-index="${status.index}" id="nav-${status.index}" onclick="showQuestion(${status.index})">
                                ${status.count}
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div class="p-3 bg-light rounded-3 d-flex align-items-center gap-3">
                        <div class="bg-white p-2 rounded-circle shadow-sm">
                            <i class="bi bi-shield-check text-primary"></i>
                        </div>
                        <div>
                            <div class="fw-700 small">Proctoring Active</div>
                            <div class="text-muted smaller" style="font-size: 0.7rem;">Session is being monitored</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Question Area -->
            <div class="col-lg-9 order-lg-1">
                <c:forEach var="q" items="${questions}" varStatus="status">
                    <div class="question-card animate__animated animate__fadeIn" id="q-${status.index}">
                        <div class="d-flex justify-content-between align-items-start mb-4">
                            <span class="badge bg-indigo-100 text-indigo-700 rounded-pill px-3 py-2 fw-800">Question ${status.count}</span>
                            <span class="text-muted small fw-600">${q.marks} Points</span>
                        </div>
                        
                        <h3 class="fw-700 mb-5 leading-tight">${q.text}</h3>
                        
                        <div class="option-container">
                            <c:forEach var="opt" items="${questionOptions[q.id]}">
                                <label class="option-item" onclick="selectOption(this, ${status.index})">
                                    <input type="radio" name="question_${q.id}" value="${opt.id}">
                                    <span class="fw-600">${opt.text}</span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>

                <div class="d-flex justify-content-between mt-5 pt-3">
                    <button type="button" id="prevBtn" class="btn btn-light btn-portal border px-4" onclick="navigate(-1)">
                        <i class="bi bi-arrow-left me-2"></i>Back
                    </button>
                    <button type="button" id="nextBtn" class="btn btn-primary-portal btn-portal px-5" onclick="navigate(1)">
                        Next <i class="bi bi-arrow-right ms-2"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Submit Confirmation Modal -->
    <div class="modal fade" id="submitModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 rounded-4 p-5 shadow-lg text-center">
                <div class="mb-4">
                    <div class="bg-primary bg-opacity-10 d-inline-block p-4 rounded-circle">
                        <i class="bi bi-cloud-arrow-up text-primary h1 mb-0"></i>
                    </div>
                </div>
                <h2 class="fw-800">Ready to Submit?</h2>
                <p class="text-muted">You have answered <span id="answeredCountModal">0</span> out of ${questions.size()} questions. Final submission is irreversible.</p>
                <div class="d-grid gap-3 mt-5">
                    <button type="submit" class="btn btn-primary-portal btn-portal" onclick="showSubmitting()">Yes, Submit My Final Answers</button>
                    <button type="button" class="btn btn-light btn-portal" data-bs-dismiss="modal">I'll Keep Working</button>
                </div>
            </div>
        </div>
    </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let currentQ = 0;
    const totalQ = ${questions.size()};
    let timeLeft = ${exam.timeLimit} * 60;
    let cheatCount = 0;
    const MAX_VIOLATIONS = 3;
    let examStarted = false;

    // --- PROCTORING LOGIC ---

    function enterFullscreen() {
        const docEl = document.documentElement;
        if (docEl.requestFullscreen) {
            docEl.requestFullscreen().catch(err => {
                console.error("Error attempting to enable full-screen mode:", err);
            });
        } else if (docEl.webkitRequestFullscreen) {
            docEl.webkitRequestFullscreen();
        }
        
        document.getElementById('startOverlay').style.display = 'none';
        document.getElementById('violationOverlay').style.display = 'none';
        examStarted = true;
    }

    document.addEventListener("fullscreenchange", () => {
        if (!document.fullscreenElement && examStarted) {
            showViolation("Fullscreen mode exited! Please return to fullscreen immediately or the exam will be auto-submitted.");
        }
    });

    document.addEventListener("visibilitychange", () => {
        if (document.hidden && examStarted) {
            cheatCount++;
            if (cheatCount >= MAX_VIOLATIONS) {
                alert("FINAL WARNING: Absolute Integrity Violation. Multiple tab switches detected. Automatic submission triggered.");
                document.getElementById('examForm').submit();
            } else {
                alert("Security Warning (" + cheatCount + "/" + MAX_VIOLATIONS + "): You switched tabs. This has been logged. Staying on this page is MANDATORY.");
            }
        }
    });

    // Disable copy, paste, and function keys
    document.addEventListener('keydown', (e) => {
        // Disable F12, Ctrl+Shift+I, Ctrl+U, etc.
        if (e.keyCode === 123 || (e.ctrlKey && e.shiftKey && (e.keyCode === 73 || e.keyCode === 74)) || (e.ctrlKey && e.keyCode === 85)) {
            e.preventDefault();
            return false;
        }
        // Disable Copy/Paste
        if (e.ctrlKey && (e.keyCode === 67 || e.keyCode === 86)) {
            e.preventDefault();
            return false;
        }
    });

    function showViolation(msg) {
        document.getElementById('violationMessage').innerText = msg;
        document.getElementById('violationOverlay').style.display = 'flex';
    }

    window.onbeforeunload = function() {
        if (examStarted) {
            return "Exam is in progress! Any unsaved changes will be lost.";
        }
    };

    // --- EXAM NAVIGATION LOGIC ---

    function showQuestion(index) {
        document.querySelectorAll('.question-card').forEach(c => c.classList.remove('active'));
        document.getElementById('q-' + index).classList.add('active');
        
        document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
        document.getElementById('nav-' + index).classList.add('active');
        
        currentQ = index;
        
        document.getElementById('prevBtn').disabled = (currentQ === 0);
        document.getElementById('nextBtn').innerHTML = (currentQ === totalQ - 1) ? 'Review & Finish <i class="bi bi-check-circle ms-2"></i>' : 'Next Question <i class="bi bi-arrow-right ms-2"></i>';
    }

    function navigate(step) {
        let next = currentQ + step;
        if (next >= 0 && next < totalQ) {
            showQuestion(next);
        } else if (next === totalQ) {
            updateProgress();
            new bootstrap.Modal(document.getElementById('submitModal')).show();
        }
    }

    function selectOption(el, index) {
        const parent = el.closest('.option-container');
        parent.querySelectorAll('.option-item').forEach(i => i.classList.remove('selected'));
        el.classList.add('selected');
        
        // Mark navigator as answered
        document.getElementById('nav-' + index).classList.add('answered');
        updateProgress();
    }

    function updateProgress() {
        const answeredItems = document.querySelectorAll('.nav-btn.answered').length;
        document.getElementById('progressText').innerText = answeredItems + ' / ' + totalQ + ' Answered';
        document.getElementById('answeredCountModal').innerText = answeredItems;
    }

    function showSubmitting() {
        examStarted = false; // Disable beforeunload
        document.getElementById('submittingOverlay').style.display = 'flex';
        // Form will submit normally
    }

    // --- TIMER LOGIC ---

    const timerDisplay = document.getElementById('timer');
    const timerContainer = document.getElementById('timerContainer');
    
    const interval = setInterval(() => {
        if (!examStarted) return;
        
        timeLeft--;
        let minutes = Math.floor(timeLeft / 60);
        let seconds = timeLeft % 60;
        timerDisplay.innerText = minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
        
        // Timer color logic
        if (timeLeft <= 300 && timeLeft > 60) {
            timerContainer.className = 'timer-box timer-warning animate__animated animate__pulse animate__infinite';
        } else if (timeLeft <= 60) {
            timerContainer.className = 'timer-box timer-danger pulse-danger';
        }

        if (timeLeft <= 0) {
            clearInterval(interval);
            showSubmitting();
            document.getElementById('examForm').submit();
        }
    }, 1000);

    // Initial State
    showQuestion(0);
    
    // Prevent back button
    window.history.pushState(null, null, window.location.href);
    window.onpopstate = function () {
        window.history.go(1);
    };
</script>

</body>
</html>
