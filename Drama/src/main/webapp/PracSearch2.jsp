<%@page import="dooriburn.com.model.DramaSearchDTO"%>
<%@page import="dooriburn.com.model.DramaSearchDAO"%>
<%@page import="dooriburn.com.model.FilmLikeDTO"%>
<%@page import="dooriburn.com.model.FilmLikeDAO"%>
<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dooriburn.com.model.MemberDTO"%>

<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PracSearch</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=Work+Sans:400,300,600,400italic,700"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Playfair+Display:400,700"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/PracSearch.css">
<style>
.box .image img {
	width: 150px;
	height: 150px;
	object-fit: cover;
	margin: 0;
	display: block;
	margin-left: 10px;
	border-radius: 7px;
}

.star-button {
	background: none;
	border: none;
	font-size: 24px;
	cursor: pointer;
	color: black;
	margin-bottom: 170px;
}

.star-button.liked {
	color: gold;
}

.star-button:focus {
	outline: none;
}

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

#page_control {
    text-align: center; /* 가운데 정렬 */
    margin-top: 8px; /* 상단 여백 추가 */
    margin-bottom: 100px !important;
}

#page_control a {
    display: inline-block; /* 인라인 블록 요소로 설정하여 한 줄에 나열되도록 함 */
    padding: 3px 8px; /* 버튼의 패딩 설정 */
    margin: 0 3px; /* 버튼 사이의 간격 설정 */
    text-decoration: none; /* 링크에 밑줄 제거 */
    border: 1px solid #FFEEB9; /* 테두리 추가 */
    /*background-color: #f0f0f0;*/ /* 배경색 설정 */
    color: #333; /* 글자색 설정 */
    background-color: #FFEEB9;
}

#page_control a:hover {
    background-color: #FBE090; /* 호버 시 배경색 변경 */
}

#page_control a:active {
    background-color: #ffd964; /* 클릭 시 배경색 변경 */
}

#page_control .current {
    font-weight: bold; /* 현재 페이지 버튼의 글씨를 두껍게 설정 */
}

@media screen and (max-width: 768px) { 
	#page_control {
        margin-bottom: 100px !important; 
    } 
    #page_control a:hover {
        background-color: #FBE090; 
    }
    #page_control a:focus {
        background-color: #ffd964;  
    }
