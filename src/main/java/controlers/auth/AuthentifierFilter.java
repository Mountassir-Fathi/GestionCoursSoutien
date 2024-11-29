package controlers.auth;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bo.User;


/**
 * Servlet Filter implementation class AuthentifierFilter
 */
@WebFilter(urlPatterns = {"/manager/dashboard",
							"/manager/profs",
							"/manager/etudiants-inscrits",
							"/manager/etudiants-non-inscrits",
							"/manager/groupes",
							"/manager/niveaux",
							"/manager/matieres",
							"/manager/salles",
							"/manager/absenses/etudiants",
							"/manager/absenses",
							"/manager/paiement",
							"/manager/emploi-de-temps",
							"/prof/emploi-de-temps",
							"/prof/absenses/etudiants",
							"/etudiant/emploi"})
public class AuthentifierFilter extends HttpFilter implements Filter {
       
	private static final long serialVersionUID = 5113823812583406840L;

	/**
     * @see HttpFilter#HttpFilter()
     */
    public AuthentifierFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		var req = (HttpServletRequest) request;
		var resp = (HttpServletResponse) response;
		var path = req.getServletPath();
		
		
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("userInfo");
		
		if (user == null) {
			resp.sendRedirect(req.getContextPath());
			return;

		}		
		
		if (path.contains("GeneratePDF")) chain.doFilter(request, response);
		if (path.startsWith("/etudiant") && user.getRole().equals("ETUDIANT")){
			chain.doFilter(request, response);
		}

		else if (path.startsWith("/prof") && user.getRole().equals("PROF")){
			chain.doFilter(request, response);
	
		}
		else if (path.startsWith("/manager") && user.getRole().equals("MANAGER")){
			chain.doFilter(request, response);
		}
		else {
			resp.sendRedirect(req.getContextPath());
			return;
		}
			
//		chain.doFilter(request, response);
		
		
	}

	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
