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
<title>contestUpdateAction.jsp</title>
</head>
<body>

<!-- 공모전 게시글 수정 action --> 
	<%
	request.setCharacterEncoding("UTF-8");
	
	int maxFileSize = 1024 * 1024 * 1024;
	String path = request.getRealPath("boardImg");
	
	try { 
	    MultipartRequest multi = new MultipartRequest(request, path, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
	     
	    int c_num = Integer.parseInt(multi.getParameter("c_num"));  
	    
	    String title = multi.getParameter("contestTitle");  
	    String img = multi.getFilesystemName("contestImg");  
	    String content = multi.getParameter("contestContent"); 
	    
	    ContestDTO dto = new ContestDTO(c_num, title, img, content); // 수정된 정보로 DTO 생성
	    ContestDAO dao = new ContestDAO();  
	    
	    int cnt = dao.contestUpdate(dto); // DAO를 통해 수정 메서드 호출
	    
	    if (cnt > 0) { 
	        out.println("<script>alert('게시글 수정 성공');</script>");
	        response.sendRedirect("contestView.jsp?c_num=" + c_num);  
	        
	        // 콘솔 확인용
	        out.println(title);
	        out.println(img);
	        out.println(content);
	    } else { 
	        out.println("<script>alert('게시글 수정 실패');</script>");
	        out.flush();
	    }
	} catch (Exception e) {
	    out.println("<script>alert('게시글 수정 중 오류 발생: " + e.getMessage() + "');</script>");
	    out.flush();
	    e.printStackTrace();
	}
	
	%>
</body>
</html>
