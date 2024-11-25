package dooriburn.com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dooriburn.com.model.FilmLikeDAO;
import dooriburn.com.model.FilmLikeDTO;
import dooriburn.com.model.MemberDAO;
import dooriburn.com.model.MemberDTO;

import java.util.List;

@WebServlet("/FilmLikeService")
public class FilmLikeService extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		int f_num = Integer.parseInt(request.getParameter("f_num"));

		FilmLikeDTO dto = new FilmLikeDTO(email, f_num);
		FilmLikeDAO dao = new FilmLikeDAO();

//		System.out.println(email);
//		System.out.println(f_num);
		String message;

		if (dao.isLiked(dto)) {
			int cnt = dao.removeLike(dto);
			if (cnt > 0) {
				message = "좋아요 취소성공";
			} else {
				message = "좋아요 취소실패";
			}

		} else {
			int cnt = dao.addLike(dto);
			if (cnt > 0) {
				message = "좋아요 추가성공";
			} else {
				message = "좋아요 추가실패";
			}

		}

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"message\":\"" + message + "\"}");
	}

}