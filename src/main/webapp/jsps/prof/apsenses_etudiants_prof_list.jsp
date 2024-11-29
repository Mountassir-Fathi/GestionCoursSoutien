<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">

<head>
<title>Gestion des Absences</title>
<jsp:include page="../fragments/top.jsp"></jsp:include>


</head>

<body>


	<jsp:include page="../fragments/navbar.jsp"></jsp:include>

	<main id="main" class="main width-80 mx-auto">

		<div class="pagetitle">
			<h1>Absences</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item active">Absences
						Gr-${emploi.groupe.nom}<i class="bi bi-caret-right-fill me-1"></i>N-${emploi.niveau.nom}<i
						class="bi bi-caret-right-fill "></i>M-${emploi.matiere.nom}
					</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<div>
								<h5 class="my-2 text-primary">
									<i class="bi bi-calendar2-date me-2 text-primary"> </i>${emploi.date }
									<i class="bi bi-caret-right-fill "></i> <i
										class="bi bi-clock me-2 text-primary"></i>
									<c:set var="times" value="${emploi.timestart}" scope="page" />
									<c:set var="timee" value="${emploi.timeend}" scope="page" />
									${times.split(':')[0]}:${times.split(':')[1]} <i
										class="bi bi-arrow-right "></i>
									${timee.split(':')[0]}:${timee.split(':')[1]}
								</h5>
							</div>

							<h5 class="card-title text-center fs-3">Table des Présences
							</h5>

							<table class="table datatable">
								<thead>
									<tr>
										<th><span class="d-block text-center">Nom</span></th>
										<th><span class="d-block text-center">Prénom</span></th>
										<th><span class="d-block text-center">Statut de Présence</span></th>
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
												class="d-block text-center">
												<c:choose>
													<c:when test="${etudiant.value}">
														<a href="?operation=absense_statue&etudiant_id=${etudiant.key.id}&seanse_id=${emploi.id}&absense_statue=${!etudiant.value}" class="btn text-bg-success">
															<i class="bi bi-person-fill  fs-4"></i><span class="fw-bold">Présent(e)</span>
														</a>
													</c:when>
													<c:otherwise>
														<a
															href="?operation=absense_statue&etudiant_id=${etudiant.key.id}&seanse_id=${emploi.id}&absense_statue=${!etudiant.value}"  class="btn btn-danger">
															 <i class="bi bi-person-x-fill  fs-4"></i>
															<span class="fw-bold">Absent(e)</span>
														</a>
												</c:otherwise>
												</c:choose>
												
											</span></td>
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