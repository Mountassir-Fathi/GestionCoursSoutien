<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>Gestion des Étudiants Inscrits</title>
<jsp:include page="../fragments/top.jsp"></jsp:include>


</head>

<body>


	<jsp:include page="../fragments/navbar.jsp"></jsp:include>
	<jsp:include page="../fragments/sidebar.jsp"></jsp:include>

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>Étudiants Inscrits</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item active">Étudiants Inscrits</li>
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
								class="btn btn-primary my-3 py-2 px-3 rounded-pill fw-bold"
								data-bs-toggle="modal" data-bs-target="#ajouter">
								<i class="fa-solid fa-graduation-cap me-2"></i> <span
									class="fw-bold">Nouvel Étudiant</span>

							</button>

							<!-- Modal -->
							<div class="modal fade" id="ajouter" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-lg modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="exampleModalLabel">Nouvel Étudiant</h4>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<form id="ajouterForm" method="post">
												<input type="hidden" name="operation" value="ajouter" />
												<div class="row mb-3">
													<label for="nom" class="col-sm-2 col-form-label">Nom</label>
													<div class="col-sm-10">
														<input name="nom" id="nom" type="text"
															class="form-control" required>
													</div>
												</div>

												<div class="row mb-3">
													<label for="prenom" class="col-sm-2 col-form-label">Prénom</label>
													<div class="col-sm-10">
														<input name="prenom" id="prenom" type="text"
															class="form-control" required>
													</div>
												</div>

												<div class="row mb-3">
													<label for="tel" class="col-sm-2 col-form-label">Tel</label>
													<div class="col-sm-10">
														<input name="tel" id="tel" type="tel" class="form-control"
															placeholder="+212 632143152" pattern="^\+(212)\s?\d{9}$"
															required>
													</div>
												</div>

												<div class="row mb-3">
													<label for="email" class="col-sm-2 col-form-label">E-mail</label>
													<div class="col-sm-10">
														<input name="email" id="email" type="email"
															class="form-control" required>
													</div>
												</div>

												<div class="row mb-3">
													<label for="password" class="col-sm-2 col-form-label">Password</label>
													<div class="col-sm-10">
														<input name="password" id="password" type="password"
															class="form-control" required>
													</div>
												</div>

												<div class="row mb-3">
													<label class="col-sm-2 col-form-label" for="niveau">Niveau</label>
													<div class="col-sm-10">
														<select name="niveau" class="form-select"
															aria-label="Default select example" id="niveau">
															<c:forEach var="niveau" items="${ niveaux }">
																<option value="${ niveau.id }">${ niveau.nom }</option>
															</c:forEach>
														</select>
													</div>
												</div>

												<div class="row mb-3">
													<label class="col-sm-2 col-form-label" for="groupe">Groupe</label>
													<div class="col-sm-10">
														<select name="groupe" class="form-select"
															aria-label="Default select example" id="groupe">
															<c:forEach var="groupe" items="${ groupes }">
																<option value="${ groupe.id }">${ groupe.nom }</option>
															</c:forEach>
														</select>
													</div>
												</div>

												<div class="row mb-3">
													<legend class="col-form-label col-sm-2 pt-0">Matières</legend>
													<div class="col-sm-10">
														<c:forEach var="matiere" items="${ matieres }">
															<div class="form-check me-3 d-inline-block">
																<input name="matieres" class="form-check-input"
																	type="checkbox" id="matiere${ matiere.id }"
																	value="${ matiere.id }" checked> <label
																	class="form-check-label" for="matiere${ matiere.id }">
																	${fn:toUpperCase(matiere.nom) } </label>
															</div>
														</c:forEach>
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


							<h5 class="card-title text-center fs-3">Tableau des Étudiants Inscrits</h5>
							<!-- 		          <p class="text-center">Add lightweight datatables to your project with using the Simple DataTables library. Just add .datatable class name to any table you wish to conver to a datatable</p> -->

							<table class="table datatable">
								<thead>
									<tr>
										<th><span class="d-block text-center">Nom</span></th>
										<th><span class="d-block text-center">Prénom</span></th>
										<th><span class="d-block text-center">Niveau</span></th>
										<th><span class="d-block text-center">Groupe</span></th>
										<th><span class="d-block text-center">Tel</span></th>
										<th><span class="d-block text-center">Date d'Entrée</span></th>
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
													<div class="row">
														<div class="col-md-4">
															<!-- Button trigger modal -->
															<button type="button" class="btn btn-success w-100"
																data-bs-toggle="modal"
																data-bs-target="#modifier${ etudiant.id }">
																<i class="bi bi-pen-fill"></i>
															</button>

															<!-- Modal -->
															<div class="modal fade" id="modifier${ etudiant.id }"
																tabindex="-1" aria-labelledby="exampleModalLabel"
																aria-hidden="true">
																<div class="modal-dialog modal-lg modal-dialog-centered">
																	<div class="modal-content">
																		<div class="modal-header">
																			<h4 class="modal-title" id="exampleModalLabel">Modifier
																				Étudiant</h4>
																			<button type="button" class="btn-close"
																				data-bs-dismiss="modal" aria-label="Close"></button>
																		</div>
																		<div class="modal-body">
																			<form id="modifierForm${etudiant.id}" method="post">
																				<input type="hidden" name="operation"
																					value="modifier" /> <input type="hidden" name="id"
																					value="${ etudiant.id }" />
																				<div class="row mb-3">
																					<label for="nom${ etudiant.id }"
																						class="col-sm-2 col-form-label">Nom</label>
																					<div class="col-sm-10">
																						<input name="nom" value="${ etudiant.nom }"
																							id="nom${ etudiant.id }" type="text"
																							class="form-control" required>
																					</div>
																				</div>

																				<div class="row mb-3">
																					<label for="prenom${ etudiant.id }"
																						class="col-sm-2 col-form-label">Prénom</label>
																					<div class="col-sm-10">
																						<input name="prenom" id="prenom${ etudiant.id }"
																							type="text" value="${ etudiant.prenom }"
																							class="form-control" required>
																					</div>
																				</div>

																				<div class="row mb-3">
																					<label for="tel${ etudiant.id }"
																						class="col-sm-2 col-form-label">Tel</label>
																					<div class="col-sm-10">
																						<input name="tel" id="tel${ etudiant.id }"
																							type="tel" class="form-control"
																							value="${ etudiant.tel }"
																							placeholder="+212 632143152"
																							pattern="^\+(212)\s?\d{9}$" required>
																					</div>
																				</div>

																				<div class="row mb-3">
																					<label for="email${ etudiant.id }"
																						class="col-sm-2 col-form-label">E-mail</label>
																					<div class="col-sm-10">
																						<input name="email" id="email${ etudiant.id }"
																							type="email" value="${ etudiant.mail }"
																							class="form-control" required>
																					</div>
																				</div>

																				<div class="row mb-3">
																					<label for="password${ etudiant.id }"
																						class="col-sm-2 col-form-label">Password</label>
																					<div class="col-sm-10">
																						<input name="password"
																							id="password${ etudiant.id }" type="password"
																							class="form-control">
																					</div>
																				</div>

																				<div class="row mb-3">
																					<label class="col-sm-2 col-form-label"
																						for="niveau${ etudiant.id }">Niveau</label>
																					<div class="col-sm-10">
																						<select name="niveau" class="form-select"
																							aria-label="Default select example"
																							id="niveau${ etudiant.id }">
																							<c:forEach var="niveau" items="${ niveaux }">
																								<c:choose>
																									<c:when
																										test="${niveau.id == etudiant.niveau.id}">
																										<option value="${ niveau.id }" selected>${ niveau.nom }</option>
																									</c:when>
																									<c:otherwise>
																										<option value="${ niveau.id }">${ niveau.nom }</option>
																									</c:otherwise>
																								</c:choose>
																							</c:forEach>
																						</select>
																					</div>
																				</div>

																				<div class="row mb-3">
																					<label class="col-sm-2 col-form-label"
																						for="groupe${ etudiant.id }">Groupe</label>
																					<div class="col-sm-10">
																						<select name="groupe" class="form-select"
																							aria-label="Default select example"
																							id="groupe${ etudiant.id }">
																							<c:forEach var="groupe" items="${ groupes }">
																								<c:choose>
																									<c:when
																										test="${groupe.id == etudiant.groupe.id}">
																										<option value="${ groupe.id }" selected>${ groupe.nom }</option>
																									</c:when>
																									<c:otherwise>
																										<option value="${ groupe.id }">${ groupe.nom }</option>
																									</c:otherwise>
																								</c:choose>
																							</c:forEach>
																						</select>
																					</div>
																				</div>

																				<div class="row mb-3">
																					<legend class="col-form-label col-sm-2 pt-0">Matières</legend>
																					<div class="col-sm-10">
																						<c:forEach var="matiere" items="${ matieres }">
																							<c:set var="isExist" value="0" scope="page" />
																							<c:forEach var="etudiantMatiere"
																								items="${ etudiant.matieres }">
																								<c:if test="${etudiantMatiere.id == matiere.id}">
																									<c:set var="isExist" value="1" scope="page" />
																								</c:if>
																							</c:forEach>

																							<c:choose>
																								<c:when test="${ isExist == 1 }">
																									<div class="form-check me-3 d-inline-block">
																										<input name="matieres"
																											class="form-check-input" type="checkbox"
																											id="matiere${ matiere.id }${etudiant.id}"
																											value="${ matiere.id }" checked> <label
																											class="form-check-label"
																											for="matiere${ matiere.id }${etudiant.id}">
																											${matiere.nom } </label>
																									</div>
																								</c:when>
																								<c:otherwise>
																									<div class="form-check me-3 d-inline-block">
																										<input name="matieres"
																											class="form-check-input" type="checkbox"
																											id="matiere${ matiere.id }${etudiant.id}"
																											value="${ matiere.id }"> <label
																											class="form-check-label"
																											for="matiere${ matiere.id }${etudiant.id}">
																											${matiere.nom } </label>
																									</div>
																								</c:otherwise>
																							</c:choose>
																						</c:forEach>
																					</div>
																				</div>
																			</form>
																		</div>
																		<div class="modal-footer">
																			<button type="button" class="btn btn-secondary"
																				data-bs-dismiss="modal">Fermer</button>
																			<button type="submit"
																				form="modifierForm${etudiant.id}"
																				class="btn btn-primary">Enregister</button>
																		</div>
																	</div>
																</div>
															</div>


														</div>

														<div class="col-md-4">
															<a href="?operation=supprimer&id=${ etudiant.id }"
																class="btn btn-danger w-100"> <i
																class="bi bi-eraser-fill"></i>
															</a>
														</div>
														<div class="col-md-4">




															<!-- Button trigger modal -->
															<button type="button" class="btn btn-info w-100"
																data-bs-toggle="modal"
																data-bs-target="#info${ etudiant.id }">
																<i class="bi bi-info-circle-fill"></i>
															</button>


															<!-- Modal -->
															<div class="modal fade" id="info${ etudiant.id }"
																tabindex="-1" aria-labelledby="exampleModalLabel"
																aria-hidden="true">
																<div class="modal-dialog  modal-dialog-centered">
																	<div class="modal-content">
																		<div class="modal-header">
																			<h4 class="modal-title" id="exampleModalLabel">${etudiant.nom }
																				${etudiant.prenom }</h4>
																			<button type="button" class="btn-close"
																				data-bs-dismiss="modal" aria-label="Close"></button>
																		</div>
																		<div class="modal-body">
																			<h5>
																				<span class="text-secondary">E-mail    : </span>${etudiant.mail }</h5>
																			<h5>
																				<span class="text-secondary">Matière(s): </span>
																				<c:set var="count" value="1" />
																				<c:forEach var="matiere"
																					items="${etudiant.matieres }">
																					<c:choose>
																						<c:when
																							test="${ count == fn:length(etudiant.matieres) }">
																	${matiere.nom }
																</c:when>
																						<c:otherwise>
																	${matiere.nom } - 
																</c:otherwise>
																					</c:choose>
																					<c:set var="count" value="${ count + 1 }" />
																				</c:forEach>
																			</h5>

																			<h5>
																				<span class="text-secondary">Le coût associé :
																				</span>${etudiant.cotisationAnnuelle }</h5>

																		</div>
																		<div class="modal-footer">
																			<div></div>
																		</div>
																	</div>
																</div>
															</div>



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