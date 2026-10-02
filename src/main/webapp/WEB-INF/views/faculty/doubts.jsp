<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Doubts – Faculty</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root { --teal: #00f2fe; --blue: #4facfe; --dark: #0f172a; --card: #1e293b; }
        body { background: var(--dark); color: #e2e8f0; font-family: 'Inter', sans-serif; min-height: 100vh; }

        .page-hero {
            background: linear-gradient(135deg, #0f172a, #1a1f3c);
            border-bottom: 1px solid rgba(79,172,254,0.15);
            padding: 2rem 0 1.5rem;
        }
        .page-hero h1 { font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 2rem; }
        .page-hero h1 span { background: linear-gradient(135deg, #4facfe, #00f2fe); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }

        .stat-chip {
            background: rgba(79,172,254,0.09); border: 1px solid rgba(79,172,254,0.22);
            border-radius: 12px; padding: 0.5rem 1rem; display: inline-flex; align-items: center; gap: 0.45rem;
        }
        .stat-chip .n { font-size: 1.3rem; font-weight: 800; background: linear-gradient(135deg, #4facfe, #00f2fe); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }

        /* Filter bar */
        .filter-row {
            background: rgba(30,41,59,0.7); border: 1px solid rgba(255,255,255,0.07);
            border-radius: 14px; padding: 0.8rem 1.2rem;
            display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;
            margin-bottom: 1.5rem;
        }
        .filter-row select, .filter-row input {
            background: rgba(15,23,42,0.8); border: 1px solid rgba(79,172,254,0.22);
            color: #e2e8f0; border-radius: 9px; padding: 0.38rem 0.85rem; font-size: 0.86rem;
        }
        .filter-row select:focus, .filter-row input:focus { border-color: #4facfe; outline: none; }
        option { background: #1e293b; }

        /* Doubt Card */
        .doubt-card {
            background: var(--card); border: 1px solid rgba(255,255,255,0.07);
            border-radius: 16px; overflow: hidden;
            transition: all 0.3s; margin-bottom: 1rem;
        }
        .doubt-card:hover { border-color: rgba(79,172,254,0.35); transform: translateY(-2px); box-shadow: 0 12px 30px rgba(0,0,0,0.3); }
        .doubt-card.open { border-left: 4px solid #f59e0b; }
        .doubt-card.replied { border-left: 4px solid #10b981; }

        .dc-header { padding: 1rem 1.2rem 0.6rem; display: flex; align-items: flex-start; gap: 0.85rem; }
        .avatar-circle {
            width: 40px; height: 40px; border-radius: 50%;
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            display: flex; align-items: center; justify-content: center;
            font-weight: 800; font-size: 0.9rem; color: #0f172a; flex-shrink: 0;
        }
        .dc-student { font-weight: 700; font-size: 0.92rem; color: #f1f5f9; }
        .dc-video { color: #4facfe; font-size: 0.78rem; }
        .dc-time { color: #64748b; font-size: 0.73rem; }

        .dc-question {
            padding: 0 1.2rem 0.8rem 1.2rem;
            color: #cbd5e1; font-size: 0.92rem; line-height: 1.6;
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }

        /* Status Badge */
        .badge-open { background: rgba(245,158,11,0.12); border: 1px solid rgba(245,158,11,0.3); color: #fbbf24; border-radius: 20px; padding: 0.18rem 0.65rem; font-size: 0.72rem; font-weight: 700; }
        .badge-replied { background: rgba(16,185,129,0.12); border: 1px solid rgba(16,185,129,0.3); color: #34d399; border-radius: 20px; padding: 0.18rem 0.65rem; font-size: 0.72rem; font-weight: 700; }

        /* Reply Section */
        .reply-section { padding: 0.9rem 1.2rem; }
        .existing-reply {
            background: rgba(79,172,254,0.06); border: 1px solid rgba(79,172,254,0.15);
            border-radius: 10px; padding: 0.8rem 1rem; margin-bottom: 0.75rem;
        }
        .reply-label-text { font-size: 0.76rem; font-weight: 700; color: #4facfe; margin-bottom: 0.3rem; }
        .reply-body { color: #94d8e8; font-size: 0.88rem; line-height: 1.55; }
        .reply-by { font-size: 0.72rem; color: #475569; margin-top: 0.3rem; }

        .reply-form { display: flex; gap: 0.6rem; align-items: flex-end; }
        .reply-input {
            flex: 1; background: rgba(15,23,42,0.7) !important;
            border: 1.5px solid rgba(79,172,254,0.22) !important;
            color: #e2e8f0 !important; border-radius: 10px !important; resize: none;
        }
        .reply-input:focus { border-color: #4facfe !important; box-shadow: 0 0 0 3px rgba(79,172,254,0.15) !important; }
        .btn-reply {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            color: #0f172a; border: none; border-radius: 10px;
            padding: 0.45rem 1.1rem; font-weight: 700; font-size: 0.85rem; white-space: nowrap;
            transition: all 0.3s;
        }
        .btn-reply:hover { transform: translateY(-1px); box-shadow: 0 6px 16px rgba(0,242,254,0.3); }

        /* Empty */
        .empty-box { text-align: center; padding: 4rem 2rem; background: rgba(30,41,59,0.5); border-radius: 18px; }
    </style>
</head>
<body>
    <%@ include file="fheader.jsp" %>

    <div class="page-hero">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                <div>
                    <h1>💬 Student <span>Doubts</span></h1>
                    <p class="text-secondary mb-0">Review and reply to student questions from your video lectures</p>
                </div>
                <div class="d-flex gap-2 flex-wrap">
                    <div class="stat-chip"><i class="fas fa-clock" style="color:#f59e0b;"></i><span class="n">${openCount}</span><span style="color:#94a3b8;font-size:0.82rem;">Open</span></div>
                    <div class="stat-chip"><i class="fas fa-check-circle" style="color:#10b981;"></i><span class="n">${doubts.size() - openCount}</span><span style="color:#94a3b8;font-size:0.82rem;">Replied</span></div>
                </div>
            </div>
        </div>
    </div>

    <div class="container py-4">
        <!-- Filters -->
        <div class="filter-row">
            <i class="fas fa-filter" style="color:#4facfe;"></i>
            <select id="statusFilter" onchange="filterDoubts()">
                <option value="">All Status</option>
                <option value="OPEN">Open</option>
                <option value="REPLIED">Replied</option>
            </select>
            <input type="search" id="doubtSearch" placeholder="🔍 Search questions..." oninput="filterDoubts()" style="min-width:200px;">
            <span class="ms-auto" style="color:#64748b;font-size:0.85rem;" id="dcount">${doubts.size()} questions</span>
        </div>

        <!-- Doubts -->
        <c:choose>
            <c:when test="${empty doubts}">
                <div class="empty-box">
                    <i class="fas fa-comments fa-3x mb-3" style="color:rgba(79,172,254,0.25);"></i>
                    <h5 style="color:#94a3b8;">No student doubts yet</h5>
                    <p style="color:#64748b;font-size:0.88rem;">When students ask questions on your videos, they'll appear here.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div id="doubtsList">
                    <c:forEach var="d" items="${doubts}">
                        <div class="doubt-card ${d.status == 'OPEN' ? 'open' : 'replied'} d-item"
                             data-status="${d.status}"
                             data-text="${d.questionText.toLowerCase()}">
                            <div class="dc-header">
                                <div class="avatar-circle">${d.student.name.substring(0,1).toUpperCase()}</div>
                                <div class="flex-grow-1">
                                    <div class="d-flex align-items-center gap-2 flex-wrap">
                                        <span class="dc-student">${d.student.name}</span>
                                        <c:choose>
                                            <c:when test="${d.status == 'OPEN'}">
                                                <span class="badge-open"><i class="fas fa-clock me-1"></i>Open</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-replied"><i class="fas fa-check-circle me-1"></i>Replied</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="dc-video"><i class="fas fa-video me-1"></i>${d.video.title} · ${d.video.course.title}</div>
                                    <div class="dc-time"><i class="fas fa-calendar me-1"></i>${d.askedAt != null ? d.askedAt.toLocalDate() : ''}</div>
                                </div>
                            </div>
                            <div class="dc-question">"${d.questionText}"</div>
                            <div class="reply-section">
                                <c:if test="${d.status == 'REPLIED' and not empty d.reply}">
                                    <div class="existing-reply">
                                        <div class="reply-label-text"><i class="fas fa-reply me-1"></i>Your Reply</div>
                                        <div class="reply-body">${d.reply}</div>
                                        <div class="reply-by">
                                            <c:if test="${d.repliedBy != null}">— ${d.repliedBy.name}</c:if>
                                            <c:if test="${d.repliedAt != null}"> · ${d.repliedAt.toLocalDate()}</c:if>
                                        </div>
                                    </div>
                                </c:if>
                                <form method="post" action="/doubts/reply/${d.id}" class="reply-form">
                                    <textarea name="reply" class="form-control reply-input" rows="2"
                                              placeholder="${d.status == 'REPLIED' ? 'Update your reply...' : 'Type your reply...'}">${d.reply != null ? d.reply : ''}</textarea>
                                    <button type="submit" class="btn btn-reply">
                                        <i class="fas fa-paper-plane me-1"></i>${d.status == 'REPLIED' ? 'Update' : 'Reply'}
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterDoubts() {
            const status = document.getElementById('statusFilter').value;
            const q = document.getElementById('doubtSearch').value.toLowerCase();
            let vis = 0;
            document.querySelectorAll('.d-item').forEach(el => {
                const ok = (!status || el.dataset.status === status) && (!q || el.dataset.text.includes(q));
                el.style.display = ok ? '' : 'none';
                if (ok) vis++;
            });
            document.getElementById('dcount').textContent = vis + ' questions';
        }
    </script>
</body>
</html>
