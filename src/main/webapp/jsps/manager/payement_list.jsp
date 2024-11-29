<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">

<head>
<title>Gestion des Paiements</title>
<jsp:include page="../fragments/top.jsp"></jsp:include>


</head>

<body>


	<jsp:include page="../fragments/navbar.jsp"></jsp:include>
	<jsp:include page="../fragments/sidebar.jsp"></jsp:include>

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>Paiements</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item active">Paiements</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">


							<h5 class="card-title text-center fs-3">Table des Paiements</h5>
							<!-- 		          <p class="text-center">Add lightweight datatables to your project with using the Simple DataTables library. Just add .datatable class name to any table you wish to conver to a datatable</p> -->

							<table class="table datatable">
								<thead>
									<tr>
										<th><span class="d-block text-center">Nom</span></th>
										<th><span class="d-block text-center">Prénom</span></th>
										<th><span class="d-block text-center">Niveau</span></th>
										<th><span class="d-block text-center">Groupe</span></th>
										<th><span class="d-block text-center">Frais d'Adhésion</span></th>
										<th><span class="d-block text-center">Action</span></th>
									</tr>
								</thead>
								<tbody>

									<c:forEach var="etudiant" items="${map}">
										<tr>
											<td class="text-center"><span
												class="d-block text-center">${etudiant.key.nom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${etudiant.key.prenom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${etudiant.key.niveau.nom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${etudiant.key.groupe.nom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${etudiant.key.cotisationAnnuelle}
													DH</span></td>
											<td class="text-center">
												<div class="container">
													<div class="row justify-content-center">
														<div class="col-md-4 w-50 text-center">
															<c:choose>
																<c:when test="${etudiant.value}">
																	<a
																		href="?operation=payer&id=${etudiant.key.id}&payer=false"
																		class="btn text-bg-success"> <i
																		class="bi bi-cash-coin"></i> <span class="fw-bold">Payer</span>
																	</a>
																</c:when>
																<c:otherwise>
																	<a
																		href="?operation=payer&id=${etudiant.key.id}&payer=true"
																		class="btn btn-danger"> <i class="bi bi-cash-coin"></i>
																		<span class="fw-bold">Non Payer</span>
																	</a>
																</c:otherwise>
															</c:choose>
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