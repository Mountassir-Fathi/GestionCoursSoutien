package controlers.manager;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Emploi;
import model.dao.EmploiDao;
import model.dao.EtudiantDao;
import model.dao.NiveauDao;
import model.dao.PayementDao;


@WebServlet("/manager/dashboard")
public class DashboardController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
    private EmploiDao emploiDao = new EmploiDao();
	private NiveauDao niveauDao = new NiveauDao();
	private EtudiantDao etudiantDao = new EtudiantDao();
	private PayementDao payementDao = new PayementDao();
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
			
		double total = payementDao.getPayementById(LocalDate.now().getMonthValue()).getTotal();
		double prevTotal = payementDao.getPayementById(LocalDate.now().minusMonths(1).getMonthValue()).getTotal();
		int totalPourcentage = (int) (((total - prevTotal) / prevTotal) * 100);

		var etudiantsInscrits = etudiantDao.allEtudiantsInscri(true);
		long nombreEiPrev = etudiantsInscrits.stream().filter(
				etudiant -> etudiant.getDate_debut().getMonthValue() == LocalDate.now().minusMonths(1).getMonthValue())
				.count();
		nombreEiPrev = nombreEiPrev <= 0 ? 1 : nombreEiPrev;
		long nombreEi = etudiantsInscrits.stream()
				.filter(etudiant -> etudiant.getDate_debut().getMonthValue() == LocalDate.now().getMonthValue())
				.count();
		int nombreEiPourcentage = (int) (((nombreEi - nombreEiPrev) / nombreEiPrev) * 100);

		var etudiantsNonInscrits = etudiantDao.allEtudiantsInscri(false);
		long nombreEniPrev = etudiantsNonInscrits.stream().filter(
				etudiant -> etudiant.getDate_debut().getMonthValue() == LocalDate.now().minusMonths(1).getMonthValue())
				.count();
		nombreEniPrev = nombreEniPrev <= 0 ? 1 : nombreEniPrev;
		long nombreEni = etudiantsNonInscrits.stream()
				.filter(etudiant -> etudiant.getDate_debut().getMonthValue() == LocalDate.now().getMonthValue())
				.count();
		int nombreEniPourcentage = (int) (((nombreEni - nombreEniPrev) / nombreEniPrev) * 100);

		var niveaux = niveauDao.getAllNiveau();
		Map<String, Double> map = new HashMap<>();

		for (var niveau : niveaux) {
			var nom = niveau.getNom();
			double cotisatonsByNiveau = 0;
			for (var et : etudiantDao.getEtudiantByNiveauId(niveau.getId())) {
				cotisatonsByNiveau += et.getCotisationAnnuelle();
			}
			map.put(nom, cotisatonsByNiveau);
		}

		////////////////////////////////////////////////////////////////

		request.setAttribute("total", total);
		request.setAttribute("totalPourcentage", totalPourcentage);

		request.setAttribute("nombreEi", nombreEi);
		request.setAttribute("nombreEiPourcentage", nombreEiPourcentage);

		request.setAttribute("nombreEni", nombreEni);
		request.setAttribute("nombreEniPourcentage", nombreEniPourcentage);

		request.setAttribute("niveaux", map);

		request.setAttribute("servletPath", request.getServletPath());
		this.getServletContext().getRequestDispatcher("/jsps/manager/dashboard.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<Emploi> seances = emploiDao.getEmploiNow();
        String json =  new Gson().toJson(seances);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
        System.out.println(json);
	}

}
