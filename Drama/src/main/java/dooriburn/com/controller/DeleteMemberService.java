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
 
@WebServlet("/DeleteMemberService")
public class DeleteMemberService extends HttpServlet {
 
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();		
		
		String email = request.getParameter("email");
	
		MemberDAO dao = new MemberDAO();
		 
		String recentURI = request.getParameter("from");
		int cnt = dao.delete(email);
		if (cnt > 0) { 
			System.out.println("삭제완료");
			if (recentURI != null) {
				response.sendRedirect(recentURI+"?pageNum=1"); 
			} else {
				response.sendRedirect("Realindex.jsp"); 
			} 
		} else {   
			if (recentURI != null) {
				response.sendRedirect("memberList.jsp?from="+recentURI);
			} else {
				response.sendRedirect("memberList.jsp"); 
			} 
		}  
	}
 

}
