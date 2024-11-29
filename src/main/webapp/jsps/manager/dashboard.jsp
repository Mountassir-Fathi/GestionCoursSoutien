<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dashboard</title>
<jsp:include page="../fragments/top.jsp"></jsp:include>
</head>
<body class="overflow-hidden">
	<jsp:include page="../fragments/navbar.jsp"></jsp:include>
	<jsp:include page="../fragments/sidebar.jsp"></jsp:include>



	<main id="main" class="main">

		<div class="pagetitle">
			<h1>Dashboard</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item active">Dashboard</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section dashboard">
			<div class="row">

				<!-- Left side columns -->
				<div class="col-lg-8">
					<div class="row">



						<!-- Sales Card -->
						<div class="col-xxl-4 col-md-6">
							<div class="card info-card sales-card">

								<div class="card-body">
									<h5 class="card-title">
										Revenu  <span>| Aujourd'hui</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="fa-regular fa-money-bill-1"></i>
										</div>
										<div class="ps-3">
											<h6>${ total }DH</h6>
											<span class="text-muted small pt-2 ps-1">Augmentation de </span>
											<span class="text-success small pt-1 fw-bold">${ totalPourcentage }%</span> 
												

										</div>
									</div>
								</div>

							</div>
						</div>
						<!-- End Sales Card -->

						<!-- Revenue Card -->
						<div class="col-xxl-4 col-md-6">
							<div class="card info-card revenue-card">


								<div class="card-body">
									<h5 class="card-title">
										Étudiants arrivants <span>| Ce mois-ci</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-people"></i>
										</div>
										<div class="ps-3">
											<h6>${ nombreEi }</h6>
											<span class="text-muted small pt-2 ps-1">Augmentation de </span>
											<span class="text-success small pt-1 fw-bold">${ nombreEiPourcentage }%</span>

										</div>
									</div>
								</div>

							</div>
						</div>
						<!-- End Revenue Card -->



						<!-- Customers Card -->
						<div class="col-xxl-4 col-xl-12">

							<div class="card info-card customers-card">

								<div class="card-body">
									<h5 class="card-title">
										Étudiants inscrits <span>| Ce mois-ci</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-people"></i>
										</div>
										<div class="ps-3">
											<h6>${ nombreEni }</h6>
											<span class="text-muted small pt-2 ps-1">Augmentation de </span>
											<span class="text-danger small pt-1 fw-bold">${ nombreEniPourcentage }%</span>
										</div>
									</div>

								</div>
							</div>

						</div>
						<!-- End Customers Card -->

						<!-- Recent Sales -->
						<div class="col-12" style="height: 430px;">
							<div class="card recent-sales overflow-auto h-100">


								<div class="card-body">
									<h5 class="card-title">
										Séances actives <span>| Aujourd'hui</span>
									</h5>
									

								<table class="table table-striped" id="seances-table">
									<thead>
										<tr>
											<th><span class="d-block text-center">Niveau</span></th>
											<th><span class="d-block text-center">Groupe</span></th>
											<th><span class="d-block text-center">Matiére</span></th>
											<th><span class="d-block text-center">Salle</span></th>
											<th><span class="d-block text-center">Durée de Séance</span></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
									
								</div>

							</div>
						</div>
						<!-- End Recent Sales -->

					</div>
				</div>
				<!-- End Left side columns -->

				<!-- Right side columns -->
				<div class="col-lg-4">

					<!-- Website Traffic -->
					<div style="height: 618px" class="card">

						<div class="card-body pb-0">
							<h5 class="card-title">
								Revenu Par Niveau<span> | Aujourd'hui</span>
							</h5>

							<div id="trafficChart" style="height: calc(100% - 57px)"
								class="echart d-flex align-items-center"></div>

							<script>
              	let data = [
              		<c:forEach var="niveau" items="${niveaux}" >
						  {value: ${niveau.value}, name: '${niveau.key}'},
					</c:forEach>
              		];
                document.addEventListener("DOMContentLoaded", () => {
                  echarts.init(document.querySelector("#trafficChart")).setOption({
                    tooltip: {
                      trigger: 'item'
                    },
                    legend: {
                      top: '5%',
                      left: 'center'
                    },
                    series: [{
                      name: 'Revenu',
                      type: 'pie',
                      radius: ['40%', '70%'],
                      avoidLabelOverlap: false,
                      label: {
                        show: false,
                        position: 'center'
                      },
                      emphasis: {
                        label: {
                          show: true,
                          fontSize: '18',
                          fontWeight: 'bold'
                        }
                      },
                      labelLine: {
                        show: false
                      },
                      data: [
                    	  ...data
                      ]
                    }]
                  });
                });
              </script>

						</div>
					</div>
					<!-- End Website Traffic -->

				</div>
				<!-- End Right side columns -->

			</div>
		</section>

	</main>
	<!-- End #main -->

	<jsp:include page="../fragments/bottom.jsp"></jsp:include>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
								<script>
									$(document).ready(function() {
										setTimeout(function() {
											$.ajax({
												method: "POST",
												url: "dashboard",
												success: function(result) {
													// Mettre à jour le tableau HTML avec les données récupérées
													var table = $("#seances-table tbody");
													table.empty();
													$.each(result, function(i, seance) {
														var row = $("<tr>");
														$("<td class=\"text-center\"><span class=\"d-block text-center\">").text(seance.niveau.nom).appendTo(row);
														$("<td class=\"text-center\"><span class=\"d-block text-center\">").text(seance.matiere.nom).appendTo(row);
														$("<td class=\"text-center\"><span class=\"d-block text-center\">").text(seance.groupe.nom).appendTo(row);
														$("<td class=\"text-center\"><span class=\"d-block text-center\">").text(seance.salle).appendTo(row);
														$("<td class=\"text-center\"><span class=\"d-block text-center\">").html(seance.timestart + " <i class='bi bi-arrow-right'></i> " + seance.timeend).appendTo(row);
														row.appendTo(table);
													});
												}
											});
										}, 0);
									});
									$(document).ready(function() {
										setInterval(function() {
											$.ajax({
												method: "POST",
												url: "dashboard",
												success: function(result) {
													// Mettre à jour le tableau HTML avec les données récupérées
													var table = $("#seances-table tbody");
													table.empty();
													$.each(result, function(i, seance) {
														var row = $("<tr>");
														$("<td class=\"text-center\"><span class=\"d-block text-center\">").text(seance.niveau.nom).appendTo(row);
														$("<td class=\"text-center\"><span class=\"d-block text-center\">").text(seance.matiere.nom).appendTo(row);
														$("<td class=\"text-center\"><span class=\"d-block text-center\">").text(seance.groupe.nom).appendTo(row);
														$("<td class=\"text-center\"><span class=\"d-block text-center\">").text(seance.salle).appendTo(row);
														$("<td class=\"text-center\"><span class=\"d-block text-center\">").html(seance.timestart + " <i class='bi bi-arrow-right'></i> " + seance.timeend).appendTo(row);
														row.appendTo(table);
													});
												}
											});
										}, 2 * 60 * 1000);
									});
								</script>
</body>
</html>