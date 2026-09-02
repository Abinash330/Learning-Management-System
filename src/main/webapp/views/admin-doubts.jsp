<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Student Doubts – Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root { --primary: #4f46e5; --secondary: #ec4899; }
        body { background: #f1f5f9; font-family: 'Inter', sans-serif; min-height: 100vh; }

        .page-banner {
            background: linear-gradient(135deg, #1e1b4b 0%, #4f46e5 50%, #7c3aed 100%);
            padding: 2rem 0 1.5rem; color: white;
            box-shadow: 0 4px 30px rgba(79,70,229,0.3);
        }
        .page-banner h1 { font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 2rem; }

        .stat-card {
            background: white; border-radius: 16px; padding: 1.2rem 1.5rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            border-left: 4px solid;
        }
        .stat-card.amber { border-color: #f59e0b; }
        .stat-card.green { border-color: #10b981; }
        .stat-card.purple { border-color: #7c3aed; }
        .stat-num { font-size: 2rem; font-weight: 800; line-height: 1; }
        .stat-lbl { color: #64748b; font-size: 0.82rem; font-weight: 600; margin-top: 0.2rem; }

        .controls-bar {
            background: white; border-radius: 14px; padding: 0.9rem 1.4rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06); margin-bottom: 1.5rem;
            display: flex; gap: 0.8rem; align-items: center; flex-wrap: wrap;
        }
        .controls-bar input, .controls-bar select {
            border: 1.5px solid #e2e8f0; border-radius: 10px;
            padding: 0.4rem 0.9rem; font-size: 0.87rem; transition: all 0.2s;
        }
        .controls-bar input:focus, .controls-bar select:focus { border-color: #4f46e5; outline: none; box-shadow: 0 0 0 3px rgba(79,70,229,0.1); }

        /* Doubt Card */
        .doubt-card {
            background: white; border-radius: 16px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
            margin-bottom: 1rem; overflow: hidden;
            border-left: 4px solid #e2e8f0;
            transition: all 0.3s;
        }
        .doubt-card:hover { transform: translateY(-2px); box-shadow: 0 10px 28px rgba(0,0,0,0.1); }
        .doubt-card.open   { border-left-color: #f59e0b; }
        .doubt-card.replied { border-left-color: #10b981; }

        .dc-top { padding: 1rem 1.2rem 0.6rem; display: flex; align-items: flex-start; gap: 0.85rem; }
        .av {
            width: 42px; height: 42px; border-radius: 50%;
            background: linear-gradient(135deg, #4f46e5, #7c3aed);
            display: flex; align-items: center; justify-content: center;
            font-weight: 800; color: white; flex-shrink: 0; font-size: 0.95rem;
        }
        .student-name { font-weight: 700; font-size: 0.95rem; color: #1e293b; }
        .video-ref { color: #4f46e5; font-size: 0.78rem; font-weight: 600; }
        .course-ref { color: #7c3aed; font-size: 0.76rem; }
        .time-ref { color: #94a3b8; font-size: 0.73rem; }

        .dc-q { padding: 0 1.2rem 0.85rem; color: #334155; font-size: 0.92rem; line-height: 1.6; border-bottom: 1px solid #f1f5f9; }
        .dc-q blockquote { margin: 0; border-left: 3px solid #c7d2fe; padding-left: 0.85rem; font-style: italic; }

        .badge-open    { background: #fef3c7; color: #d97706; border-radius: 20px; padding: 0.18rem 0.65rem; font-size: 0.72rem; font-weight: 700; }
        .badge-replied { background: #d1fae5; color: #059669; border-radius: 20px; padding: 0.18rem 0.65rem; font-size: 0.72rem; font-weight: 700; }

        .dc-bottom { padding: 0.85rem 1.2rem; background: #fafafa; }
        .existing-reply {
            background: #ede9fe; border-radius: 10px;
            padding: 0.75rem 1rem; margin-bottom: 0.7rem;
        }
        .reply-lbl { font-size: 0.74rem; font-weight: 700; color: #4f46e5; margin-bottom: 0.3rem; }
        .reply-body-text { color: #3730a3; font-size: 0.88rem; line-height: 1.5; }
        .reply-from { font-size: 0.71rem; color: #94a3b8; margin-top: 0.3rem; }

        .reply-form { display: flex; gap: 0.6rem; align-items: flex-end; }
        .btn-reply-admin {
            background: linear-gradient(135deg, #4f46e5, #7c3aed); color: white;
            border: none; border-radius: 10px; padding: 0.45rem 1.1rem;
            font-weight: 700; font-size: 0.85rem; white-space: nowrap; transition: all 0.25s;
        }
        .btn-reply-admin:hover { opacity: 0.88; color: white; }
        .btn-del-admin {
            background: #fee2e2; color: #ef4444; border: none; border-radius: 8px;
            padding: 0.35rem 0.8rem; font-size: 0.8rem; font-weight: 600; transition: all 0.2s;
        }
        .btn-del-admin:hover { background: #fecaca; }

        .empty-box { text-align: center; padding: 4rem 2rem; background: white; border-radius: 20px; }
    </style>
</head>
<body>
    <%@ include file="aheader.jsp" %>

    <div class="page-banner">
        <div class="container">
            <h1><i class="fas fa-comments me-3"></i>All Student Doubts</h1>
            <p class="mb-0 opacity-75">Full oversight of every doubt and question submitted by students</p>
        </div>
    </div>

    <div class="container py-4">
        <!-- Stats -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="stat-card amber">
                    <div class="stat-num" style="color:#f59e0b;">${openCount}</div>
                    <div class="stat-lbl"><i class="fas fa-clock me-1"></i>Open / Unanswered</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card green">
                    <div class="stat-num" style="color:#10b981;">${repliedCount}</div>
                    <div class="stat-lbl"><i class="fas fa-check-circle me-1"></i>Replied</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card purple">
                    <div class="stat-num" style="color:#7c3aed;">${openCount + repliedCount}</div>
                    <div class="stat-lbl"><i class="fas fa-layer-group me-1"></i>Total Questions</div>
                </div>
            </div>
        </div>

        <!-- Controls -->
        <div class="controls-bar">
            <i class="fas fa-filter" style="color:#4f46e5;"></i>
            <input type="search" id="adsearch" placeholder="🔍 Search by question or student..." oninput="filterAD()" style="min-width:240px;">
            <select id="adstatus" onchange="filterAD()">
                <option value="">All Status</option>
                <option value="open">Open Only</option>
                <option value="replied">Replied Only</option>
            </select>
            <span class="ms-auto text-secondary" style="font-size:0.85rem;" id="adcount">${openCount + repliedCount} doubts</span>
        </div>

        <!-- List -->
        <c:choose>
            <c:when test="${empty doubts}">
                <div class="empty-box">
                    <i class="fas fa-comment-slash fa-3x mb-3" style="color:#c7d2fe;"></i>
                    <h5 class="text-muted">No student doubts yet</h5>
                    <p class="text-muted small">When students ask questions on video lectures, they appear here.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div id="adList">
                    <c:forEach var="d" items="${doubts}">
                        <div class="doubt-card ${d.status == 'OPEN' ? 'open' : 'replied'} ad-item"
                             data-status="${d.status.toLowerCase()}"
                             data-text="${d.questionText.toLowerCase()} ${d.student.name.toLowerCase()}">
                            <div class="dc-top">
                                <div class="av">${d.student.name.substring(0,1).toUpperCase()}</div>
                                <div class="flex-grow-1">
                                    <div class="d-flex align-items-center gap-2 flex-wrap">
                                        <span class="student-name">${d.student.name}</span>
                                        <c:choose>
                                            <c:when test="${d.status == 'OPEN'}">
                                                <span class="badge-open"><i class="fas fa-clock me-1"></i>Open</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-replied"><i class="fas fa-check me-1"></i>Replied</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="video-ref"><i class="fas fa-video me-1"></i>${d.video.title}</div>
                                    <div class="course-ref"><i class="fas fa-book me-1"></i>${d.video.course.title}</div>
                                    <div class="time-ref"><i class="fas fa-calendar me-1"></i>${d.askedAt != null ? d.askedAt.toLocalDate() : ''}</div>
                                </div>
                                <!-- Delete button (Admin only) -->
                                <form method="post" action="/doubts/delete/${d.id}" onsubmit="return confirm('Delete this doubt?')" class="ms-auto">
                                    <button type="submit" class="btn-del-admin"><i class="fas fa-trash me-1"></i>Delete</button>
                                </form>
                            </div>
                            <div class="dc-q"><blockquote>${d.questionText}</blockquote></div>
                            <div class="dc-bottom">
                                <c:if test="${d.status == 'REPLIED' and not empty d.reply}">
                                    <div class="existing-reply">
                                        <div class="reply-lbl"><i class="fas fa-reply me-1"></i>Current Reply</div>
                                        <div class="reply-body-text">${d.reply}</div>
                                        <div class="reply-from">
                                            <c:if test="${d.repliedBy != null}">by ${d.repliedBy.name}</c:if>
                                            <c:if test="${d.repliedAt != null}"> · ${d.repliedAt.toLocalDate()}</c:if>
                                        </div>
                                    </div>
                                </c:if>
                                <form method="post" action="/doubts/reply/${d.id}" class="reply-form">
                                    <textarea name="reply" class="form-control" rows="2" style="border-radius:10px;border:1.5px solid #e2e8f0;resize:none;font-size:0.88rem;"
                                              placeholder="Type admin reply...">${d.reply != null ? d.reply : ''}</textarea>
                                    <button type="submit" class="btn btn-reply-admin">
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
        function filterAD() {
            const q = document.getElementById('adsearch').value.toLowerCase();
            const s = document.getElementById('adstatus').value;
            let vis = 0;
            document.querySelectorAll('.ad-item').forEach(el => {
                const ok = (!q || el.dataset.text.includes(q)) && (!s || el.dataset.status === s);
                el.style.display = ok ? '' : 'none';
                if (ok) vis++;
            });
            document.getElementById('adcount').textContent = vis + ' doubts';
        }
    </script>
</body>
</html>
