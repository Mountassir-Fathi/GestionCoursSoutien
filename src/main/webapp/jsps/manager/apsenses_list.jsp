<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">

<head>
<title>Suivi des Absences</title>
<jsp:include page="../fragments/top.jsp"></jsp:include>


</head>

<body>


	<jsp:include page="../fragments/navbar.jsp"></jsp:include>
	<jsp:include page="../fragments/sidebar.jsp"></jsp:include>

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>Absences</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item active">Absences</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">

							<h5 class="card-title text-center fs-3">Table des Absences</h5>

							<table class="table datatable">
								<thead>
									<tr>
										<th><span class="d-block text-center">Niveau</span></th>
										<th><span class="d-block text-center">Groupe</span></th>
										<th><span class="d-block text-center">Matière</span></th>
										<th><span class="d-block text-center">Salle</span></th>
										<th><span class="d-block text-center">Durée de Séance</span></th>
										<th><span class="d-block text-center">Date</span></th>
										<th><span class="d-block text-center">Actions</span></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="emploi" items="${emplois}">
										<tr>
											<td class="text-center"><span
												class="d-block text-center">${emploi.niveau.nom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${emploi.groupe.nom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${emploi.matiere.nom}</span></td>
											<td class="text-center"><span
												class="d-block text-center">${emploi.salle}</span></td>
											<td class="text-center"><span
												class="d-block text-center"> <c:set var="times"
														value="${emploi.timestart}" scope="page" /> <c:set
														var="timee" value="${emploi.timeend}" scope="page" />
													${times.split(':')[0]}:${times.split(':')[1]} <i
													class="bi bi-arrow-right"></i>
													${timee.split(':')[0]}:${timee.split(':')[1]}
											</span></td>
											<td><span class="d-block text-center">${emploi.date}</span></td>
											<td class="text-center">
												<div class="container">
													<div class="row justify-content-center">

														<div class="col-md-4 ">
															<a href="absenses/etudiants?operation=voir&seanse_id=${ emploi.id }"
																class="btn btn-info w-100"> <i
																class="bi bi-eye text-white"></i>
															</a>
														</div>

														<div class="col-md-4">
															<a href="absenses/etudiants?operation=telecharger&seanse_id=${ emploi.id }"
																class="btn btn-warning w-100"> <i
																class="bi bi-arrow-down-circle text-white"></i>
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