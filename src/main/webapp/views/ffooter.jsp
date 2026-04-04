<link rel="stylesheet" href="/css/bootstrap.min.css" />
<style>
    /* Make all footer text white */
    footer {
        color: white;
        background-color: #2b2b2b;
        /* distinct dark tone for faculty */
        border-top: 5px solid #38EF7D;
    }

    /* Make links white */
    footer .nav-link,
    footer h5,
    footer p,
    footer a {
        color: #dcdcdc !important;
        transition: 0.3s;
    }

    /* Hover color success for faculty */
    footer .nav-link:hover,
    footer a:hover {
        color: #11998E !important;
    }
</style>

<footer class="py-5 mt-5">
    <div class="row container mx-auto">
        <div class="col-6 col-md-3 mb-3">
            <h5 class="text-success">Teaching Tools</h5>
            <ul class="nav flex-column">
                <li class="nav-item mb-2"><a href="/fdashboard" class="nav-link p-0 text-body-secondary">Faculty
                        Dashboard</a></li>
                <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-body-secondary">Curriculum Planning</a>
                </li>
                <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-body-secondary">Gradebook</a></li>
                <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-body-secondary">Faculty Directory</a>
                </li>
            </ul>
        </div>
        <div class="col-6 col-md-3 mb-3">
            <h5 class="text-success">Institutional</h5>
            <ul class="nav flex-column">
                <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-body-secondary">Academic Calendar</a>
                </li>
                <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-body-secondary">Department Policies</a>
                </li>
                <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-body-secondary">HR Portal</a></li>
            </ul>
        </div>

    </div>
    <div
        class="d-flex flex-column flex-sm-row justify-content-between py-4 my-4 border-top border-secondary container mx-auto">
        <p>© 2026 Faculty Systems. Educational Tools.</p>
    </div>
</footer>