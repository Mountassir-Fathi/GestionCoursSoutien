package controlers.manager;

import java.io.IOException;
import java.util.Map;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.PageSize;
import com.lowagie.text.pdf.PdfWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.Emploi;
import model.bo.Etudiant;
import model.dao.EmploiDao;
import model.dao.EtudiantDao;

@WebServlet("/manager/absenses/etudiants")
public class ApsensesEtudiantController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private EtudiantDao etudiantDao = new EtudiantDao();
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

		case "telecharger":
			telecharger(request, response);
			break;
		default:
			response.sendRedirect(request.getContextPath());
		}
	
			
	}

	private void voirlisteabsense(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int seanse_id = Integer.parseInt(request.getParameter("seanse_id"));
		Emploi emploi = emploiDao.getEmploiById(seanse_id);
		request.setAttribute("emploi", emploi);
		Map<Etudiant, Boolean> map = etudiantDao.getapsensesByIdseanse(seanse_id);
		request.setAttribute("map", map);
		request.setAttribute("servletPath", request.getServletPath());
		this.getServletContext().getRequestDispatcher("/jsps/manager/apsenses_etudiants_list.jsp").forward(request,response);
		
	}

	public void telecharger(HttpServletRequest request, HttpServletResponse response) {
		var seanceId = Integer.parseInt(request.getParameter("seanse_id"));
		var document = new Document(PageSize.A4);
		try {
			PdfWriter.getInstance(document, response.getOutputStream());
		} catch (DocumentException | IOException e) {
			e.printStackTrace();
		}
		
		response.setContentType("application/pdf");
	    response.setHeader("Content-disposition","inline; filename='" + new EmploiDao().getEmploiById(seanceId).getDate() + ".pdf'");

	    document.open();
		var generatePDF = new utils.GeneratePDF(document);
		generatePDF.sessionInfo(new EmploiDao().getEmploiById(seanceId));
		generatePDF.addTableTitle("List d'absence");
		generatePDF.createTableHeader("Nom", "Prenom", "Numéro Tél", "Absence");
		generatePDF.createTableBody(new EtudiantDao().getapsensesByIdseanse(seanceId));
	    document.close();
	}
}
