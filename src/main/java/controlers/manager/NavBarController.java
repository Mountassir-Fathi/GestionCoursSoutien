package controlers.manager;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.User;
import model.dao.AuthentifierDao;


@WebServlet("/navbar")
public class NavBarController extends HttpServlet {

	private static final long serialVersionUID = 8875163179167273200L;
	private AuthentifierDao authentifierDao = new AuthentifierDao();
	
	/*********************************/

	/*********************************/
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		var password = req.getParameter("password");
		var newPassword = req.getParameter("newpassword");
		var reNewPassword = req.getParameter("renewpassword");

		User user = (User) req.getSession().getAttribute("userInfo");
		
		
		if (authentifierDao.Authentifier(user.getMail(), password) == null) {
			///////////////////////
		} else {
			authentifierDao.changePassword(newPassword, user.getId());
		}
		
		
		String link = "";
		String role =  user.getRole();
		
		

		switch (role) {
		case "ETUDIANT": 
			link = "etudiant/emploi";
			 break;
		case "PROF": 
			link = "/prof/emploi-de-temps";
			 break;
		case "MANAGER": 
			link = "/manager/dashboard";
			 break;
		}
		
		resp.sendRedirect(link);
	}

}
