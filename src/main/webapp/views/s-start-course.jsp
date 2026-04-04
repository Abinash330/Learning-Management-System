<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Player</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .player-container { background: #000; height: 500px; display: flex; align-items: center; justify-content: center; color: #fff; }
    </style>
</head>
<body>
    <jsp:include page="sheader.jsp" />
    <div class="container mt-4 mb-5">
        <div class="row">
            <div class="col-lg-8">
                <div class="player-container rounded-4 mb-3 shadow">
                    <h3><i class="fa fa-play-circle fa-3x text-white opacity-50"></i></h3>
                </div>
                <h2>Advanced Java Programming</h2>
                <p class="text-muted">Chapter 4: Streams & Lambda Expressions</p>
                <p>In this lesson we cover the basics of the Java Stream API...</p>
            </div>
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-white fw-bold">Course Content</div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item bg-light"><i class="fa fa-play-circle text-primary me-2"></i> 1. Introduction</li>
                        <li class="list-group-item"><i class="fa fa-lock text-muted me-2"></i> 2. Deep Dive inside Streams</li>
                        <li class="list-group-item"><i class="fa fa-lock text-muted me-2"></i> 3. Lambda Syntax</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="sfooter.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</body>
</html>
