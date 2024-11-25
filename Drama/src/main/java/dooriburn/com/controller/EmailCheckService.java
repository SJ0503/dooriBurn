package dooriburn.com.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dooriburn.com.model.MemberDAO;


@WebServlet("/EmailCheckService")
public class EmailCheckService extends HttpServlet {
	

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String email = request.getParameter("userEmail");
		
		PrintWriter out = response.getWriter();
		
		MemberDAO dao = new MemberDAO();
		
		int cnt = dao.checkEmail(email);
		
		out.write(cnt + "");
	}

}
