<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    .faculty-header {
        background: linear-gradient(135deg, #064e3b 0%, #065f46 50%, #047857 100%);
        border-bottom: 3px solid #10b981;
        position: sticky; top: 0; z-index: 1020;
        backdrop-filter: blur(10px);
        box-shadow: 0 4px 20px rgba(0,0,0,0.2);
    }
    .faculty-header .nav-link {
        color: rgba(255,255,255,0.85) !important;
        font-weight: 600; font-size: 0.9rem;
        padding: 0.5rem 1rem; border-radius: 8px;
        transition: all 0.25s;
    }
    .faculty-header .nav-link:hover {
        color: white !important;
        background: rgba(255,255,255,0.12);
    }
    .faculty-header .nav-link.active-link {
        color: white !important;
        background: rgba(16,185,129,0.25);
        border-bottom: 2px solid #10b981;
    }
    .faculty-badge {
        background: linear-gradient(135deg, #10b981, #059669);
        color: white; font-weight: 700; border-radius: 50px;
        padding: 0.35rem 0.9rem; font-size: 0.75rem; letter-spacing: 0.5px;
        box-shadow: 0 3px 10px rgba(16,185,129,0.3);
    }
    .btn-notif {
        width:36px; height:36px; border-radius:50%; border:1.5px solid rgba(255,255,255,0.2);
        background:rgba(255,255,255,0.08); color:white; display:flex; align-items:center; justify-content:center;
        transition: all 0.25s; cursor:pointer;
    }
    .btn-notif:hover { background:rgba(16,185,129,0.3); border-color:#10b981; }
    .faculty-brand {
        font-weight: 900; font-size: 1.3rem; letter-spacing: -0.5px;
        color: white; text-decoration: none;
    }
    .faculty-brand span { color: #6ee7b7; }
</style>

<header class="faculty-header py-2">
    <div class="container d-flex flex-wrap align-items-center justify-content-between gap-2">

        <!-- Brand -->
        <a href="/fdashboard" class="faculty-brand me-4">
            <i class="bi bi-mortarboard-fill me-2"></i>EduPro<span>Faculty</span>
        </a>

        <!-- Nav Links -->
        <ul class="nav mb-0 d-none d-lg-flex">
            <li><a href="/fdashboard" class="nav-link"><i class="bi bi-grid-1x2 me-1"></i> Dashboard</a></li>
            <li><a href="/f-assignments" class="nav-link"><i class="bi bi-file-earmark-text me-1"></i> Assignments</a></li>
            <li><a href="/addnotice" class="nav-link"><i class="bi bi-megaphone me-1"></i> Post Notice</a></li>
        </ul>

        <!-- Right Controls -->
        <div class="d-flex align-items-center gap-2">
            <span class="faculty-badge d-none d-sm-inline"><i class="bi bi-person-badge-fill me-1"></i> Professor Mode</span>

            <!-- 🔔 Notification Bell -->
            <div class="dropdown">
                <button class="btn-notif position-relative" id="fNotifBell" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-bell-fill"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="fNotifCount" style="font-size:0.6rem;display:none;">0</span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-4 p-0" style="width:300px;max-height:380px;overflow-y:auto;" aria-labelledby="fNotifBell">
                    <li class="px-3 py-2 border-bottom d-flex justify-content-between align-items-center rounded-top-4" style="background:#f8fafc;">
                        <span class="fw-bold text-dark small">🔔 Notifications</span>
                        <button class="btn btn-sm btn-link text-primary p-0 text-decoration-none small" onclick="fMarkAllRead()">Mark all read</button>
                    </li>
                    <div id="fNotifList">
                        <li class="px-3 py-3 text-center text-muted small" id="fNotifEmpty">
                            <i class="bi bi-bell-slash fa-2x mb-2 d-block fs-4"></i>No new notifications
                        </li>
                    </div>
                </ul>
            </div>

            <a href="/logout" class="btn btn-sm fw-bold rounded-pill px-3" style="border:1.5px solid rgba(255,255,255,0.3);color:white;background:rgba(255,255,255,0.08);">
                <i class="bi bi-box-arrow-right me-1"></i>Logout
            </a>
        </div>
    </div>
</header>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 🔔 Faculty Notification Bell
    (function() {
        fetch('/api/notices')
            .then(r => r.json())
            .then(notices => {
                const lastSeen = parseInt(localStorage.getItem('fNotifLastSeen') || '0');
                const unread = notices.filter(n => n.id > lastSeen);
                const countEl = document.getElementById('fNotifCount');
                const listEl  = document.getElementById('fNotifList');
                const emptyEl = document.getElementById('fNotifEmpty');
                if(unread.length > 0) {
                    countEl.textContent = unread.length > 9 ? '9+' : unread.length;
                    countEl.style.display = '';
                    emptyEl.style.display = 'none';
                    listEl.innerHTML = '';
                    notices.slice(0, 5).forEach(n => {
                        const isNew = n.id > lastSeen;
                        listEl.innerHTML += `
                        <li>
                          <a href="#" class="dropdown-item py-2 px-3 border-bottom small">
                            <div class="d-flex gap-2 align-items-start">
                              <i class="bi bi-megaphone-fill text-success mt-1"></i>
                              <div>
                                <div class="fw-semibold">${n.title}</div>
                                <small class="text-muted">${n.notice_date || ''}</small>
                              </div>
                              ${isNew ? '<span class="badge bg-success ms-auto" style="font-size:0.6rem;">NEW</span>' : ''}
                            </div>
                          </a>
                        </li>`;
                    });
                }
            }).catch(()=>{});
    })();

    function fMarkAllRead() {
        fetch('/api/notices').then(r=>r.json()).then(n=>{
            if(n.length>0){ localStorage.setItem('fNotifLastSeen', n[0].id); location.reload(); }
        }).catch(()=>{});
    }
</script>