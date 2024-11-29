<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">

<head>
<title>Planning des Séances</title>
<jsp:include page="../fragments/top.jsp"></jsp:include>


</head>

<body>


	<jsp:include page="../fragments/navbar.jsp"></jsp:include>

	<main id="main" class="main width-80 mx-auto">


		<!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">



							<h5 class="card-title text-center fs-3">Table des Séances</h5>

							<table class="table datatable">
								<thead>
									<tr>
										<th><span class="d-block text-center">Niveau</span></th>
										<th><span class="d-block text-center">Groupe</span></th>
										<th><span class="d-block text-center">Salle</span></th>
										<th><span class="d-block text-center">Durée de
												Séance</span></th>
										<th><span class="d-block text-center">Date</span></th>
										<th><span class="d-block text-center">Action</span></th>
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
												class="d-block text-center">${emploi.salle}</span></td>
											<td class="text-center"><span
												class="d-block text-center"> <c:set var="times"
														value="${emploi.timestart}" scope="page" /> <c:set
														var="timee" value="${emploi.timeend}" scope="page" />
													${times.split(':')[0]}:${times.split(':')[1]} <i
													class="bi bi-arrow-right"></i>
													${timee.split(':')[0]}:${timee.split(':')[1]}
											</span></td>
											<td class="text-center"><span
												class="d-block text-center">${emploi.date}</span></td>
											<td class="text-center">
												<div class="container">
													<div class="row justify-content-center">
														<div class="col-md-4 w-75">

															<a
																href="absenses/etudiants?fait=on&seanse_id=${ emploi.id }">
																<c:choose>

																	<c:when test="${!emploi.fait}">
																		<button type="submit" name="operation" value="apsense"
																			class="btn btn-danger w-100">
																			<i class="bx bx-task-x me-2"></i>Non Suivi
																		</button>
																	</c:when>

																	<c:otherwise>
																		<button type="submit" name="operation" value="apsense"
																			class="btn btn-success w-100">
																			<i class="bx bx-task me-2"></i>Suivi
																		</button>
																	</c:otherwise>

																</c:choose>
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