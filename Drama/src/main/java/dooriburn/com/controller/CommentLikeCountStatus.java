package dooriburn.com.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dooriburn.com.model.CommentLikeDAO;

@WebServlet("/CommentLikeCountStatus")
public class CommentLikeCountStatus extends HttpServlet {
	
    private CommentLikeDAO dao;
 
    public void init() throws ServletException {
        super.init();
        dao = new CommentLikeDAO();
    }
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  
		int cmt_num = Integer.parseInt(request.getParameter("cmt_num"));
		String email = request.getParameter("email");
		
		int likeCount = dao.commentLikeCount(cmt_num); // 좋아요수
		boolean userLiked = dao.userLiked(email, cmt_num); // 사용자의 좋아요 여부
		 
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.print("{ \"likeCount\": " + likeCount + ", \"userLiked\": " + userLiked + " }");
		out.flush();
    }
	 
	 

}
