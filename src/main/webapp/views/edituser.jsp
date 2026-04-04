<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Identity | EduPro LMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary: #4f46e5;
            --body-bg: #f8fafc;
        }
        body {
            background-color: var(--body-bg);
            font-family: 'Inter', system-ui, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-wrapper {
            flex-grow: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 4rem 1rem;
        }
        .edit-card {
            background: white; border-radius: 24px; padding: 3rem; width: 100%; max-width: 600px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.08); border: 1px solid rgba(0,0,0,0.05);
            animation: slideUp 0.5s ease-out;
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .input-custom {
            border-radius: 12px; border: 2px solid #e2e8f0; padding: 1rem 1rem 1rem 3rem;
            background: #f8fafc; font-weight: 500; font-size: 1rem; color: #1e293b;
        }
        .input-custom:focus {
            border-color: var(--primary); background: white; box-shadow: 0 0 0 4px rgba(79,70,229,0.1);
        }
        .icon-wrap {
            position: absolute; left: 1rem; top: 1.1rem; color: #94a3b8; font-size: 1.2rem;
        }
    </style>
</head>
<body>
    <jsp:include page="aheader.jsp" />
    
    <div class="main-wrapper">
        <div class="edit-card">
            <div class="text-center mb-4">
                <div class="bg-primary bg-opacity-10 text-primary d-inline-flex p-3 rounded-circle mb-3" style="font-size: 2rem;">
                    <i class="bi bi-person-lines-fill"></i>
                </div>
                <h3 class="fw-bold m-0">Modify Identity</h3>
                <p class="text-muted">Update system record attributes</p>
            </div>

            <c:forEach var="user" items="${users_master}">
                <form action="/updateusers" method="post">
                    
                    <div class="mb-4 position-relative">
                        <label class="form-label small fw-bold text-muted">Primary Identifier (Cannot be changed)</label>
                        <i class="bi bi-envelope-at icon-wrap mt-4 pt-1"></i>
                        <input type="email" name="email" value="${user.email}" class="form-control input-custom" readonly style="background: #e2e8f0; cursor: not-allowed; opacity: 0.8;">
                    </div>

                    <div class="mb-4 position-relative">
                        <label class="form-label small fw-bold text-dark">Full Name</label>
                        <i class="bi bi-person icon-wrap mt-4 pt-1"></i>
                        <input type="text" name="name" value="${user.name}" class="form-control input-custom" required>
                    </div>

                    <div class="mb-4 position-relative">
                        <label class="form-label small fw-bold text-dark">Contact Number</label>
                        <i class="bi bi-phone icon-wrap mt-4 pt-1"></i>
                        <input type="text" name="mobile" value="${user.mobile}" class="form-control input-custom" required>
                    </div>

                    <div class="mb-5 position-relative">
                        <label class="form-label small fw-bold text-dark">Access Authorization Level</label>
                        <i class="bi bi-shield-check icon-wrap mt-4 pt-1 z-index-1" style="z-index: 10;"></i>
                        <select name="role" class="form-select input-custom ps-5" required>
                            <option value="Student" ${user.role == 'Student' ? 'selected' : ''}>Student Group</option>
                            <option value="Faculty" ${user.role == 'Faculty' ? 'selected' : ''}>Faculty Group</option>
                            <option value="Admin" ${user.role == 'Admin' ? 'selected' : ''}>Administrator</option>
                        </select>
                    </div>

                    <div class="d-flex gap-3">
                        <a href="/users" class="btn btn-light fw-bold px-4 py-3 rounded-3 flex-grow-1 text-muted">Cancel</a>
                        <button type="submit" class="btn btn-primary fw-bold px-4 py-3 rounded-3 flex-grow-1 shadow">
                            Commit Changes <i class="bi bi-check2-circle ms-1"></i>
                        </button>
                    </div>
                </form>
            </c:forEach>
        </div>
    </div>
    
    <jsp:include page="afooter.jsp" />
</body>
</html>