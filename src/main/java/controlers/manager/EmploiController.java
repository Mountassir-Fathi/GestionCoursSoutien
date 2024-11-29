package controlers.manager;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Emploi;
import model.bo.Groupe;
import model.bo.Matiere;
import model.bo.Niveau;
import model.bo.Prof;
import model.bo.Salle;
import model.dao.EmploiDao;
import model.dao.GroupeDao;
import model.dao.MatiereDao;
import model.dao.NiveauDao;
import model.dao.ProfDao;
import model.dao.SalleDao;

@WebServlet("/manager/emploi-de-temps")
public class EmploiController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private NiveauDao niveauDao = new NiveauDao();
	private MatiereDao matiereDao = new MatiereDao();
	private GroupeDao groupeDao = new GroupeDao();
	private ProfDao profDao = new ProfDao();
	private SalleDao salleDao = new SalleDao();
	private EmploiDao emploiDao = new EmploiDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "supprimer":
			supprimerSeance(request, response);
			break;
		default:

			List<Niveau> niveaux = niveauDao.getAllNiveau();
			List<Groupe> groupes = groupeDao.getAllGroupes();
			List<Matiere> matieres = matiereDao.allMatieres();
			List<Prof> profs = profDao.getAllProfs();
			List<Salle> salles = salleDao.getAllSalles();

			List<Emploi> emplois = emploiDao.getallEmplois();
			request.setAttribute("emplois", emplois);

			request.setAttribute("niveaux", niveaux);
			request.setAttribute("groupes", groupes);
			request.setAttribute("matieres", matieres);
			request.setAttribute("profs", profs);
			request.setAttribute("salles", salles);

			request.setAttribute("servletPath", request.getServletPath());
			this.getServletContext().getRequestDispatcher("/jsps/manager/emploi_list.jsp").forward(request, response);
		}
	}

	private void supprimerSeance(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		emploiDao.deleteseanse(id);
		response.sendRedirect(request.getContextPath() + request.getServletPath());

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "ajouter":
			ajouterEmploi(request, response);
			break;
		case "modifier":
			modifierEmploi(request, response);
			break;
		default:

			response.sendRedirect(request.getContextPath() + request.getServletPath());

		}

	}

	private void modifierEmploi(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int id = Integer.parseInt(request.getParameter("id"));
		int niveau_id = Integer.parseInt(request.getParameter("niveau"));
		int groupe_id = Integer.parseInt(request.getParameter("groupe"));
		int matiere_id = Integer.parseInt(request.getParameter("matiere"));
		int salle_id = Integer.parseInt(request.getParameter("salle"));
		String timestart = request.getParameter("timestart");
		String timeend = request.getParameter("timeend");
		String date = request.getParameter("date");

		emploiDao.modifierEmplois(id, niveau_id, groupe_id, matiere_id, salle_id, timestart, timeend, date);
		response.sendRedirect(request.getContextPath() + request.getServletPath());

	}

	private void ajouterEmploi(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int niveau_id = Integer.parseInt(request.getParameter("niveau"));
		int groupe_id = Integer.parseInt(request.getParameter("groupe"));
		int matiere_id = Integer.parseInt(request.getParameter("matiere"));
		int salle_id = Integer.parseInt(request.getParameter("salle"));
		String timestart = request.getParameter("timestart");
		String timeend = request.getParameter("timeend");
		String date = request.getParameter("date");

		emploiDao.ajouterEmplois(niveau_id, groupe_id, matiere_id, salle_id, timestart, timeend, date);
		response.sendRedirect(request.getContextPath() + request.getServletPath());
	}

}
