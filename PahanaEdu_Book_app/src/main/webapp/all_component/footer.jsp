<%@ page import="java.time.Year,java.time.LocalDateTime,java.time.format.DateTimeFormatter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  .site-footer {
    text-align: center;
    padding: 20px 15px;
    background-color: #81b1ce;
    color: white;
    width: 100%;
    margin-top: 100px;
    font-size: 0.9rem;
  }

  .site-footer a {
    color: #ffffff;
    text-decoration: underline;
  }

  .site-footer a:hover,
  .site-footer a:focus {
    color: #dfe6e9;
    outline: none;
  }

  .footer-row + .footer-row {
    margin-top: 15px;
    border-top: 1px solid rgba(255,255,255,0.3);
    padding-top: 15px;
  }
</style>

<footer class="site-footer" aria-label="Page footer">
  <div class="container-fluid">
    <!-- First row: copyright and author -->
    <div class="row footer-row">
      <div class="col-sm-6 text-start">
        &copy; <span id="year"><%= Year.now().getValue() %></span> LK.
      </div>
      <div class="col-sm-6 text-sm-end d-none d-sm-block">
        Created with <i class="mdi mdi-heart text-danger" aria-hidden="true"></i>
        by <a href="#" rel="author" aria-label="Lahiru Kasun profile">Lahiru Kasun</a>
      </div>
    </div>

    <!-- Second row: company & contact info -->
    <div class="row footer-row">
      <div class="col-md-4 text-start">
        <strong>Company:</strong> Pahana Edu Bookshop<br>
        <strong>Address:</strong> Bambalapitiya, Colombo
      </div>
      <div class="col-md-4 text-center">
        <strong>Email:</strong>
        <a href="mailto:Pahana_Edu_bookshop@gmail.com">Pahana_Edu_bookshop@gmail.com</a><br>
        <strong>Phone:</strong> 076 444 7275
      </div>
      <div class="col-md-4 text-end">
        <strong>Current Date & Time:</strong><br>
        <%= LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) %>
      </div>
    </div>
  </div>
</footer>

<script>
  // JS fallback: update year if it ever differs (progressive enhancement)
  (function() {
    const currentYear = new Date().getFullYear().toString();
    const el = document.getElementById('year');
    if (el && el.textContent !== currentYear) {
      el.textContent = currentYear;
    }
  })();
</script>


