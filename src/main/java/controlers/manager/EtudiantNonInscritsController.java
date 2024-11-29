package controlers.manager;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Etudiant;
import model.dao.EtudiantDao;

@WebServlet("/manager/etudiants-non-inscrits")
public class EtudiantNonInscritsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private EtudiantDao etudiantDao = new EtudiantDao();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "ajouter":
			ajouterEtudiant(request, response);
			break;
		case "supprimer-tous":
			supprimerTousEtudiant(request, response);
			break;
		case "supprimer":
			supprimerEtudiant(request, response);
			break;
		default:
			List<Etudiant> etudiants = etudiantDao.allEtudiantsInscri(false); // jib ghire etudiant in status false

			request.setAttribute("etudiants", etudiants);
			System.out.println(etudiants);

			request.setAttribute("servletPath", request.getServletPath());
			this.getServletContext().getRequestDispatcher("/jsps/manager/etudiants_non_inscrits_list.jsp")
					.forward(request, response);
		}
	}

	private void supprimerTousEtudiant(HttpServletRequest request, HttpServletResponse response) throws IOException {
		etudiantDao.supprimertousetudiant();
		response.sendRedirect(request.getContextPath() + request.getServletPath());
	}

	private void ajouterEtudiant(HttpServletRequest request, HttpServletResponse response) throws IOException {
		var id = Integer.parseInt(request.getParameter("id"));
		etudiantDao.activerCompte(id);
		response.sendRedirect(request.getContextPath() + "/manager/etudiants-inscrits");
	}

	private void supprimerEtudiant(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String IdString = request.getParameter("id");
		if (IdString != null) {
			var id = Integer.parseInt(IdString);
			etudiantDao.deleteEtudiantById(id);
		}
		response.sendRedirect(request.getContextPath() + request.getServletPath());

	}
}
