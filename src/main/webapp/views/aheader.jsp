<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
    :root {
        --primary: #4f46e5;
        --secondary: #ec4899;
        --nav-bg: rgba(255, 255, 255, 0.92);
        --nav-text: #1e293b;
        --nav-border: rgba(255,255,255,0.3);
        --nav-shadow: rgba(0,0,0,0.05);
    }
    body.dark-mode {
        --nav-bg: rgba(15, 23, 42, 0.97) !important;
        --nav-text: #e2e8f0 !important;
        --nav-border: rgba(255,255,255,0.08) !important;
        --nav-shadow: rgba(0,0,0,0.4) !important;
        --card-bg: #1e293b !important;
        --body-bg: #0f172a !important;
        --text-main: #e2e8f0 !important;
        --text-muted: #94a3b8 !important;
        background-color: #0f172a !important;
        color: #e2e8f0 !important;
    }
    body.dark-mode .glass-card { background: #1e293b !important; border-color: rgba(255,255,255,0.08) !important; color: #e2e8f0 !important; }
    body.dark-mode .table-container { background: #1e293b !important; border-color: rgba(255,255,255,0.06) !important; }
    body.dark-mode .table tbody tr { background: #0f172a !important; }
    body.dark-mode .table tbody tr:hover { background: #1e293b !important; }
    body.dark-mode .table thead th { color: #94a3b8 !important; }
    body.dark-mode .table tbody td { color: #e2e8f0 !important; }
    body.dark-mode .op-card { background: #1e293b !important; }
    body.dark-mode .op-card:hover { background: #0f172a !important; }
    body.dark-mode h1,body.dark-mode h2,body.dark-mode h3,body.dark-mode h4,body.dark-mode h5,body.dark-mode h6 { color: #e2e8f0 !important; }
    body.dark-mode .text-dark { color: #e2e8f0 !important; }
    body.dark-mode .text-muted { color: #94a3b8 !important; }
    body.dark-mode .fw-bold.text-dark { color: #f1f5f9 !important; }
    body.dark-mode .modal-content { background: #1e293b !important; }
    body.dark-mode .modal-header, body.dark-mode .modal-body { background: #0f172a !important; }
    body.dark-mode .form-control, body.dark-mode .form-select { background: #1e293b !important; color: #e2e8f0 !important; border-color: rgba(255,255,255,0.1) !important; }

    .glass-header {
        background: var(--nav-bg);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        border-bottom: 1px solid var(--nav-border);
        box-shadow: 0 4px 30px var(--nav-shadow);
        position: sticky;
        top: 0;
        z-index: 1000;
        transition: all 0.3s ease;
    }

    .brand-logo {
        font-family: 'Inter', sans-serif;
        font-weight: 900;
        font-size: 1.5rem;
        letter-spacing: -0.5px;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        text-decoration: none;
    }

    .nav-link-custom {
        color: var(--nav-text);
        font-weight: 600;
        font-size: 0.95rem;
        padding: 0.5rem 1rem;
        margin: 0 0.25rem;
        border-radius: 8px;
        transition: all 0.3s ease;
        position: relative;
    }
    .nav-link-custom::after {
        content: ''; position: absolute; width: 0; height: 2px;
        bottom: 0; left: 50%; background: linear-gradient(90deg, var(--primary), var(--secondary));
        transition: all 0.3s ease; transform: translateX(-50%);
    }
    .nav-link-custom:hover { color: var(--primary); background: rgba(79,70,229,0.07); }
    .nav-link-custom:hover::after { width: 80%; }

    .role-badge {
        background: linear-gradient(135deg, #ef4444, #dc2626);
        color: white; font-weight: 700; border-radius: 50px;
        padding: 0.4rem 0.9rem; font-size: 0.78rem; letter-spacing: 0.5px;
        box-shadow: 0 4px 10px rgba(220,38,38,0.25);
    }
    .btn-logout {
        border: 2px solid #e2e8f0; border-radius: 50px; font-weight: 600;
        padding: 0.4rem 1.2rem; color: #64748b; background: white; transition: all 0.3s ease;
    }
    .btn-logout:hover { background: #f8fafc; border-color: #cbd5e1; color: #1e293b; transform: translateY(-2px); }
    body.dark-mode .btn-logout { background: rgba(255,255,255,0.07); border-color: rgba(255,255,255,0.15); color: #cbd5e1; }

    .search-pill {
        border-radius: 50px; padding: 0.5rem 1.5rem 0.5rem 2.5rem;
        border: 1px solid #e2e8f0; background: #f8fafc; transition: all 0.3s; color: var(--nav-text);
    }
    .search-pill:focus { border-color: var(--primary); background: white; box-shadow: 0 0 0 4px rgba(79,70,229,0.1); outline: none; }
    body.dark-mode .search-pill { background: rgba(255,255,255,0.06); border-color: rgba(255,255,255,0.12); color: #e2e8f0; }

    .dark-toggle {
        width: 38px; height: 38px; border-radius: 50%; border: 2px solid #e2e8f0;
        background: white; color: #64748b; display: flex; align-items: center; justify-content: center;
        cursor: pointer; transition: all 0.3s ease; font-size: 1rem;
    }
    .dark-toggle:hover { border-color: var(--primary); color: var(--primary); transform: rotate(20deg); }
    body.dark-mode .dark-toggle { background: rgba(255,255,255,0.08); border-color: rgba(255,255,255,0.2); color: #fbbf24; }

    .live-clock {
        font-size: 0.78rem; font-weight: 700; color: var(--nav-text); opacity: 0.6;
        font-family: 'Courier New', monospace; letter-spacing: 1px;
    }
</style>

<header class="glass-header py-2">
    <div class="container d-flex flex-wrap align-items-center justify-content-between gap-2">
        <a href="/" class="brand-logo d-flex align-items-center me-4">
            <i class="bi bi-hexagon-fill me-2 fs-4"></i> EduPro<span style="color:#1e293b;-webkit-text-fill-color:#1e293b;">Admin</span>
        </a>

        <ul class="nav mb-0 justify-content-center d-none d-lg-flex">
            <li><a href="/adashboard" class="nav-link nav-link-custom"><i class="bi bi-grid-1x2-fill me-1"></i> Dashboard</a></li>
            <li><a href="/users" class="nav-link nav-link-custom"><i class="bi bi-people-fill me-1"></i> Data Center</a></li>
            <li><a href="/addnotice" class="nav-link nav-link-custom"><i class="bi bi-broadcast me-1"></i> Publisher</a></li>
        </ul>

        <div class="d-flex align-items-center gap-2 gap-md-3">
            <span class="live-clock d-none d-md-inline" id="liveClock">--:--:--</span>

            <div class="position-relative d-none d-xl-block">
                <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted"></i>
                <input type="search" class="form-control search-pill" placeholder="Search systems..." style="width:180px;">
            </div>

            <button class="dark-toggle" id="darkToggleBtn" title="Toggle Dark Mode" onclick="toggleDarkMode()">
                <i class="bi bi-moon-stars-fill" id="darkIcon"></i>
            </button>

            <div class="role-badge d-none d-sm-flex align-items-center gap-1">
                <i class="bi bi-shield-lock-fill"></i> Root Access
            </div>

            <a href="/logout" class="btn btn-logout shadow-sm">
                Log Out <i class="bi bi-box-arrow-right ms-1"></i>
            </a>
        </div>
    </div>
</header>

<script>
    function updateClock() {
        const now = new Date();
        const h = String(now.getHours()).padStart(2,'0');
        const m = String(now.getMinutes()).padStart(2,'0');
        const s = String(now.getSeconds()).padStart(2,'0');
        const el = document.getElementById('liveClock');
        if(el) el.textContent = h+':'+m+':'+s;
    }
    setInterval(updateClock, 1000); updateClock();

    function toggleDarkMode() {
        document.body.classList.toggle('dark-mode');
        const isDark = document.body.classList.contains('dark-mode');
        localStorage.setItem('adminDarkMode', isDark ? '1' : '0');
        document.getElementById('darkIcon').className = isDark ? 'bi bi-sun-fill' : 'bi bi-moon-stars-fill';
    }
    (function(){
        if(localStorage.getItem('adminDarkMode') === '1'){
            document.body.classList.add('dark-mode');
            const icon = document.getElementById('darkIcon');
            if(icon) icon.className = 'bi bi-sun-fill';
        }
    })();
</script>