<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Lectures – Faculty Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --teal: #00f2fe;
            --blue: #4facfe;
            --dark: #0f172a;
            --card-bg: #1e293b;
            --text: #e2e8f0;
            --muted: #94a3b8;
        }
        * { box-sizing: border-box; }
        body { background: var(--dark); color: var(--text); font-family: 'Inter', sans-serif; min-height: 100vh; }

        /* Hero Banner */
        .page-hero {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #0f2044 100%);
            border-bottom: 1px solid rgba(79,172,254,0.15);
            padding: 2rem 0 1.5rem;
            position: relative;
            overflow: hidden;
        }
        .page-hero::before {
            content: '';
            position: absolute; top: -60px; right: -60px;
            width: 340px; height: 340px;
            background: radial-gradient(circle, rgba(0,242,254,0.08) 0%, transparent 70%);
            border-radius: 50%;
        }
        .page-hero h1 { font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 2rem; }
        .page-hero h1 span { background: linear-gradient(135deg, #4facfe, #00f2fe); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }

        /* Stat Cards */
        .stat-pill {
            background: rgba(79,172,254,0.08);
            border: 1px solid rgba(79,172,254,0.2);
            border-radius: 14px;
            padding: 0.6rem 1.2rem;
            display: inline-flex; align-items: center; gap: 0.5rem;
        }
        .stat-pill .num { font-size: 1.4rem; font-weight: 800; background: linear-gradient(135deg, #4facfe, #00f2fe); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }

        /* Upload Button */
        .btn-upload {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            color: #0f172a; font-weight: 700; border: none;
            border-radius: 12px; padding: 0.55rem 1.4rem;
            transition: all 0.3s;
        }
        .btn-upload:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0,242,254,0.35); color: #0f172a; }

        /* Video Card */
        .video-card {
            background: var(--card-bg);
            border: 1px solid rgba(255,255,255,0.07);
            border-radius: 18px;
            overflow: hidden;
            transition: all 0.35s cubic-bezier(.4,0,.2,1);
            height: 100%;
        }
        .video-card:hover { transform: translateY(-6px); border-color: rgba(79,172,254,0.4); box-shadow: 0 20px 40px rgba(0,0,0,0.4), 0 0 0 1px rgba(79,172,254,0.15); }

        .video-thumb {
            position: relative;
            background: linear-gradient(135deg, #0f2044, #1a1040);
            height: 180px;
            display: flex; align-items: center; justify-content: center;
            overflow: hidden;
        }
        .video-thumb video {
            width: 100%; height: 100%; object-fit: cover; opacity: 0.6;
        }
        .play-overlay {
            position: absolute; width: 56px; height: 56px;
            background: rgba(0,242,254,0.9); border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem; color: #0f172a;
            transition: all 0.3s; cursor: pointer;
        }
        .video-card:hover .play-overlay { transform: scale(1.1); box-shadow: 0 0 30px rgba(0,242,254,0.5); }

        .course-badge {
            position: absolute; top: 10px; left: 10px;
            background: rgba(15,23,42,0.85);
            border: 1px solid rgba(79,172,254,0.3);
            color: #4facfe; font-size: 0.7rem; font-weight: 700;
            padding: 0.2rem 0.6rem; border-radius: 20px;
            backdrop-filter: blur(8px);
        }

        .video-body { padding: 1.1rem 1.2rem 0.8rem; }
        .video-title { font-weight: 700; font-size: 1rem; color: #f1f5f9; margin-bottom: 0.35rem; line-height: 1.3; }
        .video-desc { color: var(--muted); font-size: 0.83rem; line-height: 1.5; margin-bottom: 0.75rem;
            display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
        .video-meta { display: flex; gap: 0.5rem; align-items: center; color: var(--muted); font-size: 0.75rem; flex-wrap: wrap; }
        .video-meta i { color: #4facfe; }

        .video-actions { padding: 0.75rem 1.2rem; border-top: 1px solid rgba(255,255,255,0.06); display: flex; gap: 0.5rem; }
        .btn-edit-v { background: rgba(79,172,254,0.1); border: 1px solid rgba(79,172,254,0.3); color: #4facfe; border-radius: 8px; padding: 0.35rem 0.9rem; font-size: 0.82rem; font-weight: 600; transition: all 0.2s; }
        .btn-edit-v:hover { background: rgba(79,172,254,0.22); color: #4facfe; }
        .btn-del-v { background: rgba(239,68,68,0.1); border: 1px solid rgba(239,68,68,0.3); color: #ef4444; border-radius: 8px; padding: 0.35rem 0.9rem; font-size: 0.82rem; font-weight: 600; transition: all 0.2s; }
        .btn-del-v:hover { background: rgba(239,68,68,0.22); color: #ef4444; }

        /* Empty State */
        .empty-state { text-align: center; padding: 5rem 2rem; }
        .empty-state .icon-wrap { width: 90px; height: 90px; background: rgba(79,172,254,0.08); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; }

        /* Modal */
        .modal-content { background: #1e293b; border: 1px solid rgba(79,172,254,0.2); border-radius: 20px; }
        .modal-header { border-bottom: 1px solid rgba(255,255,255,0.07); background: rgba(15,23,42,0.6); border-radius: 20px 20px 0 0; }
        .modal-title { font-family: 'Outfit', sans-serif; font-weight: 800; }
        .form-control, .form-select {
            background: rgba(15,23,42,0.7) !important;
            border: 1px solid rgba(79,172,254,0.2) !important;
            color: #e2e8f0 !important; border-radius: 10px !important;
        }
        .form-control:focus, .form-select:focus { border-color: #4facfe !important; box-shadow: 0 0 0 3px rgba(79,172,254,0.15) !important; }
        .form-label { color: #94a3b8; font-size: 0.85rem; font-weight: 600; }

        /* Drop zone */
        .drop-zone {
            border: 2px dashed rgba(79,172,254,0.35);
            border-radius: 14px;
            padding: 2rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: rgba(79,172,254,0.03);
        }
        .drop-zone:hover, .drop-zone.dragover { border-color: #00f2fe; background: rgba(79,172,254,0.08); }
        .drop-zone .dz-icon { font-size: 2.5rem; color: #4facfe; margin-bottom: 0.5rem; }

        /* Progress bar during upload */
        .upload-progress { display: none; margin-top: 0.75rem; }

        /* Filter bar */
        .filter-bar { background: rgba(30,41,59,0.6); border: 1px solid rgba(255,255,255,0.07); border-radius: 14px; padding: 0.75rem 1.2rem; margin-bottom: 1.5rem; }
        .filter-bar select { background: rgba(15,23,42,0.7); border: 1px solid rgba(79,172,254,0.2); color: #e2e8f0; border-radius: 8px; padding: 0.4rem 0.8rem; }
        .filter-bar select:focus { border-color: #4facfe; outline: none; }

        /* Scrollbar */
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: rgba(79,172,254,0.3); border-radius: 3px; }
    </style>
</head>
<body>
    <%@ include file="fheader.jsp" %>

    <!-- Hero -->
    <div class="page-hero">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                <div>
                    <h1>📹 My <span>Video Lectures</span></h1>
                    <p class="text-secondary mb-0">Upload and manage course videos for your students</p>
                </div>
                <div class="d-flex gap-3 align-items-center">
                    <div class="stat-pill"><i class="fas fa-video" style="color:#4facfe;"></i><span class="num">${videos.size()}</span><span style="color:#94a3b8;font-size:0.85rem;">Videos</span></div>
                    <button class="btn btn-upload" data-bs-toggle="modal" data-bs-target="#uploadModal">
                        <i class="fas fa-cloud-upload-alt me-2"></i>Upload Video
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="container py-4">

        <!-- Filter Bar -->
        <div class="filter-bar d-flex align-items-center gap-3 flex-wrap">
            <i class="fas fa-filter" style="color:#4facfe;"></i>
            <span style="color:#94a3b8;font-size:0.9rem;font-weight:600;">Filter by course:</span>
            <select id="courseFilter" onchange="filterVideos(this.value)">
                <option value="all">All Courses</option>
                <c:forEach var="c" items="${courses}">
                    <option value="${c.id}">${c.title}</option>
                </c:forEach>
            </select>
            <input type="search" id="videoSearch" class="form-control form-control-sm" style="max-width:220px;background:rgba(15,23,42,0.7);border:1px solid rgba(79,172,254,0.2);color:#e2e8f0;border-radius:8px;" placeholder="🔍 Search videos..." oninput="searchVideos(this.value)">
        </div>

        <!-- Video Grid -->
        <c:choose>
            <c:when test="${empty videos}">
                <div class="empty-state">
                    <div class="icon-wrap"><i class="fas fa-video" style="color:#4facfe;font-size:2rem;"></i></div>
                    <h4 style="color:#f1f5f9;font-family:'Outfit',sans-serif;font-weight:800;">No Videos Yet</h4>
                    <p style="color:#94a3b8;">Upload your first lecture video to get started!</p>
                    <button class="btn btn-upload px-4" data-bs-toggle="modal" data-bs-target="#uploadModal">
                        <i class="fas fa-plus me-2"></i>Upload First Video
                    </button>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4" id="videoGrid">
                    <c:forEach var="v" items="${videos}">
                        <div class="col-md-6 col-xl-4 video-item" data-course="${v.course.id}" data-title="${v.title.toLowerCase()}">
                            <div class="video-card">
                                <div class="video-thumb">
                                    <video muted preload="metadata" onmouseenter="this.play()" onmouseleave="this.pause();this.currentTime=0;">
                                        <source src="/videos/stream/${v.id}" type="video/mp4">
                                    </video>
                                    <span class="course-badge"><i class="fas fa-book me-1"></i>${v.course.title}</span>
                                    <div class="play-overlay" onclick="window.location='/videos/stream/${v.id}'">
                                        <i class="fas fa-play ms-1"></i>
                                    </div>
                                </div>
                                <div class="video-body">
                                    <div class="video-title">${v.title}</div>
                                    <div class="video-desc">${v.description}</div>
                                    <div class="video-meta">
                                        <span><i class="fas fa-file-video me-1"></i>${v.originalFileName}</span>
                                        <span><i class="fas fa-clock me-1"></i>${v.uploadedAt != null ? v.uploadedAt.toLocalDate() : ''}</span>
                                    </div>
                                </div>
                                <div class="video-actions">
                                    <a href="/videos/edit/${v.id}" class="btn-edit-v"><i class="fas fa-edit me-1"></i>Edit</a>
                                    <form method="post" action="/videos/delete/${v.id}" onsubmit="return confirm('Delete this video?')" class="d-inline">
                                        <button type="submit" class="btn-del-v"><i class="fas fa-trash me-1"></i>Delete</button>
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
                    <h5 class="modal-title text-white"><i class="fas fa-cloud-upload-alt me-2" style="color:#00f2fe;"></i>Upload Video Lecture</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="/videos/upload" enctype="multipart/form-data" onsubmit="showUploadProgress()">
                    <div class="modal-body p-4">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label">Video Title *</label>
                                <input type="text" name="title" class="form-control" placeholder="e.g. Introduction to Data Structures" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Description</label>
                                <textarea name="description" class="form-control" rows="3" placeholder="Brief description of this lecture..."></textarea>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Course *</label>
                                <select name="course_id" class="form-select" required>
                                    <option value="">-- Select Course --</option>
                                    <c:forEach var="c" items="${courses}">
                                        <option value="${c.id}">${c.title}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Video File *</label>
                                <div class="drop-zone" id="dropZone" onclick="document.getElementById('videoFile').click()">
                                    <div class="dz-icon"><i class="fas fa-film"></i></div>
                                    <div style="color:#4facfe;font-weight:700;" id="dzText">Click or drag & drop your video here</div>
                                    <div style="color:#64748b;font-size:0.8rem;margin-top:0.3rem;">MP4, WebM, OGG • Max 500 MB</div>
                                </div>
                                <input type="file" name="file" id="videoFile" accept="video/*" required style="display:none;" onchange="onFileSelect(this)">
                                <div class="upload-progress" id="uploadProgress">
                                    <div class="d-flex justify-content-between mb-1"><span style="font-size:0.8rem;color:#94a3b8;">Uploading...</span><span id="upPct" style="font-size:0.8rem;color:#4facfe;">0%</span></div>
                                    <div class="progress" style="height:6px;border-radius:3px;background:rgba(255,255,255,0.07);">
                                        <div class="progress-bar" id="upBar" style="background:linear-gradient(90deg,#4facfe,#00f2fe);width:0%;border-radius:3px;transition:width 0.4s;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0 px-4 pb-4">
                        <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-upload px-5"><i class="fas fa-upload me-2"></i>Upload Now</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function onFileSelect(inp) {
            const f = inp.files[0];
            if (f) {
                document.getElementById('dzText').textContent = '✅ ' + f.name + ' (' + (f.size / 1024 / 1024).toFixed(1) + ' MB)';
                document.getElementById('dropZone').style.borderColor = '#00f2fe';
            }
        }

        const dz = document.getElementById('dropZone');
        dz.addEventListener('dragover', e => { e.preventDefault(); dz.classList.add('dragover'); });
        dz.addEventListener('dragleave', () => dz.classList.remove('dragover'));
        dz.addEventListener('drop', e => {
            e.preventDefault(); dz.classList.remove('dragover');
            const f = e.dataTransfer.files[0];
            if (f) { document.getElementById('videoFile').files = e.dataTransfer.files; onFileSelect(document.getElementById('videoFile')); }
        });

        function showUploadProgress() {
            document.getElementById('uploadProgress').style.display = 'block';
            let pct = 0;
            const interval = setInterval(() => {
                pct = Math.min(pct + Math.random() * 8, 95);
                document.getElementById('upBar').style.width = pct + '%';
                document.getElementById('upPct').textContent = Math.round(pct) + '%';
                if (pct >= 95) clearInterval(interval);
            }, 300);
        }

        function filterVideos(courseId) {
            document.querySelectorAll('.video-item').forEach(el => {
                el.style.display = (courseId === 'all' || el.dataset.course === courseId) ? '' : 'none';
            });
        }

        function searchVideos(q) {
            document.querySelectorAll('.video-item').forEach(el => {
                el.style.display = el.dataset.title.includes(q.toLowerCase()) ? '' : 'none';
            });
        }
    </script>
</body>
</html>
