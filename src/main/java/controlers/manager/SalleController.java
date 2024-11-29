package controlers.manager;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Salle;
import model.dao.SalleDao;

@WebServlet("/manager/salles")
public class SalleController extends HttpServlet {
	SalleDao salleDao = new SalleDao();

	private static final long serialVersionUID = 7731404264859145043L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "supprimer":
			supprimerSalle(request, response);
			break;
		default:
			List<Salle> salles = salleDao.getAllSalles();
			request.setAttribute("salles", salles);
			request.setAttribute("servletPath", request.getServletPath());
			this.getServletContext().getRequestDispatcher("/jsps/manager/salles_list.jsp").forward(request, response);
	}

}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "ajouter":
			ajouterSalle(request, response);
			break;
		case "modifier":
			modifierSalle(request, response);
			break;
		default:
			response.sendRedirect(request.getContextPath() + request.getServletPath());
		}
	}

	private void modifierSalle(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int id = Integer.parseInt(request.getParameter("id"));		
		String nom = request.getParameter("nom");
		salleDao.updateSalle(new Salle(id, nom));
		response.sendRedirect(request.getContextPath() + request.getServletPath());
	}

	private void ajouterSalle(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String nom = request.getParameter("nom");
		System.out.println("dddddnom");
		salleDao.ajouterSalle(nom);
		response.sendRedirect(request.getContextPath() + request.getServletPath());
	}

	private void supprimerSalle(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		salleDao.deleteSalleById(id);
		response.sendRedirect(request.getContextPath() + request.getServletPath());
		
	}
	
}
