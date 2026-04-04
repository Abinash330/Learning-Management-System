<jsp:include page="header.jsp" />

<!-- Bootstrap & Icons -->
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<style>
    /* Animated Gradient Background */
    @keyframes gradientBG {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    .contact-wrapper {
        min-height: calc(100vh - 120px);
        background: linear-gradient(-45deg, #f8fafc, #e0e7ff, #f3e8ff, #e2e8f0);
        background-size: 400% 400%;
        animation: gradientBG 15s ease infinite;
        padding: 4rem 1rem;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'Inter', 'Segoe UI', sans-serif;
        overflow: hidden;
    }

    /* Container Animations */
    @keyframes slideUpScale {
        0% { opacity: 0; transform: translateY(50px) scale(0.95); }
        100% { opacity: 1; transform: translateY(0) scale(1); }
    }

    .custom-card {
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(20px);
        border-radius: 24px;
        box-shadow: 0 30px 60px -15px rgba(0, 0, 0, 0.15), 0 0 40px rgba(99, 102, 241, 0.1);
        overflow: hidden;
        max-width: 1100px;
        width: 100%;
        display: flex;
        flex-wrap: wrap;
        opacity: 0;
        animation: slideUpScale 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
    }

    .contact-info-panel {
        background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
        color: white;
        padding: 4rem 3rem;
        flex: 1;
        min-width: 320px;
        position: relative;
        overflow: hidden;
    }

    /* Floating Background Shapes */
    @keyframes float1 {
        0% { transform: translateY(0) translateX(0) rotate(0deg); }
        33% { transform: translateY(-30px) translateX(20px) rotate(120deg); }
        66% { transform: translateY(20px) translateX(-20px) rotate(240deg); }
        100% { transform: translateY(0) translateX(0) rotate(360deg); }
    }
    @keyframes float2 {
        0% { transform: translateY(0) translateX(0) scale(1); }
        50% { transform: translateY(40px) translateX(40px) scale(1.2); }
        100% { transform: translateY(0) translateX(0) scale(1); }
    }

    .bg-circle-1 {
        position: absolute;
        width: 350px;
        height: 350px;
        background: radial-gradient(circle, rgba(255,255,255,0.15) 0%, rgba(255,255,255,0) 70%);
        border-radius: 50%;
        bottom: -100px;
        right: -100px;
        z-index: 1;
        animation: float1 15s infinite infinite linear;
    }
    .bg-circle-2 {
        position: absolute;
        width: 250px;
        height: 250px;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
        border-radius: 50%;
        top: -50px;
        left: -50px;
        z-index: 1;
        animation: float2 12s infinite ease-in-out;
    }

    /* Staggered Content Animations */
    @keyframes fadeSlideIn {
        0% { opacity: 0; transform: translateX(-30px); }
        100% { opacity: 1; transform: translateX(0); }
    }
    @keyframes fadeSlideUp {
        0% { opacity: 0; transform: translateY(20px); }
        100% { opacity: 1; transform: translateY(0); }
    }

    .info-title, .info-desc, .info-item, .social-links {
        opacity: 0;
        animation: fadeSlideIn 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
        position: relative;
        z-index: 2;
    }
    
    .info-title { animation-delay: 0.2s; font-weight: 800; font-size: 2.25rem; margin-bottom: 1rem; }
    .info-desc { animation-delay: 0.3s; color: #e0e7ff; margin-bottom: 3rem; line-height: 1.7; font-size: 1.05rem; }
    .info-item:nth-child(4) { animation-delay: 0.4s; }
    .info-item:nth-child(5) { animation-delay: 0.5s; }
    .info-item:nth-child(6) { animation-delay: 0.6s; }
    .social-links { animation-delay: 0.7s; margin-top: 4rem; }

    .info-item {
        display: flex;
        align-items: flex-start;
        margin-bottom: 2rem;
        transition: transform 0.3s ease;
    }
    .info-item:hover {
        transform: translateX(10px);
    }
    .info-item .icon-box {
        width: 50px;
        height: 50px;
        background: rgba(255, 255, 255, 0.15);
        border-radius: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 1.25rem;
        font-size: 1.4rem;
        backdrop-filter: blur(8px);
        box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        transition: all 0.3s ease;
    }
    .info-item:hover .icon-box {
        background: white;
        color: #6366f1;
        transform: rotate(10deg) scale(1.1);
    }
    .info-item span {
        font-size: 1.05rem;
        font-weight: 500;
        line-height: 1.5;
        padding-top: 0.25rem;
    }

    .social-links a {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 45px;
        height: 45px;
        background: rgba(255, 255, 255, 0.1);
        color: white;
        border-radius: 50%;
        font-size: 1.2rem;
        margin-right: 1rem;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        text-decoration: none;
    }
    .social-links a:hover {
        background: white;
        color: #6366f1;
        transform: translateY(-8px) scale(1.15) rotate(5deg);
        box-shadow: 0 15px 25px rgba(0,0,0,0.2);
    }

    /* Right Form Side Animations */
    .contact-form-panel {
        padding: 4rem;
        flex: 1.5;
        min-width: 320px;
        background: rgba(255, 255, 255, 0.95);
    }
    
    .form-title {
        font-weight: 800;
        color: #111827;
        margin-bottom: 2.5rem;
        font-size: 2.25rem;
        opacity: 0;
        animation: fadeSlideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards 0.3s;
    }

    .anim-field {
        opacity: 0;
        animation: fadeSlideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
    }
    .anim-field:nth-child(1) { animation-delay: 0.4s; }
    .anim-field:nth-child(2) { animation-delay: 0.5s; }
    .anim-field:nth-child(3) { animation-delay: 0.6s; }
    .btn-wrapper {
        opacity: 0;
        animation: fadeSlideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards 0.7s;
    }

    .input-group-custom {
        margin-bottom: 1.5rem;
        position: relative;
        overflow: hidden;
        border-radius: 14px;
    }
    
    .input-group-custom .form-control {
        border-radius: 14px;
        border: 2px solid #f1f5f9;
        padding: 1rem 1rem 1rem 3.25rem;
        font-size: 1rem;
        font-weight: 500;
        color: #334155;
        transition: all 0.3s ease;
        background: #f8fafc;
        width: 100%;
        box-shadow: inset 0 2px 4px rgba(0,0,0,0.02);
    }
    .input-group-custom .form-control::placeholder {
        color: #94a3b8;
        transition: opacity 0.3s ease;
    }
    .input-group-custom .form-control:focus::placeholder {
        opacity: 0;
    }
    
    .input-group-custom .form-control:focus {
        border-color: #6366f1;
        background: #ffffff;
        box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.15);
        outline: none;
        transform: translateY(-2px);
    }
    
    .input-icon {
        position: absolute;
        left: 1.25rem;
        top: 1.1rem;
        color: #94a3b8;
        z-index: 10;
        font-size: 1.25rem;
        transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }
    .input-group-custom textarea.form-control + .input-icon {
        top: 1.1rem;
    }

    .input-group-custom .form-control:focus ~ .input-icon {
        color: #6366f1;
        transform: scale(1.1) rotate(-5deg);
    }
    .input-group-custom .form-control:not(:placeholder-shown) ~ .input-icon {
        color: #6366f1;
    }

    /* Animate button */
    .btn-send {
        background: linear-gradient(135deg, #111827 0%, #374151 100%);
        color: white;
        border: none;
        border-radius: 14px;
        padding: 1.15rem;
        font-weight: 600;
        font-size: 1.1rem;
        width: 100%;
        transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 0.75rem;
        margin-top: 1rem;
        position: relative;
        overflow: hidden;
        z-index: 1;
    }
    
    .btn-send::before {
        content: '';
        position: absolute;
        top: 0; left: -100%; width: 100%; height: 100%;
        background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
        transition: left 0.4s ease;
        z-index: -1;
    }

    .btn-send:hover::before {
        left: 0;
    }
    
    .btn-send:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(79, 70, 229, 0.3);
        color: white;
    }
    
    .btn-send .bi-send-fill {
        transition: transform 0.3s ease;
    }
    .btn-send:hover .bi-send-fill {
        transform: translateX(5px) translateY(-5px);
    }

    @media (max-width: 991px) {
        .custom-card {
            flex-direction: column;
        }
        .contact-info-panel, .contact-form-panel {
            padding: 3rem 2rem;
        }
    }
</style>

<div class="contact-wrapper">
    <div class="custom-card">
        
        <!-- Left Side: Information -->
        <div class="contact-info-panel">
            <div class="bg-circle-1"></div>
            <div class="bg-circle-2"></div>
            
            <h3 class="info-title">Let's Connect</h3>
            <p class="info-desc">Have a question, feedback, or need assistance? We're here to help! Fill out the form and our team will get back to you shortly.</p>
            
            <div class="info-item">
                <div class="icon-box"><i class="bi bi-geo-alt-fill"></i></div>
                <span>123 Learning Boulevard<br>Education City, ED 75001</span>
            </div>
            
            <div class="info-item">
                <div class="icon-box"><i class="bi bi-telephone-fill"></i></div>
                <span>+1 (800) 123-4567<br>Mon-Fri from 8am to 5pm</span>
            </div>
            
            <div class="info-item">
                <div class="icon-box"><i class="bi bi-envelope-fill"></i></div>
                <span>support@lms-platform.edu<br>info@lms-platform.edu</span>
            </div>
            
            <div class="social-links">
                <a href="#"><i class="bi bi-twitter-x"></i></a>
                <a href="#"><i class="bi bi-instagram"></i></a>
                <a href="#"><i class="bi bi-linkedin"></i></a>
                <a href="#"><i class="bi bi-facebook"></i></a>
            </div>
        </div>

        <!-- Right Side: Form -->
        <div class="contact-form-panel">
            <h3 class="form-title">Send us a message</h3>
            
            <form action="${pageContext.request.contextPath}/contact" method="post">
                <div class="row anim-field">
                    <div class="col-md-6">
                        <div class="input-group-custom">
                            <input type="text" name="name" class="form-control" placeholder="Full Name" required>
                            <i class="bi bi-person input-icon"></i>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group-custom">
                            <input type="email" name="email" class="form-control" placeholder="Email Address" required>
                            <i class="bi bi-envelope input-icon"></i>
                        </div>
                    </div>
                </div>

                <div class="row anim-field">
                    <div class="col-md-6">
                        <div class="input-group-custom">
                            <input type="text" name="mobile" class="form-control" placeholder="Mobile Number" required>
                            <i class="bi bi-telephone input-icon"></i>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group-custom">
                            <input type="text" name="subject" class="form-control" placeholder="Subject" required>
                            <i class="bi bi-chat-dots input-icon"></i>
                        </div>
                    </div>
                </div>

                <div class="input-group-custom anim-field">
                    <textarea name="message" class="form-control" rows="5" placeholder="How can we help you?" required></textarea>
                    <i class="bi bi-pencil-square input-icon"></i>
                </div>

                <div class="btn-wrapper">
                    <button type="submit" class="btn btn-send">
                        Send Message <i class="bi bi-send-fill fs-5 ms-1"></i>
                    </button>
                </div>
            </form>
        </div>
        
    </div>
</div>

<jsp:include page="footer.jsp" />