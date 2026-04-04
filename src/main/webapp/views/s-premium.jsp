<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Go Premium</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="sheader.jsp" />
    <div class="container py-5 text-center">
        <i class="fa fa-medal fa-5x text-warning mb-4 shadow-sm rounded-circle p-4 bg-white"></i>
        <h1 class="display-5 fw-bold">Upgrade to Premium</h1>
        <p class="lead text-muted mb-5">Unlock all certificates, advanced projects, and 1-on-1 mentorship.</p>
        
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card border-primary shadow-lg rounded-4">
                    <div class="card-header bg-primary text-white py-3 fs-4 fw-bold">Pro Plan</div>
                    <div class="card-body py-5">
                        <h2 class="card-title pricing-card-title">$19<small class="text-muted fw-light">/mo</small></h2>
                        <ul class="list-unstyled mt-3 mb-4 text-start ms-5">
                            <li class="mb-2"><i class="fa fa-check text-success me-2"></i>Unlimited Course Access</li>
                            <li class="mb-2"><i class="fa fa-check text-success me-2"></i>Verified Certificates</li>
                            <li class="mb-2"><i class="fa fa-check text-success me-2"></i>Advanced Projects</li>
                            <li class="mb-2"><i class="fa fa-check text-success me-2"></i>Priority Support</li>
                        </ul>
                        <button type="button" class="w-100 btn btn-lg btn-primary rounded-pill mt-3">Get Started</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="sfooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
