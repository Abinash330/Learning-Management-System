<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ | EduPro Support</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <style>
    :root {
        --glass-bg: rgba(255, 255, 255, 0.75);
        --glass-border: rgba(255, 255, 255, 0.4);
        --primary-gradient: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
        --accent-color: #8b5cf6;
    }

    body {
        background: radial-gradient(circle at top right, #f3f4f6, #e5e7eb);
        font-family: 'Outfit', sans-serif;
        min-height: 100vh;
        color: #1f2937;
    }

    /* Premium Hero Section */
    .faq-hero {
        background: var(--primary-gradient);
        color: white;
        padding: 120px 20px 160px;
        position: relative;
        overflow: hidden;
        border-radius: 0 0 40px 40px;
    }

    .faq-hero::before {
        content: '';
        position: absolute;
        top: -50px;
        right: -50px;
        width: 300px;
        height: 300px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        filter: blur(40px);
    }

    .faq-hero h1 {
        font-size: 3.5rem;
        font-weight: 800;
        margin-bottom: 1rem;
        text-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    /* Search Container with Glassmorphism */
    .search-container {
        max-width: 700px;
        margin: -80px auto 40px;
        padding: 0 15px;
    }

    .glass-search {
        background: var(--glass-bg);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid var(--glass-border);
        border-radius: 24px;
        padding: 12px 12px 12px 25px;
        display: flex;
        align-items: center;
        box-shadow: 0 20px 50px rgba(0,0,0,0.1);
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }

    .glass-search:focus-within {
        transform: translateY(-5px) scale(1.02);
        box-shadow: 0 30px 60px rgba(99, 102, 241, 0.2);
        border-color: rgba(99, 102, 241, 0.5);
    }

    .glass-search input {
        border: none;
        background: transparent;
        font-size: 1.1rem;
        width: 100%;
        outline: none;
        color: #374151;
    }

    .search-btn {
        background: var(--primary-gradient);
        border: none;
        border-radius: 16px;
        padding: 12px 28px;
        color: white;
        font-weight: 600;
        transition: 0.3s;
    }

    .search-btn:hover {
        transform: scale(1.05);
        box-shadow: 0 10px 20px rgba(139, 92, 246, 0.3);
    }

    /* FAQ Card List */
    .faq-section {
        max-width: 900px;
        margin: 0 auto 100px;
        padding: 0 20px;
    }

    .faq-card {
        background: var(--glass-bg);
        backdrop-filter: blur(8px);
        -webkit-backdrop-filter: blur(8px);
        border: 1px solid var(--glass-border);
        border-radius: 20px;
        margin-bottom: 20px;
        overflow: hidden;
        transition: all 0.3s ease;
    }

    .faq-card:hover {
        background: rgba(255, 255, 255, 0.9);
        box-shadow: 0 15px 35px rgba(0,0,0,0.05);
    }

    .faq-header {
        padding: 24px 30px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .faq-question {
        font-size: 1.2rem;
        font-weight: 600;
        color: #1f2937;
        display: flex;
        align-items: center;
    }

    .faq-icon-box {
        width: 45px;
        height: 45px;
        background: #f3f4f6;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 20px;
        color: var(--accent-color);
        font-size: 1.3rem;
        transition: 0.3s;
    }

    .faq-card.active .faq-icon-box {
        background: var(--primary-gradient);
        color: white;
    }

    .faq-content {
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.4s ease-out, padding 0.3s ease;
        padding: 0 30px 0 95px;
    }

    .faq-card.active .faq-content {
        max-height: 500px;
        padding: 0 30px 30px 95px;
    }

    .faq-answer {
        color: #4b5563;
        line-height: 1.7;
        font-size: 1.05rem;
    }

    .role-badge {
        font-size: 0.75rem;
        padding: 4px 12px;
        border-radius: 20px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-left: 10px;
    }

    .badge-all { background: #e5e7eb; color: #4b5563; }
    .badge-student { background: #dbeafe; color: #1e40af; }
    .badge-faculty { background: #fef3c7; color: #92400e; }
    .badge-admin { background: #fee2e2; color: #991b1b; }

    .category-tag {
        font-size: 0.8rem;
        color: var(--accent-color);
        background: #f5f3ff;
        padding: 2px 8px;
        border-radius: 6px;
        margin-bottom: 8px;
        display: inline-block;
    }

    .chevron {
        transition: transform 0.3s ease;
        color: #9ca3af;
    }

    .faq-card.active .chevron {
        transform: rotate(180deg);
        color: var(--accent-color);
    }

    /* Empty State */
    .no-results {
        text-align: center;
        padding: 50px;
        display: none;
    }
    </style>
</head>
<body>
<c:choose>
    <c:when test="${sessionScope.role == 'Student'}">
        <jsp:include page="sheader.jsp" />
    </c:when>
    <c:when test="${sessionScope.role == 'Faculty'}">
        <jsp:include page="fheader.jsp" />
    </c:when>
    <c:when test="${sessionScope.role == 'Admin'}">
        <jsp:include page="aheader.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="header.jsp" />
    </c:otherwise>
</c:choose>

<div class="faq-hero text-center">
    <div class="container">
        <h1 class="animate__animated animate__fadeInDown">Expert Support</h1>
        <p class="lead opacity-75 animate__animated animate__fadeInUp">
            Current View: 
            <span class="badge ${sessionScope.role == 'Admin' ? 'badge-admin' : (sessionScope.role == 'Faculty' ? 'badge-faculty' : (sessionScope.role == 'Student' ? 'badge-student' : 'badge-all'))}">
                ${sessionScope.role != null ? sessionScope.role : 'Guest'} 
            </span>
        </p>

        <c:if test="${sessionScope.role == 'Admin'}">
            <button class="btn btn-light rounded-pill px-4 mt-3 fw-600 animate__animated animate__zoomIn" 
                    data-bs-toggle="modal" data-bs-target="#faqModal" onclick="prepareAddFaq()">
                <i class="bi bi-plus-lg me-2"></i>Add New FAQ
            </button>
        </c:if>
    </div>
</div>

<c:if test="${not empty message}">
    <div class="container mt-4">
        <div class="alert alert-success border-0 rounded-4 shadow-sm animate__animated animate__fadeIn">
            <i class="bi bi-check-circle-fill me-2"></i> ${message}
        </div>
    </div>
</c:if>

<div class="search-container">
    <div class="glass-search animate__animated animate__zoomIn">
        <i class="bi bi-search me-3 text-muted" style="font-size: 1.4rem;"></i>
        <input type="text" id="faqSearch" placeholder="Search for questions or keywords..." autocomplete="off">
        <button class="search-btn d-none d-md-block">Search</button>
    </div>
</div>

<div class="faq-section" id="faqAccordion">
    <c:forEach var="faq" items="${faqs}" varStatus="status">
        <div class="faq-card animate__animated animate__fadeInUp" style="animation-delay: ${status.index * 0.1}s">
            <div class="faq-header" onclick="toggleFaq(this)">
                <div class="faq-question">
                    <div class="faq-icon-box">
                        <i class="bi ${faq.category == 'Technical' ? 'bi-cpu' : (faq.category == 'User Management' ? 'bi-people' : 'bi-info-circle')}"></i>
                    </div>
                    <div>
                        <span class="category-tag">${faq.category}</span>
                        <div class="d-flex align-items-center">
                            ${faq.question}
                            <span class="role-badge badge-${faq.role.toLowerCase()}">${faq.role}</span>
                        </div>
                    </div>
                </div>
                <div class="d-flex align-items-center">
                    <c:if test="${sessionScope.role == 'Admin'}">
                        <button class="btn btn-sm btn-outline-primary border-0 rounded-circle me-2" 
                                onclick="event.stopPropagation(); prepareEditFaq(${faq.id}, '${faq.question}', '${faq.answer}', '${faq.role}', '${faq.category}')">
                            <i class="bi bi-pencil-square"></i>
                        </button>
                        <form action="/admin/faq/delete/${faq.id}" method="post" class="d-inline" onsubmit="return confirm('Delete this FAQ?')">
                            <button type="submit" class="btn btn-sm btn-outline-danger border-0 rounded-circle me-3" onclick="event.stopPropagation()">
                                <i class="bi bi-trash"></i>
                            </button>
                        </form>
                    </c:if>
                    <i class="bi bi-chevron-down chevron"></i>
                </div>
            </div>
            <div class="faq-content">
                <div class="faq-answer">
                    ${faq.answer}
                </div>
            </div>
        </div>
    </c:forEach>

    <div id="noResults" class="no-results animate__animated animate__fadeIn">
        <img src="https://illustrations.popsy.co/gray/search.svg" alt="No results" style="width: 200px; margin-bottom: 20px;">
        <h3>No matches found</h3>
        <p class="text-muted">Try adjusting your search keywords or visit our help center.</p>
        <button onclick="clearSearch()" class="btn btn-primary rounded-pill px-4 mt-3" style="background: var(--primary-gradient); border: none;">Clear Search</button>
    </div>
</div>

<div class="container text-center mb-5">
    <div class="p-5 rounded-4" style="background: white; border: 1px solid #e5e7eb;">
        <h4 class="fw-800 mb-3">Still need help?</h4>
        <p class="text-muted mb-4">Our dedicated support team is ready to assist you with any questions.</p>
        <div class="d-flex justify-content-center gap-3">
            <a href="/contact" class="btn btn-outline-primary rounded-pill px-4">Contact Us</a>
            <a href="mailto:support@lms.com" class="btn btn-primary rounded-pill px-4" style="background: var(--primary-gradient); border: none;">Email Support</a>
        </div>
    </div>
</div>

<script>
    function toggleFaq(header) {
        const card = header.parentElement;
        const isActive = card.classList.contains('active');
        
        // Close all other cards
        document.querySelectorAll('.faq-card').forEach(c => c.classList.remove('active'));
        
        // Toggle current card
        if (!isActive) {
            card.classList.add('active');
        }
    }

    // Client-side search logic
    const searchInput = document.getElementById('faqSearch');
    const faqCards = document.querySelectorAll('.faq-card');
    const noResults = document.getElementById('noResults');

    searchInput.addEventListener('input', (e) => {
        const term = e.target.value.toLowerCase();
        let visibleCount = 0;

        faqCards.forEach(card => {
            const question = card.querySelector('.faq-question').textContent.toLowerCase();
            const answer = card.querySelector('.faq-answer').textContent.toLowerCase();
            
            if (question.includes(term) || answer.includes(term)) {
                card.style.display = 'block';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        noResults.style.display = (visibleCount === 0) ? 'block' : 'none';
    });

    function clearSearch() {
        searchInput.value = '';
        searchInput.dispatchEvent(new Event('input'));
        searchInput.focus();
    }
</script>

<!-- FAQ Admin Modal -->
<div class="modal fade" id="faqModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow-lg">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-800" id="faqModalTitle">Add New FAQ</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/admin/faq/save" method="post">
                <div class="modal-body">
                    <input type="hidden" name="id" id="formFaqId">
                    <div class="mb-3">
                        <label class="form-label fw-600">Question</label>
                        <input type="text" name="question" id="formQuestion" class="form-control rounded-3" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-600">Answer</label>
                        <textarea name="answer" id="formAnswer" class="form-control rounded-3" rows="4" required></textarea>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-600">Target Role</label>
                            <select name="role" id="formRole" class="form-select rounded-3">
                                <option value="All">All</option>
                                <option value="Student">Student</option>
                                <option value="Faculty">Faculty</option>
                                <option value="Admin">Admin</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-600">Category</label>
                            <select name="category" id="formCategory" class="form-select rounded-3">
                                <option value="General">General</option>
                                <option value="Technical">Technical</option>
                                <option value="Courses">Courses</option>
                                <option value="User Management">User Management</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary rounded-pill px-4" style="background: var(--primary-gradient); border: none;">Save FAQ</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function prepareAddFaq() {
        document.getElementById('faqModalTitle').innerText = 'Add New FAQ';
        document.getElementById('formFaqId').value = '';
        document.getElementById('formQuestion').value = '';
        document.getElementById('formAnswer').value = '';
        document.getElementById('formRole').value = 'All';
        document.getElementById('formCategory').value = 'General';
    }

    function prepareEditFaq(id, question, answer, role, category) {
        document.getElementById('faqModalTitle').innerText = 'Edit FAQ';
        document.getElementById('formFaqId').value = id;
        document.getElementById('formQuestion').value = question;
        document.getElementById('formAnswer').value = answer;
        document.getElementById('formRole').value = role;
        document.getElementById('formCategory').value = category;
        
        // Open modal
        var myModal = new bootstrap.Modal(document.getElementById('faqModal'));
        myModal.show();
    }
</script>

<c:choose>
    <c:when test="${sessionScope.role == 'Student'}">
        <jsp:include page="sfooter.jsp" />
    </c:when>
    <c:when test="${sessionScope.role == 'Faculty'}">
        <jsp:include page="ffooter.jsp" />
    </c:when>
    <c:when test="${sessionScope.role == 'Admin'}">
        <jsp:include page="afooter.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="footer.jsp" />
    </c:otherwise>
</c:choose>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>