@media (max-width: 768px) {
    .search-container {
        width: 60%;
        height: auto;
        flex-direction: row;
        padding: 10px;
    }
</style>
</head>
<body>
	<%
	MemberDTO info = (MemberDTO) session.getAttribute("info");
	FilmLikeDAO dao = new FilmLikeDAO();

	String exUrl = "SearchService?s_option=2&pageNum=1&search=";


	String s_option = request.getParameter("s_option");
	String search = request.getParameter("search");

	int cnt = (Integer) request.getAttribute("cnt");
	int pageNum = (Integer) request.getAttribute("pageNum");
	int pageSize = (Integer) request.getAttribute("pageSize");

	ArrayList<String> titles = (ArrayList<String>) request.getAttribute("titles");
	ArrayList<String> places = (ArrayList<String>) request.getAttribute("places");
	ArrayList<String> img_src = (ArrayList<String>) request.getAttribute("img_src");
	ArrayList<String> scene = (ArrayList<String>) request.getAttribute("scene");
	ArrayList<Integer> index = (ArrayList<Integer>) request.getAttribute("index");
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

	<div class="main-content">
		<form action="SearchService" method="get">
			<div class="search-container" style="height: 30px;">
				<select name="s_option" style="margin-right: 7px;">
					<option value="0" <%="0".equals(s_option) ? "selected" : ""%>>드라마</option>
					<option value="1" <%="1".equals(s_option) ? "selected" : ""%>>장소</option>
						<option value="2" <%="2".equals(s_option) ? "selected" : ""%>>지역</option>
				</select> <input name="search" type="text" placeholder="검색"
					value="<%=search != null ? search : ""%>"
					style="flex-grow: 1; margin-right: 5px;">
					<input name="pageNum" value="1" style="display: none">
				<button type="submit">
					<img src="<%=request.getContextPath()%>/images/search.png" alt="검색"
						style="width: 40px; height: 40px;" />
				</button>
			</div>
		</form>
	</div>

	<%
	if(index!=null){
	for (int i = 0; i < index.size(); i++) {
		String seen = scene.get(i).length() > 50 ? scene.get(i).substring(0, 40) + "..." : scene.get(i);
	%>
	<div class="box">
		<div class="image"
			onclick="goToAddress(event, '<%=request.getContextPath()%>/detail.jsp?index=<%=index.get(i) + 1%>')">
			<img src="<%=img_src.get(i)%>" alt="이미지"
				onerror="handleImageError(this)">
		</div>
		<div class="content"
			onclick="goToAddress(event, '<%=request.getContextPath()%>/detail.jsp?index=<%=index.get(i) + 1%>')">
			<h2 style="font-weight: bold;"><%=places.get(i)%></h2>
			<h3><%=titles.get(i)%></h3>
			<p><%=seen%></p>
		</div>

		<%
		if (info == null) {
		%>
		<button class="star-button"
			onclick="handleLikeClick(<%=index.get(i) + 1%>, '', this)">☆</button>
		<%
		} else {
		FilmLikeDTO dto = new FilmLikeDTO(info.getEmail(), index.get(i) + 1);
		if (dao.isLiked(dto)) {
		%>
		<button class="star-button"
			onclick="handleLikeClick(<%=index.get(i) + 1%>, '<%=info.getEmail()%>', this)">★</button>
		<%
		} else {
		%>
		<button class="star-button"
			onclick="handleLikeClick(<%=index.get(i) + 1%>, '<%=info.getEmail()%>', this)">☆</button>
		<%
		}
		}
		%>
	</div>
	<%
	}}else{
	%>

	<div class="banner" style="height:20px; font-size:x-large;">'<%=search %>' 에 대한</div><br>
	<div class="banner" style="height:20px; font-size:x-large;">검색결과가 없습니다.</div>
	<% } %>
	<!-- 페이징 처리 -->
	<div id="page_control">
		<%
		if (cnt != 0) {
			int pageCount = cnt / pageSize + (cnt % pageSize == 0 ? 0 : 1);
			int pageBlock = 5;
			int startPage = ((pageNum - 1) / pageBlock) * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) {
				endPage = pageCount;
			}
			if (startPage > pageBlock) {
		%>
		<a
			href="SearchService?s_option=<%=s_option%>&search=<%=search%>&pageNum=<%=startPage - pageBlock%>">◀</a>
		<%
		}
		for (int i = startPage; i <= endPage; i++) {
		%>
		<a
			href="SearchService?s_option=<%=s_option%>&search=<%=search%>&pageNum=<%=i%>"><%=i%></a>
		<%
		}
		if (endPage < pageCount) {
		%>
		<a
			href="SearchService?s_option=<%=s_option%>&search=<%=search%>&pageNum=<%=startPage + pageBlock%>">▶</a>
		<%
		}
		}
		%>
	</div>
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
	<script>  
        function goToAddress(event, url) {
            event.stopPropagation();
            location.href = url;
        }

        function handleLikeClick(filmId, email, button) {
            if (!email) {
                alert("로그인이 필요합니다.");
                return;
            }
            $.ajax({
                type: 'POST',
                url: '<%=request.getContextPath()%>/FilmLikeService',
                data: { 
                    f_num: filmId,
                    email: email
                },
                success: function(response) {
                    console.log('좋아요 처리 성공:', response);
                    if (button.textContent === '★'){
                        button.textContent = '☆';
                        button.classList.remove('liked');
                    } else {
                        button.textContent = '★';
                        button.classList.add('liked');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('좋아요 처리 오류:', error);
                }
            });
        }

        function handleImageError(img) {
            img.onerror = null; // 무한 루프 방지
            img.src = '<%=request.getContextPath()%>/images/no-image.png';
        }
    </script>
</body>
</html>
