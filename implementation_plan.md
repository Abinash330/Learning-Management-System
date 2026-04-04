# Dynamic & Comprehensive Admin Portal Rebuild

The objective is to transform the Administrator portal from a mix of hardcoded layouts and basic forms into a fully dynamic, end-to-end data-driven command center. This requires bridging the gap between backend JDBC queries and our newly established premium UI token limits.

## Scope of Work

1. **Dynamic Dashboard Metrics (`AdminController.java`)**
    - The top KPI metrics inside `adashboard.jsp` (Active Users, Total Faculty, Total Courses) are currently hardcoded. We will wire them up dynamically.
    - Execute `COUNT(*)` SQL aggregation queries for Users and Faculty. 
    - Pass these integers into the `Model` so they reflect real-time infrastructure data.

2. **Revamp `/users` (Raw Database Access UI)**
    - Redesign `users.jsp` to match the premium theme.
    - Ensure it is a full-width data grid for deep-dives into the SQL table `user_master`.
    - Link back beautifully to the `adashboard`.

3. **Revamp `/edituser` (User Editing Form)**
    - Redesign `edituser.jsp` with glassmorphism forms.
    - Wire up form validations and ensure the controller's `updateusers` pipeline works flawlessly with the UI.

4. **Revamp `/addnotice` (Announcements Broadcaster)**
    - Redesign `addnotice.jsp` to look like a premium publisher platform rather than a basic form.
    - Include large text-areas, rich submission buttons, and clear success/error flash messages.

## Proposed Changes

### Controllers

#### [MODIFY] `AdminController.java`
- Update the `/adashboard` GET request mapped method.
- Add queries:
  - `SELECT COUNT(*) FROM user_master WHERE status = 1`
  - `SELECT COUNT(*) FROM user_master WHERE role = 'Faculty'`
  - Pass the aggregated counts to `Model`.

---

### Views (JSPs)

#### [MODIFY] `adashboard.jsp`
- Replace hardcoded numbers (1,250 / 45 / 80) with JSP EL bound variables (e.g., `${activeUsersCount}`, `${facultyCount}`).

#### [MODIFY/NEW] `users.jsp`
- Total rewrite of the raw-table access page.
- Apply `glass-card` styling, full-screen bounds, search filter mechanics, and clean pagination-ready structures.

#### [MODIFY/NEW] `edituser.jsp`
- Transform into an elegant glassmorphism editing modal/page.
- Properly map the User object bound from the `edit` POST method in `AdminController`.

#### [MODIFY/NEW] `addnotice.jsp`
- Overhaul layout with floating labels, gradient buttons, and visual success confirmation alerts.

## Open Questions

> [!IMPORTANT]
> - Do you have an existing database table for `Courses`? (If not, we can either create an empty schema for it or leave the 'Total Courses' metric mocked until the Course Builder is implemented).
> - Do you want the `users.jsp` page to feature a pure SQL-viewer styling (dense tables) or a spacious card-based styling like the dashboard?

## Verification Plan

### Manual Verification
- Log in visually through the browser as an Admin.
- Verify the numbers on the dashboard reflect the raw row counts in the MySQL backend.
- Post a Notice, then verify visual confirmation in the browser.
- Edit a user, and confirm the DB reflects the new name/role/mobile.
