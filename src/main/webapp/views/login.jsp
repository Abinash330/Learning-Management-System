<jsp:include page="header.jsp" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="/css/bootstrap.min.css" />

<style>
    :root {
        --primary: #4f46e5;
        --secondary: #ec4899;
        --bg-color: #f8fafc;
        --text-color: #0f172a;
    }

    body {
        margin: 0;
        padding: 0;
        background-color: var(--bg-color);
    }

    .login-wrapper {
        min-height: calc(100vh - 120px);
        background: radial-gradient(circle at top right, #e0e7ff 0%, #f8fafc 50%),
                    radial-gradient(circle at bottom left, #fae8ff 0%, #f8fafc 50%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 4rem 1rem;
        font-family: 'Inter', system-ui, -apple-system, sans-serif;
    }

    .login-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        border-radius: 24px;
        box-shadow: 0 30px 60px -15px rgba(0, 0, 0, 0.1), 0 0 40px rgba(79, 70, 229, 0.05);
        overflow: hidden;
        max-width: 480px;
        width: 100%;
        opacity: 0;
        animation: slideUpScale 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
        position: relative;
    }

    @keyframes slideUpScale {
        0% { opacity: 0; transform: translateY(40px) scale(0.95); }
        100% { opacity: 1; transform: translateY(0) scale(1); }
    }

    .login-header {
        text-align: center;
        padding: 3.5rem 2rem 1.5rem;
    }
    
    .icon-bounce {
        font-size: 3.5rem;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        animation: float 4s ease-in-out infinite;
        display: inline-block;
        margin-bottom: 0.5rem;
    }
    
    @keyframes float {
        0% { transform: translateY(0px); }
        50% { transform: translateY(-10px); }
        100% { transform: translateY(0px); }
    }

    .form-title {
        font-weight: 800;
        color: var(--text-color);
        margin-bottom: 0.5rem;
        font-size: 2rem;
    }

    .role-badges {
        display: flex; gap: 0.5rem; justify-content: center; margin-bottom: 1rem; flex-wrap: wrap;
    }
    .role-badge {
        font-size: 0.8rem; font-weight: 700; padding: 0.35rem 1rem; border-radius: 20px;
        background: rgba(79, 70, 229, 0.1); color: var(--primary);
        box-shadow: 0 2px 5px rgba(79,70,229,0.05);
    }

    .login-body {
        padding: 0 3rem 3.5rem;
    }

    .input-group-custom {
        margin-bottom: 1.5rem;
        position: relative;
    }
    
    .input-group-custom .form-control {
        border-radius: 14px;
        border: 2px solid #e2e8f0;
        padding: 1rem 1rem 1rem 3.25rem;
        font-weight: 500;
        background: #f8fafc;
        transition: all 0.3s ease;
        font-size: 1rem;
    }
    
    .input-group-custom .form-control:focus {
        border-color: var(--primary);
        background: #fff;
        box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        outline: none;
    }
    
    .input-icon {
        position: absolute; left: 1.25rem; top: 1.15rem;
        color: #94a3b8; z-index: 10; font-size: 1.25rem;
        transition: all 0.3s ease;
    }
    
    .input-group-custom .form-control:focus ~ .input-icon {
        color: var(--primary); transform: scale(1.1);
    }

    .btn-login {
        background: linear-gradient(135deg, var(--text-color), #334155);
        color: white; border: none; border-radius: 14px;
        padding: 1rem; font-weight: 600; font-size: 1.15rem;
        width: 100%; transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        display: flex; justify-content: center; align-items: center; gap: 0.5rem;
        position: relative; overflow: hidden; z-index: 1;
        margin-top: 1rem;
    }

    .btn-login::before {
        content: ''; position: absolute; top: 0; left: -100%; width: 100%; height: 100%;
        background: linear-gradient(135deg, var(--primary), #7c3aed);
        transition: left 0.4s ease; z-index: -1;
    }

    .btn-login:hover::before { left: 0; }
    .btn-login:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(79, 70, 229, 0.3); color: white; }

    .bottom-link {
        text-align: center; margin-top: 2rem; font-size: 1rem; font-weight: 500; color: #64748b;
    }
    .bottom-link a {
        color: var(--primary); font-weight: 800; text-decoration: none; transition: all 0.3s ease;
    }
    .bottom-link a:hover { color: var(--secondary); text-decoration: underline; }

    /* Stagger field animations */
    .anim-field {
        opacity: 0; animation: fadeSlideUp 0.6s forwards;
    }
    .anim-field:nth-child(1) { animation-delay: 0.2s; }
    .anim-field:nth-child(2) { animation-delay: 0.3s; }
    .anim-field:nth-child(3) { animation-delay: 0.4s; }
    .anim-field:nth-child(4) { animation-delay: 0.5s; }

    @keyframes fadeSlideUp {
        0% { opacity: 0; transform: translateY(20px); }
        100% { opacity: 1; transform: translateY(0); }
    }
    
    @media (max-width: 576px) {
        .login-body { padding: 0 2rem 2.5rem; }
        .login-header { padding: 2.5rem 1.5rem 1.5rem; }
    }
</style>

<div class="login-wrapper">
    <div class="login-card">
        
        <div class="login-header">
            <i class="bi bi-fingerprint icon-bounce"></i>
            <h3 class="form-title">Welcome Back</h3>
            <p class="text-muted mb-4">Sign in to access your secure portal</p>
            
            <div class="role-badges">
                <span class="role-badge"><i class="bi bi-mortarboard-fill me-1"></i> Student</span>
                <span class="role-badge"><i class="bi bi-person-video3 me-1"></i> Faculty</span>
                <span class="role-badge"><i class="bi bi-shield-lock-fill me-1"></i> Admin</span>
            </div>
        </div>

        <div class="login-body">
            
            <c:if test="${not empty output}">
                <div class="alert alert-danger rounded-3 fw-bold text-center py-2 mb-4 anim-field border-0 shadow-sm" style="background: #fee2e2; color: #b91c1c;">
                    <i class="bi bi-exclamation-octagon-fill me-2"></i> ${output}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                
                <!-- Email -->
                <div class="input-group-custom anim-field">
                    <input type="email" name="email" class="form-control" placeholder="Email Address" required>
                    <i class="bi bi-envelope-at input-icon"></i>
                </div>

                <!-- Password -->
                <div class="input-group-custom anim-field">
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                    <i class="bi bi-key input-icon"></i>
                </div>

                <div class="anim-field">
                    <button type="submit" class="btn-login">
                        Sign In <i class="bi bi-box-arrow-in-right fs-4 ms-1"></i>
                    </button>
                </div>

            </form>

            <div class="bottom-link anim-field">
                Don't have an account? <br class="d-sm-none"> <a href="${pageContext.request.contextPath}/register">Create one here</a>
            </div>

        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />