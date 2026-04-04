<!-- <link rel="stylesheet" href="/css/bootstrap.min.css" />
<header class="p-3 text-bg-dark">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start"> <a href="/"
                class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none"> <svg class="bi me-2"
                    width="40" height="32" role="img" aria-label="Bootstrap">
                    <use xlink:href="#bootstrap"></use>
                </svg> </a>
            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="/sdashboard" class="nav-link px-2 text-secondary">Dashboard</a></li>
                <li><a href="/s-courses" class="nav-link px-2 text-white">My Courses</a></li>
                <li><a href="/s-assignments" class="nav-link px-2 text-white">Assignments</a></li>
                <li><a href="/contact" class="nav-link px-2 text-white">Contact Support</a></li>
            </ul>
            <form action="/s-search" method="GET" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3 d-flex" role="search"> 
                <input type="search" name="q" class="form-control form-control-dark text-bg-dark me-2" placeholder="Search Courses..." aria-label="Search">
                <button type="submit" class="btn btn-outline-light"><i class="fa fa-search"></i></button>
            </form>
            <div class="text-end d-flex align-items-center">
                <button id="darkModeToggle" class="btn btn-dark text-white border-0 me-3">
                    <i class="fa fa-moon"></i>
                </button>
                <div class="dropdown text-end">
                    <a href="#" class="d-block link-light text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="https://ui-avatars.com/api/?name=${name != null ? name : 'Student'}&background=random" alt="mdo" width="32" height="32" class="rounded-circle">
                    </a>
                    <ul class="dropdown-menu text-small dropdown-menu-end shadow" aria-labelledby="dropdownUser1">
                        <li><a class="dropdown-item" href="/s-profile?tab=profile">Profile</a></li>
                        <li><a class="dropdown-item" href="/s-profile?tab=settings">Settings</a></li>
                        <li><a class="dropdown-item" href="/s-profile?tab=help">Help</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="/logout"><i class="fa fa-sign-out-alt me-2"></i>Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Dark mode logic
        const toggleBtn = document.getElementById("darkModeToggle");
        const body = document.body;
        if(localStorage.getItem("theme") === "dark") {
            body.setAttribute("data-bs-theme", "dark");
            toggleBtn.innerHTML = '<i class="fa fa-sun text-warning"></i>';
        }
        toggleBtn.addEventListener("click", () => {
            if(body.getAttribute("data-bs-theme") === "dark") {
                body.removeAttribute("data-bs-theme");
                localStorage.setItem("theme", "light");
                toggleBtn.innerHTML = '<i class="fa fa-moon"></i>';
            } else {
                body.setAttribute("data-bs-theme", "dark");
                localStorage.setItem("theme", "dark");
                toggleBtn.innerHTML = '<i class="fa fa-sun text-warning"></i>';
            }
        });

        // SweetAlert Welcome (simulated on dashboard load if flag logic was present)
        if(window.location.pathname === "/sdashboard" && !sessionStorage.getItem("welcomed")) {
            Swal.fire({
                title: 'Welcome Back!',
                text: 'Your learning journey continues.',
                icon: 'success',
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true
            });
            sessionStorage.setItem("welcomed", "true");
        }
    });
</script> -->


<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="/css/bootstrap.min.css" />

