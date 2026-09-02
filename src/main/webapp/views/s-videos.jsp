<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Video Lectures – Student</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0f172a; color: #e2e8f0; font-family: 'Inter', sans-serif; min-height: 100vh; }

        /* Hero */
        .s-hero {
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 50%, #321b5e 100%);
            padding: 2.5rem 0 2rem;
            border-bottom: 1px solid rgba(99,102,241,0.2);
            position: relative; overflow: hidden;
        }
        .s-hero::before {
            content: ''; position: absolute;
            top: -80px; right: -80px; width: 400px; height: 400px;
            background: radial-gradient(circle, rgba(99,102,241,0.12) 0%, transparent 70%);
            border-radius: 50%;
        }
        .s-hero h1 { font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 2.2rem; }
        .s-hero h1 span { background: linear-gradient(135deg, #6366f1, #a78bfa, #ec4899); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }

        /* Course Filter Tabs */
        .course-tabs { display: flex; gap: 0.5rem; flex-wrap: wrap; margin-bottom: 1.5rem; }
        .tab-btn {
            padding: 0.4rem 1.1rem; border-radius: 50px; font-size: 0.85rem; font-weight: 600;
            border: 1.5px solid rgba(99,102,241,0.3); color: #94a3b8;
            background: transparent; cursor: pointer; transition: all 0.25s;
        }
        .tab-btn:hover, .tab-btn.active {
            background: rgba(99,102,241,0.15); border-color: #6366f1; color: #a5b4fc;
        }

        /* Search */
        .s-search {
            background: rgba(30,27,75,0.6) !important;
            border: 1.5px solid rgba(99,102,241,0.25) !important;
            color: #e2e8f0 !important; border-radius: 12px !important;
        }
        .s-search:focus { border-color: #6366f1 !important; box-shadow: 0 0 0 3px rgba(99,102,241,0.15) !important; }

        /* Video Card */
        .sv-card {
            background: linear-gradient(145deg, #1e293b, #1a1040);
            border: 1px solid rgba(99,102,241,0.12);
            border-radius: 20px; overflow: hidden; height: 100%;
            transition: all 0.35s cubic-bezier(.4,0,.2,1);
            position: relative;
        }
        .sv-card:hover {
            transform: translateY(-7px);
            border-color: rgba(99,102,241,0.45);
            box-shadow: 0 24px 48px rgba(0,0,0,0.45), 0 0 0 1px rgba(99,102,241,0.2);
        }
        .sv-card::after {
            content: ''; position: absolute; top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, #6366f1, #a78bfa, #ec4899);
            opacity: 0; transition: opacity 0.3s;
        }
        .sv-card:hover::after { opacity: 1; }

        .sv-thumb {
            height: 185px; position: relative; overflow: hidden;
            background: linear-gradient(135deg, #0f0c29, #302b63);
            display: flex; align-items: center; justify-content: center;
        }
        .sv-thumb video { width: 100%; height: 100%; object-fit: cover; opacity: 0.6; }
        .sv-play {
            position: absolute; width: 60px; height: 60px;
            background: linear-gradient(135deg, rgba(99,102,241,0.9), rgba(167,139,250,0.9));
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem; color: white;
            box-shadow: 0 0 0 0 rgba(99,102,241,0.5);
            transition: all 0.3s; animation: pulse-ring 2s infinite;
        }
        @keyframes pulse-ring {
            0% { box-shadow: 0 0 0 0 rgba(99,102,241,0.4); }
            70% { box-shadow: 0 0 0 14px rgba(99,102,241,0); }
            100% { box-shadow: 0 0 0 0 rgba(99,102,241,0); }
        }
        .sv-card:hover .sv-play { transform: scale(1.12); }
        .sv-course-badge {
            position: absolute; top: 10px; left: 10px;
            background: rgba(10,10,30,0.8); border: 1px solid rgba(99,102,241,0.4);
            color: #a5b4fc; font-size: 0.68rem; font-weight: 700;
            padding: 0.18rem 0.6rem; border-radius: 20px; backdrop-filter: blur(6px);
        }
        .sv-new-badge {
            position: absolute; top: 10px; right: 10px;
            background: linear-gradient(135deg, #ec4899, #f43f5e);
            color: white; font-size: 0.62rem; font-weight: 800;
            padding: 0.18rem 0.55rem; border-radius: 20px;
        }

        .sv-body { padding: 1.1rem 1.2rem 0.9rem; }
        .sv-title { font-weight: 700; font-size: 1rem; color: #f1f5f9; line-height: 1.3; margin-bottom: 0.3rem; }
        .sv-desc { color: #94a3b8; font-size: 0.82rem; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; margin-bottom: 0.75rem; }
        .sv-meta { display: flex; gap: 0.6rem; font-size: 0.74rem; color: #64748b; flex-wrap: wrap; }
        .sv-meta i { color: #6366f1; }

        .sv-footer { padding: 0.8rem 1.2rem; border-top: 1px solid rgba(255,255,255,0.05); }
        .btn-watch {
            width: 100%;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white; border: none; border-radius: 10px;
            padding: 0.5rem; font-weight: 700; font-size: 0.9rem;
            transition: all 0.3s;
        }
        .btn-watch:hover { opacity: 0.88; transform: translateY(-1px); box-shadow: 0 8px 20px rgba(99,102,241,0.4); color: white; }

        /* Empty State */
        .empty-state { text-align: center; padding: 5rem 2rem; }
        .empty-icon { font-size: 4rem; margin-bottom: 1.2rem; }

        /* Stats Bar */
        .stats-row {
            background: rgba(30,41,59,0.5); border: 1px solid rgba(99,102,241,0.15);
            border-radius: 14px; padding: 0.9rem 1.4rem; margin-bottom: 1.5rem;
            display: flex; gap: 2rem; flex-wrap: wrap; align-items: center;
        }
        .stat-item { display: flex; align-items: center; gap: 0.5rem; }
        .stat-item .val { font-weight: 800; font-size: 1.4rem; background: linear-gradient(135deg, #6366f1, #a78bfa); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .stat-item .lbl { color: #94a3b8; font-size: 0.8rem; }
    </style>
</head>
<body>
    <%@ include file="sheader.jsp" %>

    <!-- Hero -->
    <div class="s-hero">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                <div>
                    <h1>🎬 Video <span>Lectures</span></h1>
                    <p class="text-secondary mb-0">Watch lectures from your enrolled courses. Submit doubts and questions below each video.</p>
                </div>
                <input type="search" id="svidSearch" class="form-control s-search" style="max-width:240px;" placeholder="🔍 Search lectures..." oninput="searchSvideos(this.value)">
            </div>
        </div>
    </div>

    <div class="container py-4">
        <!-- Stats -->
        <div class="stats-row">
            <div class="stat-item"><span class="val">${videos.size()}</span><span class="lbl"><i class="fas fa-play-circle me-1" style="color:#6366f1;"></i>Available Lectures</span></div>
            <div class="stat-item"><span class="val">${courses.size()}</span><span class="lbl"><i class="fas fa-book me-1" style="color:#a78bfa;"></i>Enrolled Courses</span></div>
        </div>

        <!-- Course Filter Tabs -->
        <div class="course-tabs mb-3">
            <button class="tab-btn active" onclick="filterByTab('', this)">All Courses</button>
            <c:forEach var="c" items="${courses}">
                <button class="tab-btn" onclick="filterByTab('${c.id}', this)">${c.title}</button>
            </c:forEach>
        </div>

        <!-- Video Grid -->
        <c:choose>
            <c:when test="${empty videos}">
                <div class="empty-state">
                    <div class="empty-icon">🎬</div>
                    <h4 style="font-family:'Outfit',sans-serif;font-weight:800;color:#f1f5f9;">No Videos Yet</h4>
                    <p style="color:#94a3b8;">Your faculty haven't uploaded any videos yet. Check back soon!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4" id="svidGrid">
                    <c:forEach var="v" items="${videos}" varStatus="st">
                        <div class="col-md-6 col-xl-4 sv-item" data-course="${v.course.id}" data-title="${v.title.toLowerCase()}">
                            <div class="sv-card">
                                <div class="sv-thumb">
                                    <video muted preload="metadata">
                                        <source src="/videos/stream/${v.id}" type="video/mp4">
                                    </video>
                                    <span class="sv-course-badge"><i class="fas fa-book me-1"></i>${v.course.title}</span>
                                    <c:if test="${st.index < 3}">
                                        <span class="sv-new-badge">NEW</span>
                                    </c:if>
                                    <div class="sv-play"><i class="fas fa-play ms-1"></i></div>
                                </div>
                                <div class="sv-body">
                                    <div class="sv-title">${v.title}</div>
                                    <div class="sv-desc">${v.description}</div>
                                    <div class="sv-meta">
                                        <span><i class="fas fa-user-tie me-1"></i>${v.uploadedBy != null ? v.uploadedBy.name : 'Faculty'}</span>
                                        <span><i class="fas fa-calendar me-1"></i>${v.uploadedAt != null ? v.uploadedAt.toLocalDate() : ''}</span>
                                    </div>
                                </div>
                                <div class="sv-footer">
                                    <a href="/s-watch/${v.id}" class="btn btn-watch">
                                        <i class="fas fa-play-circle me-2"></i>Watch & Ask Doubts
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterByTab(courseId, btn) {
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            document.querySelectorAll('.sv-item').forEach(el => {
                el.style.display = (!courseId || el.dataset.course === courseId) ? '' : 'none';
            });
        }
        function searchSvideos(q) {
            document.querySelectorAll('.sv-item').forEach(el => {
                el.style.display = el.dataset.title.includes(q.toLowerCase()) ? '' : 'none';
            });
        }
        // Hover to play preview
        document.querySelectorAll('.sv-thumb').forEach(thumb => {
            const vid = thumb.querySelector('video');
            if (!vid) return;
            thumb.addEventListener('mouseenter', () => vid.play());
            thumb.addEventListener('mouseleave', () => { vid.pause(); vid.currentTime = 0; });
        });
    </script>
</body>
</html>
