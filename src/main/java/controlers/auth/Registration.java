package controlers.auth;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Niveau;
import model.dao.EtudiantDao;
import model.dao.NiveauDao;

@WebServlet("/register")
public class Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;
	NiveauDao niveauDao = new NiveauDao();
	EtudiantDao etudiantDao = new EtudiantDao();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Niveau> niveaux = new ArrayList<Niveau>();
		niveaux = niveauDao.getAllNiveau();
		request.setAttribute("niveaux", niveaux);
		request.getRequestDispatcher("jsps/auth/register.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		var nom = request.getParameter("nom");
		var prenom = request.getParameter("prenom");
		var email = request.getParameter("email");
		var tel = request.getParameter("tel");
		var niveau = Integer.parseInt(request.getParameter("niveau"));
		var password = request.getParameter("password");

		etudiantDao.inscriEtudiant(nom, prenom, email, password, niveau, tel);
		response.sendRedirect(request.getContextPath());

	}

}
