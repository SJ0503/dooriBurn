<%@page import="java.util.ArrayList"%>
<%@page import="dooriburn.com.model.ContestDAO"%>
<%@page import="dooriburn.com.model.ContestDTO"%>
<%@page import="dooriburn.com.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>contestList</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Free HTML5 Website Template by FreeHTML5.co" />
<!-- realindex에서 가져온 것들 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<!-- Realstyle.css를 가장 먼저 연결 -->
<link rel="stylesheet" href="css/Realstyle.css">
<!-- 나머지 CSS 파일들 -->
<link rel="stylesheet" href="css/other-style1.css">
<link rel="stylesheet" href="css/other-style2.css">

<link
	href='https://fonts.googleapis.com/css?family=Work+Sans:400,300,600,400italic,700'
	rel='stylesheet' type='text/css'>
<link
	href="https://fonts.googleapis.com/css?family=Playfair+Display:400,700"
	rel="stylesheet">
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

.grid-container {
	display: grid;
	place-items: center; /* 요소를 수평 및 수직 중앙 정렬 */
}

/* 최소 높이 설정 */
.contest-list-container {
	min-height: 400px; /* 필요에 따라 조정 가능 */
	padding-bottom: 20px;
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
			<%
			if (info != null) {
			%>
			<h1>
				<b><%=info.getNick()%></b> 님 환영합니다
			</h1>
			<%
			} else {
			%>
			<h1>
				<b>로그인</b>을 해주세요
			</h1>
			<%
			}
			%>
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

			<%
			if (info.getEmail().equals("admin@gmail.com")) {
			%>
			<div class="menu-section">
				<h2>
					<a href="memberList.jsp"
						style="color: black; text-decoration-line: none;">관리자 회원관리</a>
				</h2>
			</div>

			<%
			}
			%>

			<div class="menu-section">
				<h2>
					<a href="LogoutService"
						style="color: black; text-decoration-line: none;">로그아웃</a>
				</h2>
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


	<!-- 공모전 목록 -->
	<div style="clear: both; text-align: center; margin-top: 50px;">
		<br>
		<h3 style="display: inline-block;">관광사진 공모전 참가내역</h3>
	</div>
	<div class="container contest-list-container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<%
				ContestDAO dao = new ContestDAO();
				if (info != null) {
					ArrayList<ContestDTO> contests = dao.getContestsByUserComments(info.getEmail());
					if (contests == null || contests.size() == 0) {
				%>
				<p>참가한 공모전이 없습니다</p>
				<%
				} else {
				%>

				<thead>
					<tr style="background-color: #eeeeee; clear: both;">
						<th style="white-space: nowrap;">번호</th>
						<th style="text-align: center;">제목</th>
						<th style="text-align: center;">공모일</th>
					</tr>
				</thead>
				<tbody style="background-color: #f9f9f9;">
					<%
					for (ContestDTO contest : contests) {
					%>
					<tr>
						<td><%=contest.getC_num()%></td>
						<td><a style="color: #000"
							href="contestView.jsp?c_num=<%=contest.getC_num()%>"><%=contest.getC_title()%></a></td>
						<td><%=contest.getC_create_date()%> ~ <%=contest.getC_delete_date()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<%
			}
			} else {
			%>
			<p style="text-align: center;">참가한 공모전이 없습니다</p>
			<%
			}
			%>
		</div>
	</div>

	<footer id="fh5co-footer" role="contentinfo">
		<div class="button-container">
			<div>
				<%
				if (info == null) {
				%>
				<button class="btn"
					onclick="location.href='login.jsp?from=/Drama/contestList.jsp'">로그인</button>
				<button class="btn"
					onclick="location.href='join.jsp?from=/Drama/contestList.jsp'">회원가입</button>
				<%
				} else {
				%>
				<button class="btn"
					onclick="location.href='LogoutService?from=/Drama/contestList.jsp'">로그아웃</button>
				<%
				}
				%>
				<button class="btn">한국어</button>
				<button class="btn">English</button>
			</div>
		</div>
		<div class="container">
			<div class="row copyright">
				<div class="col-md-12 text-center">
					<p>
						<small class="block">&copy; 2024 DOORIBURN. All Rights
							Reserved.</small> <small class="block">Designed by DOORIBURN</small>
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