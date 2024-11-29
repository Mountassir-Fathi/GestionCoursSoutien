package controlers.etudiant;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.oracle.wls.shaded.org.apache.bcel.generic.NEW;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Emploi;
import model.bo.User;
import model.dao.EmploiDao;
import model.dao.EtudiantDao;
import model.dao.PayementDao;

@WebServlet("/etudiant/emploi")
public class EtudiantEmploiController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	EmploiDao emploiDao = new EmploiDao();
	EtudiantDao etudiantDao = new EtudiantDao();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User etudiant = (User) request.getSession().getAttribute("userInfo");
		List<Emploi> emplois = new ArrayList<Emploi>();
		emplois = emploiDao.getallSeansebyetudiant(etudiantDao.getEtudiantById(etudiant.getId()));
		boolean payer = new PayementDao().statuePayementMoi(etudiant.getId(), LocalDate.now().getMonthValue());
		request.setAttribute("payer", payer);
		System.out.println(payer);
		request.setAttribute("emplois", emplois);
		request.setAttribute("servletPath", request.getServletPath());
		this.getServletContext().getRequestDispatcher("/jsps/etudiant/emploi_etudiant_list.jsp").forward(request, response);
	}
	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(request, response);
	}
	

}
