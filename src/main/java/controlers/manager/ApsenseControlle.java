package controlers.manager;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Emploi;
import model.dao.EmploiDao;

@WebServlet("/manager/absenses")

public class ApsenseControlle extends HttpServlet {

	private static final long serialVersionUID = 1L;

	EmploiDao emploiDao = new EmploiDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "voir":
			voirlisteabsense(request, response);
			break;
		default:
			List<Emploi> emplois = emploiDao.getallEmplois();
			request.setAttribute("emplois", emplois);

			request.setAttribute("servletPath", request.getServletPath());
			this.getServletContext().getRequestDispatcher("/jsps/manager/apsenses_list.jsp").forward(request, response);
		}
	}

	private void voirlisteabsense(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		request.setAttribute("servletPath", request.getServletPath());
		this.getServletContext().getRequestDispatcher("/prof/apsenses/etudiants").forward(request, response);

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "telecharger":
			telechargerlisteabsense(request, response);
			break;
		default:
			response.sendRedirect(request.getContextPath() + request.getServletPath());
		}
	}

	private void telechargerlisteabsense(HttpServletRequest request, HttpServletResponse response) {
//code de telechargement 
	}

}
