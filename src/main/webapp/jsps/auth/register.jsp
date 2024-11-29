<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

	<jsp:include page="../fragments/top.jsp"></jsp:include>
  <title>Inscription</title>

</head>

<body>

<main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="index.html" class="logo d-flex align-items-center w-auto">
                  <img src="assets/img/logo.png" alt="">
                  <span class="d-none d-lg-block">ÉCOLE ESSALAM</span
>
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3 fs-5" style="width: 475px;">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">Création de Compte</h5>
                    <p class="text-center small">Entrez vos informations personnelles.</p>
                  </div>

                  <form class="row g-3 needs-validation" novalidate="" method="post">
                    <div class="col-12">
                      <label for="nom" class="form-label">Nom</label>
                      <input type="text" name="nom" style="height: 50px; border-radius: 50px !important" class="focus form-control" id="nom" required>
 
                      <div class="invalid-feedback">Please, enter your name!</div>
                    </div>

                    <div class="col-12">
                      <label for="prenom" class="form-label">Prénom</label>
                      <input type="text" name="prenom" style="height: 50px; border-radius: 50px !important" class="focus form-control" id="prenom" required>
                      <div class="invalid-feedback">Please, enter your name!</div>
                    </div>

                    <div class="col-12">
                      <label for="niveau" class="form-label">Niveau</label>
					  <select name="niveau" id="niveau" style="height: 50px; border-radius: 50px !important" class="focus form-select">
						  <c:forEach var="niveau" items="${ niveaux }">
								  <option value="${ niveau.id }">${ niveau.nom }</option>
						  </c:forEach>
					  </select>
                    </div>

                    <div class="col-12">
						<label for="tel" class="form-label">Tel</label>
						<input name="tel" id="tel" type="tel" style="height: 50px; border-radius: 50px !important" class="focus form-control"
							placeholder="+212 632143152" pattern="^\+(212)\s?\d{9}$"
							required>
					</div>

                    <div class="col-12">
                      <label for="email" class="form-label">E-mail</label>
                      <div class="input-group has-validation">
                        <span class="input-group-text" style="height: 50px; border-radius: 50px 0 0 50px !important" id="inputGroupPrepend">@</span>
                        <input type="email" name="email" class="focus form-control" style="height: 50px; border-radius: 0 50px 50px 0 !important" id="email" required>
                        <div class="invalid-feedback">Indiquez votre adresse e-mail!</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="password" class="form-label">Password</label>
                      <input type="password" name="password" class="focus form-control" style="height: 50px; border-radius: 50px !important" id="password" required>
                      <div class="invalid-feedback">Indiquez votre password!</div>
                    </div>
                    
                    <div class="col-12">
                    </div>
                    <div class="col-12">
                      <button class="btn btn-primary btn-login-register w-100 fs-5 rounded-pill" style="height: 50px; background-color:#f89646; border-color: #f89646"" type="submit">Créer</button>
                    </div>
                    <div class="col-12">
                      <p class="small mb-0">Déjà membre ?  <a style="color: #6bb7be;" href="${ pageContext.request.contextPath }/authentifier">Connexion</a></p>
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

  <!-- Vendor JS Files -->
	<jsp:include page="../fragments/bottom.jsp"></jsp:include>


</body>

</html>