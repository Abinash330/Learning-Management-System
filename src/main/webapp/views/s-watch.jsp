<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${video.title} – Watch Lecture</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #080d1a; color: #e2e8f0; font-family: 'Inter', sans-serif; }

        /* ── Video Player Section ── */
        .player-section {
            background: #000;
            padding: 0;
        }
        .player-wrap {
            position: relative;
            max-width: 960px;
            margin: 0 auto;
            background: #000;
        }
        .player-wrap video {
            width: 100%;
            max-height: 540px;
            display: block;
            background: #000;
        }

        /* Custom Controls overlay */
        .custom-controls {
            position: absolute; bottom: 0; left: 0; right: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.9) 0%, transparent 100%);
            padding: 1.5rem 1.2rem 0.8rem;
            opacity: 0; transition: opacity 0.3s;
        }
        .player-wrap:hover .custom-controls { opacity: 1; }

        .progress-track {
            height: 4px; background: rgba(255,255,255,0.2);
            border-radius: 4px; cursor: pointer; margin-bottom: 0.7rem;
            position: relative;
        }
        .progress-fill {
            height: 100%; border-radius: 4px;
            background: linear-gradient(90deg, #6366f1, #a78bfa);
            transition: width 0.1s;
            pointer-events: none;
        }
        .ctrl-btn {
            background: none; border: none; color: rgba(255,255,255,0.85);
            font-size: 1.1rem; cursor: pointer; padding: 0 0.4rem;
            transition: color 0.2s;
        }
        .ctrl-btn:hover { color: #a78bfa; }

        /* ── Info Bar ── */
        .info-bar {
            background: #0f172a; border-bottom: 1px solid rgba(99,102,241,0.15);
            padding: 1.2rem 0;
        }
        .video-title-hd { font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 1.5rem; color: #f1f5f9; }
        .meta-pill {
            display: inline-flex; align-items: center; gap: 0.4rem;
            background: rgba(99,102,241,0.12); border: 1px solid rgba(99,102,241,0.25);
            border-radius: 50px; padding: 0.25rem 0.85rem; font-size: 0.78rem; color: #94a3b8;
        }
        .meta-pill i { color: #6366f1; }

        /* ── Doubts Panel ── */
        .doubts-section { background: #080d1a; padding: 2rem 0 4rem; }

        .doubts-panel {
            background: rgba(15,23,42,0.8);
            border: 1px solid rgba(99,102,241,0.18);
            border-radius: 20px; overflow: hidden;
        }
        .panel-header {
            background: linear-gradient(135deg, rgba(99,102,241,0.15), rgba(167,139,250,0.08));
            border-bottom: 1px solid rgba(99,102,241,0.15);
            padding: 1.2rem 1.5rem;
            display: flex; align-items: center; justify-content: space-between;
        }
        .panel-title { font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 1.1rem; }
        .doubts-count { background: rgba(99,102,241,0.25); color: #a5b4fc; border-radius: 50px; padding: 0.15rem 0.65rem; font-size: 0.8rem; font-weight: 700; }

        /* Ask Form */
        .ask-form-wrap { padding: 1.2rem 1.5rem; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .doubt-textarea {
            background: rgba(8,13,26,0.7) !important;
            border: 1.5px solid rgba(99,102,241,0.22) !important;
            color: #e2e8f0 !important; border-radius: 12px !important;
            resize: none;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .doubt-textarea:focus {
            border-color: #6366f1 !important;
            box-shadow: 0 0 0 3px rgba(99,102,241,0.15) !important;
        }
        .char-count { font-size: 0.75rem; color: #64748b; text-align: right; margin-top: 0.3rem; }
        .btn-ask {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white; border: none; border-radius: 10px;
            padding: 0.5rem 1.4rem; font-weight: 700;
            transition: all 0.3s;
        }
        .btn-ask:hover { opacity: 0.88; transform: translateY(-2px); box-shadow: 0 8px 20px rgba(99,102,241,0.4); }

        /* Doubt Items */
        .doubts-list { padding: 1rem 1.5rem; display: flex; flex-direction: column; gap: 1rem; max-height: 500px; overflow-y: auto; }
        .doubt-item { background: rgba(8,13,26,0.5); border: 1px solid rgba(255,255,255,0.05); border-radius: 14px; padding: 1rem 1.2rem; }
        .doubt-item.has-reply { border-left: 3px solid #6366f1; }

        .doubt-q { color: #e2e8f0; font-size: 0.92rem; line-height: 1.55; margin-bottom: 0.5rem; }
        .doubt-meta { display: flex; gap: 0.6rem; align-items: center; flex-wrap: wrap; }
        .asker-badge { background: rgba(236,72,153,0.12); border: 1px solid rgba(236,72,153,0.2); color: #f472b6; border-radius: 20px; padding: 0.15rem 0.65rem; font-size: 0.72rem; font-weight: 700; }
        .open-badge { background: rgba(245,158,11,0.12); border: 1px solid rgba(245,158,11,0.25); color: #fbbf24; border-radius: 20px; padding: 0.15rem 0.65rem; font-size: 0.72rem; font-weight: 700; }
        .replied-badge { background: rgba(16,185,129,0.12); border: 1px solid rgba(16,185,129,0.25); color: #34d399; border-radius: 20px; padding: 0.15rem 0.65rem; font-size: 0.72rem; font-weight: 700; }
        .time-text { color: #475569; font-size: 0.72rem; }

        .reply-box {
            margin-top: 0.75rem; background: rgba(99,102,241,0.06);
            border: 1px solid rgba(99,102,241,0.15); border-radius: 10px; padding: 0.85rem 1rem;
        }
        .reply-label { font-size: 0.75rem; font-weight: 700; color: #6366f1; margin-bottom: 0.35rem; }
        .reply-text { color: #c7d2fe; font-size: 0.88rem; line-height: 1.5; }
        .replier-name { font-size: 0.72rem; color: #64748b; margin-top: 0.35rem; }

        /* No Doubts */
        .no-doubts { text-align: center; padding: 2.5rem; color: #475569; }
        .no-doubts i { font-size: 2.5rem; margin-bottom: 0.6rem; display: block; }

        /* Scrollbar */
        .doubts-list::-webkit-scrollbar { width: 5px; }
        .doubts-list::-webkit-scrollbar-track { background: transparent; }
        .doubts-list::-webkit-scrollbar-thumb { background: rgba(99,102,241,0.3); border-radius: 3px; }

        /* Back link */
        .back-link { color: #6366f1; font-weight: 600; font-size: 0.9rem; text-decoration: none; }
        .back-link:hover { color: #a78bfa; }
    </style>
</head>
<body>
    <%@ include file="sheader.jsp" %>

    <!-- Player -->
    <div class="player-section">
        <div class="player-wrap" id="playerWrap">
            <video id="mainVideo" preload="auto" onclick="togglePlay()">
                <source src="/videos/stream/${video.id}" type="video/mp4">
                Your browser does not support the video tag.
            </video>

            <!-- Custom Controls -->
            <div class="custom-controls">
                <div class="progress-track" id="progressTrack" onclick="seekTo(event)">
                    <div class="progress-fill" id="progressFill" style="width:0%"></div>
                </div>
                <div class="d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center gap-1">
                        <button class="ctrl-btn" onclick="togglePlay()" id="playBtn"><i class="fas fa-play"></i></button>
                        <button class="ctrl-btn" onclick="skip(-10)"><i class="fas fa-backward"></i></button>
                        <button class="ctrl-btn" onclick="skip(10)"><i class="fas fa-forward"></i></button>
                        <input type="range" min="0" max="1" step="0.05" value="1" oninput="setVolume(this.value)"
                               style="width:70px;accent-color:#6366f1;cursor:pointer;" title="Volume">
                        <span id="timeDisplay" style="color:rgba(255,255,255,0.7);font-size:0.78rem;margin-left:0.4rem;">0:00 / 0:00</span>
                    </div>
                    <div class="d-flex align-items-center gap-1">
                        <button class="ctrl-btn" onclick="toggleFullscreen()"><i class="fas fa-expand"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Info Bar -->
    <div class="info-bar">
        <div class="container">
            <a href="/s-videos" class="back-link mb-2 d-inline-block"><i class="fas fa-arrow-left me-1"></i>Back to Videos</a>
            <h1 class="video-title-hd mt-1">${video.title}</h1>
            <div class="d-flex flex-wrap gap-2 mt-2">
                <span class="meta-pill"><i class="fas fa-book"></i>${video.course.title}</span>
                <c:if test="${video.uploadedBy != null}">
                    <span class="meta-pill"><i class="fas fa-user-tie"></i>${video.uploadedBy.name}</span>
                </c:if>
                <c:if test="${video.uploadedAt != null}">
                    <span class="meta-pill"><i class="fas fa-calendar"></i>${video.uploadedAt.toLocalDate()}</span>
                </c:if>
            </div>
            <c:if test="${not empty video.description}">
                <p class="mt-2 mb-0" style="color:#94a3b8;font-size:0.92rem;max-width:720px;">${video.description}</p>
            </c:if>
        </div>
    </div>

    <!-- Doubts & Questions -->
    <div class="doubts-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="doubts-panel">
                        <div class="panel-header">
                            <div class="d-flex align-items-center gap-2">
                                <i class="fas fa-comments" style="color:#6366f1;font-size:1.2rem;"></i>
                                <span class="panel-title">Doubts &amp; Questions</span>
                                <span class="doubts-count">${doubts.size()}</span>
                            </div>
                            <span style="color:#64748b;font-size:0.82rem;">Your questions go directly to your faculty</span>
                        </div>

                        <!-- Ask a Doubt -->
                        <div class="ask-form-wrap">
                            <form method="post" action="/s-ask-doubt" onsubmit="return validateDoubt()">
                                <input type="hidden" name="video_id" value="${video.id}">
                                <label style="font-size:0.85rem;color:#94a3b8;font-weight:600;margin-bottom:0.4rem;display:block;">
                                    <i class="fas fa-pencil-alt me-1" style="color:#6366f1;"></i>Ask your Question or Doubt
                                </label>
                                <textarea name="questionText" id="doubtInput" class="form-control doubt-textarea" rows="3"
                                          placeholder="Type your doubt or question here... Be specific to get a better answer!" maxlength="600"
                                          oninput="updateChar(this)"></textarea>
                                <div class="char-count"><span id="charCount">0</span>/600</div>
                                <div class="d-flex justify-content-end mt-2">
                                    <button type="submit" class="btn btn-ask">
                                        <i class="fas fa-paper-plane me-2"></i>Submit Question
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Doubts List -->
                        <div class="doubts-list">
                            <c:choose>
                                <c:when test="${empty doubts}">
                                    <div class="no-doubts">
                                        <i class="far fa-comment-dots"></i>
                                        No questions yet. Be the first to ask!
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="d" items="${doubts}">
                                        <div class="doubt-item ${d.status == 'REPLIED' ? 'has-reply' : ''}">
                                            <div class="doubt-q">"${d.questionText}"</div>
                                            <div class="doubt-meta">
                                                <span class="asker-badge"><i class="fas fa-user me-1"></i>${d.student.name}</span>
                                                <c:choose>
                                                    <c:when test="${d.status == 'REPLIED'}">
                                                        <span class="replied-badge"><i class="fas fa-check-circle me-1"></i>Answered</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="open-badge"><i class="fas fa-clock me-1"></i>Pending</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <span class="time-text">${d.askedAt != null ? d.askedAt.toLocalDate() : ''}</span>
                                            </div>
                                            <c:if test="${d.status == 'REPLIED' and not empty d.reply}">
                                                <div class="reply-box">
                                                    <div class="reply-label"><i class="fas fa-reply me-1"></i>Faculty Response</div>
                                                    <div class="reply-text">${d.reply}</div>
                                                    <div class="replier-name">
                                                        <c:if test="${d.repliedBy != null}">— ${d.repliedBy.name}</c:if>
                                                        <c:if test="${d.repliedAt != null}"> · ${d.repliedAt.toLocalDate()}</c:if>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const vid = document.getElementById('mainVideo');
        const playBtn = document.getElementById('playBtn');

        function togglePlay() {
            if (vid.paused) { vid.play(); playBtn.innerHTML = '<i class="fas fa-pause"></i>'; }
            else            { vid.pause(); playBtn.innerHTML = '<i class="fas fa-play"></i>'; }
        }
        vid.addEventListener('ended', () => playBtn.innerHTML = '<i class="fas fa-play"></i>');

        function skip(sec) { vid.currentTime = Math.max(0, vid.currentTime + sec); }
        function setVolume(v) { vid.volume = v; }

        // Progress bar
        vid.addEventListener('timeupdate', () => {
            if (!vid.duration) return;
            const pct = (vid.currentTime / vid.duration) * 100;
            document.getElementById('progressFill').style.width = pct + '%';
            document.getElementById('timeDisplay').textContent = fmt(vid.currentTime) + ' / ' + fmt(vid.duration);
        });
        function fmt(s) {
            const m = Math.floor(s/60), sec = Math.floor(s%60);
            return m + ':' + String(sec).padStart(2,'0');
        }
        function seekTo(e) {
            const track = document.getElementById('progressTrack');
            const r = track.getBoundingClientRect();
            vid.currentTime = ((e.clientX - r.left) / r.width) * vid.duration;
        }

        function toggleFullscreen() {
            const wrap = document.getElementById('playerWrap');
            if (!document.fullscreenElement) wrap.requestFullscreen();
            else document.exitFullscreen();
        }

        // Keyboard shortcuts
        document.addEventListener('keydown', e => {
            if (e.target.tagName === 'TEXTAREA' || e.target.tagName === 'INPUT') return;
            if (e.code === 'Space') { e.preventDefault(); togglePlay(); }
            if (e.code === 'ArrowRight') skip(10);
            if (e.code === 'ArrowLeft')  skip(-10);
            if (e.code === 'ArrowUp')    { vid.volume = Math.min(1, vid.volume + 0.1); }
            if (e.code === 'ArrowDown')  { vid.volume = Math.max(0, vid.volume - 0.1); }
        });

        // Char counter
        function updateChar(el) { document.getElementById('charCount').textContent = el.value.length; }

        // Validate before submit
        function validateDoubt() {
            const v = document.getElementById('doubtInput').value.trim();
            if (!v) { alert('Please type your question first!'); return false; }
            return true;
        }
    </script>
</body>
</html>
