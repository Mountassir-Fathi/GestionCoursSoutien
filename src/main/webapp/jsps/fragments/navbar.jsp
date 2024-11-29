<%@page import="model.bo.Prof"%>
<%@page import="model.bo.User"%>
<%@page import="model.bo.Etudiant"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
User user = (User) request.getSession().getAttribute("userInfo");
if (user instanceof Etudiant) {
	user = (Etudiant) user;
} else if (user instanceof Prof) {
	user = (Prof) user;
}
%>
<!-- ======= Header ======= -->
<header id="header"
	class="header fixed-top d-flex align-items-center pe-3">

	<div class="d-flex align-items-center justify-content-between">
		<a href="${pageContext.request.contextPath }" class="logo d-flex align-items-center"> <img
			src="assets/img/logo.png" alt=""> <span
			class="d-none d-lg-block">ÉCOLE ESSALAM</span>

		</a>
		<%
		String path = (String) request.getAttribute("servletPath");
		if (path.startsWith("/prof") || path.startsWith("/etudiant")) {
		%>
		<i class=''></i>
		<%
		} else {
		%>
		<i class='bi bi-list toggle-sidebar-btn'></i>
		<%
		}
		%>
		<!--    	  <i class='$ request.getAttribute("servletPath").startsWith("/prof") || request.getAttribute("servletPath").startsWith("/etudiant")? "": "bi bi-list toggle-sidebar-btn"}'></i> -->
	</div>
	<!-- End Logo -->
	<c:set var="user" value="${ sessionScope.userInfo }" />
	

	<nav class="header-nav ms-auto">
		<ul class="d-flex align-items-center">


			<c:if test='${ user.role == "ETUDIANT" }'>
				<li class="nav-item dropdown"><a class="nav-link nav-icon show"
					href="#" data-bs-toggle="dropdown" aria-expanded="true"> <i
						class="bi bi-bell"></i>
						<c:set var="isNotTrue" value="false" scope="page"/>
							
							    <span class="badge bg-primary badge-number">1</span>
							
						
				</a> <!-- End Notification Icon -->

					<ul
						class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications show"
						data-popper-placement="bottom-end"
						style="position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate3d(-24.6667px, 35.3333px, 0px);">
						<li class="dropdown-header">Vous avez 1 nouvelle notification</li>
						<c:choose>
							<c:when test="${!payer}">
								<li>
									<hr class="dropdown-divider">
								</li>

								<li class="notification-item"><i
									class="bi bi-exclamation-circle text-warning"></i>
									
									<div>
										<h4>Annonce de payement</h4>
											<p>N'oublie pas de régler le paiement convenu pour les services
											 que je t'ai rendus en tant qu'étudiant de l'école Essalam.
											</p>
										
									</div></li>
							</c:when>
							<c:otherwise>
								<li>
									<hr class="dropdown-divider">
								</li>

								<li class="notification-item"><i
									class="bi bi-check-circle text-success"></i>
									
									<div>
										<h4>Annonce de payement</h4>
										<p>
											Je suis heureux de vous annoncer que le paiement pour ce mois a été réalisé avec succès au sein 
											de l'école Essalam. Merci pour votre promptitude et votre coopération.
										</p>
										
									</div></li>


							</c:otherwise>
						</c:choose>
					</ul> <!-- End Notification Dropdown Items -->
				</li>

			</c:if>

			<li class="nav-item dropdown pe-3"><a
				class="nav-link nav-profile d-flex align-items-center pe-0" href="#"
				data-bs-toggle="dropdown"> <span
					class="d-none d-md-block dropdown-toggle ps-2 fs-5">${ user.nom.toUpperCase().charAt(0) }.
						${ user.prenom.toUpperCase() }</span>
			</a> <!-- End Profile Iamge Icon -->

				<ul
					class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
					<li class="dropdown-header">
						<h6>${ user.nom }${ user.prenom }</h6> <span>${ user.role }</span>
					</li>
					<li>
						<hr class="dropdown-divider">
					</li>

					<li>
						<button class="dropdown-item d-flex align-items-center"
							data-bs-toggle="modal" data-bs-target="#profile">
							<i class="bi bi-person"></i> <span>Profile</span>
						</button>
					</li>
					<li>
						<hr class="dropdown-divider">
					</li>


					<li>
						<button class="dropdown-item d-flex align-items-center"
							data-bs-toggle="modal" data-bs-target="#change-password">
							<i class="bi bi-gear"></i> <span>Changer Password</span>
						</button>
					</li>
					<li>
						<hr class="dropdown-divider">
					</li>

					<li><a class="dropdown-item d-flex align-items-center"
						href="${ pageContext.request.contextPath }/signout"> <i
							class="bi bi-box-arrow-right"></i> <span>Se déconnecter</span>
					</a></li>

				</ul> <!-- End Profile Dropdown Items --></li>
			<!-- End Profile Nav -->

		</ul>
	</nav>

