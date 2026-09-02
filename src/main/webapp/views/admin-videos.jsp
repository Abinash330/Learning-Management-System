<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Video Lectures – Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root { --primary: #4f46e5; --secondary: #ec4899; }
        body { background: #f8fafc; font-family: 'Inter', sans-serif; min-height: 100vh; }

        .page-banner {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 50%, #ec4899 100%);
            padding: 2rem 0 1.5rem; color: white;
            box-shadow: 0 4px 30px rgba(79,70,229,0.25);
        }
        .page-banner h1 { font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 1.9rem; }

        .stat-card {
            background: white; border-radius: 16px;
            padding: 1.2rem 1.5rem; box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            border-left: 4px solid;
            transition: transform 0.2s;
        }
        .stat-card:hover { transform: translateY(-3px); }
        .stat-card.purple { border-color: #7c3aed; }
        .stat-card.pink   { border-color: #ec4899; }
        .stat-card.blue   { border-color: #3b82f6; }
        .stat-num { font-size: 2rem; font-weight: 800; line-height: 1; }
        .stat-label { color: #64748b; font-size: 0.82rem; font-weight: 600; margin-top: 0.2rem; }

        .controls-bar {
            background: white; border-radius: 14px;
            padding: 0.9rem 1.4rem; box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            margin-bottom: 1.5rem;
            display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;
        }
        .controls-bar input, .controls-bar select {
            border: 1.5px solid #e2e8f0; border-radius: 10px;
            padding: 0.4rem 0.9rem; font-size: 0.88rem;
            transition: border-color 0.2s;
        }
        .controls-bar input:focus, .controls-bar select:focus { border-color: #4f46e5; outline: none; box-shadow: 0 0 0 3px rgba(79,70,229,0.1); }

        .video-card {
            background: white; border-radius: 18px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.07);
            overflow: hidden; height: 100%;
            transition: all 0.3s;
            border: 1px solid #f1f5f9;
        }
        .video-card:hover { transform: translateY(-5px); box-shadow: 0 16px 40px rgba(0,0,0,0.12); border-color: #c7d2fe; }

        .video-thumb {
            height: 175px; background: linear-gradient(135deg, #1e1b4b, #312e81);
            display: flex; align-items: center; justify-content: center;
            position: relative; overflow: hidden;
        }
        .video-thumb video { width: 100%; height: 100%; object-fit: cover; opacity: 0.7; }
        .play-btn {
            position: absolute; width: 52px; height: 52px;
            background: rgba(255,255,255,0.9); border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: #4f46e5; font-size: 1.3rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            transition: all 0.3s;
        }
        .video-card:hover .play-btn { transform: scale(1.1); background: white; }

        .uploader-badge {
            position: absolute; bottom: 8px; right: 8px;
            background: rgba(0,0,0,0.7); color: white;
            border-radius: 20px; padding: 0.2rem 0.6rem; font-size: 0.7rem;
        }
        .course-badge {
            position: absolute; top: 8px; left: 8px;
            background: linear-gradient(135deg, #4f46e5, #7c3aed);
            color: white; border-radius: 20px; padding: 0.2rem 0.7rem; font-size: 0.7rem; font-weight: 700;
        }

        .video-body { padding: 1rem 1.1rem 0.7rem; }
        .video-title { font-weight: 700; font-size: 0.97rem; color: #1e293b; margin-bottom: 0.25rem; line-height: 1.3; }
        .video-desc { color: #64748b; font-size: 0.81rem; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; margin-bottom: 0.6rem; }
        .video-meta { font-size: 0.74rem; color: #94a3b8; display: flex; gap: 0.6rem; flex-wrap: wrap; }
        .video-meta i { color: #4f46e5; }

        .video-actions { padding: 0.65rem 1.1rem; border-top: 1px solid #f1f5f9; display: flex; gap: 0.5rem; }
        .btn-edit-sm { background: #ede9fe; color: #4f46e5; border: none; border-radius: 8px; padding: 0.3rem 0.85rem; font-size: 0.8rem; font-weight: 600; transition: all 0.2s; }
        .btn-edit-sm:hover { background: #ddd6fe; color: #4f46e5; }
        .btn-del-sm  { background: #fee2e2; color: #ef4444; border: none; border-radius: 8px; padding: 0.3rem 0.85rem; font-size: 0.8rem; font-weight: 600; transition: all 0.2s; }
        .btn-del-sm:hover  { background: #fecaca; color: #ef4444; }

        .empty-state { text-align: center; padding: 5rem 2rem; background: white; border-radius: 20px; }

        /* Modal */
        .modal-content { border-radius: 20px; border: none; box-shadow: 0 25px 60px rgba(0,0,0,0.15); }
        .modal-header { background: linear-gradient(135deg, #4f46e5, #7c3aed); color: white; border-radius: 20px 20px 0 0; border: none; }
        .btn-modal-primary { background: linear-gradient(135deg, #4f46e5, #7c3aed); border: none; color: white; border-radius: 10px; font-weight: 700; }
        .btn-modal-primary:hover { opacity: 0.9; color: white; }

        .drop-zone {
            border: 2px dashed #c7d2fe; border-radius: 12px;
            padding: 2rem; text-align: center; cursor: pointer;
            transition: all 0.3s; background: #fafaff;
        }
        .drop-zone:hover { border-color: #4f46e5; background: #ede9fe; }
        .drop-zone.dragover { border-color: #4f46e5; background: #ede9fe; }
    </style>
</head>
<body>
    <%@ include file="aheader.jsp" %>

    <div class="page-banner">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                <div>
                    <h1><i class="fas fa-video me-3"></i>All Video Lectures</h1>
                    <p class="mb-0 opacity-75">Full administrative control over all course videos</p>
                </div>
                <button class="btn btn-light fw-bold rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#uploadModal">
                    <i class="fas fa-plus me-2" style="color:#4f46e5;"></i>Upload Video
                </button>
            </div>
        </div>
    </div>

    <div class="container py-4">
        <!-- Stats -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="stat-card purple">
                    <div class="stat-num" style="color:#7c3aed;">${videos.size()}</div>
                    <div class="stat-label"><i class="fas fa-video me-1"></i>Total Videos</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card blue">
                    <div class="stat-num" style="color:#3b82f6;">${courses.size()}</div>
                    <div class="stat-label"><i class="fas fa-book me-1"></i>Courses with Videos</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card pink">
                    <div class="stat-num" style="color:#ec4899;">${facultyList.size()}</div>
                    <div class="stat-label"><i class="fas fa-chalkboard-teacher me-1"></i>Active Faculty</div>
                </div>
            </div>
        </div>

        <!-- Controls -->
        <div class="controls-bar">
            <i class="fas fa-filter" style="color:#4f46e5;"></i>
            <input type="search" id="vsearch" placeholder="🔍 Search by title..." oninput="filterVids()" style="min-width:200px;">
            <select id="vcourse" onchange="filterVids()">
                <option value="">All Courses</option>
                <c:forEach var="c" items="${courses}">
                    <option value="${c.title}">${c.title}</option>
                </c:forEach>
            </select>
            <select id="vfaculty" onchange="filterVids()">
                <option value="">All Faculty</option>
                <c:forEach var="f" items="${facultyList}">
                    <option value="${f.name}">${f.name}</option>
                </c:forEach>
            </select>
            <span class="ms-auto text-secondary" style="font-size:0.85rem;" id="vcount">${videos.size()} videos</span>
        </div>

        <!-- Grid -->
        <c:choose>
            <c:when test="${empty videos}">
                <div class="empty-state">
                    <i class="fas fa-video fa-3x mb-3" style="color:#c7d2fe;"></i>
                    <h5 class="text-muted">No videos uploaded yet</h5>
                    <button class="btn btn-modal-primary mt-3 px-4" data-bs-toggle="modal" data-bs-target="#uploadModal">Upload First Video</button>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4" id="vGrid">
                    <c:forEach var="v" items="${videos}">
                        <div class="col-md-6 col-xl-4 v-item"
                             data-title="${v.title.toLowerCase()}"
                             data-course="${v.course.title}"
                             data-faculty="${v.uploadedBy != null ? v.uploadedBy.name : ''}">
                            <div class="video-card">
                                <div class="video-thumb">
                                    <video muted preload="metadata" onmouseenter="this.play()" onmouseleave="this.pause();this.currentTime=0;">
                                        <source src="/videos/stream/${v.id}" type="video/mp4">
                                    </video>
                                    <span class="course-badge">${v.course.title}</span>
                                    <div class="play-btn"><i class="fas fa-play ms-1"></i></div>
                                    <c:if test="${v.uploadedBy != null}">
                                        <span class="uploader-badge"><i class="fas fa-user-tie me-1"></i>${v.uploadedBy.name}</span>
                                    </c:if>
                                </div>
                                <div class="video-body">
                                    <div class="video-title">${v.title}</div>
                                    <div class="video-desc">${v.description}</div>
                                    <div class="video-meta">
                                        <span><i class="fas fa-file-video me-1"></i>${v.originalFileName}</span>
                                        <span><i class="fas fa-calendar me-1"></i>${v.uploadedAt != null ? v.uploadedAt.toLocalDate() : 'N/A'}</span>
                                    </div>
                                </div>
                                <div class="video-actions">
                                    <a href="/videos/edit/${v.id}" class="btn-edit-sm"><i class="fas fa-edit me-1"></i>Edit</a>
                                    <form method="post" action="/videos/delete/${v.id}" onsubmit="return confirm('Delete video: ${v.title}?')" class="d-inline">
                                        <button type="submit" class="btn-del-sm"><i class="fas fa-trash me-1"></i>Delete</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Upload Modal -->
    <div class="modal fade" id="uploadModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold"><i class="fas fa-cloud-upload-alt me-2"></i>Upload Video Lecture</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="/videos/upload" enctype="multipart/form-data">
                    <div class="modal-body p-4">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label fw-semibold text-secondary">Video Title *</label>
                                <input type="text" name="title" class="form-control" placeholder="Lecture title" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold text-secondary">Description</label>
                                <textarea name="description" class="form-control" rows="3" placeholder="What this lecture covers..."></textarea>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold text-secondary">Course *</label>
                                <select name="course_id" class="form-select" required>
                                    <option value="">-- Select Course --</option>
                                    <c:forEach var="c" items="${courses}">
                                        <option value="${c.id}">${c.title}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold text-secondary">Video File *</label>
                                <div class="drop-zone" onclick="document.getElementById('adminVideoFile').click()">
                                    <i class="fas fa-film fa-2x mb-2" style="color:#4f46e5;"></i>
                                    <p class="mb-1 fw-semibold text-primary" id="adminDzText">Click or drag & drop your video</p>
                                    <small class="text-muted">MP4, WebM, OGG — max 500 MB</small>
                                </div>
                                <input type="file" id="adminVideoFile" name="file" accept="video/*" required style="display:none;" onchange="document.getElementById('adminDzText').textContent='✅ ' + this.files[0].name">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0 px-4 pb-4">
                        <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-modal-primary px-5 rounded-pill"><i class="fas fa-upload me-2"></i>Upload</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterVids() {
            const q = document.getElementById('vsearch').value.toLowerCase();
            const course = document.getElementById('vcourse').value;
            const faculty = document.getElementById('vfaculty').value;
            let visible = 0;
            document.querySelectorAll('.v-item').forEach(el => {
                const match = (!q || el.dataset.title.includes(q))
                    && (!course || el.dataset.course === course)
                    && (!faculty || el.dataset.faculty === faculty);
                el.style.display = match ? '' : 'none';
                if (match) visible++;
            });
            document.getElementById('vcount').textContent = visible + ' videos';
        }

        const dz2 = document.querySelector('.drop-zone');
        if (dz2) {
            dz2.addEventListener('dragover', e => { e.preventDefault(); dz2.classList.add('dragover'); });
            dz2.addEventListener('dragleave', () => dz2.classList.remove('dragover'));
            dz2.addEventListener('drop', e => {
                e.preventDefault(); dz2.classList.remove('dragover');
                document.getElementById('adminVideoFile').files = e.dataTransfer.files;
                document.getElementById('adminDzText').textContent = '✅ ' + e.dataTransfer.files[0].name;
            });
        }
    </script>
</body>
</html>
