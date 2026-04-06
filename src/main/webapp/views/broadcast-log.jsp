<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Broadcast History | EduPro LMS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #4f46e5;
            --body-bg: #f1f5f9;
            --card-bg: #ffffff;
            --text-muted: #64748b;
        }
        body { background: var(--body-bg); font-family: 'Inter', system-ui, sans-serif; color: #1e293b; }

        /* Hero */
        .log-hero {
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 60%, #312e81 100%);
            padding: 4rem 0 7rem;
            border-radius: 0 0 40px 40px;
            margin-bottom: -4.5rem;
            box-shadow: 0 20px 50px rgba(15,23,42,0.2);
        }

        /* Glass card */
        .glass-card {
            background: var(--card-bg);
            border-radius: 20px;
            border: 1px solid rgba(0,0,0,0.06);
            box-shadow: 0 4px 20px rgba(0,0,0,0.04);
            transition: all 0.3s ease;
        }

        /* Log row */
        .log-row {
            background: #f8fafc;
            border-radius: 14px;
            padding: 1.25rem 1.5rem;
            margin-bottom: 0.75rem;
            border: 1px solid #e2e8f0;
            transition: all 0.25s ease;
            position: relative;
            overflow: hidden;
        }
        .log-row::before {
            content: '';
            position: absolute;
            left: 0; top: 0; bottom: 0;
            width: 4px;
            background: linear-gradient(180deg, var(--primary), #ec4899);
        }
        .log-row:hover {
            background: white;
            box-shadow: 0 8px 24px rgba(79,70,229,0.08);
            transform: translateX(4px);
        }

        .audience-pill {
            font-size: 0.72rem; font-weight: 700; padding: 0.3em 0.9em;
            border-radius: 50px; letter-spacing: 0.5px;
        }

        /* Stats mini row */
        .stat-mini {
            background: linear-gradient(135deg, rgba(79,70,229,0.06), rgba(236,72,153,0.04));
            border-radius: 16px;
            padding: 1.25rem;
            text-align: center;
            border: 1px solid rgba(79,70,229,0.1);
        }
        .stat-mini .num { font-size: 1.8rem; font-weight: 900; color: var(--primary); }
        .stat-mini .lbl { font-size: 0.75rem; color: var(--text-muted); font-weight: 700; text-transform: uppercase; letter-spacing: 1px; }

        /* Fade in */
        .fade-up { animation: fadeUp 0.6s forwards; opacity: 0; }
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        @keyframes fadeUp { from{opacity:0;transform:translateY(24px);} to{opacity:1;transform:translateY(0);} }

        .btn-gradient {
            background: linear-gradient(135deg, var(--primary), #ec4899);
            color: white; border: none; font-weight: 700; padding: 0.6rem 1.5rem; border-radius: 50px;
            transition: all 0.3s ease; box-shadow: 0 4px 15px rgba(79,70,229,0.25);
        }
        .btn-gradient:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(79,70,229,0.35); color: white; }
    </style>
</head>
<body>

    <jsp:include page="aheader.jsp" />

    <!-- Hero -->
    <div class="log-hero text-center">
        <div class="container fade-up delay-1">
            <span class="badge bg-white bg-opacity-10 text-white border border-white border-opacity-20 rounded-pill px-3 py-2 mb-3" style="backdrop-filter:blur(10px);">
                <i class="bi bi-broadcast-pin me-1"></i> Email Broadcast Center
            </span>
            <h1 class="display-5 fw-bold text-white mb-3" style="letter-spacing:-1px;">Broadcast History</h1>
            <p class="lead text-white mx-auto" style="max-width:560px;opacity:0.75;">
                Full log of all emails broadcast to platform users — audience, recipient count, and timestamp.
            </p>
        </div>
    </div>

    <div class="container mb-5">

        <!-- Summary Stats -->
        <div class="row g-4 mb-5 fade-up delay-2">
            <div class="col-12">
                <div class="glass-card p-4">
                    <div class="row g-3">
                        <div class="col-6 col-md-3">
                            <div class="stat-mini">
                                <div class="num" id="stat-total">
                                    <c:choose>
                                        <c:when test="${not empty broadcastLogs}">${broadcastLogs.size()}</c:when>
                                        <c:otherwise>0</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="lbl">Total Broadcasts</div>
                            </div>
                        </div>
                        <div class="col-6 col-md-3">
                            <div class="stat-mini">
                                <div class="num text-success" id="stat-recipients">
                                    <c:set var="totalR" value="0" />
                                    <c:forEach var="log" items="${broadcastLogs}">
                                        <c:set var="totalR" value="${totalR + log.recipient_count}" />
                                    </c:forEach>
                                    ${totalR}
                                </div>
                                <div class="lbl">Total Emails Sent</div>
                            </div>
                        </div>
                        <div class="col-6 col-md-3">
                            <div class="stat-mini">
                                <div class="num text-info">
                                    <c:choose>
                                        <c:when test="${not empty broadcastLogs}">${broadcastLogs[0].audience}</c:when>
                                        <c:otherwise>—</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="lbl">Last Audience</div>
                            </div>
                        </div>
                        <div class="col-6 col-md-3">
                            <div class="stat-mini">
                                <div class="num text-warning">
                                    <c:choose>
                                        <c:when test="${not empty broadcastLogs}">${broadcastLogs[0].recipient_count}</c:when>
                                        <c:otherwise>0</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="lbl">Last Broadcast Size</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Log Table -->
        <div class="row fade-up delay-3">
            <div class="col-12">
                <div class="glass-card p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
                        <div>
                            <h5 class="fw-bold mb-0 d-flex align-items-center gap-2">
                                <i class="bi bi-clock-history text-primary"></i> All Broadcast Logs
                            </h5>
                            <div class="small text-muted mt-1">Showing last 50 broadcasts — newest first</div>
                        </div>
                        <a href="/adashboard" class="btn btn-gradient">
                            <i class="bi bi-broadcast-pin me-1"></i> New Broadcast
                        </a>
                    </div>

                    <!-- Error message -->
                    <c:if test="${not empty logError}">
                        <div class="alert alert-warning rounded-3 d-flex align-items-center gap-2" role="alert">
                            <i class="bi bi-tools fs-5"></i>
                            <div>
                                <strong>Setup required:</strong> ${logError}
                                <br><small class="text-muted">Run the file: <code>broadcast_migration.sql</code> in your MySQL database.</small>
                            </div>
                        </div>
                    </c:if>

                    <!-- Search -->
                    <div class="mb-3" style="max-width:320px;">
                        <div class="position-relative">
                            <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted" style="font-size:0.85rem;"></i>
                            <input type="text" id="logSearch" class="form-control rounded-pill ps-5" placeholder="Search subject or audience...">
                        </div>
                    </div>

                    <!-- Logs -->
                    <div id="logContainer">
                        <c:choose>
                            <c:when test="${not empty broadcastLogs}">
                                <c:forEach var="log" items="${broadcastLogs}">
                                    <div class="log-row" data-subject="${log.subject}" data-audience="${log.audience}">
                                        <div class="d-flex align-items-start justify-content-between gap-3 flex-wrap">
                                            <div class="flex-grow-1">
                                                <div class="d-flex align-items-center gap-2 mb-1 flex-wrap">
                                                    <h6 class="fw-bold mb-0" style="font-size:0.95rem;">${log.subject}</h6>
                                                    <span class="audience-pill bg-primary bg-opacity-10 text-primary">${log.audience}</span>
                                                </div>
                                                <p class="text-muted small mb-2" style="font-size:0.82rem;line-height:1.5;max-width:600px;">
                                                    <c:out value="${log.message}" />
                                                </p>
                                                <div class="d-flex gap-3 flex-wrap">
                                                    <span class="small text-muted">
                                                        <i class="bi bi-calendar3 me-1"></i> ${log.sent_at}
                                                    </span>
                                                    <span class="small fw-bold text-success">
                                                        <i class="bi bi-people-fill me-1"></i> ${log.recipient_count} recipients
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="text-center" style="flex-shrink:0;">
                                                <div style="width:52px;height:52px;border-radius:14px;background:linear-gradient(135deg,rgba(79,70,229,0.1),rgba(236,72,153,0.1));display:flex;align-items:center;justify-content:center;font-size:1.25rem;">
                                                    📢
                                                </div>
                                                <div class="small text-muted mt-1" style="font-size:0.68rem;">#${log.id}</div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="bi bi-inbox text-muted" style="font-size:3rem;"></i>
                                    <p class="text-muted mt-3">No broadcasts sent yet.</p>
                                    <a href="/adashboard" class="btn btn-gradient">Send First Broadcast</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div id="noLogMsg" class="text-center py-4 d-none">
                            <i class="bi bi-search text-muted" style="font-size:2rem;"></i>
                            <p class="text-muted mt-2">No broadcasts match your search.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <jsp:include page="afooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Log search
        document.getElementById('logSearch').addEventListener('input', function() {
            const q = this.value.toLowerCase();
            const rows = document.querySelectorAll('.log-row');
            let visible = 0;
            rows.forEach(r => {
                const subj = (r.getAttribute('data-subject') || '').toLowerCase();
                const aud  = (r.getAttribute('data-audience') || '').toLowerCase();
                if (!q || subj.includes(q) || aud.includes(q)) { r.style.display = ''; visible++; }
                else { r.style.display = 'none'; }
            });
            document.getElementById('noLogMsg').classList.toggle('d-none', visible > 0);
        });
    </script>
</body>
</html>
