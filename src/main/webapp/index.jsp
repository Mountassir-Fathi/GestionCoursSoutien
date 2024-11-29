<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
<!-- Basic -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<!-- Mobile Metas -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Rubik+Doodle+Shadow&display=swap" rel="stylesheet">
<!-- Site Metas -->
<link rel="icon"
	href="main-page-assets/main-page-assets/images/fevicon.png"
	type="image/gif" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta name="author" content="" />

<title>ÉCOLE ESSALAM</title>

<!-- Favicons -->
<link rel="icon" type="image/x-icon"
	href="${ pageContext.request.contextPath }/assets/img/favicon.png">
<link
	href="${ pageContext.request.contextPath }/assets/img/apple-touch-icon.png"
	rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">


<link
	href="${ pageContext.request.contextPath }/assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<!-- bootstrap core css -->
<link rel="stylesheet" type="text/css"
	href="main-page-assets/css/bootstrap.css" />

<!-- fonts style -->
<link
	href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap"
	rel="stylesheet" />

<!-- font awesome style -->
<link href="main-page-assets/css/font-awesome.min.css" rel="stylesheet" />
<!-- Custom styles for this template -->
<link href="main-page-assets/css/style.css" rel="stylesheet" />
<!-- responsive style -->
<link href="main-page-assets/css/responsive.css" rel="stylesheet" />

</head>

