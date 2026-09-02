<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notice Board — Student | EduPro LMS</title>
    <meta name="description" content="View all announcements and notices from admin and faculty. Download attachments.">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary: #0ea5e9;
            --purple: #7c3aed;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --bg: #f0f9ff;
            --card: #fff;
            --text: #0f172a;
            --muted: #64748b;
            --border: rgba(14,165,233,0.14);
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); }

        /* Dark Mode */
        body[data-bs-theme="dark"] {
            --bg: #0f172a; --card: #1e293b; --text: #e2e8f0;
            --muted: #94a3b8; --border: rgba(255,255,255,0.07);
            background: var(--bg) !important;
        }
        body[data-bs-theme="dark"] .notice-card { background: #1e293b !important; border-color: rgba(255,255,255,0.08) !important; }
        body[data-bs-theme="dark"] .notice-title { color: #f1f5f9 !important; }
        body[data-bs-theme="dark"] .notices-wrap { background: #1e293b !important; border-color: rgba(255,255,255,0.07) !important; }
        body[data-bs-theme="dark"] .search-bar { background: rgba(255,255,255,0.06) !important; border-color: rgba(255,255,255,0.1) !important; color: #e2e8f0 !important; }
        body[data-bs-theme="dark"] .stat-box { background: #1e293b !important; border-color: rgba(255,255,255,0.08) !important; }
        body[data-bs-theme="dark"] .filter-chip { color: #94a3b8 !important; border-color: rgba(255,255,255,0.1) !important; }
        body[data-bs-theme="dark"] .filter-chip.active { background: var(--primary) !important; border-color: var(--primary) !important; color: white !important; }

        /* ── Hero ── */
        .student-hero {
            background: linear-gradient(135deg, #0ea5e9 0%, #7c3aed 60%, #ec4899 100%);
            padding: 2.5rem 0; color: white; position: relative; overflow: hidden;
        }
        .student-hero::before {
            content: ''; position: absolute; inset: 0;
            background: radial-gradient(ellipse at top right, rgba(255,255,255,0.08) 0%, transparent 60%);
        }
        .student-hero::after {
            content: '📢'; position: absolute; right: 5%; top: 50%; transform: translateY(-50%);
            font-size: 6rem; opacity: 0.12;
        }
        .student-hero h1 { font-size: 1.9rem; font-weight: 800; }

        /* ── Stat Boxes ── */
        .stat-box {
            background: var(--card); border-radius: 14px; padding: 1rem 1.3rem;
            border: 1px solid var(--border); box-shadow: 0 2px 15px rgba(0,0,0,0.04);
            display: flex; align-items: center; gap: 0.9rem; transition: transform 0.3s;
        }
        .stat-box:hover { transform: translateY(-2px); }
        .sico {
            width: 44px; height: 44px; border-radius: 12px; flex-shrink: 0;
            display: flex; align-items: center; justify-content: center; font-size: 1.2rem;
        }
        .sn { font-size: 1.4rem; font-weight: 800; }
        .sl { font-size: 0.75rem; color: var(--muted); font-weight: 500; }

        /* ── Search & Filter Bar ── */
        .toolbar { display: flex; gap: 0.75rem; flex-wrap: wrap; align-items: center; margin-bottom: 1.5rem; }
        .search-bar {
            flex: 1; min-width: 200px; padding: 0.6rem 1rem 0.6rem 2.5rem;
            border: 1.5px solid #e0f2fe; border-radius: 50px; font-size: 0.9rem;
            background: white; color: var(--text); outline: none; transition: all 0.3s;
        }
        .search-bar:focus { border-color: var(--primary); box-shadow: 0 0 0 4px rgba(14,165,233,0.12); }
        .search-wrap { position: relative; flex: 1; }
        .search-wrap i { position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: var(--muted); }
        .filter-chips { display: flex; gap: 0.4rem; flex-wrap: wrap; }
        .filter-chip {
            padding: 0.4rem 1rem; border-radius: 50px; border: 1.5px solid #e0f2fe;
            font-size: 0.8rem; font-weight: 600; cursor: pointer; transition: all 0.22s; color: var(--muted);
            background: transparent;
        }
        .filter-chip.active, .filter-chip:hover { background: var(--primary); border-color: var(--primary); color: white; }

        /* ── Notices Grid ── */
        .notices-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.25rem;
        }
        .notice-card {
            background: var(--card);
            border-radius: 18px;
            border: 1px solid var(--border);
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            animation: popIn 0.4s ease;
            display: flex; flex-direction: column;
        }
        .notice-card:hover { transform: translateY(-5px); box-shadow: 0 10px 40px rgba(14,165,233,0.15); }
        @keyframes popIn { from { opacity:0; transform: scale(0.96); } to { opacity:1; transform: scale(1); } }

        .notice-card-top {
            padding: 1.25rem 1.5rem 0.75rem;
            border-bottom: 1px solid var(--border);
            position: relative;
        }
        .notice-card-tag {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 0.3rem 0.8rem; border-radius: 50px; font-size: 0.72rem; font-weight: 700;
            letter-spacing: 0.5px; text-transform: uppercase; margin-bottom: 0.75rem;
        }
        .tag-STUDENT { background: linear-gradient(135deg,#10b981,#059669); color: white; }
        .tag-ALL { background: linear-gradient(135deg,#0ea5e9,#7c3aed); color: white; }
        .tag-FACULTY { background: linear-gradient(135deg,#f59e0b,#d97706); color: white; }
        .notice-title { font-size: 1rem; font-weight: 700; margin-bottom: 0.6rem; line-height: 1.4; color: var(--text); }
        .notice-desc { font-size: 0.84rem; color: var(--muted); line-height: 1.6; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; }
        .notice-card-bottom {
            padding: 0.9rem 1.5rem;
            margin-top: auto;
            display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.5rem;
        }
        .nc-meta { display: flex; align-items: center; gap: 0.5rem; flex-wrap: wrap; }
        .nc-date { font-size: 0.75rem; color: var(--muted); display: flex; align-items: center; gap: 5px; }
        .nc-from { font-size: 0.75rem; color: var(--muted); display: flex; align-items: center; gap: 5px; }
        .btn-download {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 0.4rem 1rem; border-radius: 50px;
            background: linear-gradient(135deg, var(--primary), var(--purple));
            color: white; font-size: 0.78rem; font-weight: 700;
            text-decoration: none; border: none; transition: all 0.3s;
        }
        .btn-download:hover { transform: scale(1.05); box-shadow: 0 4px 15px rgba(14,165,233,0.35); color: white; }

        /* ── New Badge ── */
        .new-badge {
            position: absolute; top: 1rem; right: 1rem;
            background: var(--danger); color: white;
            font-size: 0.65rem; font-weight: 800; letter-spacing: 1px;
            padding: 0.18rem 0.55rem; border-radius: 50px; text-transform: uppercase;
            animation: pulse 1.5s infinite;
        }
        @keyframes pulse { 0%,100%{opacity:1;} 50%{opacity:0.6;} }

        /* ── Empty State ── */
        .empty-state { text-align: center; padding: 5rem 2rem; color: var(--muted); }
        .empty-state i { font-size: 5rem; display: block; margin-bottom: 1.5rem; opacity: 0.25; }

        /* ── Marquee Ticker ── */
        .notice-ticker {
            background: linear-gradient(135deg, #0ea5e9, #7c3aed);
            color: white; padding: 0.55rem 0; overflow: hidden; font-size: 0.85rem; font-weight: 600;
        }
        .ticker-inner { display: flex; gap: 3rem; animation: ticker 20s linear infinite; white-space: nowrap; }
        @keyframes ticker { 0% { transform: translateX(100%); } 100% { transform: translateX(-100%); } }

        @media (max-width: 576px) {
            .notices-grid { grid-template-columns: 1fr; }
            .student-hero h1 { font-size: 1.4rem; }
        }
    </style>
</head>
<body>
<div>
    <%@ include file="sheader.jsp" %>

    <!-- News Ticker -->
    <div class="notice-ticker">
        <div class="ticker-inner" id="tickerText">
            <c:choose>
                <c:when test="${not empty notices}">
                    <c:forEach var="n" items="${notices}">
                        <span><i class="bi bi-megaphone-fill me-2"></i>${n.title}</span>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <span><i class="bi bi-megaphone-fill me-2"></i>No new notices at the moment. Check back later!</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Hero -->
    <div class="student-hero">
        <div class="container position-relative">
            <div class="row align-items-center">
                <div class="col">
                    <div class="d-flex align-items-center gap-3 mb-1">
                        <div style="background:rgba(255,255,255,0.2);border-radius:14px;padding:0.6rem 0.9rem;">
                            <i class="bi bi-newspaper fs-3"></i>
                        </div>
                        <div>
                            <h1 class="mb-0">Notice Board</h1>
                            <p class="mb-0 mt-1" style="opacity:0.85;font-size:0.95rem;">All important announcements and attachments in one place</p>
                        </div>
                    </div>
                </div>
                <div class="col-auto">
                    <a href="/sdashboard" class="btn btn-light btn-sm rounded-pill px-3">
                        <i class="bi bi-arrow-left me-1"></i> Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container py-4">
        <!-- Stats -->
        <div class="row g-3 mb-4">
            <c:set var="totalCnt" value="${notices.size()}"/>
            <c:set var="attachCnt" value="0"/>
            <c:forEach var="n" items="${notices}">
                <c:if test="${n.fileName != null}"><c:set var="attachCnt" value="${attachCnt + 1}"/></c:if>
            </c:forEach>
            <div class="col-6 col-md-4">
                <div class="stat-box">
                    <div class="sico" style="background:rgba(14,165,233,0.12);color:#0ea5e9;"><i class="bi bi-newspaper"></i></div>
                    <div><div class="sn">${totalCnt}</div><div class="sl">Total Notices</div></div>
                </div>
            </div>
            <div class="col-6 col-md-4">
                <div class="stat-box">
                    <div class="sico" style="background:rgba(16,185,129,0.12);color:#10b981;"><i class="bi bi-paperclip"></i></div>
                    <div><div class="sn">${attachCnt}</div><div class="sl">With Attachments</div></div>
                </div>
            </div>
            <div class="col-6 col-md-4">
                <div class="stat-box">
                    <div class="sico" style="background:rgba(124,58,237,0.12);color:#7c3aed;"><i class="bi bi-bell-fill"></i></div>
                    <div><div class="sn">NEW</div><div class="sl">Stay Updated</div></div>
                </div>
            </div>
        </div>

        <!-- Toolbar -->
        <div class="toolbar">
            <div class="search-wrap">
                <i class="bi bi-search"></i>
                <input type="text" id="searchInput" class="search-bar" placeholder="Search notices..." oninput="searchNotices(this.value)">
            </div>
            <div class="filter-chips">
                <button class="filter-chip active" onclick="filterCards('ALL', this)">All</button>
                <button class="filter-chip" onclick="filterCards('STUDENT', this)">Student Notices</button>
                <button class="filter-chip" onclick="filterCards('GENERAL', this)">General</button>
                <button class="filter-chip" onclick="filterCards('HAS_FILE', this)">
                    <i class="bi bi-paperclip me-1"></i>With Files
                </button>
            </div>
        </div>

        <!-- Notice Grid -->
        <div class="notices-grid" id="noticesGrid">
            <c:if test="${empty notices}">
                <!-- shown via JS empty state -->
            </c:if>
            <c:forEach var="n" items="${notices}" varStatus="stat">
                <c:set var="aud" value="${n.targetAudience != null ? n.targetAudience : 'ALL'}"/>
                <div class="notice-card"
                     data-audience="${aud}"
                     data-title="${n.title}"
                     data-desc="${n.description}"
                     data-has-file="${n.fileName != null}">

                    <div class="notice-card-top">
                        <c:if test="${stat.index < 2}">
                            <span class="new-badge">NEW</span>
                        </c:if>
                        <div class="notice-card-tag tag-${aud}">
                            <c:choose>
                                <c:when test="${aud == 'STUDENT'}"><i class="bi bi-mortarboard-fill"></i> For Students</c:when>
                                <c:otherwise><i class="bi bi-globe2"></i> General</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="notice-title">${n.title}</div>
                        <div class="notice-desc">${n.description}</div>
                    </div>

                    <div class="notice-card-bottom">
                        <div class="nc-meta">
                            <span class="nc-date"><i class="bi bi-calendar3"></i> ${n.noticeDate != null ? n.noticeDate : '—'}</span>
                            <c:if test="${n.createdBy != null}">
                                <span class="nc-from"><i class="bi bi-person-circle"></i> ${n.createdBy.name}</span>
                            </c:if>
                        </div>
                        <c:if test="${n.fileName != null}">
                            <a href="/download/notice/${n.id}" class="btn-download">
                                <i class="bi bi-download"></i> Download
                            </a>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Empty State -->
        <div id="emptyState" class="empty-state" style="display:none;">
            <i class="bi bi-megaphone"></i>
            <h4 class="fw-bold mb-2">No notices found</h4>
            <p>There are no notices matching your filter right now. Check back later!</p>
            <button class="btn btn-primary rounded-pill px-4 mt-2" onclick="resetFilter()">Show All Notices</button>
        </div>

        <c:if test="${empty notices}">
            <div class="empty-state">
                <i class="bi bi-megaphone"></i>
                <h4 class="fw-bold mb-2">No Notices Yet</h4>
                <p>There are no announcements at the moment. Check back soon!</p>
            </div>
        </c:if>
    </div>

    <%@ include file="sfooter.jsp" %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let activeFilter = 'ALL';

    function filterCards(type, btn) {
        activeFilter = type;
        document.querySelectorAll('.filter-chip').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        document.getElementById('searchInput').value = '';
        applyFilter();
    }

    function searchNotices(query) {
        const q = query.toLowerCase();
        let visible = 0;
        document.querySelectorAll('.notice-card').forEach(card => {
            const title = card.dataset.title.toLowerCase();
            const desc  = card.dataset.desc.toLowerCase();
            const match = title.includes(q) || desc.includes(q);
            card.style.display = match ? '' : 'none';
            if (match) visible++;
        });
        document.getElementById('emptyState').style.display = visible === 0 ? '' : 'none';
    }

    function applyFilter() {
        let visible = 0;
        document.querySelectorAll('.notice-card').forEach(card => {
            const aud = card.dataset.audience;
            const hasFile = card.dataset.hasFile === 'true';
            let show = false;
            if (activeFilter === 'ALL') show = true;
            else if (activeFilter === 'STUDENT') show = (aud === 'STUDENT');
            else if (activeFilter === 'GENERAL') show = (aud === 'ALL' || !aud);
            else if (activeFilter === 'HAS_FILE') show = hasFile;
            card.style.display = show ? '' : 'none';
            if (show) visible++;
        });
        document.getElementById('emptyState').style.display = visible === 0 ? '' : 'none';
    }

    function resetFilter() {
        activeFilter = 'ALL';
        document.querySelectorAll('.filter-chip').forEach((b, i) => b.classList.toggle('active', i === 0));
        document.getElementById('searchInput').value = '';
        applyFilter();
    }
</script>
</body>
</html>
