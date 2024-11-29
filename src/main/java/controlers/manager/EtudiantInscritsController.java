package controlers.manager;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Etudiant;
import model.bo.Groupe;
import model.bo.Matiere;
import model.bo.Niveau;
import model.dao.EtudiantDao;
import model.dao.GroupeDao;
import model.dao.MatiereDao;
import model.dao.NiveauDao;

@WebServlet("/manager/etudiants-inscrits")
public class EtudiantInscritsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private EtudiantDao etudiantDao = new EtudiantDao();
	private NiveauDao niveauDao = new NiveauDao();
	private MatiereDao matiereDao = new MatiereDao();
	private GroupeDao groupeDao = new GroupeDao();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "supprimer":
			supprimerEtudiant(request, response);
			break;
		default:
			List<Etudiant> etudiants = etudiantDao.allEtudiantsInscri(true);
			List<Niveau> niveaux = niveauDao.getAllNiveau();

			List<Groupe> groupes = groupeDao.getAllGroupes();
			List<Matiere> matieres = matiereDao.allMatieres();

			request.setAttribute("etudiants", etudiants);
			request.setAttribute("niveaux", niveaux);
			request.setAttribute("groupes", groupes);
			request.setAttribute("matieres", matieres);

			request.setAttribute("servletPath", request.getServletPath());
			this.getServletContext().getRequestDispatcher("/jsps/manager/etudiants_inscrits_list.jsp").forward(request,
					response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "ajouter":
			ajouterEtudiant(request, response);
			break;
		case "modifier":
			modifierEtudiant(request, response);
			break;
		default:
			response.sendRedirect(request.getContextPath() + request.getServletPath());
		}
	}

	private void modifierEtudiant(HttpServletRequest request, HttpServletResponse response) throws IOException {
		var id = Integer.parseInt(request.getParameter("id"));
		var prenom = request.getParameter("prenom");
		var nom = request.getParameter("nom");
		var email = request.getParameter("email");
		var password = request.getParameter("password");
		var tel = request.getParameter("tel");
		var matieres = request.getParameterValues("matieres");
		var niveau = Integer.parseInt(request.getParameter("niveau"));
		var groupe = Integer.parseInt(request.getParameter("groupe"));

		var matieresList = Arrays.stream(matieres).map(iid -> new Matiere(Integer.parseInt(iid), null, 0)).toList();

		etudiantDao.updateEtudiantById(
				new Etudiant(id, nom, prenom, email, password, null, tel, new Niveau(niveau, null, null, 0),
						new Groupe(groupe, null, null), true, LocalDate.now(), matieresList));
		response.sendRedirect(request.getContextPath() + request.getServletPath());

	}

	private void ajouterEtudiant(HttpServletRequest request, HttpServletResponse response) throws IOException {

		var prenom = request.getParameter("prenom");
		var nom = request.getParameter("nom");
		var email = request.getParameter("email");
		var password = request.getParameter("password");
		var tel = request.getParameter("tel");
		var matieres = request.getParameterValues("matieres");
		var niveau = Integer.parseInt(request.getParameter("niveau"));
		var groupe = Integer.parseInt(request.getParameter("groupe"));

		etudiantDao.insertEtudiant(nom, prenom, email, password, niveau, groupe, tel, matieres);
		response.sendRedirect(request.getContextPath() + request.getServletPath());
	}

	private void supprimerEtudiant(HttpServletRequest request, HttpServletResponse response) throws IOException {
		var stringId = request.getParameter("id");
		int id = 0;
		try {
			id = Integer.valueOf(stringId);
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + request.getServletPath());
		}

		etudiantDao.deleteEtudiantById(id);
		response.sendRedirect(request.getContextPath() + request.getServletPath());
	}
}
