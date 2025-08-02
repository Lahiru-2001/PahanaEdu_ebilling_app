<nav class="navbar navbar-expand-lg" style="background-color: #aaaaaa;">
	<div class="container-fluid">

		<!-- Logo and System Name -->
		<a class="navbar-brand d-flex align-items-center" href="#"> <span
			class="brand-text">PahanaEdu <i
				class="fa-solid fa-book-open fa-2xl" style="color: #8293FF;"></i></span>
		</a>

		<!-- Toggler for mobile view -->
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarRight">
			<span class="navbar-toggler-icon"></span>
		</button>

		<!-- Centered nav + search, Right-aligned login/register -->
		<div class="collapse navbar-collapse justify-content-end"
			id="navbarRight">
			<ul class="navbar-nav mb-4 mb-lg-0">
				<li class="nav-item"><a class="nav-link active"
					href="index.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="#">About</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Items</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Help</a></li>
			</ul>

			<!-- Search bar -->
			<form class="d-flex ms-4" role="search">
				<input class="form-control me-2" type="search" placeholder="Search"
					aria-label="Search">
				<button class="btn btn-outline-primary" type="submit">Search</button>
			</form>

			<!-- Login/Register buttons -->
			<!-- User Dropdown -->
			<div class="dropdown d-inline-block user-dropdown ms-4">
				<button type="button" class="btn header-item"
					id="page-header-user-dropdown" data-bs-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">

					<!-- User icon -->
					<i class="fa-solid fa-circle-user fa-2x" style="color: #1b1c1d;"></i>

					<!-- Down arrow (optional) -->
					<span class="d-none d-xl-inline-block"> <i
						class="fa-solid fa-circle-chevron-down"></i>
					</span>
				</button>

				<!-- Dropdown menu -->
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
