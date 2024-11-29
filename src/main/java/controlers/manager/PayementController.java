package controlers.manager;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Etudiant;
import model.dao.PayementDao;

@WebServlet("/manager/paiement")
public class PayementController extends HttpServlet {
	
	private PayementDao payementDao = new PayementDao();
	private static final long serialVersionUID = 7093173761401464047L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		var operation = req.getParameter("operation");
		operation = operation == null ? "" : operation;

		switch (operation) {
		case "payer":
			payer(req,resp);
			break;
		default:
		Map<Etudiant, Boolean> map = payementDao.getPaymentList(LocalDate.now().getMonthValue());
		req.setAttribute("map", map);
		req.setAttribute("servletPath", req.getServletPath());
		this.getServletContext().getRequestDispatcher("/jsps/manager/payement_list.jsp").forward(req, resp);
		}
	}

	private void payer(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		 int id = Integer.parseInt(req.getParameter("id"));
		 boolean payer = Boolean.parseBoolean(req.getParameter("payer"));
		 
		 payementDao.changeretatpayement(id,payer);
		 
		 resp.sendRedirect(req.getContextPath() + req.getServletPath());
	}

}
