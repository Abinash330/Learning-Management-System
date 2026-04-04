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
        <style>
            .dashboard-header {
                background: linear-gradient(135deg, #11998E 0%, #38EF7D 100%);
                color: white;
                padding: 3rem 0;
                border-radius: 0 0 20px 20px;
                margin-bottom: 2rem;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .dashboard-card {
                transition: transform 0.3s ease;
                cursor: pointer;
            }

            .dashboard-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
            }

            .progress {
                height: 10px;
                border-radius: 5px;
            }

            .activity-item {
                border-left: 2px solid #ddd;
                padding-left: 15px;
                position: relative;
            }

            .activity-item::before {
                content: '';
                width: 10px;
                height: 10px;
                background: #11998E;
                border-radius: 50%;
                position: absolute;
                left: -6px;
                top: 5px;
            }
        </style>
    </head>

    <body>

        <!-- Header -->
        <jsp:include page="fheader.jsp" />

        <!-- Dashboard Hero -->
        <div class="dashboard-header text-center">
            <div class="container">
                <h1 class="display-5 fw-bold">Welcome, Professor!</h1>
                <p class="lead mb-0">Overview of your classes and grading tasks.</p>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container mb-5">

            <!-- Stats Row -->
            <div class="row mb-5">
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card border-0 shadow-sm rounded-4 h-100 dashboard-card">
                        <div class="card-body d-flex align-items-center">
                            <div class="bg-primary text-white rounded-circle p-3 me-3">
                                <i class="fas fa-chalkboard-teacher fa-lg"></i>
                            </div>
                            <div>
                                <h6 class="text-muted mb-0">Active Courses</h6>
                                <h3 class="fw-bold mb-0">5</h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card border-0 shadow-sm rounded-4 h-100 dashboard-card">
                        <div class="card-body d-flex align-items-center">
                            <div class="bg-success text-white rounded-circle p-3 me-3">
                                <i class="fas fa-user-graduate fa-lg"></i>
                            </div>
                            <div>
                                <h6 class="text-muted mb-0">Total Students</h6>
                                <h3 class="fw-bold mb-0">120</h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card border-0 shadow-sm rounded-4 h-100 dashboard-card">
                        <div class="card-body d-flex align-items-center">
                            <div class="bg-warning text-white rounded-circle p-3 me-3">
                                <i class="fas fa-file-alt fa-lg"></i>
                            </div>
                            <div>
                                <h6 class="text-muted mb-0">Pending To Grade</h6>
                                <h3 class="fw-bold mb-0">34</h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card border-0 shadow-sm rounded-4 h-100 dashboard-card">
                        <div class="card-body d-flex align-items-center">
                            <div class="bg-info text-white rounded-circle p-3 me-3">
                                <i class="fas fa-clock fa-lg"></i>
                            </div>
                            <div>
                                <h6 class="text-muted mb-0">Upcoming Lectures</h6>
                                <h3 class="fw-bold mb-0">2</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Ongoing Classes -->
                <div class="col-lg-8">
                    <h4 class="fw-bold mb-4"><i class="fas fa-calendar-alt me-2 text-success"></i>Current Schedule</h4>

                    <div class="card border-0 shadow-sm rounded-4 mb-3">
                        <div class="row g-0 align-items-center">
                            <div class="col-md-3">
                                <div class="bg-dark text-white d-flex align-items-center justify-content-center h-100 p-4 rounded-start"
                                    style="min-height: 120px;">
                                    <i class="fab fa-java fa-3x"></i>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="card-body">
                                    <h5 class="card-title fw-bold">Java Programming 101</h5>
                                    <p class="card-text text-muted small">CS-302 | Room 405 | Due for mid-terms.</p>
                                    <div class="progress mb-2" style="height: 5px;">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 50%"
                                            aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">60 Enrolled Students</small>
                                        <button class="btn btn-sm btn-outline-success rounded-pill px-3">Manage</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm rounded-4 mb-3">
                        <div class="row g-0 align-items-center">
                            <div class="col-md-3">
                                <div class="bg-warning text-dark d-flex align-items-center justify-content-center h-100 p-4 rounded-start"
                                    style="min-height: 120px;">
                                    <i class="fab fa-js fa-3x"></i>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="card-body">
                                    <h5 class="card-title fw-bold">Javascript Front-End</h5>
                                    <p class="card-text text-muted small">CS-415 | Virtual Lab | Assignment #4</p>
                                    <div class="progress mb-2" style="height: 5px;">
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 80%"
                                            aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">45 Enrolled Students</small>
                                        <button
                                            class="btn btn-sm btn-outline-warning text-dark rounded-pill px-3">Manage</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm rounded-4 mb-3">
                        <div class="row g-0 align-items-center">
                            <div class="col-md-3">
                                <div class="bg-primary text-white d-flex align-items-center justify-content-center h-100 p-4 rounded-start"
                                    style="min-height: 120px;">
                                    <i class="fas fa-database fa-3x"></i>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="card-body">
                                    <h5 class="card-title fw-bold">SQL and Database Design</h5>
                                    <p class="card-text text-muted small">IT-200 | Room 102 | Introductory Phase</p>
                                    <div class="progress mb-2" style="height: 5px;">
                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 20%"
                                            aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">15 Enrolled Students</small>
                                        <button
                                            class="btn btn-sm btn-outline-primary text-dark rounded-pill px-3">Manage</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Sidebar -->
                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm rounded-4 mb-4">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-3">Teaching Schedule Overview</h5>
                            <div class="activity-item pb-3 mb-3">
                                <small class="text-dark fw-bold d-block">Today, 2:30 PM</small>
                                <strong>Virtual Lecture</strong> -> Object Oriented Programming.
                            </div>
                            <div class="activity-item pb-3 mb-3">
                                <small class="text-danger fw-bold d-block">Tomorrow, 9:00 AM</small>
                                <strong>Assignment Deadline</strong> -> Java Midterm Papers due.
                            </div>
                            <div class="activity-item pb-3 mb-3">
                                <small class="text-muted d-block">Thursday, 1:00 PM</small>
                                <strong>Staff Meeting</strong> -> Curriculum Review in Board Room A.
                            </div>
                            <div class="activity-item">
                                <small class="text-muted d-block">Friday, 11:30 AM</small>
                                <strong>Office Hours</strong> -> Open for student consultation.
                            </div>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm rounded-4 bg-success text-white p-4 text-center"
                        style="background: linear-gradient(135deg, #11998E 0%, #38EF7D 100%);">
                        <i class="fas fa-upload fa-3x mb-3 text-light"></i>
                        <h5 class="fw-bold">Upload Syllabus</h5>
                        <p class="small mb-3">Prepare structure for next semester classes.</p>
                        <button class="btn btn-light text-success fw-bold rounded-pill w-100">Add Materials</button>
                    </div>
                </div>

            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="ffooter.jsp" />

        <!-- Bootstrap Bundle JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>