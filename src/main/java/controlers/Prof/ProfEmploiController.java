package controlers.Prof;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Emploi;
import model.bo.User;
import model.dao.EmploiDao;
import model.dao.ProfDao;

@WebServlet("/prof/emploi-de-temps")
public class ProfEmploiController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	EmploiDao emploiDao = new EmploiDao();
	ProfDao profDao = new ProfDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User prof = (User) request.getSession().getAttribute("userInfo");
		var operation = request.getParameter("operation");
		operation = operation == null ? "" : operation;

		if (operation.equals("apsense")) {
			apsense(request, response);
		} else {

			List<Emploi> emplois = new ArrayList<Emploi>();
			emplois = emploiDao.getallSeansebyprof(profDao.getProfById(prof.getId()));
			request.setAttribute("emplois", emplois);

			request.setAttribute("servletPath", request.getServletPath());
			this.getServletContext().getRequestDispatcher("/jsps/prof/emploi_prof_list.jsp").forward(request, response);

		}

	}

	private void apsense(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.getServletContext().getRequestDispatcher("/manager/apsenses/etudiants").forward(request, response);

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
