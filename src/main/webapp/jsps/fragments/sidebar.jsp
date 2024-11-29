<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class='nav-link ${ servletPath == "/manager/dashboard"? "": "collapsed" }' href="${ pageContext.request.contextPath }/manager/dashboard">
          <i class="bi bi-grid"></i>
          <span>Dashboard</span>
        </a>
      </li><!-- End Dashboard Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-pen-fill"></i><span>Gestion</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="components-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="${ pageContext.request.contextPath }/manager/profs" class='${ servletPath != "/manager/profs"? "": "active" }'>
              <i class="icon-size-15px fa-solid fa-chalkboard-user"></i><span>Professeurs</span>
            </a>
          </li>
          <li>
            <a href="${ pageContext.request.contextPath }/manager/etudiants-inscrits" class='${ servletPath != "/manager/etudiants-inscrits"? "": "active" }'>
              <i class="icon-size-15px fa-solid fa-graduation-cap"></i><span>Etudiants inscrits</span>
            </a>
          </li>
          <li>
            <a href="${ pageContext.request.contextPath }/manager/etudiants-non-inscrits" class='${ servletPath != "/manager/etudiants-non-inscrits"? "": "active" }'>
              <i class="icon-size-15px fa-solid fa-users-slash"></i><span>Etudiants non inscrits</span>
            </a>
          </li>

        </ul>
        
      </li><!-- End Components Nav -->
      

     <!-- End Forms Nav -->
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
          <i class="fa-solid fa-sitemap"></i><span>Organisation</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="${ pageContext.request.contextPath }/manager/matieres" class='${ servletPath != "/manager/matieres"? "": "active" }'>
              <i class=" icon-size-15px fa-solid fa-book"></i><span>Matieres</span>
            </a>
          </li>
          <li>
            <a href="${ pageContext.request.contextPath }/manager/niveaux" class='${ servletPath != "/manager/niveaux"? "": "active" }'>
              <i class="icon-size-15px fa-solid fa-layer-group"></i><span>Niveaux</span>
            </a>
          </li>
          <li>
            <a href="${ pageContext.request.contextPath }/manager/groupes" class='${ servletPath != "/manager/groupes"? "": "active" }'>
              <i class="icon-size-15px fa-solid fa-users-between-lines"></i><span>Groupes</span>
            </a>
          </li>
          <li>
            <a href="${ pageContext.request.contextPath }/manager/salles" class='${ servletPath != "/manager/salles"? "": "active" }'>
              <i class="icon-size-15px fa-solid fa-door-open"></i><span>Salles</span>
            </a>
          </li>
        </ul>
      </li><!-- End Tables Nav -->

      
      <li class="nav-item">
        <a class='nav-link ${ servletPath == "/manager/paiement"? "": "collapsed" }' href="${ pageContext.request.contextPath }/manager/paiement">
          <i class="bi bi-cash-coin"></i>
          <span>Paiement</span>
        </a>
      </li>
      <li class="nav-item">
        <a class='nav-link  ${ servletPath == "/manager/emploi-de-temps"? "": "collapsed" }' href="${ pageContext.request.contextPath }/manager/emploi-de-temps">
          <i class="bi bi-calendar-date"></i>
          <span>Emploi de temps</span>
        </a>
      </li>
      <li class="nav-item">
        <a class='nav-link  ${ servletPath == "/manager/absenses"? "": "collapsed" }' href="${ pageContext.request.contextPath }/manager/absenses">
          <i class="bi bi-clipboard"></i>
          <span>Absense</span>
        </a>
      </li>
    </ul>
    
  </aside><!-- End Sidebar-->
