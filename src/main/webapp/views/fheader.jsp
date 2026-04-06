<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    .faculty-header {
        background: rgba(255, 255, 255, 0.95);
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        position: sticky; top: 0; z-index: 1020;
        backdrop-filter: blur(15px);
        -webkit-backdrop-filter: blur(15px);
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
    }
    .faculty-header .nav-link {
        color: #4b5563 !important;
        font-weight: 600; font-size: 0.95rem;
        padding: 0.5rem 1rem; border-radius: 8px;
        margin-right: 5px;
        transition: all 0.3s ease;
        position: relative;
    }
    .faculty-header .nav-link:hover {
        color: #00f2fe !important;
        background: rgba(0, 242, 254, 0.05);
    }
    .faculty-header .nav-link.active-link {
        color: #00f2fe !important;
        background: rgba(0, 242, 254, 0.08);
    }
    .faculty-header .nav-link.active-link::after {
        content: ''; position: absolute;
        bottom: -5px; left: 50%; transform: translateX(-50%);
        width: 20px; height: 3px; border-radius: 3px;
        background-color: #00f2fe;
    }
    
    .faculty-badge {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        color: white; font-weight: 700; border-radius: 50px;
        padding: 0.4rem 1rem; font-size: 0.75rem; letter-spacing: 0.5px;
        box-shadow: 0 4px 10px rgba(0, 242, 254, 0.3);
    }
    
    .btn-notif {
        width: 38px; height: 38px; border-radius: 50%; border: none;
        background: #f1f5f9; color: #64748b; 
        display: flex; align-items: center; justify-content: center;
        transition: all 0.25s; cursor: pointer;
    }
    .btn-notif:hover { 
        background: #e2e8f0; 
        color: #00f2fe; 
        transform: translateY(-2px);
    }
    
    .faculty-brand {
        font-family: 'Outfit', sans-serif;
        font-weight: 800; font-size: 1.4rem; letter-spacing: -0.5px;
        color: #1e293b; text-decoration: none;
        display: flex; align-items: center;
    }
    .faculty-brand span { 
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
    
    .btn-logout {
        border: 2px solid transparent;
        background: #f8fafc;
        color: #ef4444;
        transition: all 0.3s ease;
    }
    .btn-logout:hover {
        background: #fee2e2;
        border-color: #fca5a5;
        transform: translateY(-1px);
    }
</style>

<header class="faculty-header py-2 px-3">
    <div class="container-fluid mx-auto px-lg-5 d-flex flex-wrap align-items-center justify-content-between gap-2">

        <!-- Brand -->
        <a href="/fdashboard" class="faculty-brand me-4">
            <div class="bg-primary text-white p-1 rounded me-2 d-flex align-items-center justify-content-center" style="background: linear-gradient(135deg, #4facfe, #00f2fe) !important; width: 32px; height: 32px;">
                <i class="fas fa-graduation-cap" style="font-size: 1rem;"></i>
            </div>
            EduPro<span>Faculty</span>
        </a>

        <!-- Nav Links -->
        <ul class="nav mb-0 d-none d-lg-flex mx-auto">
            <li><a href="/fdashboard" class="nav-link"><i class="fas fa-th-large me-2"></i>Dashboard</a></li>
            <li><a href="/f-assignments" class="nav-link"><i class="fas fa-book me-2"></i>Assignments</a></li>
            <li><a href="/addnotice" class="nav-link"><i class="fas fa-bullhorn me-2"></i>Post Notice</a></li>
        </ul>

        <!-- Right Controls -->
        <div class="d-flex align-items-center gap-3">
            <span class="faculty-badge d-none d-sm-inline">
                <i class="fas fa-user-tie me-1"></i> Professor Portal
            </span>

            <!-- 🔔 Notification Bell -->
            <div class="dropdown">
                <button class="btn-notif position-relative shadow-sm" id="fNotifBell" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-bell"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="fNotifCount" style="font-size:0.6rem;display:none; border: 2px solid white;">0</span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-4 p-0 mt-2" style="width:320px;max-height:400px;overflow-y:auto;" aria-labelledby="fNotifBell">
                    <li class="px-4 py-3 border-bottom d-flex justify-content-between align-items-center rounded-top-4" style="background:#f8fafc;">
                        <span class="fw-bold text-dark"><i class="fas fa-bell text-primary me-2"></i>Notifications</span>
                        <button class="btn btn-sm text-primary p-0 text-decoration-none fw-semibold" onclick="fMarkAllRead()">Mark read</button>
                    </li>
                    <div id="fNotifList">
                        <li class="px-3 py-5 text-center text-muted small" id="fNotifEmpty">
                            <i class="fas fa-bell-slash fa-3x mb-3 d-block text-black-50 opacity-25"></i>
                            <span class="fs-6">You're all caught up!</span>
                        </li>
                    </div>
                </ul>
            </div>

            <!-- Divider -->
            <div class="d-none d-md-block" style="height: 30px; width: 1px; background-color: #e2e8f0;"></div>

            <a href="/logout" class="btn btn-sm fw-bold rounded-pill px-4 py-2 btn-logout shadow-sm">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>
    </div>
</header>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Set active link visually based on current URL path
    document.addEventListener("DOMContentLoaded", () => {
        const path = window.location.pathname;
        const links = document.querySelectorAll(".faculty-header .nav-link");
        links.forEach(link => {
            if (link.getAttribute("href") === path) {
                link.classList.add("active-link");
            }
        });
    });

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
                          <a href="#" class="dropdown-item py-3 px-4 border-bottom transition" style="white-space: normal;">
                            <div class="d-flex gap-3 align-items-start">
                              <div class="bg-primary bg-opacity-10 text-primary p-2 rounded-circle mt-1" style="color: #00f2fe !important; background-color: rgba(0, 242, 254, 0.1) !important;">
                                  <i class="fas fa-bullhorn"></i>
                              </div>
                              <div class="flex-grow-1">
                                <div class="fw-bold mb-1 text-dark" style="font-size: 0.9rem;">${n.title}</div>
                                <small class="text-muted"><i class="far fa-clock me-1"></i>${n.noticeDate || 'Just now'}</small>
                              </div>
                              ${isNew ? '<span class="badge rounded-pill bg-primary mt-1" style="background: linear-gradient(135deg, #4facfe, #00f2fe) !important;">New</span>' : ''}
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
