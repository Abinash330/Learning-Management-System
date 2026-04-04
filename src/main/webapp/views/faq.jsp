<jsp:include page="header.jsp" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">

<style>
    body {
        background-color: #f8f9fa;
        font-family: 'Inter', sans-serif;
    }

    /* Modern Hero Section */
    .faq-hero {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 100px 20px;
        border-radius: 0 0 50% 50% / 20px 20px 80px 80px;
        box-shadow: 0 10px 30px rgba(118, 75, 162, 0.3);
    }

    .faq-hero h1 {
        font-size: 2.8rem;
        letter-spacing: -1px;
    }

    /* Search Bar Aesthetic (Visual only) */
    .faq-search {
        max-width: 600px;
        margin: -30px auto 0;
        background: white;
        padding: 10px;
        border-radius: 50px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        display: flex;
        align-items: center;
    }
    
    .faq-search input {
        border: none;
        padding-left: 20px;
        outline: none;
        width: 100%;
    }

    /* Accordion Styling */
    .accordion-item {
        border: none;
        background: transparent;
        margin-bottom: 20px;
    }

    .accordion-button {
        background: white !important;
        border-radius: 15px !important;
        padding: 1.5rem;
        font-weight: 600;
        color: #4a5568;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .accordion-button:not(.collapsed) {
        color: #667eea;
        box-shadow: 0 10px 20px rgba(102, 126, 234, 0.15);
        transform: translateY(-2px);
    }

    .accordion-button::after {
        background-size: 1.2rem;
    }

    .accordion-body {
        background: white;
        margin-top: -10px;
        padding: 2rem 1.5rem 1.5rem;
        border-radius: 0 0 15px 15px;
        color: #718096;
        line-height: 1.6;
        border-top: 1px solid #f1f1f1;
    }

    .faq-icon {
        width: 40px;
        height: 40px;
        background: #f3f0ff;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        margin-right: 15px;
        color: #764ba2;
        font-size: 1.2rem;
        transition: 0.3s;
    }

    .accordion-button:not(.collapsed) .faq-icon {
        background: #764ba2;
        color: white;
    }

    /* Hover effect */
    .accordion-item:hover .accordion-button.collapsed {
        background-color: #fdfdfd !important;
        transform: translateY(-3px);
    }
</style>

<div class="faq-hero text-center">
    <h1 class="fw-800">How can we help?</h1>
    <p class="lead opacity-75">Search our knowledge base or browse the FAQs below</p>
</div>

<div class="container">
    <div class="faq-search">
        <i class="bi bi-search ms-3 text-muted"></i>
        <input type="text" placeholder="Type your question here...">
        <button class="btn btn-primary rounded-pill px-4" style="background: #764ba2; border: none;">Search</button>
    </div>
</div>

<div class="container my-5" style="max-width: 800px;">

    <div class="accordion" id="faqAccordion">

        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                    <span class="faq-icon"><i class="bi bi-lightbulb"></i></span>
                    What is LMS?
                </button>
            </h2>
            <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                <div class="accordion-body">
                    <strong>Learning Management System (LMS)</strong> is a comprehensive digital platform designed to bridge the gap between students and educators. It allows you to manage courses, track real-time progress, and access learning materials anywhere in the world.
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                    <span class="faq-icon"><i class="bi bi-person-plus"></i></span>
                    How do I register on LMS?
                </button>
            </h2>
            <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                <div class="accordion-body">
                    Getting started is easy! Click the <span class="badge bg-soft-primary text-primary" style="background: #e0e7ff;">Register</span> button at the top right, provide your email and credentials, and you'll have instant access to our dashboard.
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">
                    <span class="faq-icon"><i class="bi bi-journal-check"></i></span>
                    How can I enroll in a course?
                </button>
            </h2>
            <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                <div class="accordion-body">
                    Navigate to the <strong>Course Library</strong>, browse through our categories, and once you find a course that interests you, click the <strong>"Enroll Now"</strong> button. The course will be added to your personal dashboard immediately.
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq4">
                    <span class="faq-icon"><i class="bi bi-shield-lock"></i></span>
                    Is LMS free to use?
                </button>
            </h2>
            <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                <div class="accordion-body">
                    We offer a <strong>Free Tier</strong> that includes access to all basic community courses. However, Professional Certifications and specialized bootcamps may carry a one-time enrollment fee.
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq5">
                    <span class="faq-icon"><i class="bi bi-chat-dots"></i></span>
                    How can I contact support?
                </button>
            </h2>
            <div id="faq5" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                <div class="accordion-body">
                    Need a hand? Our support team is available 24/7. You can reach us via the live chat widget at the bottom of the screen or by emailing <a href="mailto:support@lms.com" class="text-decoration-none" style="color: #764ba2; font-weight: 600;">support@lms.com</a>.
                </div>
            </div>
        </div>

    </div>
    
    <div class="text-center mt-5">
        <p class="text-muted">Still have questions?</p>
        <a href="#" class="btn btn-outline-secondary rounded-pill px-4">Visit Help Center</a>
    </div>
</div>

<jsp:include page="footer.jsp" />