package controlers.Prof;

import java.io.IOException;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Emploi;
import model.bo.Etudiant;
import model.dao.EmploiDao;
import model.dao.EtudiantDao;

@WebServlet("/prof/absenses/etudiants")
public class ProfApsensesEtudiantsController extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private EtudiantDao etudiantDao = new EtudiantDao();
	EmploiDao emploiDao = new EmploiDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;
		
		switch (operation) {
			case"absense_statue":
				present(request, response);
				break;

			default:
				if (request.getParameter("seanse_id") != null) {
					var fait = request.getParameter("fait") != null? true: false;
					var seanseId = Integer.parseInt(request.getParameter("seanse_id") );
					emploiDao.updateFait(fait, seanseId);
				}

				voirlisteabsense(request, response);
		}
	}

	private void present(HttpServletRequest request, HttpServletResponse response) throws IOException {
		var seanseId = Integer.parseInt(request.getParameter("seanse_id"));
		var etudiant_id = Integer.parseInt(request.getParameter("etudiant_id"));
		var absenseStatue = Boolean.parseBoolean(request.getParameter("absense_statue"));

		emploiDao.present(seanseId, etudiant_id, absenseStatue);
		
		response.sendRedirect(request.getContextPath() + request.getServletPath()+"?seanse_id="+seanseId);
	}

	private void voirlisteabsense(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int seanse_id = Integer.parseInt(request.getParameter("seanse_id"));
		Emploi emploi = emploiDao.getEmploiById(seanse_id);
		request.setAttribute("emploi", emploi);
		Map<Etudiant, Boolean> map = etudiantDao.getapsensesByIdseanse(seanse_id);
		request.setAttribute("map", map);
		request.setAttribute("servletPath", request.getServletPath());
		this.getServletContext().getRequestDispatcher("/jsps/prof/apsenses_etudiants_prof_list.jsp").forward(request,response);
		
	}


}
