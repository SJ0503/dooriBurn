package dooriburn.com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dooriburn.com.model.CommentDAO;
import dooriburn.com.model.CommentLikeDAO;
import dooriburn.com.model.CommentLikeDTO;
import dooriburn.com.model.FilmLikeDAO;
import dooriburn.com.model.FilmLikeDTO;
import dooriburn.com.model.MemberDTO;
 
@WebServlet("/CommentLikeService")
public class CommentLikeService extends HttpServlet {
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String email = request.getParameter("email");
      int cmt_num = Integer.parseInt(request.getParameter("cmt_num"));
       
      CommentLikeDTO dto = new CommentLikeDTO(cmt_num, email);
      CommentLikeDAO dao = new CommentLikeDAO();
      String message;
        if (dao.userLiked(email, cmt_num)) {
           
           int cnt = dao.removeLike(cmt_num, email);
           if(cnt>0) {
              message = "좋아요 취소 성공";
           }else {
              message = "좋아요 취소 실패";
         }
            
        } else {
           int cnt =dao.addLike(cmt_num, email);
           if(cnt>0) {
              message = "좋아요 추가 성공";
           }else {
              message = "좋아요 추가 실패";
         }
           
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"message\":\"" + message + "\"}");
    }
}
