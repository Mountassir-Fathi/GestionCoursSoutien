package controlers.manager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Matiere;
import model.bo.Niveau;
import model.bo.Prof;
import model.dao.MatiereDao;
import model.dao.NiveauDao;
import model.dao.ProfDao;

@WebServlet("/manager/profs")
public class ProfsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ProfDao profDao = new ProfDao();
	private NiveauDao niveauDao = new NiveauDao();
	private MatiereDao matiereDao = new MatiereDao();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "supprimer":
			supprimerProf(request, response);
			break;
		default:
			List<Prof> profs = profDao.getAllProfs();
			List<Niveau> niveaux = niveauDao.getAllNiveau();
			List<Matiere> matieres = matiereDao.allMatieres();

			List<List<Integer>> matrix = new ArrayList<List<Integer>>();

			for (var prof : profs) {
				List<Integer> list = new ArrayList<Integer>();
				for (var niveau : prof.getNiveaux()) {
					System.out.println(niveau.getId());
					list.add(niveauDao.getnombreGrbyIdN(niveau.getId()));
				}
				matrix.add(list);
			}

			// System.out.println(matrix);
			request.setAttribute("matrix", matrix);
			request.setAttribute("profs", profs);
			request.setAttribute("niveaux", niveaux);
			request.setAttribute("matieres", matieres);
			request.setAttribute("servletPath", request.getServletPath());

			this.getServletContext().getRequestDispatcher("/jsps/manager/profs_list.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "ajouter":
			ajouterprof(request, response);
			break;
		case "modifier":
			modifierProf(request, response);
			break;
		default:
			response.sendRedirect(request.getContextPath() + request.getServletPath());
		}
	}

	private void modifierProf(HttpServletRequest request, HttpServletResponse response) throws IOException {
		var id = Integer.parseInt(request.getParameter("id"));
		var prenom = request.getParameter("prenom");
		var nom = request.getParameter("nom");
		var mail = request.getParameter("email");
		var password = request.getParameter("password");
		var tel = request.getParameter("tel");
		var niveaux = request.getParameterValues("niveaux");

		List<Niveau> niveauList = new ArrayList<Niveau>();

		for (String string : niveaux) {
			niveauList.add(niveauDao.getNiveauById(Integer.parseInt(string)));
			profDao.deleteProfN(id, Integer.parseInt(string));

		}

		Prof prof = new Prof(id, nom, prenom, mail, password, null, tel, null, null, niveauList);
		profDao.updateProfById(prof);

		response.sendRedirect(request.getContextPath() + request.getServletPath());

	}

	private void ajouterprof(HttpServletRequest request, HttpServletResponse response) throws IOException {

		var prenom = request.getParameter("prenom");
		var nom = request.getParameter("nom");
		var mail = request.getParameter("email");
		var password = request.getParameter("password");
		var tel = request.getParameter("tel");
		var idmatiereString = request.getParameter("matiere");
		var matiere = Integer.parseInt(idmatiereString);
		var niveaux = request.getParameterValues("niveaux");

		
		profDao.insertProfN(nom, prenom, mail, password, "PROF", tel, matiereDao.getMatiereById(matiere), niveaux);
		response.sendRedirect(request.getContextPath() + request.getServletPath());

	}

	private void supprimerProf(HttpServletRequest request, HttpServletResponse response) throws IOException {
		var stringId = request.getParameter("id");

		int id = 0;
		try {
			id = Integer.valueOf(stringId);
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + request.getServletPath());
		}

		profDao.deleteProf(id);
		response.sendRedirect(request.getContextPath() + request.getServletPath());
	}
}
