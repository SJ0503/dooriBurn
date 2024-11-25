<%@page import="dooriburn.com.model.MemberDAO"%>
<%@page import="dooriburn.com.model.MemberDTO"%>
<%@page import="dooriburn.com.model.ContestDAO"%>
<%@page import="dooriburn.com.model.ContestDTO"%> 
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML>
<html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>memberList</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Website Template by FreeHTML5.co" /> 
	
	<!-- realindex에서 가져온 것들 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" >
 	<!-- 폰트 -->
	<link href="https://fonts.googleapis.com/css?family=Work+Sans:400,300,600,400italic,700" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,700" rel="stylesheet">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet"> 
	<!-- Realstyle.css를 가장 먼저 연결 -->
	<link rel="stylesheet" href="css/Realstyle.css"> 
	<!-- 나머지 CSS 파일들 -->
	<link rel="stylesheet" href="css/other-style1.css">
	<link rel="stylesheet" href="css/other-style2.css">
	  
	<link href='https://fonts.googleapis.com/css?family=Work+Sans:400,300,600,400italic,700' rel='stylesheet' type='text/css'>
	<link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,700" rel="stylesheet">  
	<link rel="stylesheet" href="css/animate.css"> 
	<link rel="stylesheet" href="css/icomoon.css"> 
	<link rel="stylesheet" href="css/bootstrap.css"> 
	<link rel="stylesheet" href="css/style2.css"> 
	<script src="js/modernizr-2.6.2.min.js"></script> 

	<style> 
	 /* 메뉴 위치 우상단으로 조정 */
	.menu-icon {
		position: absolute;
		top: 10px;
		right: 20px;
		cursor: pointer;
		color: #545454;
	}
	.sidenav .menu-items a:hover {
	    font-weight: bold !important;
	}
	/* 버튼과 저작권 정보 사이에 여백 추가, 중간배열 */
	.button-container {
	    margin-bottom: 20px; 
		display: flex; 
		justify-content: center;
	}
	</style> 

	</head>  
	<body>
		<%    
		MemberDTO info = (MemberDTO) session.getAttribute("info"); 
		MemberDAO m_dao = new MemberDAO();
		// 게시판 DB에 있는 글 개수 확인
		int cnt = m_dao.getCount();
		// 페이징 처리 ////////////////////////////////////////////////////////////// 
		
		int pageSize = 10; // 한 페이지에 출력될 글 수 
		 
		int pageNum = 1; // 현 페이지 정보 설정
		if (request.getParameter("pageNum") != null){
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}  
		
		int startRow = (pageNum - 1) * pageSize + 1;  // 첫행번호를 계산 
		
		// 게시글 목록 가져오기
		// 회원 목록 가져오기
		ArrayList<MemberDTO> m_list = m_dao.getMemberList(startRow, pageSize);
		
		String exUrl = "SearchService?s_option=2&pageNum=1&search=";
	%>	
	<header>
		<div class="banner" onclick="redirectToPage()">여기가 거기여?</div>
		<div class="menu-icon" onclick="openNav()">☰</div>
	</header>

	<div id="mySidenav" class="sidenav" style="width: 0;">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()" style="color:#545454;">&times;</a>
			<div class="menu-section">
			      <%if(info !=null) {%>
      	<h1><b><%=info.getNick() %></b> 님 환영합니다</h1>
      <%}else{%>
      <h1><b>로그인</b>을 해주세요</h1>
      <%}%>
      <br>
				<h2>지역별로 찾기</h2>
				<div class="menu-items">
					<a href="<%=exUrl%>서울">서울</a> <a href="<%=exUrl%>부산">부산</a>
					<a href="<%=exUrl%>인천">인천</a> <a href="<%=exUrl%>대구">대구</a>
					<a href="<%=exUrl%>대전">대전</a> <a href="<%=exUrl%>광주">광주</a>
					<a href="<%=exUrl%>울산">울산</a> <a href="<%=exUrl%>세종">세종</a>
					<a href="<%=exUrl%>경기">경기</a> <a href="<%=exUrl%>충청북도">충북</a>
					<a href="<%=exUrl%>충청남도">충남</a> <a href="<%=exUrl%>전라북도">전북</a>
					<a href="<%=exUrl%>전라남도">전남</a> <a href="<%=exUrl%>경상북도">경북</a>
					<a href="<%=exUrl%>경상남도">경남</a> <a href="<%=exUrl%>강원">강원</a>
					<a href="<%=exUrl%>제주">제주</a> <a href="#"> </a>
				</div>
			</div>
			<div class="menu-section">
				<h2>여행사진 공모전</h2>
				<div class="menu-items">
					<a href="contestBoard.jsp">참가하기</a>
				</div>
			</div>
			<%
      if (info != null) {
      %>
      <div class="menu-section">
         <h2>마이 페이지</h2>
         <div class="menu-itemss">
         
            <a href="update.jsp">회원정보 수정</a> <a href="likeList.jsp">관심 촬영지</a> <a
               href="contestList.jsp">공모전 참가내역</a>
         </div>
         
         <% if (info.getEmail().equals("admin@gmail.com")) {%>
         <div class="menu-section">
         <h2> <a href="memberList.jsp" style="color: black;  text-decoration-line: none;">관리자 회원관리</a></h2>
         </div>
         
         <%} %>
         
         <div class="menu-section">
         	<h2 > <a href="LogoutService" style="color: black;  text-decoration-line: none;">로그아웃</a></h2>
            </div>
         <%
         } else {
         %>
         <div class="menu-section">
            <h2>마이 페이지</h2>
            <div class="menu-itemss">
               <a href="login.jsp">로그인</a> <a href="join.jsp">회원가입</a>
            </div>
         </div>
          
         </div>
         <%
         }
         %>
		</div>
	</div>
 	<header id="fh5co-header" class="fh5co-cover" style="height: 50px;"> 
		<div class="overlay"></div>
		<div class="container"></div>
	</header>
	
	
	
 	<div style="clear: both; text-align: center; margin-top: 20px;"> 
 	<br>
 		<h3 style="display: inline-block;">회원관리</h3>
 		<h5>총 회원수 : <%=cnt %> </h5>
 	</div>
 	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
				<thead>
					<tr style="background-color: #eeeeee; clear: both;">
						<th style="text-align: center;">이메일</th> 
						<th style="text-align: center;">이름</th>
						<th style="text-align: center;">닉네임</th>
						<th style="text-align: center;">회원삭제</th>
						 
					</tr>
				</thead>
				<tbody>
					<% for (MemberDTO dto : m_list) { %>
						<tr>
							<td><%= dto.getEmail()%></td>
							<td><%= dto.getName() %></td>
							<td><%= dto.getNick() %></td>
							<td><a href="DeleteMemberService?email=<%=dto.getEmail() %>" style="color: black;  text-decoration-line: none;">X</a></td>
					 	</tr>
					<% } %> 
				</tbody>
			</table>  
		</div> 
		
	</div>
	<!-- 페이징 처리 -->
	<div id="page_control">
		<% if(cnt != 0){  
			// 전체 페이지수 계산
			int pageCount = cnt / pageSize + (cnt%pageSize==0?0:1);
			
			// 한 페이지에 보여줄 페이지 블럭
			int pageBlock = 5;
			 
			int startPage = ((pageNum-1)/pageBlock)*pageBlock+1;
			 
			int endPage = startPage + pageBlock-1;
			if(endPage > pageCount){
				endPage = pageCount;
			}
			if(startPage > pageBlock) { %>
				<a href="memberList.jsp?pageNum=<%=startPage - pageBlock%>">◀</a>
			<%} %>
		    
			<% for(int i=startPage ; i <= endPage ; i++) { %>
				<a href="memberList.jsp?pageNum=<%=i%>"><%=i %></a>
			<%} %>
		    
			<% if(endPage < pageCount){ %>
				<a href="memberList.jsp?pageNum=<%=startPage + pageBlock%>">▶</a>
			<%} %>
		<%} %>
	</div>

 
 	<footer id="fh5co-footer" role="contentinfo"> 
 			<div class="button-container">
			   	<div>    
					<%if(info == null) {%>
						<button class="btn" onclick="location.href='login.jsp?from=/Drama/contestBoard.jsp'">로그인</button>
						<button class="btn" onclick="location.href='join.jsp?from=/Drama/contestBoard.jsp'">회원가입</button>
					<%} else { %>
						<button class="btn" onclick="location.href='LogoutService?from=/Drama/contestBoard.jsp'">로그아웃</button>
					<%} %>
						<button class="btn">한국어</button>
						<button class="btn">English</button>   
				</div>
			</div>				
		<div class="container">
			<div class="row copyright"> 
				<div class="col-md-12 text-center">
					<p>
						<small class="block">&copy; 2024 DOORIBURN. All Rights Reserved.</small> 
						<small class="block">Designed by DOORIBURN</small>
					</p>
 				</div>  
			</div>
		</div> 
	</footer>
 
	
	<!-- Side navigation script -->
	<script>  
	    function redirectToPage() {
	        window.location.href = 'Realindex.jsp';
	    }
		function openNav() {
			document.getElementById("mySidenav").style.width = "80%";
		}

		function closeNav() {
			document.getElementById("mySidenav").style.width = "0";
		}
	</script>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://bootstrap.js"></script> 
	<script src="js/jquery.min.js"></script> 
	<script src="js/jquery.easing.1.3.js"></script> 
	<script src="js/bootstrap.min.js"></script> 
	<script src="js/jquery.waypoints.min.js"></script> 
	<script src="js/main.js"></script>

	</body>
</html>
