<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">

<head>
<title>Gestion des Niveaux</title>
<jsp:include page="../fragments/top.jsp"></jsp:include>


</head>

<body>


	<jsp:include page="../fragments/navbar.jsp"></jsp:include>
	<jsp:include page="../fragments/sidebar.jsp"></jsp:include>

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>Niveaux</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item active">Niveaux</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">

							<!-- Button trigger modal -->
							<button type="button"
								class="btn btn-primary my-3 py-2 px-3 rounded-pill"
								data-bs-toggle="modal" data-bs-target="#ajouter">
								<i class="fa-solid fa-layer-group me-2"></i> <span
									class="fw-bold">Ajouter Niveau</span>
							</button>

							<!-- Modal -->
							<div class="modal fade" id="ajouter" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-lg modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="exampleModalLabel">Ajouter
												Niveau</h4>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<form id="ajouterForm" method="post"
												action="/lessons-management/manager/niveaux">
												<input type="hidden" name="operation" value="ajouter" />
												<div class="row mb-3">
													<label for="nom" class="col-sm-2 col-form-label">Nom</label>
													<div class="col-sm-10">
														<input name="nom" id="nom" type="text"
															class="form-control" required>
													</div>
												</div>
											</form>
										</div>

										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">Fermer</button>
											<button type="submit" form="ajouterForm"
												class="btn btn-primary">Enregister</button>
										</div>

									</div>
								</div>
							</div>


							<h5 class="card-title text-center fs-3">Table des Niveaux</h5>
							<!-- 		          <p class="text-center">Add lightweight datatables to your project with using the Simple DataTables library. Just add .datatable class name to any table you wish to conver to a datatable</p> -->

							<div class="w-75 mx-auto">
								<table class="table datatable">
									<thead>
										<tr>
											<th><span class="d-block text-center">Nom</span></th>
											<th><span class="d-block text-center">Matières</span></th>
											<th><span class="d-block text-center">Nombre
													d'étudiants</span></th>
											<th><span class="d-block text-center">Actions</span></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="niveau" items="${niveaux}">
											<tr>
												<td class="text-center"><span
													class="d-block text-center">${niveau.nom}</span></td>
												<td class="text-center"><span
													class="d-block text-center"> <c:set var="count"
															value="1" /> <c:forEach var="matiere"
															items="${niveau.matieres}">
															<c:choose>
																<c:when test="${ count == fn:length(niveau.matieres) }">
													${matiere.nom }
												</c:when>
																<c:otherwise>
													${matiere.nom } - 
												</c:otherwise>
															</c:choose>
															<c:set var="count" value="${ count + 1 }" />
														</c:forEach></span></td>
												<td class="text-center"><span
													class="d-block text-center">${niveau.nbretudiants}</span></td>


												<td class="text-center">
													<div class="container">
														<div class="row justify-content-center">
															<div class="col-md-4">

																<!-- Button trigger modal -->
																<button type="button" class="btn btn-success w-100"
																	data-bs-toggle="modal"
																	data-bs-target="#modifier${ niveau.id }">
																	<i class="bi bi-pen-fill"></i>
																</button>

																<!-- Modal -->
																<div class="modal fade" id="modifier${ niveau.id }"
																	tabindex="-1" aria-labelledby="exampleModalLabel"
																	aria-hidden="true">
																	<div
																		class="modal-dialog modal-lg modal-dialog-centered">
																		<div class="modal-content">
																			<div class="modal-header">
																				<h4 class="modal-title" id="exampleModalLabel">Modifier
																					Niveau</h4>
																				<button type="button" class="btn-close"
																					data-bs-dismiss="modal" aria-label="Close"></button>
																			</div>
																			<div class="modal-body">
																				<form id="modifierForm${ niveau.nom }" method="post">
																					<input type="hidden" name="operation"
																						value="modifier" /> <input type="hidden"
																						name="id" value="${niveau.id}" />
																					<div class="row mb-3">
																						<label for="nom${ niveau.nom }"
																							class="col-sm-2 col-form-label">Nom</label>
																						<div class="col-sm-10">
																							<input name="nom" value="${ niveau.nom }"
																								id="nom${ niveau.nom }" type="text"
																								class="form-control" required>
																						</div>
																					</div>

																				</form>
																			</div>
																			<div class="modal-footer">
																				<button type="button" class="btn btn-secondary"
																					data-bs-dismiss="modal">Fermer</button>
																				<button type="submit"
																					form="modifierForm${ niveau.nom }"
																					class="btn btn-primary">Enregister</button>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
															<div class="col-md-4">
																<a href="?operation=supprimer&id=${ niveau.id }"
																	class="btn btn-danger w-100"> <i
																	class="bi bi-eraser-fill"></i>
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