</header>
<!-- End Header -->


<!-- Modal -->
<div class="text-uppercase modal fade" id="profile" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Profile</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body fs-4">
				<span class="text-secondary">Nom : </span>${ user.nom } <br> <span
					class="text-secondary">Prénom : </span> ${ user.prenom } <br> <span
					class="text-secondary">E-mail : </span> ${ user.mail } <br>
				<c:if test='${ user.role == "ETUDIANT" }'>

					<span class="text-secondary">Tel : </span> ${ user.tel }
							  <br>
					<span class="text-secondary">Matière(s) : </span>

					<c:set var="count" value="1" />
					<c:forEach var="matiere" items="${ user.matieres }">
						<c:choose>
							<c:when test="${ count == fn:length(user.matieres) }">
											${matiere.nom }
										</c:when>
							<c:otherwise>
											${matiere.nom } - 
										</c:otherwise>
						</c:choose>
						<c:set var="count" value="${ count + 1 }" />
					</c:forEach>
					<br>
					<span class="text-secondary">Niveau : </span> ${ user.niveau.nom }
							  <br>
					<span class="text-secondary">Group : </span> ${ user.groupe.nom }
							  <br>
					<span class="text-secondary">Date Inscription : </span> ${ user.date_debut }
					  	</c:if>

				<c:if test='${ user.role == "PROF" }'>
					<span class="text-secondary">Tel : </span> ${ user.tel }
							  <br>
					<span class="text-secondary">Matière : </span> ${ user.matiere.nom }
							  <br>
					<span class="text-secondary">Niveau(x) : </span>
					<c:set var="count" value="1" />
					<c:forEach var="niveau" items="${ user.niveaux }">
						<c:choose>
							<c:when test="${ count == fn:length(user.niveaux) }">
											${niveau.nom }
										</c:when>
							<c:otherwise>
											${niveau.nom } - 
										</c:otherwise>
						</c:choose>
						<c:set var="count" value="${ count + 1 }" />
					</c:forEach>
					<br>
					<span class="text-secondary">Date Debut : </span> ${ user.date_debut }
					  	</c:if>
			</div>
			<div class="modal-footer"></div>
		</div>
	</div>
</div>



<!-- Modal -->
<div class="modal fade" id="change-password" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Changer Password</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">

				<!-- Change Password Form -->
				<form action="${ pageContext.request.contextPath }/navbar"
					method="post" id="formcp">
					<div class="row mb-3">
						<label for="currentPassword"
							class="col-md-4 col-lg-3 col-form-label">Password
							actuel</label>
						<div class="col-md-8 col-lg-9">
							<input name="password" type="password" class="form-control"
								id="currentPassword">
						</div>
					</div>

					<div class="row mb-3">
						<label for="newPassword" class="col-md-4 col-lg-3 col-form-label">Nouveau
							Password</label>
						<div class="col-md-8 col-lg-9">
							<input name="newpassword" type="password" class="form-control"
								id="newPassword">
						</div>
					</div>

					<div class="row mb-3">
						<label for="renewPassword"
							class="col-md-4 col-lg-3 col-form-label">Confirmez Password</label>
						<div class="col-md-8 col-lg-9">
							<input name="renewpassword" type="password" class="form-control"
								id="renewPassword">
						</div>
					</div>

				</form>
				<!-- End Change Password Form -->

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Fermer</button>
				<button type="submit" form="formcp" class="btn btn-primary"
					name="op" value="${ user.role }">Enregistrer</button>
			</div>
		</div>
	</div>
</div>
