<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Dashboard - AbhiWeb</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="/css/style.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            font-family: 'Outfit', sans-serif;
            background-color: #f8f9fc;
        }

        .dashboard-header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 3.5rem 0;
            border-radius: 0 0 30px 30px;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(79, 172, 254, 0.3);
            position: relative;
            overflow: hidden;
        }

        .dashboard-header::after {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z' fill='%23ffffff' fill-opacity='0.1' fill-rule='evenodd'/%3E%3C/svg%3E");
            opacity: 0.8;
            z-index: 0;
            pointer-events: none;
        }

        .dashboard-header .container {
            position: relative;
            z-index: 1;
        }

        /* Glassmorphism Cards */
        .glass-card {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.4);
            border-radius: 20px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.07);
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

        .dashboard-card {
            cursor: pointer;
            overflow: hidden;
            position: relative;
        }

        .dashboard-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1) !important;
            background: rgba(255, 255, 255, 0.9);
        }

        /* Gradient Icons */
        .icon-gradient-1 { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .icon-gradient-2 { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }
        .icon-gradient-3 { background: linear-gradient(135deg, #f2994a 0%, #f2c94c 100%); }
        .icon-gradient-4 { background: linear-gradient(135deg, #ff0844 0%, #ffb199 100%); }

        .stat-icon {
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 16px;
            color: white;
            font-size: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #2b3452;
            line-height: 1.2;
        }

        /* Course List Items */
        .course-item {
            transition: all 0.2s ease;
            border-left: 4px solid transparent;
        }
        
        .course-item:hover {
            background-color: rgba(255, 255, 255, 0.9);
            border-left: 4px solid #4facfe;
            transform: translateX(5px);
        }

        .course-icon-wrapper {
            width: 80px;
            height: 80px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
            color: white;
        }
        
        .course-icon-wrapper.alt-1 { background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%); }
        .course-icon-wrapper.alt-2 { background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%); }
        .course-icon-wrapper.alt-3 { background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 99%, #fecfef 100%); }

        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }

        .empty-state {
            padding: 3rem 1rem;
            text-align: center;
            color: #6c757d;
        }
    </style>
</head>

<body>

    <!-- Header -->
    <jsp:include page="fheader.jsp" />

    <!-- Dashboard Hero -->
    <div class="dashboard-header text-center">
        <div class="container">
            <h1 class="display-5 fw-bold mb-3">Welcome back, ${name}! <i class="fas fa-hand-sparkles text-warning ms-2"></i></h1>
            <p class="lead mb-0 text-white-50">Here is an overview of your active classes and performance metrics.</p>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container mb-5 pb-4">

        <!-- Stats Row -->
        <div class="row g-4 mb-5">
            <!-- Active Courses -->
            <div class="col-xl-3 col-md-6">
                <div class="glass-card dashboard-card h-100 p-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="stat-icon icon-gradient-1 me-3">
                            <i class="fas fa-layer-group"></i>
                        </div>
                        <div>
                            <h6 class="text-muted fw-bold mb-0 text-uppercase" style="letter-spacing: 0.5px; font-size: 0.8rem;">Active Courses</h6>
                        </div>
                    </div>
                    <div class="stat-value">${courseCount}</div>
                    <div class="mt-2 text-success small fw-medium">
                        <i class="fas fa-arrow-up me-1"></i> Current Semester
                    </div>
                </div>
            </div>
            
            <!-- Total Students -->
            <div class="col-xl-3 col-md-6">
                <div class="glass-card dashboard-card h-100 p-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="stat-icon icon-gradient-2 me-3">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <div>
                            <h6 class="text-muted fw-bold mb-0 text-uppercase" style="letter-spacing: 0.5px; font-size: 0.8rem;">Total Students</h6>
                        </div>
                    </div>
                    <div class="stat-value">${totalStudents}</div>
                    <div class="mt-2 text-muted small fw-medium">
                        Across all enrolled classes
                    </div>
                </div>
            </div>

            <!-- Pending To Grade -->
            <div class="col-xl-3 col-md-6">
                <div class="glass-card dashboard-card h-100 p-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="stat-icon icon-gradient-3 me-3">
                            <i class="fas fa-clipboard-check"></i>
                        </div>
                        <div>
                            <h6 class="text-muted fw-bold mb-0 text-uppercase" style="letter-spacing: 0.5px; font-size: 0.8rem;">Pending Grading</h6>
                        </div>
                    </div>
                    <div class="stat-value text-warning">${pendingGrade}</div>
                    <div class="mt-2 text-warning small fw-medium">
                        <i class="fas fa-exclamation-circle me-1"></i> Requires attention
                    </div>
                </div>
            </div>

            <!-- Total Assignments -->
            <div class="col-xl-3 col-md-6">
                <div class="glass-card dashboard-card h-100 p-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="stat-icon icon-gradient-4 me-3">
                            <i class="fas fa-tasks"></i>
                        </div>
                        <div>
                            <h6 class="text-muted fw-bold mb-0 text-uppercase" style="letter-spacing: 0.5px; font-size: 0.8rem;">Total Assignments</h6>
                        </div>
                    </div>
                    <div class="stat-value">${assignmentCount}</div>
                    <div class="mt-2 text-success small fw-medium">
                        <i class="fas fa-check-circle me-1"></i> Successfully distributed
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Active Courses List -->
            <div class="col-lg-7">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold mb-0"><i class="fas fa-chalkboard-teacher me-2 text-primary"></i>Your Courses</h4>
                    <a href="/f-assignments" class="btn btn-sm btn-outline-primary rounded-pill px-3 fw-medium">View Assignments <i class="fas fa-arrow-right ms-1"></i></a>
                </div>

                <div class="glass-card p-2">
                    <c:choose>
                        <c:when test="${not empty courses}">
                            <c:forEach items="${courses}" var="course" varStatus="status">
                                <div class="course-item p-3 mb-2 rounded-3 d-flex align-items-center justify-content-between">
                                    <div class="d-flex align-items-center">
                                        <!-- Cycle through different gradient backgrounds based on index -->
                                        <div class="course-icon-wrapper alt-${status.index % 4} me-4 shadow-sm">
                                            <i class="fas fa-book-open fa-2x"></i>
                                        </div>
                                        <div>
                                            <h5 class="fw-bold mb-1 text-dark">${course.title}</h5>
                                            <p class="mb-0 text-muted small"><i class="fas fa-users me-1 text-secondary"></i> ${course.enrolledCount} Enrolled</p>
                                        </div>
                                    </div>
                                    <div>
                                        <button class="btn btn-light text-primary btn-sm rounded-circle shadow-sm" title="Course Options" disabled>
                                            <i class="fas fa-ellipsis-v"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-folder-open fa-3x text-muted mb-3 opacity-50"></i>
                                <h5>No Assigned Courses</h5>
                                <p class="text-muted mb-0">You have not been assigned to any active courses yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Analytics Sidebar -->
            <div class="col-lg-5">
                <h4 class="fw-bold mb-4"><i class="fas fa-chart-pie me-2 text-success"></i>Enrollment Overview</h4>
                
                <div class="glass-card p-4 mb-4">
                    <div class="chart-container">
                        <canvas id="enrollmentChart"></canvas>
                    </div>
                </div>

                <!-- Quick Action -->
                <div class="glass-card overflow-hidden">
                    <div class="p-4 bg-primary bg-gradient text-white text-center rounded-3">
                        <i class="fas fa-plus-circle fa-3x mb-3 text-white-50"></i>
                        <h5 class="fw-bold text-white mb-2">Create New Assignment</h5>
                        <p class="small text-white-50 mb-4">Quickly distribute a new task to your students.</p>
                        <a href="/f-assignments" class="btn btn-light text-primary fw-bold rounded-pill px-4 py-2 w-100 shadow-sm">
                            Get Started
                        </a>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="ffooter.jsp" />

    <!-- Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Chart Setup -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Prepare data from JSTL
            const courseNames = [];
            const studentCounts = [];
            
            <c:forEach items="${courses}" var="c">
                courseNames.push('${c.title}'.replace(/'/g, "\\'"));
                studentCounts.push(${c.enrolledCount});
            </c:forEach>

            const ctx = document.getElementById('enrollmentChart');
            
            if (ctx && courseNames.length > 0) {
                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: courseNames,
                        datasets: [{
                            label: 'Enrolled Students',
                            data: studentCounts,
                            backgroundColor: [
                                '#4facfe', // Blue
                                '#00f2fe', // Light Blue
                                '#f6d365', // Yellow
                                '#fda085', // Orange
                                '#a18cd1', // Purple
                                '#fbc2eb'  // Pink
                            ],
                            borderWidth: 2,
                            borderColor: '#ffffff',
                            hoverOffset: 10
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    usePointStyle: true,
                                    padding: 20,
                                    font: {
                                        family: "'Outfit', sans-serif",
                                        size: 12
                                    }
                                }
                            },
                            tooltip: {
                                backgroundColor: 'rgba(0, 0, 0, 0.8)',
                                padding: 12,
                                titleFont: {
                                    family: "'Outfit', sans-serif",
                                    size: 14
                                },
                                bodyFont: {
                                    family: "'Outfit', sans-serif",
                                    size: 13
                                },
                                cornerRadius: 8
                            }
                        },
                        cutout: '70%'
                    }
                });
            } else if (ctx) {
                // Display empty state for chart if no courses
                ctx.parentElement.innerHTML = '<div class="d-flex align-items-center justify-content-center h-100 text-muted flex-column"><i class="fas fa-chart-bar fa-3x mb-3 opacity-25"></i><p>Not enough data</p></div>';
            }
        });
    </script>
</body>

</html>
