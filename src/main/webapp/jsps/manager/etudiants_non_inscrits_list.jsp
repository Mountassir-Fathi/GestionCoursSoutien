<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">

<head>
<title>Les étudiants non inscrits</title>
<jsp:include page="../fragments/top.jsp"></jsp:include>


</head>

<body>


	<jsp:include page="../fragments/navbar.jsp"></jsp:include>
	<jsp:include page="../fragments/sidebar.jsp"></jsp:include>

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>Étudiants Non Inscrits</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item active">Étudiants Non Inscrits</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">

							<a class="btn btn-danger my-3 py-2 px-3 rounded-pill fw-bold"
								href="?operation=supprimer-tous"> <i
								class="fa-solid fa-users-slash me-1"></i> <span class="wf-bold">Supprimer
									Tous</span>
							</a>



							<h5 class="card-title text-center fs-3">Tableau des
								Étudiants Non Inscrits</h5>

							<!-- 		          <p class="text-center">Add lightweight datatables to your project with using the Simple DataTables library. Just add .datatable class name to any table you wish to conver to a datatable</p> -->

							<table class="table datatable">
								<thead>
									<tr>
										<th><span class="d-block text-center">Nom</span></th>
										<th><span class="d-block text-center">Prénom </span></th>
										<th><span class="d-block text-center">Niveau</span></th>
										<th><span class="d-block text-center">Groupe</span></th>
										<th><span class="d-block text-center">Tel</span></th>
										<th><span class="d-block text-center">Date
												d'Inscription</span></th>
										<th><span class="d-block text-center">Actions</span></th>


									</tr>
								</thead>
								<tbody>
									<c:forEach var="etudiant" items="${etudiants}">
										<tr>
											<td class="text-center"><span
												class="d-block text-center">${etudiant.nom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${etudiant.prenom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${etudiant.niveau.nom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${etudiant.groupe.nom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${etudiant.tel}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${etudiant.date_debut}</span></td>
											<td class="text-center">
												<div class="container">
													<div class="row justify-content-center">

														<div class="col-md-4">
															<a href="?operation=ajouter&id=${ etudiant.id }"
																class="btn btn-success w-100"> <i
																class="bi bi-check-lg"></i>
															</a>
														</div>

														<div class="col-md-4">
															<a href="?operation=supprimer&id=${ etudiant.id }"
																class="btn btn-danger w-100"> <i class="bi bi-x-lg"></i>
															</a>
														</div>
													</div>
												</div>
											</td>
										</tr>
									</c:forEach>

								</tbody>
							</table>
						</div>
					</div>

				</div>
			</div>
		</section>

	</main>
	<!-- End #main -->


	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<jsp:include page="../fragments/bottom.jsp"></jsp:include>

</body>

</html>