package dooriburn.com.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dooriburn.com.model.DramaSearchDAO;
import dooriburn.com.model.DramaSearchDTO;
import dooriburn.com.model.MemberDAO;
import dooriburn.com.model.MemberDTO;
import dooriburn.com.model.ReviewDAO;
import dooriburn.com.model.ReviewDTO;


@WebServlet("/ReviewUpdateService")
public class ReviewUpdateService extends HttpServlet {
	

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		MemberDTO info = (MemberDTO)session.getAttribute("info");
		
		String index = request.getParameter("index");
		DramaSearchDAO Drama_dao = new DramaSearchDAO();
		ArrayList<DramaSearchDTO> film_detail = Drama_dao.film_detail(index);
		
		String email = info.getEmail();
		Double f_num = film_detail.get(0).getFNum();
		int rating = Integer.parseInt(request.getParameter("reviewStar"));
		String content = request.getParameter("content");
		String[] mood = request.getParameterValues("mood");
		
		ReviewDTO dto = new ReviewDTO(email, f_num, rating, content, mood);
		ReviewDAO dao = new ReviewDAO();
		
		int cnt = dao.Insert(dto);
		
		response.sendRedirect("detail.jsp?index="+index);
		
	}

}
