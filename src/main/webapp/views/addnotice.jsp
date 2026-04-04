<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publisher | EduPro LMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary: #f97316; /* Orange for broadcast */
            --dark-bg: #0f172a;
            --body-bg: #f8fafc;
        }
        body {
            background-color: var(--body-bg);
            font-family: 'Inter', system-ui, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-wrapper {
            flex-grow: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 4rem 1rem;
        }
        .publisher-card {
            background: white; border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.08); border: 1px solid rgba(0,0,0,0.05);
            width: 100%; max-width: 800px;
            display: flex; overflow: hidden;
        }
        .sidebar-brand {
            background: linear-gradient(135deg, #ea580c, #f97316);
            color: white; padding: 3rem 2rem; width: 35%;
            display: flex; flex-direction: column; justify-content: center;
        }
        .form-area {
            padding: 3rem; width: 65%;
        }
        .input-custom {
            border-radius: 12px; border: 2px solid #e2e8f0; padding: 1rem 1rem;
            background: #f8fafc; font-weight: 500; font-size: 1rem;
        }
        .input-custom:focus {
            border-color: var(--primary); background: white; box-shadow: 0 0 0 4px rgba(249,115,22,0.1); outline: none;
        }
    </style>
</head>
<body>
    <jsp:include page="aheader.jsp" />
    
    <div class="main-wrapper">
        <div class="publisher-card">
            
            <div class="sidebar-brand">
                <i class="bi bi-broadcast-pin text-white mb-3" style="font-size: 3rem;"></i>
                <h2 class="fw-bold mb-3">Notice Publisher</h2>
                <p class="opacity-75">Broadcast essential alerts, curriculum updates, and schedules directly to the student portal.</p>
                <div class="mt-auto">
                    <a href="/adashboard" class="text-white text-decoration-none fw-bold">
                        <i class="bi bi-arrow-left me-1"></i> Dashboard
                    </a>
                </div>
            </div>

            <div class="form-area">
                
                <c:if test="${not empty message}">
                    <div class="alert alert-success d-flex align-items-center mb-4 border-0 rounded-3" style="background:#fff7ed; color:#c2410c;">
                        <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                        <div class="fw-bold">${message}</div>
                    </div>
                </c:if>

                <form action="/addnotice" method="post">
                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark">Announcement Title</label>
                        <input type="text" name="title" class="form-control input-custom" placeholder="e.g., Mid-Term Examination Schedule" required>
                    </div>

                    <div class="mb-5">
                        <label class="form-label fw-bold text-dark">Detailed Description</label>
                        <textarea name="description" class="form-control input-custom" rows="6" placeholder="Provide full context here..." required></textarea>
                        <div class="small text-muted mt-2"><i class="bi bi-info-circle me-1"></i> This notice will be time-stamped automatically upon publishing.</div>
                    </div>

                    <button type="submit" class="btn fw-bold w-100 py-3 rounded-3 text-white" style="background: var(--primary); box-shadow: 0 4px 15px rgba(249,115,22,0.3);">
                        Publish to Portal <i class="bi bi-send-fill ms-2"></i>
                    </button>
                </form>
            </div>

        </div>
    </div>
    
    <jsp:include page="afooter.jsp" />
</body>
</html>