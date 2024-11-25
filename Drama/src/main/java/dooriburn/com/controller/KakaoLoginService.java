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

@WebServlet("/KakaoLoginService")
public class KakaoLoginService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public KakaoLoginService() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String nick = request.getParameter("nickname");
        String email = request.getParameter("id");
        String pw = email;

        MemberDAO dao = new MemberDAO();
        HttpSession session = request.getSession();

        int check_cnt = dao.checkEmail(email);

        if (check_cnt == 0) {
            // 로그인 로직
            MemberDTO dto = new MemberDTO(email, pw);
            MemberDTO info = dao.login(dto);
            
            if (info != null) {
                session.setAttribute("info", info);
                System.out.println("로그인 성공: " + info.getEmail() + ", " + info.getNick());
                response.sendRedirect("Realindex.jsp");
            } else {
                System.out.println("로그인 실패");
                response.sendRedirect("login.jsp");
            }
        } else {
            // 회원가입 로직
            String name = nick;
            String phone = "kakao";
            String addr = "kakao";

            MemberDTO dto = new MemberDTO(email, pw, nick, name, phone, addr);
            int cnt = dao.join(dto);

            if (cnt > 0) {
                session.setAttribute("info", dto);
                System.out.println("회원가입 성공: " + dto.getEmail() + ", " + dto.getNick());
                response.sendRedirect("Realindex.jsp");
            } else {
                System.out.println("회원가입 실패");
                response.sendRedirect("join.jsp");
            }
        }
    }
}
