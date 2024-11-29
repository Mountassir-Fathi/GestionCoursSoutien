package controlers.manager;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Niveau;
import model.dao.NiveauDao;

@WebServlet("/manager/niveaux")
public class NiveauController extends HttpServlet {
	private static final long serialVersionUID = -237169409642499104L;

	NiveauDao niveauDao = new NiveauDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setAttribute("servletPath", request.getServletPath());

		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "supprimer":
			supprimerEtudiant(request, response);
			break;
		default:
			List<Niveau> niveaux = niveauDao.getAllNiveau();
			
			request.setAttribute("niveaux", niveaux);

			request.setAttribute("servletPath", request.getServletPath());

			this.getServletContext().getRequestDispatcher("/jsps/manager/niveaux_list.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "modifier":
			modifierNiveau(request, response);
			break;
		case "ajouter":
			ajouterNiveau(request, response);
			break;
		default:
			response.sendRedirect(request.getContextPath() + request.getServletPath());
		}
	}

	private void ajouterNiveau(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String nom = request.getParameter("nom");
		niveauDao.addNiveau(nom);
		response.sendRedirect(request.getContextPath() + request.getServletPath());

	}

	private void modifierNiveau(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String nom = request.getParameter("nom");
		int niveau_id = Integer.parseInt(request.getParameter("id"));
		niveauDao.modifyNiveau(niveau_id, nom);
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

		niveauDao.deleteNiveauById(id);
		response.sendRedirect(request.getContextPath() + request.getServletPath());
	}

}
