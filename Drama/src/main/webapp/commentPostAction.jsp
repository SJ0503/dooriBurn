<%@page import="dooriburn.com.model.MemberDTO"%>
<%@page import="dooriburn.com.model.CommentDAO"%>
<%@page import="dooriburn.com.model.CommentDTO"%>
<%@page import="dooriburn.com.model.ContestDAO"%>
<%@page import="dooriburn.com.model.ContestDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>commentPostAction.jsp</title>
</head>
<body>

<!-- 댓글 작성 action -->
<%
request.setCharacterEncoding("UTF-8");
int maxFileSize = 1024 * 1024 * 10;
String path = request.getRealPath("/commentImg");
MemberDTO info = (MemberDTO) session.getAttribute("info");

if (info == null) {
    response.sendRedirect("login.jsp");
    return;
}

try {
    MultipartRequest multi = new MultipartRequest(request, path, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
    
    // 디버깅: 모든 파라미터 확인
    String img = multi.getFilesystemName("commentImg");
    String cNum = multi.getParameter("c_num");
    int c_num = 0;

    if (cNum != null && !cNum.isEmpty()) {
        try {
            c_num = Integer.parseInt(cNum);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            c_num = 0; // 기본값 설정
        }
    }

    String email = info.getEmail();
    CommentDTO dto = new CommentDTO(img, c_num, email);
    CommentDAO dao = new CommentDAO();
    int cnt = dao.commentPost(dto);

    if (cnt > 0) {
        response.sendRedirect("contestView.jsp?c_num=" + c_num);
    } else {
        out.println("<script>alert('댓글 작성 실패');</script>");
        response.sendRedirect("contestView.jsp?c_num=" + c_num);
    }
} catch (Exception e) {
    out.println("<script>alert('댓글 작성 중 오류 발생: " + e.getMessage() + "');</script>");
    out.flush();
    e.printStackTrace();
}
%>

</body>
</html>
