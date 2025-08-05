<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.entity.User, com.entity.Customer"%>

<%
User loggedUser = (User) session.getAttribute("loggedUser");
Customer customer = (Customer) session.getAttribute("customer");
String role = null;
if (loggedUser != null) {
	role = loggedUser.getRole();
}

if (loggedUser == null) {
%>

<!-- Skip link for keyboard users -->
<a class="visually-hidden-focusable sr-only" href="#main-content" style="position: absolute; top: 0; left: 0; background:#fff; padding:8px; z-index:1000;">
  Skip to content
</a>

<nav class="navbar navbar-expand-lg bg-body-tertiary shadow-sm" aria-label="Primary navigation">
  <div class="container-fluid">
    <!-- Brand -->
    <a class="navbar-brand d-flex align-items-center gap-2" href="index.jsp">
      <span class="h5 mb-0">PahanaEdu</span>
      <i class="fa-solid fa-book-open" aria-hidden="true" style="color: #8293FF; font-size:1.5rem;"></i>
      <span class="visually-hidden">Home</span>
    </a>

    <!-- Toggler -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain"
      aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Collapsible content -->
    <div class="collapse navbar-collapse justify-content-end" id="navbarMain">
      <!-- Navigation links -->
      <ul class="navbar-nav me-3 mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="index.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">About</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Items</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Help</a>
        </li>
      </ul>

      <!-- Search form -->
      <form class="d-flex align-items-center me-3" role="search" aria-label="Site search">
        <label for="nav-search" class="visually-hidden">Search</label>
        <input id="nav-search" class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-primary" type="submit">Search</button>
      </form>

      <!-- User dropdown -->
      <div class="dropdown">
        <button class="btn btn-light d-flex align-items-center" type="button" id="userDropdown" data-bs-toggle="dropdown"
          aria-expanded="false" aria-label="User menu">
          <i class="fa-solid fa-user" aria-hidden="true" style="font-size:1.25rem; color:#1b1c1d;"></i>
          <span class="ms-2 d-none d-lg-inline">Account</span>
        </button>
        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
          <li>
            <a class="dropdown-item d-flex align-items-center" href="Login.jsp">
              <i class="fa-solid fa-right-to-bracket me-2" aria-hidden="true"></i>Login
            </a>
          </li>
          <li><hr class="dropdown-divider"></li>
          <li>
            <a class="dropdown-item text-danger d-flex align-items-center" href="register.jsp">
              <i class="fa-solid fa-user-plus me-2 text-danger" aria-hidden="true"></i>Register
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</nav>

<!-- Optional: CSS to enhance -->
<style>
  :root {
    --navbar-bg: #f5f6fa;
    --brand-color: #2c3e50;
  }

  .navbar {
    background-color: var(--navbar-bg) !important;
  }

  .navbar-brand {
    color: var(--brand-color);
    font-weight: 600;
  }

  .nav-link {
    position: relative;
  }

  .nav-link:focus-visible,
  .btn:focus-visible {
    outline: 3px solid #8293FF;
    outline-offset: 2px;
  }

  .dropdown-menu {
    min-width: 200px;
  }

  /* Show active underline */
  .nav-link.active {
    font-weight: 600;
  }

  /* Visually hidden but focusable helper */
  .visually-hidden-focusable {
    clip: rect(0 0 0 0);
    clip-path: inset(50%);
    height: 1px;
    overflow: hidden;
    position: absolute;
    width: 1px;
  }
  .visually-hidden-focusable:focus, .visually-hidden-focusable:not(.sr-only) {
    clip: auto;
    clip-path: none;
    height: auto;
    width: auto;
    position: static;
    margin: 0;
    padding: 8px;
    background: #fff;
    border: 1px solid #8293FF;
    z-index: 2000;
  }
</style>


<!-- Admin-Navbar -->
<%
} else if ("admin".equalsIgnoreCase(role)) {
%>
<!-- admin-navbar.css (include separately) -->
<style>
  :root {
    --navbar-bg: #1f3b70;
    --navbar-text: #ffffff;
    --brand-accent: #8293FF;
  }
  .navbar-admin {
    background-color: #6f737a;
  }
  .navbar-admin .nav-link {
    color: var(--navbar-text);
  }
  .navbar-admin .nav-link.active,
  .navbar-admin .nav-link:hover {
    color: #f0f8ff;
    font-weight: 600;
  }
  .theme-toggle {
    cursor: pointer;
    border: none;
    background: transparent;
  }
  .badge-notification {
    position: absolute;
    top: 6px;
    right: 6px;
    font-size: 0.55rem;
    transform: translate(50%, -50%);
  }
  .avatar-circle {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background-color: #ccc;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    font-size: 0.85rem;
    color: #333;
  }
</style>

<nav class="navbar navbar-expand-lg navbar-admin navbar-dark">
  <div class="container-fluid">
    <!-- Brand -->
    <a class="navbar-brand d-flex align-items-center gap-2" href="#">
      <span class="fs-5 fw-bold">PahanaEdu</span>
      <i class="fa-solid fa-book-open" style="color: var(--brand-accent);"></i>
    </a>

    <!-- Mobile toggler -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar" aria-controls="adminNavbar" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Collapse content -->
    <div class="collapse navbar-collapse" id="adminNavbar">
      <!-- Left nav links -->
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link <!-- add 'active' server-side when on dashboard -->" href="Admin_Home.jsp" aria-current="page"><i class="fa-solid fa-layer-group"></i> Dashboard</a>
        </li>
        
       <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="moreDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Items
          </a>
          <ul class="dropdown-menu" aria-labelledby="moreDropdown">
            <li><a class="dropdown-item" href="Admin_Add_Item.jsp">Add Items</a></li>
            <li><a class="dropdown-item" href="Admin_View_Item.jsp">View Items</a></li>
          </ul>
        </li>
        
        
        <li class="nav-item">
          <a class="nav-link" href="Admin_Bill_details.jsp">Payments</a>
        </li>
        <!-- Example dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="moreDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            More
          </a>
          <ul class="dropdown-menu" aria-labelledby="moreDropdown">
            <li><a class="dropdown-item" href="#">Reports</a></li>
            <li><a class="dropdown-item" href="#">Settings</a></li>
          </ul>
        </li>
      </ul>

      <!-- Search -->
      <form class="d-flex me-3" role="search" method="get" action="search.jsp">
        <input class="form-control form-control-sm me-2" type="search" name="q" placeholder="Search…" aria-label="Search">
        <button class="btn btn-sm btn-outline-light" type="submit">Search</button>
      </form>

      <!-- Right-side utilities -->
      <div class="d-flex align-items-center gap-3">
        <!-- Notifications -->
        <div class="dropdown">
          <button class="btn position-relative text-white" id="notifDropdown" data-bs-toggle="dropdown" aria-expanded="false" aria-label="Notifications">
            <i class="fa-regular fa-bell fa-lg"></i>
            <span class="badge bg-danger rounded-pill badge-notification">3</span>
            <span class="visually-hidden">3 new notifications</span>
          </button>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="notifDropdown" style="width: 300px;">
            <li class="dropdown-header">Notifications</li>
            <li><hr class="dropdown-divider"></li>
            <li>
              <a class="dropdown-item d-flex align-items-start" href="#">
                <div class="me-2"><i class="fa-solid fa-circle-exclamation"></i></div>
                <div>
                  <div class="small text-muted">5 min ago</div>
                  <div>New user registered: <strong>john.doe</strong></div>
                </div>
              </a>
            </li>
            <li>
              <a class="dropdown-item d-flex align-items-start" href="#">
                <div class="me-2"><i class="fa-solid fa-file-lines"></i></div>
                <div>
                  <div class="small text-muted">1 hour ago</div>
                  <div>Monthly report is ready.</div>
                </div>
              </a>
            </li>
            <li>
              <a class="dropdown-item text-center" href="#">View all</a>
            </li>
          </ul>
        </div>

       <!--  <!-- Theme toggle -->
     <!--    <button class="theme-toggle text-white" id="themeToggle" aria-label="Toggle theme">
          <i class="fa-solid fa-moon" id="themeIcon"></i>
        </button> -->

        <!-- User dropdown -->
        <div class="dropdown">
          <button class="btn d-flex align-items-center text-white" type="button" id="userMenu" data-bs-toggle="dropdown" aria-expanded="false">
            <!-- Optionally replace with user avatar image -->
            <div class="avatar-circle me-2">
              <%= loggedUser.getUsername().substring(0,1).toUpperCase() %>
            </div>
            <span class="me-1"><%= loggedUser.getUsername() %></span>
            <i class="fa-solid fa-chevron-down small"></i>
          </button>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userMenu">
            <li><a class="dropdown-item" href="Admin_Manage_Users.jsp"><i class="fa-regular fa-user"></i> Manage Users</a></li>
            <li><a class="dropdown-item" href="Admin_help.jsp"><i class="fa-regular fa-headset"></i> Help</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item text-danger" href="index.jsp"> <i class="fa-solid fa-right-from-bracket" style="color: #ff0000;"></i> Logout</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</nav>

<!-- Optional script to persist theme (light/dark) -->
<script>
  const toggleBtn = document.getElementById('themeToggle');
  const themeIcon = document.getElementById('themeIcon');
  const setTheme = (mode) => {
    if (mode === 'dark') {
      document.documentElement.classList.add('bg-dark', 'text-light');
      themeIcon.className = 'fa-solid fa-sun';
    } else {
      document.documentElement.classList.remove('bg-dark', 'text-light');
      themeIcon.className = 'fa-solid fa-moon';
    }
    localStorage.setItem('adminTheme', mode);
  };
  // initialize
/*   const saved = localStorage.getItem('adminTheme') || 'light';
  setTheme(saved);
  toggleBtn.addEventListener('click', () => {
    const current = localStorage.getItem('adminTheme') === 'dark' ? 'dark' : 'light';
    setTheme(current === 'dark' ? 'light' : 'dark'); */
  });
