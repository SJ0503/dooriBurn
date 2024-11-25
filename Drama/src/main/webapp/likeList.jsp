<%@page import="dooriburn.com.model.DramaSearchDAO"%>
<%@page import="dooriburn.com.model.DramaSearchDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dooriburn.com.model.MemberDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>좋아요 누른 촬영지 목록</title>

<!-- 폰트 -->
<link
   href="https://fonts.googleapis.com/css?family=Work+Sans:400,300,600,400italic,700"
   rel="stylesheet" type="text/css">
<link
   href="https://fonts.googleapis.com/css?family=Playfair+Display:400,700"
   rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
   href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap"
   rel="stylesheet">

<link rel="stylesheet" href="css/Realstyle.css">
<style type="text/css"></style>
<style>
body {
   background-color: #f4f4f9;
}

/* 메뉴 위치 우상단으로 조정 */
.menu-icon {
   position: absolute;
   top: 10px;
   right: 20px;
   cursor: pointer;
   color: #545454;
}

/* 추가: 마이 페이지 하위 목록 세로 정렬을 위해 */
.sidenav .menu-itemss a:hover {
   color: #333;
   font-weight: bold !important;
}

.sidenav .menu-items a:hover {
   font-weight: bold !important;
}

h1 {
   text-align: center;
   color: #333;
   margin-top: 50px;
}

a {
   text-decoration: none;
   color: #333;
}

a.custom-link {
   display: block;
   padding: 10px;
   background: #fff;
   border-radius: 5px;
   margin: 10px auto;
   width: 50%; /* 80%; */
   /* max-width: 800px; */
   box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
   transition: background-color 0.3s, box-shadow 0.3s;
}

a.custom-link:hover {
   background-color: #f4f4f9;
   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.custom-link h2 {
   font-weight: bold;
   text-align: left;
   margin: 0;
   width: 100%;
}

.custom-link h3 {
   margin-left: 30px;
}

@media ( max-width : 768px) {
   a.custom-link {
      width: 80%; /* 7.31 크기 늘리기 */
      padding-left: 0px;
      padding-top: 25px;
   }
   .custom-link h2, .custom-link h3 {
      font-size: 16px;
      margin-left: 20px;
   }
   .sidenav {
      width: 50%;
   }
}
</style>

</head>
<body>

	<%
	MemberDTO info = (MemberDTO) session.getAttribute("info");
	String exUrl = "SearchService?s_option=2&pageNum=1&search=";
	%>
	<header>
		<div class="banner" onclick="redirectToPage()">여기가 거기여?</div>
		<div class="menu-icon" onclick="openNav()">☰</div>
	</header>


   <div id="mySidenav" class="sidenav" style="width: 0;">
      <a href="javascript:void(0)" class="closebtn" onclick="closeNav()"
         style="color: #545454;">&times;</a>
      <div class="menu-section">
            <%if(info !=null) {%>
      	<h1><b><%=info.getNick() %></b> 님 환영합니다</h1>
      <%}else{%>
      <h1><b>로그인</b>을 해주세요</h1>
      <%}%>
      <br>
         <h2>지역별로 찾기</h2>
         <div class="menu-items">
            <a href="<%=exUrl%>서울">서울</a> <a href="<%=exUrl%>부산">부산</a> <a
               href="<%=exUrl%>인천">인천</a> <a href="<%=exUrl%>대구">대구</a> <a
               href="<%=exUrl%>대전">대전</a> <a href="<%=exUrl%>광주">광주</a> <a
               href="<%=exUrl%>울산">울산</a> <a href="<%=exUrl%>세종">세종</a> <a
               href="<%=exUrl%>경기">경기</a> <a href="<%=exUrl%>충청북도">충북</a> <a
               href="<%=exUrl%>충청남도">충남</a> <a href="<%=exUrl%>전라북도">전북</a> <a
               href="<%=exUrl%>전라남도">전남</a> <a href="<%=exUrl%>경상북도">경북</a> <a
               href="<%=exUrl%>경상남도">경남</a> <a href="<%=exUrl%>강원">강원</a> <a
               href="<%=exUrl%>제주">제주</a> <a href="#"> </a>
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

   <div class="banner-likelist" style="text-align: center; margin-bottom: -50px;">
      <h2 style="font-weight: 800;">관심 촬영지</h2>
   </div>

   <!-- 즐겨찾기 목록 -->
   <%
   DramaSearchDAO dao = new DramaSearchDAO();
   if (info != null) {
      List<DramaSearchDTO> likes = dao.getLikes(info.getEmail());
      if (likes == null || likes.size() == 0) {
   %>
   <h1>좋아요 목록이 없습니다.</h1>
   <%
   } else {
   %>
   <br>
   <br>
   <%
   for (DramaSearchDTO like : likes) {
   %>

   <a class="custom-link"
      href="detail.jsp?index=<%=String.format("%.0f", like.getFNum())%>">
      <h2>
         📍
         <%=like.getFName()%>
      </h2>
      <h3><%=like.getDrama()%></h3>
   </a>
   <br>

   <%
   }
   %>


   <%
   }
   %>
   <%
   }
   %>


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

</body>
</html>
