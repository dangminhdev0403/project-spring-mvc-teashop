<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${title}</title>

    <!-- Favicon -->
    <link
      rel="apple-touch-icon"
      sizes="76x76"
      href="/client/assets/favicon/apple-touch-icon.png"
    />
    <link
      rel="icon"
      type="image/png"
      sizes="32x32"
      href="/client/assets/favicon/favicon-32x32.png"
    />
    <link
      rel="icon"
      type="image/png"
      sizes="16x16"
      href="/client/assets/favicon/favicon-16x16.png"
    />
    <link rel="manifest" href="/client/assets/favicon/site.webmanifest" />
    <meta name="msapplication-TileColor" content="#da532c" />
    <meta name="theme-color" content="#ffffff" />

    <!-- Fonts -->
    <link rel="stylesheet" href="/client/assets/fonts/stylesheet.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
    />

    <!-- Styles -->
    <link rel="stylesheet" href="/client/assets/css/main.css" />
    <link rel="stylesheet" href="/client/assets/css/style.css" />
    <link rel="stylesheet" href="/client/assets/css/reponsive.css" />

    <link rel="stylesheet" href="/client/assets/css/sweetalert2.min.css" />

    <!-- Scripts -->
    <script src="/client/assets/js/scripts.js"></script>
    <script src="/client/assets/js/res.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://dangminhdev0403.github.io/lib-javascript/scripts.js"></script>
    <script src="https://unpkg.com/json5@2/dist/index.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/confetti-js"></script>
    
    <style>
      .alert {
        position: relative;
        padding: 1rem 1rem;
        margin-bottom: 1rem;
        border: 1px solid transparent;
        border-radius: 0.25rem;
      }
      .alert-danger {
        text-align: center;
        color: #842029;
        background-color: #f8d7da;
        border-color: #f5c2c7;
      }

      .hidden {
        display: none !important;
      }
      .swal-footer {
        display: flex;
        flex-direction: row-reverse;
        justify-content: center;
      }
      .btn-success {
        background: #31ce36 !important;
        border-color: #31ce36 !important;
      }

      .btn-danger {
        background: #f25961 !important;
        border-color: #f25961 !important;
        color: #fff;
      }
      .sub-menu--not-main {
        height: 100%;
      }
      .tinh {
        font-size: 1.7rem;
      }

      .quan {
        font-size: 1.7rem;
        text-align: -webkit-center;
      }
      .phuong {
        font-size: 1.7rem;
        text-align: -webkit-center;
      }
    </style>
  </head>
  <body>
    <header id="header" class="header"></header>

    <script>
      load("#header", "/header-logined");
    </script>
  </body>
</html>
