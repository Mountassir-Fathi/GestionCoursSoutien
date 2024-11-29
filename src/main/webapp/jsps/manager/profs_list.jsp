<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">

<head>
<title>Gestion des Professeurs</title>
<jsp:include page="../fragments/top.jsp"></jsp:include>


</head>

<body>


	<jsp:include page="../fragments/navbar.jsp"></jsp:include>
	<jsp:include page="../fragments/sidebar.jsp"></jsp:include>

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>Professeurs</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item active">Professeurs</li>
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
								<i class="fa-solid fa-chalkboard-user me-2"></i> <span
									class="fw-bold"> Nouveau Professeur</span>
							</button>

							<!-- Modal -->
							<div class="modal fade" id="ajouter" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-lg modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="exampleModalLabel">Ajouter
												Professeur</h4>
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
													<label for="prenom" class="col-sm-2 col-form-label">Prénom
													</label>
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
													<label class="col-sm-2 col-form-label" for="matiere">Matière</label>
													<div class="col-sm-10">
														<select name="matiere" class="form-select"
															aria-label="Default select example" id="matiere">
															<c:forEach var="matiere" items="${ matieres }">
																<option value="${ matiere.id }">${ matiere.nom }</option>
															</c:forEach>
														</select>
													</div>
												</div>

												<div class="row mb-3">
													<legend class="col-form-label col-sm-2 pt-0">Niveaux</legend>
													<div class="col-sm-10">
														<c:forEach var="niveau" items="${ niveaux }">
															<div class="form-check me-3 d-inline-block">
																<input name="niveaux" class="form-check-input"
																	type="checkbox" id="niveau${ niveau.id }"
																	value="${ niveau.id }" checked> <label
																	class="form-check-label" for="niveau${ niveau.id }">
																	${ niveau.nom } </label>
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


							<h5 class="card-title text-center fs-3">Tableau des
								Professeurs</h5>

							<table class="table datatable">
								<thead>
									<tr>
										<th><span class="d-block text-center">Nom</span></th>
										<th><span class="d-block text-center">Prénom </span></th>
										<th><span class="d-block text-center">Matière</span></th>
										<th><span class="d-block text-center">Tel</span></th>
										<th><span class="d-block text-center">Date
												d'Entrée</span></th>
										<th><span class="d-block text-center">Actions</span></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="prof" items="${profs}">
										<tr>
											<td class="text-center"><span
												class="d-block text-center">${prof.nom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${prof.prenom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${prof.matiere.nom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${prof.tel}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${prof.date_debut}</span></td>
											<td>

												<div class="container">
													<div class="row ">
														<div class="col-md-4">
															<!-- Button trigger modal -->
															<button type="button" class="btn btn-success w-100"
																data-bs-toggle="modal"
																data-bs-target="#modifier${ prof.id }">
																<i class="bi bi-pen-fill"></i>
															</button>

															<!-- Modal -->
															<div class="modal fade" id="modifier${ prof.id }"
																tabindex="-1" aria-labelledby="exampleModalLabel"
																aria-hidden="true">
																<div class="modal-dialog modal-lg modal-dialog-centered">
																	<div class="modal-content">
																		<div class="modal-header">
																			<h4 class="modal-title" id="exampleModalLabel">Modifier
																				Professeur</h4>
																			<button type="button" class="btn-close"
																				data-bs-dismiss="modal" aria-label="Close"></button>
																		</div>
																		<div class="modal-body">
																			<form id="modifierForm${ prof.id }" method="post">
																				<input type="hidden" name="operation"
																					value="modifier" /> <input type="hidden" name="id"
																					value="${ prof.id }" />
																				<div class="row mb-3">
																					<label for="nom${ prof.id }"
																						class="col-sm-2 col-form-label">Nom</label>
																					<div class="col-sm-10">
																						<input name="nom" value="${ prof.nom }"
																							id="nom${ prof.id }" type="text"
																							class="form-control" required>
																					</div>
																				</div>

																				<div class="row mb-3">
																					<label for="prenom${ prof.id }"
																						class="col-sm-2 col-form-label">Prénom</label>
																					<div class="col-sm-10">
																						<input name="prenom" id="prenom${ prof.id }"
																							type="text" value="${ prof.prenom }"
																							class="form-control" required>
																					</div>
																				</div>

																				<div class="row mb-3">
																					<label for="tel${ prof.id }"
																						class="col-sm-2 col-form-label">Tel</label>
																					<div class="col-sm-10">
																						<input name="tel" id="tel${ prof.id }" type="tel"
																							class="form-control" value="${ prof.tel }"
																							placeholder="+212 632143152"
																							pattern="^\+(212)\s?\d{9}$" required>
																					</div>
																				</div>

																				<div class="row mb-3">
																					<label for="email${ prof.id }"
																						class="col-sm-2 col-form-label">E-mail</label>
																					<div class="col-sm-10">
																						<input name="email" id="email${ prof.id }"
																							type="email" value="${ prof.mail }"
																							class="form-control" required>
																					</div>
																				</div>

																				<div class="row mb-3">
																					<label for="password${ prof.id }"
																						class="col-sm-2 col-form-label">Password</label>
																					<div class="col-sm-10">
																						<input name="password" id="password${ prof.id }"
																							type="password" class="form-control">
																					</div>
																				</div>

																				<div class="row mb-3">
																					<legend class="col-form-label col-sm-2 pt-0">Niveau(x)</legend>
																					<div class="col-sm-10">
																						<c:forEach var="niveau" items="${ niveaux }">
																							<c:set var="isExist" value="0" scope="page" />
																							<c:forEach var="profNiveau"
																								items="${ prof.niveaux }">
																								<c:if test="${profNiveau.id == niveau.id}">
																									<c:set var="isExist" value="1" scope="page" />
																								</c:if>
																							</c:forEach>

																							<c:choose>
																								<c:when test="${ isExist == 1 }">
																									<div class="form-check me-3 d-inline-block">
																										<input name="niveaux" class="form-check-input"
																											type="checkbox"
																											id="niveau${ niveau.id }${ prof.id }"
																											value="${ niveau.id }" checked> <label
																											class="form-check-label"
																											for="niveau${ niveau.id }${ prof.id }">
																											${niveau.nom } </label>
																									</div>
																								</c:when>
																								<c:otherwise>
																									<div class="form-check me-3 d-inline-block">
																										<input name="niveaux" class="form-check-input"
																											type="checkbox"
																											id="niveau${ niveau.id }${ prof.id }"
																											value="${ niveau.id }"> <label
																											class="form-check-label"
																											for="niveau${ niveau.id }${ prof.id }">
																											${niveau.nom } </label>
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
																			<button type="submit" form="modifierForm${ prof.id }"
																				class="btn btn-primary">Enregister</button>
																		</div>
																	</div>
																</div>
															</div>


														</div>


														<!-- button suprimer -->
														<div class="col-md-4">
															<a href="?operation=supprimer&id=${ prof.id }"
																class="btn btn-danger w-100"> <i
																class="bi bi-eraser-fill"></i>
															</a>
														</div>
														<div class="col-md-4">





															<!-- Button trigger modal -->
															<button type="button" class="btn btn-info w-100"
																data-bs-toggle="modal"
																data-bs-target="#info${ prof.id }">
																<i class="bi bi-info-circle-fill"></i>
															</button>


															<!-- Modal -->
															<div class="modal fade" id="info${ prof.id }"
																tabindex="-1" aria-labelledby="exampleModalLabel"
																aria-hidden="true">
																<div class="modal-dialog  modal-dialog-centered">
																	<div class="modal-content">
																		<div class="modal-header">
																			<h4 class="modal-title" id="exampleModalLabel">${prof.nom }
																				${prof.prenom }</h4>
																			<button type="button" class="btn-close"
																				data-bs-dismiss="modal" aria-label="Close"></button>
																		</div>
																		<div class="modal-body">
																			<h5>
																				<span class="text-secondary">E-mail : </span>${prof.mail }</h5>
																			<h5>
																				<span class="text-secondary">Matières :</span> ${ prof.matiere.nom }
																			</h5>
																			<h5>
																				<span class="text-secondary">Niveaux : </span>
																				<c:set var="count" value="1" />
																				<c:forEach var="niveau" items="${prof.niveaux }">
																					<c:choose>
																						<c:when
																							test="${ count == fn:length(prof.niveaux) }">
																							${niveau.nom }
																						</c:when>
																						<c:otherwise>
																							${niveau.nom } - 
																						</c:otherwise>
																					</c:choose>
																					<c:set var="count" value="${ count + 1 }" />
																				</c:forEach>
																			</h5>
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