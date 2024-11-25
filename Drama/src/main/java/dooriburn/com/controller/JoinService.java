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

@WebServlet("/JoinService")
public class JoinService extends HttpServlet {
	
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		// todo
		
		String nick = request.getParameter("nick");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String addr = request.getParameter("addr");
		
		
		MemberDTO dto = new MemberDTO(email, pw, nick, name, phone, addr);
		MemberDAO dao = new MemberDAO();

		HttpSession session = request.getSession(); 
		String recentURI = request.getParameter("from");
		
		int cnt = dao.join(dto);
		
		if(cnt > 0) { 
			if (recentURI != null) {
				response.sendRedirect(recentURI); 
			} else {
				response.sendRedirect("Realindex.jsp"); 
			} 
		} else {
			// 회원가입 실패
			if (recentURI != null) {
				response.sendRedirect("join.jsp?from="+recentURI);
			} else {
				response.sendRedirect("join.jsp"); 
			} 
		}
		    
	}

}
