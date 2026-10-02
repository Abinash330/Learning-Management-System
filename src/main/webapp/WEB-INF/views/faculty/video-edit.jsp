<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Video – ${video.title}</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #0f172a; color: #e2e8f0; font-family: 'Inter', sans-serif; min-height: 100vh; }
        .edit-card {
            background: #1e293b; border: 1px solid rgba(79,172,254,0.18);
            border-radius: 20px; padding: 2rem; max-width: 720px; margin: 3rem auto;
            box-shadow: 0 20px 60px rgba(0,0,0,0.4);
        }
        .edit-title { font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 1.6rem; color: #f1f5f9; }
        .edit-title span { background: linear-gradient(135deg, #4facfe, #00f2fe); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .form-label { color: #94a3b8; font-size: 0.84rem; font-weight: 600; margin-bottom: 0.3rem; }
        .form-control, .form-select {
            background: rgba(15,23,42,0.7) !important; border: 1.5px solid rgba(79,172,254,0.22) !important;
            color: #e2e8f0 !important; border-radius: 10px !important;
        }
        .form-control:focus, .form-select:focus { border-color: #4facfe !important; box-shadow: 0 0 0 3px rgba(79,172,254,0.15) !important; }
        option { background: #1e293b; }
        .btn-save { background: linear-gradient(135deg, #4facfe, #00f2fe); color: #0f172a; border: none; border-radius: 12px; font-weight: 800; padding: 0.6rem 2rem; transition: all 0.3s; }
        .btn-save:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0,242,254,0.3); }
        .btn-back { background: rgba(255,255,255,0.07); border: 1px solid rgba(255,255,255,0.12); color: #94a3b8; border-radius: 12px; font-weight: 600; padding: 0.6rem 1.5rem; transition: all 0.2s; }
        .btn-back:hover { background: rgba(255,255,255,0.12); color: #e2e8f0; }
        .preview-box { background: #000; border-radius: 12px; overflow: hidden; margin-bottom: 1rem; }
        .preview-box video { width: 100%; max-height: 260px; display: block; }
        .file-note { color: #64748b; font-size: 0.8rem; margin-top: 0.4rem; }
    </style>
</head>
<body>
    <c:choose>
        <c:when test="${isAdmin}"><%@ include file="aheader.jsp" %></c:when>
        <c:otherwise><%@ include file="fheader.jsp" %></c:otherwise>
    </c:choose>

    <div class="container">
        <div class="edit-card">
            <h2 class="edit-title mb-4"><i class="fas fa-edit me-2" style="color:#4facfe;"></i>Edit <span>Video</span></h2>

            <div class="preview-box">
                <video controls preload="metadata">
                    <source src="/videos/stream/${video.id}" type="video/mp4">
                </video>
            </div>

            <form method="post" action="/videos/edit/${video.id}" enctype="multipart/form-data">
                <div class="mb-3">
                    <label class="form-label">Video Title *</label>
                    <input type="text" name="title" class="form-control" value="${video.title}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3">${video.description}</textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Course *</label>
                    <select name="course_id" class="form-select" required>
                        <c:forEach var="c" items="${courses}">
                            <option value="${c.id}" ${c.id == video.course.id ? 'selected="selected"' : ''}>${c.title}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-4">
                    <label class="form-label">Replace Video File <span style="color:#64748b;">(optional — leave blank to keep current)</span></label>
                    <input type="file" name="file" class="form-control" accept="video/*">
                    <div class="file-note"><i class="fas fa-file-video me-1"></i>Current file: ${video.originalFileName}</div>
                </div>
                <div class="d-flex gap-3">
                    <button type="submit" class="btn btn-save"><i class="fas fa-save me-2"></i>Save Changes</button>
                    <a href="${isAdmin ? '/admin/videos' : '/videos'}" class="btn btn-back"><i class="fas fa-arrow-left me-1"></i>Cancel</a>
                </div>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