<body>

	<div class="hero_area">
		<!-- header section strats -->
		<header class="header_section long_section px-0">
			<nav class="navbar navbar-expand-lg custom_nav-container ">
				<a class="navbar-brand d-flex" href=""> <img width="35"
					src="${ pageContext.request.contextPath }/assets/img/apple-touch-icon.png" />
					<span class="pl-2"> ÉCOLE ESSALAM </span>
				</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class=""> </span>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<div
						class="d-flex mx-auto flex-column flex-lg-row align-items-center">
						<ul class="navbar-nav  ">
							<li class="nav-item active"><a class="nav-link" href="">Home
									<span class="sr-only">(current)</span>
							</a></li>
							<li class="nav-item"><a class="nav-link" href="#about">
									À PROPOS</a></li>
							<li class="nav-item"><a class="nav-link" href="#niveaux">
									Niveaux</a></li>
							<li class="nav-item"><a class="nav-link" href="#contactus">CONTACTEZ-NOUS</a>
							</li>

						</ul>
					</div>
					<div class="quote_btn-container">

						<c:choose>
							<c:when test="${ isAuthenticated }">
								<a class="pill" href="${ dashboard }"> <span>
										Dashboard </span> <i class="bi bi-grid"></i>
								</a>
							</c:when>
							<c:otherwise>
								<a class="pill" href="register"> <span> S'INSCRIRE </span> <i
									class="bi bi-person-plus-fill"></i>
								</a>
								<a class="pill" href="authentifier"> <span> SE
										CONNECTER </span> <i class="bi bi-person-fill"></i>
								</a>
							</c:otherwise>
						</c:choose>



					</div>
				</div>
			</nav>
		</header>
		<!-- end header section -->
		<!-- slider section -->
		<section class="slider_section long_section">
			<div id="customCarousel" class="carousel slide" data-ride="carousel">
				<div class="carousel-inner">
					<div class="carousel-item active">
						<div class="container ">
							<div class="row">
								<div class="col-md-5">
									<div class="detail-box">
										<h1>
											ÉCOLE ESSALAM <br>
										</h1> 
										<h5>
											<p>
												Développez vos compétences académiques et préparez-vous pour
												un avenir brillant!
												<p></p>
												 Inscrivez-vous dès maintenant
												pour des cours de soutien scolaire de qualité!
											</p>
										</h5>
										
										<div class="btn-box">
											<a href="register" class="btn2">Je m'inscris</a> <a
												href="#contactus" class="btn1"> CONTACTEZ-NOUS </a>
										</div>
									</div>
								</div>
								<div class="col-md-7">
									<div class="img-box">
										<img src="main-page-assets/images/phsalam.jpg" alt="">
									</div>
								</div>
							</div>
						</div>
					</div>

					<ol class="carousel-indicators">
						<li data-target="#customCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#customCarousel" data-slide-to="1"></li>
						<li data-target="#customCarousel" data-slide-to="2"></li>
					</ol>
				</div>
				</div>
		</section>
		<!-- end slider section -->
	</div>

	<!-- furniture section -->

	<section id="niveaux" class="furniture_section layout_padding">
		<div class="container">
			<div class="heading_container align-items-center">
				<h1>
					ÉCOLE ESSALAM <br>
				</h1>
				<h4>avec ses multiples niveaux d'étude, s'adapte à chaque étape de notre parcours éducatif.
				</h4>
			</div>
			<div style="justify-content: space-evenly;" class="row ">
			
			<c:forEach var="niveau" items="${ niveaux }" >
				<div class="d-flex justify-content-center col-md-6 col-lg-3">
				  <div class="box box-styling" data-toggle="modal" data-target="#staticBackdrop${niveau.id }">
						<div style="height: 100%" class="display-4 img-box">
							${ niveau.nom }
						</div>
					</div>
				</div>
				
				
				<!-- Modal -->
				<div class="modal fade" id="staticBackdrop${niveau.id }" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				  <div class="modal-dialog modal-dialog-centered">
					<div class="modal-content" style="border-radius: 50px 0;">
					  <div class="modal-header">
						<h4 class="modal-title ml-4" id="staticBackdropLabel">
						${ niveau.nom }
						</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						  <span aria-hidden="true">&times;</span>
						</button>
					  </div>
					  <div class="modal-body">
							<c:forEach var="matiere" items="${ niveau.matieres }" >
								<h3 class="display-5 d-block text-center p-2"><span class="text-secondary"> ${ matiere.nom }</span> : ${matiere.prix }DH</h3>
								<hr>
							</c:forEach>
					  </div>
					</div>
				  </div>
				</div>
			
			</c:forEach>
			
				
			</div>
		</div>
	</section>

	<!-- end furniture section -->


	<!-- about section -->

	<section id="about" class="about_section layout_padding long_section">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<div class="img-box">
						<img src="main-page-assets/images/2023-09-12.jpg" alt="">
					</div>
				</div>
				<div class="col-md-6">
					<div class="detail-box">
						<div class="heading_container">
							<h2>Progressez rapidement avec nos cours de soutien sur mesure !</h2>
						</div>
						<h5>
							<p>
								Des difficultés dans vos matières scolaires ? Vous cherchez une solution efficace pour améliorer vos résultats scolaires ?
								<p></p>
								Progressez dans toutes les matières avec d’excellents enseignants maîtrisant parfaitement le programme. Nous vous offrons un accompagnement complet pour améliorer vos résultats scolaires et favoriser l’autonomie.
							</p>
						</h5>
						


					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- end about section -->

	<!-- blog section -->

	<section class="blog_section layout_padding">
		<div class="container">
			<!-- <div class="heading_container">
				<h2>Niveaux</h2>
			</div> -->
			<div class="row">
				<div class="col-md-6 col-lg-4 mx-auto">
					<div class="box blog-styling">
						<div style="background-color: #eadcbd;" class="img-box">
							<img src="main-page-assets/images/Primaire.png" alt="">
						</div>
						<div class="detail-box">
							<h5 style="font-weight: 500;color:#eadcbd; ">Cours de groupe</h5>
							<h4 style="font-weight: bold;">Primaire</h4>
							<p>
								Nos cours de soutien scolaire  pour le primaire sont
							    spécialement adaptés aux jeunes élèves, créant un 
							    environnement engageant pour établir des fondations solides.
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-6 col-lg-4 mx-auto">
					<div class="box blog-styling">
						<div  style="background-color: #e75012;"  class="img-box">
							<img src="main-page-assets/images/College.png" alt="">
						</div>
						<div class="detail-box">
							<h5 style="font-weight: 500;color:#e75012;">Cours de groupe</h5>
							<h4 style="font-weight: bold;">Collège</h4>
							<p>
								Nos séances de groupes comblent toutes les difficultés des élèves. 
								Notre programme pour le collège offre 
								une approche personnalisée, adaptée aux besoins spécifiques de chaque élève.
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-6 col-lg-4 mx-auto">
					<div class="box blog-styling">
						<div  style="background-color: #6ca495;"  class="img-box">
							<img src="main-page-assets/images/Lycee.png" alt="">
						</div>
						<div class="detail-box">
							<h5 style="font-weight: 500;color: #6ca495;">Cours de groupe</h5>
							<h4 style="font-weight: bold;">Lycée</h4>
							<p>Nos cours de soutien pour les niveaux du lycée sont une solution adaptée à
							 la progression rapide et à la préparation efficace des examens. Ils visent à renforcer 
							votre maîtrise des chapitres difficiles vous permettant de réussir votre baccalauréat !
						    </p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- end blog section -->

	  <!-- client section -->

  <section class="client_section layout_padding-bottom">
    <div class="container">
      <div class="heading_container">
        <h2>
          Testimonial
        </h2>
      </div>
      <div id="carouselExample2Controls" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <div class="row">
              <div class="col-md-11 col-lg-10 mx-auto">
                <div class="box">
                  <div class="img-box">
                    <img src="main-page-assets/images/client.jpg" alt="" />
                  </div>
                  <div class="detail-box">
                    <div class="name">
                      <i class="fa fa-quote-left" aria-hidden="true"></i>
                      <h6>
                        ffffffffffff
                      </h6>
                    </div>
                    <p>
                      It is a long established fact that a reader will be
                      distracted by the readable cIt is a long established fact
                      that a reader will be distracted by the readable c
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <div class="row">
              <div class="col-md-11 col-lg-10 mx-auto">
                <div class="box">
                  <div class="img-box">
                    <img src="main-page-assets/images/client.jpg" alt="" />
                  </div>
                  <div class="detail-box">
                    <div class="name">
                      <i class="fa fa-quote-left" aria-hidden="true"></i>
                      <h6>
                        ggggggggggggggg
                      </h6>
                    </div>
                    <p>
                      It is a long established fact that a reader will be
                      distracted by the readable cIt is a long established fact
                      that a reader will be distracted by the readable c
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          

          <div class="carousel-item">
            <div class="row">
              <div class="col-md-11 col-lg-10 mx-auto">
                <div class="box">
                  <div class="img-box">
                    <img src="main-page-assets/images/client.jpg" alt="" />
                  </div>
                  <div class="detail-box">
                    <div class="name">
                      <i class="fa fa-quote-left" aria-hidden="true"></i>
                      <h6>
                        Siaalya
                      </h6>
                    </div>
                    <p>
                      It is a long established fact that a reader will be
                      distracted by the readable cIt is a long established fact
                      that a reader will be distracted by the readable c
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <div class="carousel-item">
            <div class="row">
              <div class="col-md-11 col-lg-10 mx-auto">
                <div class="box">
                  <div class="img-box">
                    <img src="main-page-assets/images/client.jpg" alt="" />
                  </div>
                  <div class="detail-box">
                    <div class="name">
                      <i class="fa fa-quote-left" aria-hidden="true"></i>
                      <h6>
                        Siaalya
                      </h6>
                    </div>
                    <p>
                      It is a long established fact that a reader will be
                      distracted by the readable cIt is a long established fact
                      that a reader will be distracted by the readable c
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          
          
          <div class="carousel-item">
            <div class="row">
              <div class="col-md-11 col-lg-10 mx-auto">
                <div class="box">
                  <div class="img-box">
                    <img src="main-page-assets/images/client.jpg" alt="" />
                  </div>
                  <div class="detail-box">
                    <div class="name">
                      <i class="fa fa-quote-left" aria-hidden="true"></i>
                      <h6>
                        hhhhhhhhhhhhhhhhhhhhh
                      </h6>
                    </div>
                    <p>
                      It is a long established fact that a reader will be
                      distracted by the readable cIt is a long established fact
                      that a reader will be distracted by the readable c
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="carousel_btn-container">
          <a class="carousel-control-prev" href="#carouselExample2Controls" role="button" data-slide="prev">
            <i class="fa fa-long-arrow-left" aria-hidden="true"></i>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carouselExample2Controls" role="button" data-slide="next">
            <i class="fa fa-long-arrow-right" aria-hidden="true"></i>
            <span class="sr-only">Next</span>
          </a>
        </div>
      </div>
    </div>
  </section>

  <!-- end client section -->

	<!-- contact section -->

	
	<section id="contactus" class="contact_section  long_section">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<div class="form_container">
						<div class="heading_container">
							<h2><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Contactez-nous</font></font></h2>
						</div>
						<form action="">
							<div>
								<input type="text" placeholder="votre nom">
							</div>
							<div>
								<input type="text" placeholder="Numéro de téléphone">
							</div>
							<div>
								<input type="email" placeholder="E-mail">
							</div>
							<div>
								<input type="text" class="message-box" placeholder="Message">
							</div>
							<div class="btn_box">
								<button><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">ENVOYER</font></font></button>
							</div>
						</form>
					</div>
				</div>
				<div class="col-md-6">
					<div class="map_container">
						<div class="map">
							<!--             //////////////// -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- end contact section -->






	<!-- info section -->
	<section class="info_section long_section">

		<div class="container">
			<div class="contact_nav">
				<a href=" https://wa.me/+212653080707"> <i class="fa fa-phone"
					aria-hidden="true"></i> <span class="mt-2"> WhatsApp </span>
				</a> <a href="mailto:support@ecolesalam.edu"> <i
					class="fa fa-envelope" aria-hidden="true"></i> <span class="mt-2">
						Email </span>
				</a> <a href="https://maps.app.goo.gl/qmd95UQYKCao2iAX6"> <i
					class="fa fa-map-marker" aria-hidden="true"></i> <span class="mt-2">
						Location </span>
				</a>
			</div>

			<div class="contact_nav">
				<a href=""> <i class="bi bi-instagram" aria-hidden="true"></i> <span
					class="mt-2"> Instagram </span>
				</a> <a href=""> <i class="bi bi-twitter" aria-hidden="true"></i> <span
					class="mt-2"> Twitter </span>
				</a> <a href="https://web.facebook.com/profile.php?id=100063696952325">
					<i class="bi bi-facebook" aria-hidden="true"></i> <span
					class="mt-2"> Facebook </span>
				</a>
			</div>

		</div>
	</section>
	<!-- end info_section -->



	<!-- jQery -->
	<script src="main-page-assets/js/jquery-3.4.1.min.js"></script>
	<!-- bootstrap js -->
	<script src="main-page-assets/js/bootstrap.js"></script>
	<!-- custom js -->
	<script src="main-page-assets/js/custom.js"></script>
	<!-- Google Map -->
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCh39n5U-4IoWpsVGUHWdqB6puEkhRLdmI&callback=myMap"></script>
	<!-- End Google Map -->

</body>

</html>