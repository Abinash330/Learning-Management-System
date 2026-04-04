<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .profile-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 4rem 0; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); }
        .avatar-upload { position: relative; max-width: 150px; margin: auto; }
        .avatar-upload .avatar-preview { width: 150px; height: 150px; position: relative; border-radius: 100%; border: 6px solid #fff; box-shadow: 0px 2px 10px rgba(0,0,0,0.1); }
        .avatar-upload .avatar-preview > div { width: 100%; height: 100%; border-radius: 100%; background-size: cover; background-repeat: no-repeat; background-position: center; }
        .avatar-upload .avatar-edit { position: absolute; right: 0; z-index: 1; top: 0; }
        .avatar-upload .avatar-edit input { display: none; }
        .avatar-upload .avatar-edit label { display: inline-block; width: 40px; height: 40px; margin-bottom: 0; border-radius: 100%; background: #FFFFFF; border: 1px solid transparent; box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.12); cursor: pointer; font-weight: normal; transition: all .2s ease-in-out; text-align: center; line-height: 40px; color: #757575; }
        .avatar-upload .avatar-edit label:hover { background: #f1f1f1; border-color: #d6d6d6; }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="sheader.jsp" />

    <div class="profile-header text-center">
        <div class="container">
            <h1 class="display-6 fw-bold">Account Hub</h1>
            <p class="mb-0 text-white-50">Manage your profile, settings, and get help.</p>
        </div>
    </div>

    <div class="container py-5" style="margin-top: -60px;">
        <div class="row">
            <div class="col-md-3">
                <div class="card border-0 shadow-sm rounded-4 mb-4">
                    <div class="card-body p-0">
                        <div class="nav flex-column nav-pills p-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                            <button class="nav-link text-start mb-2 px-4 ${param.tab == 'profile' || empty param.tab ? 'active' : ''}" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="true"><i class="fa fa-user me-3"></i> My Profile</button>
                            <button class="nav-link text-start mb-2 px-4 ${param.tab == 'settings' ? 'active' : ''}" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false"><i class="fa fa-cog me-3"></i> Settings</button>
                            <button class="nav-link text-start px-4 ${param.tab == 'help' ? 'active' : ''}" id="v-pills-help-tab" data-bs-toggle="pill" data-bs-target="#v-pills-help" type="button" role="tab" aria-controls="v-pills-help" aria-selected="false"><i class="fa fa-question-circle me-3"></i> Help & Support</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-9">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-5">
                        <div class="tab-content" id="v-pills-tabContent">
                        
                            <!-- Profile Tab -->
                            <div class="tab-pane fade ${param.tab == 'profile' || empty param.tab ? 'show active' : ''}" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
                                <h3 class="fw-bold mb-4">Profile Information</h3>
                                
                                <div class="avatar-upload mb-5">
                                    <div class="avatar-edit">
                                        <input type='file' id="imageUpload" accept=".png, .jpg, .jpeg" />
                                        <label for="imageUpload"><i class="fa fa-pencil-alt"></i></label>
                                    </div>
                                    <div class="avatar-preview">
                                        <div id="imagePreview"></div>
                                    </div>
                                </div>

                                <form>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label text-muted">Full Name</label>
                                            <input type="text" class="form-control rounded-3" value="${user.name}" readonly>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted">Email Address</label>
                                            <input type="email" class="form-control rounded-3" value="${user.email}" readonly>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted">Phone Number</label>
                                            <input type="text" class="form-control rounded-3" value="${user.mobile}" readonly>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted">Role</label>
                                            <input type="text" class="form-control rounded-3" value="${user.role}" readonly>
                                        </div>
                                        <div class="col-12 mt-4 text-end">
                                            <button type="button" class="btn btn-primary rounded-pill px-4">Update Profile</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            
                            <!-- Settings Tab -->
                            <div class="tab-pane fade ${param.tab == 'settings' ? 'show active' : ''}" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
                                <h3 class="fw-bold mb-4">Account Settings</h3>
                                <h5 class="fw-bold fs-6 mb-3">Change Password</h5>
                                <form>
                                    <div class="mb-3">
                                        <label class="form-label text-muted">Current Password</label>
                                        <input type="password" class="form-control rounded-3">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label text-muted">New Password</label>
                                        <input type="password" class="form-control rounded-3">
                                    </div>
                                    <div class="mb-4">
                                        <label class="form-label text-muted">Confirm New Password</label>
                                        <input type="password" class="form-control rounded-3">
                                    </div>
                                    
                                    <hr class="mb-4">
                                    
                                    <h5 class="fw-bold fs-6 mb-3">Notifications</h5>
                                    <div class="form-check form-switch mb-3">
                                        <input class="form-check-input" type="checkbox" id="emailNotif" checked>
                                        <label class="form-check-label" for="emailNotif">Email Notifications</label>
                                    </div>
                                    
                                    <div class="text-end mt-4">
                                        <button type="button" class="btn btn-primary rounded-pill px-4">Save Changes</button>
                                    </div>
                                </form>
                            </div>
                            
                            <!-- Help Tab -->
                            <div class="tab-pane fade ${param.tab == 'help' ? 'show active' : ''}" id="v-pills-help" role="tabpanel" aria-labelledby="v-pills-help-tab">
                                <h3 class="fw-bold mb-4">Help & Support</h3>
                                <p class="text-muted mb-4">Need help with your courses or account? Find answers below or contact our support team.</p>
                                
                                <div class="accordion accordion-flush bg-white" id="accordionFlushExample">
                                  <div class="accordion-item border rounded-3 mb-2">
                                    <h2 class="accordion-header">
                                      <button class="accordion-button collapsed rounded-3" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                                        How do I reset my password?
                                      </button>
                                    </h2>
                                    <div id="flush-collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
                                      <div class="accordion-body text-muted">You can reset your password from the Settings tab or on the Login page by clicking "Forgot Password".</div>
                                    </div>
                                  </div>
                                  <div class="accordion-item border rounded-3 mb-2">
                                    <h2 class="accordion-header">
                                      <button class="accordion-button collapsed rounded-3" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
                                        Where are my certificates?
                                      </button>
                                    </h2>
                                    <div id="flush-collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
                                      <div class="accordion-body text-muted">Completed certificates appear on your Dashboard once a course reaches 100% completion.</div>
                                    </div>
                                  </div>
                                </div>
                                
                                <div class="mt-5 p-4 bg-light rounded-4 text-center">
                                    <i class="fa fa-envelope fa-2x text-primary mb-3"></i>
                                    <h5>Still need help?</h5>
                                    <p class="text-muted small">Our support team is available 24/7 to assist you.</p>
                                    <a href="/contact" class="btn btn-outline-primary rounded-pill">Contact Support</a>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="sfooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set initial Avatar
        var initialAvatar = "https://ui-avatars.com/api/?name=" + encodeURIComponent("${user.name != null ? user.name : 'Student'}") + "&background=random&size=150";
        document.getElementById('imagePreview').style.backgroundImage = 'url(' + initialAvatar + ')';

        // Trigger generic avatar upload feature visually
        document.getElementById('imageUpload').addEventListener('change', function(e) {
            if (e.target.files && e.target.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('imagePreview').style.backgroundImage = 'url(' + e.target.result + ')';
                }
                reader.readAsDataURL(e.target.files[0]);
            }
        });
    </script>
</body>
</html>
