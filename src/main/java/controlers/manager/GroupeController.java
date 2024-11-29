package controlers.manager;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Groupe;
import model.bo.Niveau;
import model.dao.GroupeDao;
import model.dao.NiveauDao;

/**
 * Servlet implementation class GroupsList
 */
@WebServlet("/manager/groupes")
public class GroupeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	GroupeDao groupeDao = new GroupeDao();
	NiveauDao niveauDao = new NiveauDao();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GroupeController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "supprimer":
			supprimerGroupe(request, response);
			break;
		default:
			List<Groupe> groupes = groupeDao.getAllGroupes();
			List<Niveau> niveaux = niveauDao.getAllNiveau();

			request.setAttribute("groupes", groupes);
			request.setAttribute("niveaux", niveaux);
		
			request.setAttribute("servletPath", request.getServletPath());
			this.getServletContext().getRequestDispatcher("/jsps/manager/groupes_list2.jsp").forward(request, response);
		}
	}

	private void supprimerGroupe(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int id =Integer.parseInt(request.getParameter("id"));
		groupeDao.deleteGroupeById(id);
		response.sendRedirect(request.getContextPath() + request.getServletPath());

		
	}

	

	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "ajouter":
			ajouterGroupe(request, response);
			break;
		case "modifier":
			modifierGroupe(request, response);
			break;	
		default:
			response.sendRedirect(request.getContextPath() + request.getServletPath());
			
		}
		
	}

	private void modifierGroupe(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String nom = request.getParameter("nom");
		int niveau_id = Integer.parseInt(request.getParameter("niveau"));
		groupeDao.updateGroupe(new Groupe(id,nom,niveauDao.getNiveauById(niveau_id)));
		
		response.sendRedirect(request.getContextPath() + request.getServletPath());
		
	}

	private void ajouterGroupe(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String nom = request.getParameter("nom");
		int niveau_id = Integer.parseInt(request.getParameter("niveau"));
		groupeDao.ajouterGroupe(nom, niveau_id);
		response.sendRedirect(request.getContextPath() + request.getServletPath());

		
	}

}
