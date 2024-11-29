package controlers.manager;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Matiere;
import model.dao.MatiereDao;

@WebServlet("/manager/matieres")
public class MatiereController extends HttpServlet {
	private MatiereDao matiereDao = new MatiereDao();

	private static final long serialVersionUID = -922855849738485090L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("servletPath", request.getServletPath());
		
		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;
		
		if (operation.equals("supprimer")) {
			supprimer(request, response);
		} else {
			List<Matiere> matieres = matiereDao.allMatieres();
			request.setAttribute("matieres", matieres);
			request.setAttribute("servletPath", request.getServletPath());
			this.getServletContext().getRequestDispatcher("/jsps/manager/matieres_list.jsp").forward(request, response);
		}
		
	}
	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;
		if (operation.equals("modifier")) {
			modifierMatiere(request,response);
		}else if (operation.equals("ajouter")) {
			ajouterMatiere(request,response);
		}else {
			response.sendRedirect(request.getContextPath()+ request.getServletPath());
		}
		
	}
	
	private void ajouterMatiere(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		var nom = request.getParameter("nom");
		var prix = Float.parseFloat(request.getParameter("prix"));
		matiereDao.ajouterMatiere(nom,prix);
		response.sendRedirect(request.getContextPath() + request.getServletPath());	
		
	}

	private void modifierMatiere(HttpServletRequest request, HttpServletResponse response) throws IOException {

		var id = Integer.parseInt(request.getParameter("id"));
		var nom = request.getParameter("nom");
		var prix = Float.parseFloat(request.getParameter("prix"));
		matiereDao.updateMatiere(new Matiere(id,nom,prix));
		response.sendRedirect(request.getContextPath() + request.getServletPath());
	}

	private void supprimer(HttpServletRequest request, HttpServletResponse response) throws IOException  {
		var id = Integer.parseInt(request.getParameter("id"));
		
		matiereDao.deleteMaitreById(id);
		response.sendRedirect(request.getContextPath() + request.getServletPath());
	}

}
