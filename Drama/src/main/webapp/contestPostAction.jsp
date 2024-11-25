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
<title>contestPostAction.jsp</title>
</head>
<body>


<!-- 게시글 작성 action  -->  
	<%
	request.setCharacterEncoding("UTF-8");
	
	int maxFileSize = 1024 * 1024 * 10;
	String path = request.getRealPath("/boardImg");
	
    try { 
		MultipartRequest multi = new MultipartRequest(request, path, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
		
		String title = multi.getParameter("contestTitle");  
		String img = multi.getFilesystemName("contestImg"); 
		String content = multi.getParameter("contestContent"); 
	 
		ContestDTO dto = new ContestDTO(title, img, content);
		ContestDAO dao = new ContestDAO();  
		
		int cnt = dao.contestPost(dto);
		 
	    if (cnt > 0) { 
	        out.println("<script>alert('글 작성 성공');</script>");
	        response.sendRedirect("contestBoard.jsp"); 
	    } else { 
	        out.println("<script>alert('글 작성 실패');</script>");
	        out.flush();
	    }
    } catch (Exception e) {
        out.println("<script>alert('글 작성 중 오류 발생: " + e.getMessage() + "');</script>");
        out.flush();
        e.printStackTrace();
    }
    
    
	%>
</body>
</html>