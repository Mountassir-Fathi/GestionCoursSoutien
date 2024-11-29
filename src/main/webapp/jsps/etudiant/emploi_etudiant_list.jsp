<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>Horaire des Cours</title>
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


							<h5 class="card-title text-center fs-3">Table des Horaires</h5>

							<table class="table datatable">
								<thead>
									<tr>
										<th><span class="d-block text-center">Matière</span></th>
										<th><span class="d-block text-center">Salle</span></th>
										<th><span class="d-block text-center">Durée de Séance</span></th>
										<th><span class="d-block text-center">Date</span></th>
									</tr>
								</thead>
								<tbody>

									<c:forEach var="emploi" items="${emplois}">
										<tr>
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
											<td class="text-center"><span
												class="d-block text-center">${emploi.date}</span></td>
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