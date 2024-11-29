package controlers;

import java.io.IOException;

import com.oracle.wls.shaded.org.apache.bcel.generic.NEW;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.User;
import model.dao.NiveauDao;


@WebServlet("")
public class MainPageController extends HttpServlet {

	private static final long serialVersionUID = -1338640181878396045L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User) req.getSession().getAttribute("userInfo");
		boolean isAuthenticated = false;
		String dashboard = "";
		
		if (user != null) {
			isAuthenticated = true;
			switch (user.getRole()) {
			case "ETUDIANT":
				dashboard = "etudiant/emploi";
				break;

			case "PROF":
				dashboard = "prof/emploi-de-temps";
				break; 

			case "MANAGER":
				dashboard = "manager/etudiants-inscrits";
				break;
			
			}
		}

		req.setAttribute("isAuthenticated", isAuthenticated);
		req.setAttribute("dashboard", dashboard);
		req.setAttribute("niveaux", new NiveauDao().getAllNiveau());
		req.getRequestDispatcher("index.jsp").forward(req, resp);
	}

}
