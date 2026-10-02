<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - EduPro LMS</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
</head>
<body class="bg-light">
    <div class="container py-5 text-center">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow-sm border-0 rounded-4 p-4 mt-5">
                    <div class="display-1 text-danger mb-3">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                    </div>
                    <h2 class="fw-bold text-dark">Something Went Wrong</h2>
                    <p class="text-muted mt-2">
                        <c:out value="${errorMessage}" default="The page or resource you are looking for encountered an unexpected problem." />
                    </p>
                    <div class="mt-4">
                        <a href="/" class="btn btn-primary rounded-pill px-4 py-2 fw-semibold">
                            <i class="bi bi-house-door me-1"></i> Back to Home
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