<style>
    :root {
        --glass-bg: rgba(33, 37, 41, 0.9);
        --accent-color: #0d6efd;
    }

    body {
        font-family: 'Inter', sans-serif;
    }

    /* Glassmorphism Effect */
    .header-glass {
        background: var(--glass-bg);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        position: sticky;
        top: 0;
        z-index: 1020;
    }

    /* Modern Nav Links */
    .nav-link {
        font-weight: 500;
        transition: all 0.3s ease;
        position: relative;
        opacity: 0.85;
    }

    .nav-link:hover {
        opacity: 1;
        transform: translateY(-1px);
    }

    /* Underline animation */
    .nav-link::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: 0;
        left: 50%;
        background-color: var(--accent-color);
        transition: all 0.3s ease;
        transform: translateX(-50%);
    }

    .nav-link:hover::after {
        width: 70%;
    }

    /* Search Bar Styling */
    .search-input {
        background: rgba(255, 255, 255, 0.1) !important;
        border: 1px solid rgba(255, 255, 255, 0.2) !important;
        border-radius: 8px 0 0 8px !important;
        color: white !important;
        transition: all 0.3s ease;
    }

    .search-input:focus {
        background: rgba(255, 255, 255, 0.2) !important;
        box-shadow: none !important;
        border-color: var(--accent-color) !important;
    }

    .search-btn {
        border-radius: 0 8px 8px 0 !important;
        border-left: none !important;
    }

    /* Avatar Glow */
    .user-avatar {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border: 2px solid transparent;
    }

    .user-avatar:hover {
        transform: scale(1.1);
        box-shadow: 0 0 10px rgba(13, 110, 253, 0.5);
        border-color: var(--accent-color);
    }

    /* Dark Mode Toggle Animation */
    #darkModeToggle {
        transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }
    #darkModeToggle:active {
        transform: rotate(45deg) scale(0.9);
    }
</style>