</script>

<!-- Admin-Navbar End -->
<%



} else if ("customer".equalsIgnoreCase(role)) {
%>


<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
  <div class="container-fluid">
    <!-- Brand -->
    <a class="navbar-brand d-flex align-items-center" href="#">
      <i class="fa-solid fa-book-open fa-lg me-2" style="color: #8293FF;"></i>
      <span class="fw-bold text-primary">PahanaEdu</span>
    </a>

    <!-- Toggler -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#customerNavbar" aria-controls="customerNavbar" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Content -->
    <div class="collapse navbar-collapse" id="customerNavbar">
      <!-- Left: primary nav -->
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="Customer_Home.jsp">Home</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="shopDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Shop
          </a>
          <ul class="dropdown-menu" aria-labelledby="shopDropdown">
            <li><a class="dropdown-item" href="categories.jsp">Categories</a></li>
            <li><a class="dropdown-item" href="best_sellers.jsp">Best Sellers</a></li>
            <li><a class="dropdown-item" href="new_arrivals.jsp">New Arrivals</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="all_products.jsp">All Products</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="orders.jsp">My Orders</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="support.jsp">Support</a>
        </li>
      </ul>

      <!-- Center: search (collapses gracefully) -->
      <form class="d-flex mx-lg-3 my-2 my-lg-0" role="search" aria-label="Search products">
        <div class="input-group">
          <input class="form-control" type="search" placeholder="Search courses, books..." aria-label="Search">
          <button class="btn btn-outline-primary" type="submit" aria-label="Submit search">
            <i class="fa-solid fa-magnifying-glass"></i>
          </button>
        </div>
      </form>

      <!-- Right: utilities -->
      <ul class="navbar-nav align-items-center mb-2 mb-lg-0">
        <!-- Notifications -->
        <li class="nav-item me-2">
          <button class="btn position-relative" type="button" aria-label="Notifications">
            <i class="fa-regular fa-bell fa-lg"></i>
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
              3
              <span class="visually-hidden">unread notifications</span>
            </span>
          </button>
        </li>

        <!-- Cart -->
        <li class="nav-item me-2">
          <a class="btn position-relative" href="cart.jsp" aria-label="View cart">
            <i class="fa-solid fa-cart-shopping fa-lg"></i>
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-success">
              2
              <span class="visually-hidden">items in cart</span>
            </span>
          </a>
        </li>

        <!-- Theme toggle -->
        <li class="nav-item me-3">
          <button id="themeToggle" class="btn" aria-label="Toggle light/dark mode">
            <i class="fa-solid fa-moon"></i>
          </button>
        </li>

        <!-- User dropdown -->
        <li class="nav-item dropdown">
          <button class="btn d-flex align-items-center" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fa-solid fa-user-circle fa-2x me-1"></i>
            <span class="d-none d-md-inline"><%= loggedUser.getUsername() %></span>
            <i class="fa-solid fa-caret-down ms-1"></i>
          </button>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
            <li><a class="dropdown-item" href="profile.jsp">Profile</a></li>
            <li><a class="dropdown-item" href="settings.jsp">Settings</a></li>
            <li><a class="dropdown-item" href="help.jsp">Help Center</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item text-danger" href="index.jsp">Logout</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Optional: Light/Dark mode toggle script -->
<script>
  const toggle = document.getElementById('themeToggle');
  toggle.addEventListener('click', () => {
    document.body.classList.toggle('bg-dark');
    document.body.classList.toggle('text-light');
    // swap icon
    const icon = toggle.querySelector('i');
    if (document.body.classList.contains('bg-dark')) {
      icon.className = 'fa-solid fa-sun';
    } else {
      icon.className = 'fa-solid fa-moon';
    }
  });
</script>

<!-- Custom small adjustments -->
<style>
  .navbar-brand .text-primary {
    font-size: 1.25rem;
  }
  .btn {
    border: none;
    background: none;
  }
  .navbar .btn:focus {
    outline: 2px solid #8293FF;
    outline-offset: 2px;
  }
</style>

<%
} else {
%>
<nav class="navbar navbar-expand-lg" style="background-color: #aaaaaa;">
	<div class="container-fluid">

		<a class="navbar-brand d-flex align-items-center" href="#"> <span
			class="brand-text">PahanaEdu <i
				class="fa-solid fa-book-open fa-2xl" style="color: #8293FF;"></i></span>
		</a>

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarRight">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse justify-content-end"
			id="navbarRight">
			<ul class="navbar-nav mb-4 mb-lg-0 me-3">
				<li class="nav-item"><a class="nav-link active"
					href="index.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="#">About</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Items</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Help</a></li>
			</ul>

			<form class="d-flex ms-4 me-3" role="search">
				<input class="form-control me-2" type="search" placeholder="Search"
					aria-label="Search">
				<button class="btn btn-outline-primary" type="submit">Search</button>
			</form>

			<div class="dropdown d-inline-block user-dropdown ms-4">
				<button type="button" class="btn header-item"
					id="page-header-user-dropdown" data-bs-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">
					<i class="fa-solid fa-user fa-2x" style="color: #1b1c1d;"></i>

				</button>
				<div class="dropdown-menu dropdown-menu-end">
					<a class="dropdown-item" href="Login.jsp"> <i
						class="fa-solid fa-right-to-bracket me-2"></i> Login
					</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item text-danger" href="register.jsp"> <i
						class="fa-solid fa-user-plus me-2 text-danger"></i> Register
					</a>
				</div>
			</div>

		</div>
	</div>
</nav>

<%
}
%>

