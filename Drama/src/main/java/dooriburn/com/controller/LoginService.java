package dooriburn.com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dooriburn.com.model.MemberDAO;
import dooriburn.com.model.MemberDTO;

@WebServlet("/LoginService")
public class LoginService extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");

		MemberDTO dto = new MemberDTO(email, pw);
		MemberDAO dao = new MemberDAO();

		MemberDTO info = dao.login(dto);

		HttpSession session = request.getSession(); 
		String recentURI = request.getParameter("from");
		
		if (info != null) {
			if (pw.equals(info.getPw())) {
				session.setAttribute("info", info); 
				if (recentURI != null) {
					response.sendRedirect(recentURI); 
				} else {
					response.sendRedirect("Realindex.jsp");  
				} 
			}else {
				if (recentURI != null) {
					response.sendRedirect("login.jsp?from="+recentURI+"&error=true");
				} else {
					response.sendRedirect("login.jsp?&error=true"); 
				}
			}
		}else { 
				if (recentURI != null) {
					response.sendRedirect("login.jsp?from="+recentURI+"&error=true");
				} else {
					response.sendRedirect("login.jsp?error=true"); 
				}
		}
	}
}
 