<header class="p-3 header-glass">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            
            <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none me-4">
                <i class="fa-solid font-awesome-logo fa-graduation-cap fa-2xl text-primary"></i>
            </a>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="/sdashboard" class="nav-link px-3 text-white">Dashboard</a></li>
                <li><a href="/s-courses" class="nav-link px-3 text-white">My Courses</a></li>
                <li><a href="/s-assignments" class="nav-link px-3 text-white">Assignments</a></li>
                <li><a href="/contact" class="nav-link px-3 text-white-50">Support</a></li>
            </ul>

            <form action="/s-search" method="GET" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3 d-flex" role="search">
                <div class="input-group">
                    <input type="search" name="q" class="form-control search-input" placeholder="Search courses..." aria-label="Search">
                    <button type="submit" class="btn btn-primary search-btn">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </form>

            <div class="text-end d-flex align-items-center gap-2">
                <!-- 🌙 Dark Mode Toggle -->
                <button id="darkModeToggle" class="btn btn-link text-white text-decoration-none p-2">
                    <i class="fa-solid fa-moon fs-5"></i>
                </button>

                <!-- 🔔 Notification Bell -->
                <div class="dropdown">
                    <button class="btn btn-link text-white text-decoration-none p-2 position-relative" id="notifBell" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-bell fs-5"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="notifCount" style="font-size:0.6rem;display:none;">0</span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end shadow-lg border-secondary p-0" style="width:320px;max-height:400px;overflow-y:auto;" aria-labelledby="notifBell">
                        <li class="px-3 py-2 border-bottom border-secondary d-flex justify-content-between align-items-center">
                            <span class="fw-bold text-white">🔔 Notifications</span>
                            <button class="btn btn-sm btn-link text-primary p-0 text-decoration-none" onclick="markAllRead()">Mark all read</button>
                        </li>
                        <div id="notifList">
                            <li class="px-3 py-3 text-center text-muted small" id="notifEmpty">
                                <i class="fa-regular fa-bell-slash fa-2x mb-2 d-block"></i>No new notifications
                            </li>
                        </div>
                    </ul>
                </div>

                <!-- 👤 User Avatar Dropdown -->
                <div class="dropdown text-end">
                    <a href="#" class="d-block link-light text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="https://ui-avatars.com/api/?name=${name != null ? name : 'Student'}&background=0D6EFD&color=fff" alt="avatar" width="35" height="35" class="rounded-circle user-avatar">
                    </a>
                    <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end shadow-lg border-secondary" aria-labelledby="dropdownUser1">
                        <li><h6 class="dropdown-header">Welcome, ${name != null ? name : 'Student'}</h6></li>
                        <li><a class="dropdown-item" href="/s-profile?tab=profile"><i class="fa-regular fa-user me-2"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="/s-profile?tab=settings"><i class="fa-solid fa-gear me-2"></i> Settings</a></li>
                        <li><hr class="dropdown-divider border-secondary"></li>
                        <li><a class="dropdown-item text-danger" href="/logout"><i class="fa-solid fa-arrow-right-from-bracket me-2"></i> Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const toggleBtn = document.getElementById("darkModeToggle");
        const body = document.body;

        // Apply theme on load
        if(localStorage.getItem("theme") === "dark") {
            body.setAttribute("data-bs-theme", "dark");
            toggleBtn.innerHTML = '<i class="fa-solid fa-sun text-warning fs-5"></i>';
        }

        toggleBtn.addEventListener("click", () => {
            const isDark = body.getAttribute("data-bs-theme") === "dark";
            if(isDark) {
                body.removeAttribute("data-bs-theme");
                localStorage.setItem("theme", "light");
                toggleBtn.innerHTML = '<i class="fa-solid fa-moon fs-5"></i>';
            } else {
                body.setAttribute("data-bs-theme", "dark");
                localStorage.setItem("theme", "dark");
                toggleBtn.innerHTML = '<i class="fa-solid fa-sun text-warning fs-5"></i>';
            }
        });

        // Refined Toast notification
        if(window.location.pathname === "/sdashboard" && !sessionStorage.getItem("welcomed")) {
            const Toast = Swal.mixin({
                toast: true, position: 'top-end', showConfirmButton: false,
                timer: 3000, timerProgressBar: true, background: '#1a1d20', color: '#fff'
            });
            Toast.fire({ icon: 'success', title: 'Signed in successfully' });
            sessionStorage.setItem("welcomed", "true");
        }

        // ── 🔔 Notification Bell ──────────────────────────────
        (function loadNotifications() {
            fetch('/api/notices')
                .then(r => r.json())
                .then(notices => {
                    const lastSeen = parseInt(localStorage.getItem('notifLastSeen') || '0');
                    const unread = notices.filter(n => n.id > lastSeen);
                    const countEl = document.getElementById('notifCount');
                    const listEl  = document.getElementById('notifList');
                    const emptyEl = document.getElementById('notifEmpty');

                    if (unread.length > 0) {
                        countEl.textContent = unread.length > 9 ? '9+' : unread.length;
                        countEl.style.display = '';
                        emptyEl.style.display = 'none';
                        listEl.innerHTML = '';
                        notices.slice(0, 6).forEach(n => {
                            const isNew = n.id > lastSeen;
                            listEl.innerHTML += `
                            <li>
                              <a href="/s-assignments" class="dropdown-item py-2 px-3 border-bottom border-secondary ${isNew ? 'border-start border-primary border-3' : ''}">
                                <div class="d-flex gap-2 align-items-start">
                                  <i class="fa-solid fa-megaphone text-primary mt-1" style="font-size:0.85rem;"></i>
                                  <div>
                                    <div class="fw-semibold text-white" style="font-size:0.85rem;">${n.title}</div>
                                    <small class="text-muted">${n.notice_date || ''}</small>
                                  </div>
                                  ${isNew ? '<span class="badge bg-primary ms-auto" style="font-size:0.6rem;">NEW</span>' : ''}
                                </div>
                              </a>
                            </li>`;
                        });
                    } else {
                        countEl.style.display = 'none';
                    }
                }).catch(() => {/* API not ready yet — silent fail */});
        })();
    });

    function markAllRead() {
        fetch('/api/notices')
            .then(r => r.json())
            .then(notices => {
                if(notices.length > 0) {
                    localStorage.setItem('notifLastSeen', notices[0].id);
                    document.getElementById('notifCount').style.display = 'none';
                    document.getElementById('notifList').innerHTML = '';
                    document.getElementById('notifEmpty').style.display = '';
                }
            }).catch(()=>{});
    }
</script>