<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">

<head>
<title>Organisation des Séances</title>
<jsp:include page="../fragments/top.jsp"></jsp:include>


</head>

<body>


	<jsp:include page="../fragments/navbar.jsp"></jsp:include>
	<jsp:include page="../fragments/sidebar.jsp"></jsp:include>

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>Séances</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item active">Séances</li>
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
								<i class="bi bi-calendar-date me-2"></i> 
								<span class="fw-bold">Nouvelle Séance</span>
									
							</button>

							<!-- Modal -->
							<div class="modal fade" id="ajouter" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-lg modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="exampleModalLabel">Nouvelle Séance</h4>
											<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<form id="ajouterForm" method="post">
												<input type="hidden" name="operation" value="ajouter" />
												
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
													<label class="col-sm-2 col-form-label"  for="groupe">Groupe</label>
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
												  <label class="col-sm-2 col-form-label"  for="matiere">Matière</label>
												  <div class="col-sm-10">
													<select name="matiere" class="form-select" aria-label="Default select example"  id="matiere">
														<c:forEach var="matiere" items="${ matieres }">
														  <option value="${ matiere.id }">${ matiere.nom }</option>
														</c:forEach>
													</select>
												  </div>
												</div>
												
												 <div class="row mb-3">
													<label class="col-sm-2 col-form-label"  for="salle">Salle</label>
													<div class="col-sm-10">
														<select name="salle" class="form-select"
															aria-label="Default select example"  id="salle">
															<c:forEach var="salle" items="${ salles }">
																<option value="${ salle.id }">${ salle.nom }</option>
															</c:forEach>
														</select>
													</div>
												</div>
												
												<div class="row mb-3">
									                  <label for="inputTimestart" class="col-sm-2 col-form-label">Début de Séance</label>
									                  <div class="col-sm-10">
									                    <input type="time" class="form-control" name="timestart" id="inputTimestart" required>
									                  </div>
                								</div>
                								
                								<div class="row mb-3">
									                  <label for="inputTimeend" class="col-sm-2 col-form-label">Fin de Séance</label>
									                  <div class="col-sm-10">
									                    <input type="time" class="form-control" name="timeend" id="inputTimeend" required>
									                  </div>
                								</div>
										
												<div class="row mb-3">
									                  <label for="inputDate" class="col-sm-2 col-form-label">Date</label>
									                  <div class="col-sm-10">
									                    <input type="date" name="date" id="inputDate" class="form-control" required>
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


							<h5 class="card-title text-center fs-3">Table des Séances</h5>
							<!-- 		          <p class="text-center">Add lightweight datatables to your project with using the Simple DataTables library. Just add .datatable class name to any table you wish to conver to a datatable</p> -->

							<table class="table datatable">
								<thead>
									<tr>
										<th><span class="d-block text-center">Niveau</span></th>
										<th><span class="d-block text-center">Groupe</span></th>
										<th><span class="d-block text-center">Matières</span></th>
										<th><span class="d-block text-center">Salle</span></th>
										<th><span class="d-block text-center">Durée de Séance</span></th>
										<th><span class="d-block text-center">Date</span></th>
										<th><span class="d-block text-center">Action</span></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="emploi" items="${emplois}"> 
										<tr>
											<td class="text-center"><span class="d-block text-center">${emploi.niveau.nom}</span></td>
											<td class="text-center"><span class="d-block text-center">${emploi.groupe.nom}</span></td>
											<td class="text-center"><span class="d-block text-center">${emploi.matiere.nom}</span></td>
											<td class="text-center"><span class="d-block text-center">${emploi.salle}</span></td>
											<td class="text-center"><span class="d-block text-center">
												<c:set var="times" value="${emploi.timestart}" scope="page"/>
												<c:set var="timee" value="${emploi.timeend}" scope="page"/>
												 ${times.split(':')[0]}:${times.split(':')[1]} 
													<i class="bi bi-arrow-right"></i>
												 ${timee.split(':')[0]}:${timee.split(':')[1]}</span>
											 </td>
											<td><span class="d-block text-center">${emploi.date}</span></td>
											<td class="text-center">
												<div class="container">
													<div class="row justify-content-center">
														<div class="col-md-4 width-80">
															<a href="?operation=supprimer&id=${ emploi.id }"
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
		</section>

	</main>
	<!-- End #main -->


	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<jsp:include page="../fragments/bottom.jsp"></jsp:include>

</body>

</html>