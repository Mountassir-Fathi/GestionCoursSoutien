<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="../fragments/top.jsp"></jsp:include>
<title>Login</title>

</head>

<body class="overflow-hidden">

	<main>
		<div class="container">

			<section
				class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
				<div class="container">
					<div class="row justify-content-center">
						<div
							class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

							<div class="d-flex justify-content-center py-4">
								<a href="index.html"
									class="logo d-flex align-items-center w-auto"> <img
									src="assets/img/logo.png" alt=""> <span
									class="d-none d-lg-block">ÉCOLE ESSALAM</span>
								</a>
							</div>
							<!-- End Logo -->

							<div class="card mb-3 fs-5" style="width: 475px; height: auto;">

								<div class="card-body">

									<div class="pt-4 pb-2">
										<h5 class="card-title text-center pb-0 fs-4">Connexion à
											votre compte</h5>
										<p class="text-center small">Enter votre email & password
											pour connecter</p>
									</div>

									<form method="post"
										class="row g-3 needs-validation" novalidate>

										<div class="col-12">
											<label for="email" class="form-label">E-mail</label>
											<div class="input-group has-validation">
												<span class="inpt-style input-group-text" style="border-radius:50px 0 0 50px !important" id="inputGroupPrepend">@</span>
												<input  type="email" name="email" style="border-radius: 0 50px 50px 0 !important" class="inpt-style focus form-control"
													id="email" required>
												<div class="invalid-feedback">Veuillez saisir votre adresse e-mail.</div>
											</div>
										</div>

										<div class="col-12">
											<label for="password" class="form-label">Password</label>
											<input type="password" name="password" class="rounded-pill focus inpt-style form-control"
												id="password" required>
											<div class="invalid-feedback">Veuillez saisir votre mot de passe.</div>
										</div>

										<div class="col-12">
											${ incorrect? "<span class='d-block text-center text-danger'>Email Ou Password incorrect</span>": ""}
										</div>
										<div class="col-12">
											<button class="btn btn-primary btn-login-register w-100 fs-5 rounded-pill" style="height: 50px; background-color:#f89646; border-color: #f89646" type="submit">Login</button>
										</div>
										<div class="col-12">
											<p class="small mb-0">
												Pas encore inscrit(e) ? <a style="color: #6bb7be;"
													href="${ pageContext.request.contextPath }/register"> Rejoignez-nous !</a>
											</p>
										</div>
									</form>

								</div>
							</div>
						</div>
					</div>
				</div>

			</section>

		</div>
	</main>
	<!-- End #main -->

	<jsp:include page="../fragments/bottom.jsp"></jsp:include>

</body>

</html>