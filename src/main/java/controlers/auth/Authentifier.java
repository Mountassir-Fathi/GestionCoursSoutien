package controlers.auth;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dao.AuthentifierDao;

@WebServlet("/authentifier")
public class Authentifier extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private AuthentifierDao authentifierDao = new AuthentifierDao();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
			
		this.getServletContext().getRequestDispatcher("/jsps/auth/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
			
		var email = request.getParameter("email");
		var password = request.getParameter("password");

		var user = authentifierDao.Authentifier(email, password);
		if (user == null) {
			request.setAttribute("incorrect", true);
			this.getServletContext().getRequestDispatcher("/jsps/auth/login.jsp").forward(request, response);
		} else {
			var session = request.getSession();
			session.setAttribute("userInfo", user);
			session.setMaxInactiveInterval(50 * 60);
			response.sendRedirect(request.getContextPath());
		}
	}
}
