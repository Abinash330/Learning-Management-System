<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Department Management | EduPro Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root { --primary:#8b5cf6; --secondary:#d946ef; --dark-bg:#0f172a; --body-bg:#f8fafc; --text-main:#0f172a; --text-muted:#64748b; }
        body { background:var(--body-bg); font-family:'Inter',system-ui,sans-serif; color:var(--text-main); }

        .page-hero {
            background: linear-gradient(135deg,#0f172a 0%,#2e1065 60%,#4c1d95 100%);
            padding: 3.5rem 0 6rem; color: white;
            border-radius: 0 0 40px 40px;
            margin-bottom: -4rem;
            box-shadow: 0 20px 50px rgba(15,23,42,0.2);
            position: relative; overflow: hidden;
        }
        .hero-circle { position:absolute; border-radius:50%; filter:blur(50px); }
        .hc1 { width:250px;height:250px;background:rgba(139,92,246,0.3);top:-50px;right:8%; }
        .hc2 { width:200px;height:200px;background:rgba(217,70,239,0.2);bottom:-50px;left:5%; }

        .data-card {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(10px);
            border-radius: 24px; padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); 
            border: 1px solid rgba(255,255,255,0.5);
        }

        .filter-bar { background:rgba(255,255,255,0.9); border-radius:14px; padding:1rem 1.25rem; border:1px solid #e2e8f0; margin-bottom:1.25rem; }
        .search-input { border-radius:50px; border:1.5px solid #e2e8f0; padding:0.5rem 1rem 0.5rem 2.5rem; background:white; width:100%; font-weight:500; font-size:0.9rem; transition:all 0.3s; }
        .search-input:focus { border-color:var(--primary); box-shadow:0 0 0 4px rgba(139,92,246,0.1); outline:none; }

        .table { margin-bottom:0; border-collapse:separate; border-spacing:0 12px; margin-top:-8px; }
        .table thead th { border:none; background:transparent; color:var(--text-muted); font-weight:700; font-size:0.75rem; text-transform:uppercase; letter-spacing:1px; padding:0.75rem 1.25rem; }
        .table tbody tr { background:white; transition:all 0.3s cubic-bezier(0.4, 0, 0.2, 1); border-radius:14px; box-shadow: 0 4px 6px rgba(0,0,0,0.02);}
        .table tbody tr:hover { transform:translateY(-3px); box-shadow:0 12px 25px rgba(139,92,246,0.1); }
        .table tbody td { border:none!important; padding:1.25rem 1.25rem; vertical-align:middle; }
        .table tbody td:first-child { border-radius:14px 0 0 14px; }
        .table tbody td:last-child { border-radius:0 14px 14px 0; }

        .dept-icon { width:48px;height:48px;border-radius:14px;display:flex;align-items:center;justify-content:center;background:linear-gradient(135deg,rgba(139,92,246,0.15),rgba(217,70,239,0.15));color:var(--primary);font-size:1.25rem; }

        .btn-gradient { background:linear-gradient(135deg,var(--primary),var(--secondary)); color:white; border:none; font-weight:700; padding:0.6rem 1.5rem; border-radius:50px; transition:all 0.3s; box-shadow:0 4px 15px rgba(139,92,246,0.25); }
        .btn-gradient:hover { transform:translateY(-2px); box-shadow:0 8px 25px rgba(139,92,246,0.4); color:white; }

        .fade-up { animation:fadeUp 0.6s forwards; opacity:0; }
        .d1{animation-delay:0.1s;} .d2{animation-delay:0.2s;}
        @keyframes fadeUp { 0%{opacity:0;transform:translateY(20px);} 100%{opacity:1;transform:translateY(0);} }
        
        .chart-container { position: relative; height: 300px; width: 100%; display:flex; align-items:center; justify-content:center;}
    </style>
</head>
<body>
    <jsp:include page="aheader.jsp" />

    <!-- Hero -->
    <div class="page-hero text-center">
        <div class="hero-circle hc1"></div>
        <div class="hero-circle hc2"></div>
        <div class="container position-relative">
            <span class="badge px-3 py-2 rounded-pill fw-bold mb-3 d-inline-block" style="background:rgba(255,255,255,0.1);border:1px solid rgba(255,255,255,0.2);letter-spacing:1px;font-size:0.75rem;">
                <i class="bi bi-building me-1"></i> ORGANIZATION
            </span>
            <h1 class="display-6 fw-bold text-white mb-2" style="letter-spacing:-1px;">Departments & Facultys</h1>
            <p class="text-white mb-0" style="opacity:0.75;">Structure your institution dynamically for ease of access</p>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row fade-up d1">
            <!-- Table Column -->
            <div class="col-lg-8 mb-4">
                <div class="data-card h-100">
                    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
                        <div>
                            <h4 class="fw-bold m-0"><i class="bi bi-grid-1x2 text-primary me-2"></i>Campus Departments</h4>
                            <p class="text-muted small m-0 mt-1">Manage institutional departments</p>
                        </div>
                        <button class="btn btn-gradient shadow-sm btn-sm px-4" data-bs-toggle="modal" data-bs-target="#addDeptModal">
                            <i class="bi bi-plus-lg me-2"></i>New Dept
                        </button>
                    </div>

                    <div class="position-relative mb-4">
                        <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted"></i>
                        <input type="text" id="deptSearchInput" class="search-input" placeholder="Search departments..." oninput="filterDept()">
                    </div>

                    <div class="table-responsive">
                        <table class="table align-middle" id="deptTable">
                            <thead>
                                <tr>
                                    <th width="50%">Department Details</th>
                                    <th>Description</th>
                                    <th class="text-end">Manage</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="dept" items="${departments}">
                                    <tr data-name="${dept.name}">
                                        <td>
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="dept-icon"><i class="bi bi-mortarboard-fill"></i></div>
                                                <div>
                                                    <div class="fw-bold text-dark" style="font-size:1.05rem;">${dept.name}</div>
                                                    <div class="small text-muted fw-semibold">ID: #${dept.id}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <p class="m-0 text-muted small" style="max-width:200px; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; overflow:hidden;">${dept.description}</p>
                                        </td>
                                        <td class="text-end">
                                            <form method="post" action="/admin-departments/delete" class="m-0 p-0 d-inline">
                                                <input type="hidden" value="${dept.id}" name="id"/>
                                                <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3 shadow-sm" onclick="return confirm('Delete this department? Action cannot be undone.');">
                                                    <i class="bi bi-trash3 me-1"></i> Delete
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${empty departments}">
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-building-slash" style="font-size: 3rem; opacity:0.3"></i>
                                <p class="mt-3 fw-bold mb-0">No Departments Found</p>
                                <p class="small">Click "New Dept" to create one.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Visualization Column -->
            <div class="col-lg-4 mb-4 fade-up d2">
                <div class="data-card h-100 d-flex flex-column">
                    <h5 class="fw-bold mb-4"><i class="bi bi-pie-chart-fill text-secondary me-2"></i>Department Overview</h5>
                    <div class="chart-container flex-grow-1">
                        <canvas id="deptChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Modal -->
    <div class="modal fade" id="addDeptModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 border-0 shadow">
                <div class="modal-header bg-light border-0">
                    <h5 class="fw-bold modal-title"><i class="bi bi-building-add text-primary me-2"></i>Create Department</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="/admin-departments/add" method="post">
                    <div class="modal-body p-4 border-0">
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">Department Name</label>
                            <input type="text" name="name" class="form-control rounded-3 py-2" placeholder="e.g., Computer Science" required />
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">Description</label>
                            <textarea name="description" class="form-control rounded-3 py-2" rows="4" placeholder="Brief description of the department's core focus..." required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer bg-light border-0">
                        <button type="button" class="btn btn-light rounded-pill fw-bold" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-gradient">Save Department</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="afooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterDept() {
            const q = document.getElementById('deptSearchInput').value.toLowerCase().trim();
            document.querySelectorAll('#deptTable tbody tr').forEach(row => {
                const text = row.getAttribute('data-name').toLowerCase();
                row.style.display = (!q || text.includes(q)) ? '' : 'none';
            });
        }

        // Initialize Chart.js Doughnut
        document.addEventListener('DOMContentLoaded', function() {
            var ctx = document.getElementById('deptChart').getContext('2d');
            
            // Gather labels from the table for dynamic chart data
            var labels = [];
            document.querySelectorAll('#deptTable tbody tr').forEach(row => {
                let name = row.getAttribute('data-name');
                if(name) labels.push(name);
            });

            // If empty, show a placeholder
            if (labels.length === 0) {
                labels = ['No Data'];
                var data = [1];
                var colors = ['#e2e8f0'];
            } else {
                // Generate dummy distribution or real if we want to pass course counts later
                var data = labels.map(() => Math.floor(Math.random() * 15) + 5); 
                var colors = ['#8b5cf6', '#d946ef', '#0ea5e9', '#f59e0b', '#10b981', '#f43f5e'];
            }

            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: labels,
                    datasets: [{
                        data: data,
                        backgroundColor: colors,
                        borderWidth: 0,
                        hoverOffset: 10
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    cutout: '75%',
                    plugins: {
                        legend: { display:false },
                        tooltip: {
                            callbacks: {
                                label: function(context) { return '  ' + context.raw + ' items'; }
                            },
                            backgroundColor: 'rgba(15, 23, 42, 0.9)',
                            padding: 12,
                            cornerRadius: 8,
                            titleFont: {family:'Inter', size:14},
                            bodyFont: {family:'Inter', size:13}
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
