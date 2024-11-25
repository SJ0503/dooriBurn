<%@page import="dooriburn.com.model.RanKingDTO"%>
<%@page import="dooriburn.com.model.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dooriburn.com.model.RankingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Realindex</title>

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

<!-- CSS 파일 연결 -->
<link rel="stylesheet" href="css/Realstyle.css">

<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
   crossorigin="anonymous">


<style type="text/css"></style>

<style>
.main-content {
   background-color: #f8f1dc;
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

footer {
   margin-bottom: 50px;
}

footer div {
   display: block !important;
   width: 100%;
   text-align: center;
   margin-bottom: 10px;
}

@media ( max-width : 600px) {
   footer div {
      margin-bottom: 100px !important;
   }
}

.carousel-caption {
   position: absolute;
   right: 25%;
   bottom: 20px;
   left: 25%;
   z-index: 1;
   padding-top: 20px;
   padding-bottom: 20px;
   color: #fff;
   text-align: center;
   text-shadow: 0 1px 2px rgba(0, 0, 0, 0.6); /* 수정: 올바른 쉼표 사용 */
}

.carousel-item .carousel-caption {
   color: #666 !important;
   text-shadow: none !important;
   right: 0 !important;
   left: 35.4% !important;
   width: 100px;
}

.carousel-item img {
   width: 600px; /* 원하는 너비 */
   height: 200px; /* 원하는 높이 */
   object-fit: cover; /* 이미지를 비율에 맞게 자르기 */
}

.rank-text {
   width: 75%;
}

@media (max-width: 768px) {
    .search-container {
        width: 65%;
        height: auto;
        flex-direction: row;
        padding: 10px;
    }

/* 
.d-none {
   display: none;
} */
</style>
</head>
<body>


   <%
   MemberDTO info = (MemberDTO) session.getAttribute("info");
   // 랭킹 불러오기
   ArrayList<RanKingDTO> ranking = new RankingDAO().Ranking();
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

   <div class="main-content">
      <form action="SearchService" method="get">
         <div class="search-container" style="height: 50px;">
            <select name="s_option" style="margin-right: 7px;font-size: 13px;">
               <!-- name="category" -> s_option -->
               <option value="0">드라마</option>
               <option value="1">장소</option>
               <option value="2">지역</option>
            </select> <input name="search" type="text" placeholder="검색"
               style="flex-grow: 1; margin-right: 5px; font-size: 18px;">
            <button type="submit">
               <img src="images/search.png" style="width: 40px; height: 40px;" />
            </button>
            <input name="pageNum" value="1" style="display: none">
         </div>
      </form>
      

      <div class="ranking">
         <div class="rank-item">
            <div class="rank-num">1</div>
            <div class="rank-text"
               onclick="location.href='detail.jsp?index=<%=ranking.get(0).getF_num()%>'">
               <%=ranking.get(0).getDrama()%>-<%=ranking.get(0).getF_name()%>
            </div>
         </div>
         <div class="rank-item">
            <div class="rank-num">2</div>
            <div class="rank-text"
               onclick="location.href='detail.jsp?index=<%=ranking.get(1).getF_num()%>'">
               <%=ranking.get(1).getDrama()%>-<%=ranking.get(1).getF_name()%>
            </div>
         </div>
         <div class="rank-item">
            <div class="rank-num">3</div>
            <div class="rank-text"
               onclick="location.href='detail.jsp?index=<%=ranking.get(2).getF_num()%>'">
               <%=ranking.get(2).getDrama()%>-<%=ranking.get(2).getF_name()%>
            </div>
         </div>
         <div class="rank-item">
            <div class="rank-num">4</div>
            <div class="rank-text"
               onclick="location.href='detail.jsp?index=<%=ranking.get(3).getF_num()%>'">
               <%=ranking.get(3).getDrama()%>-<%=ranking.get(3).getF_name()%>
            </div>
         </div>
         <div class="rank-item">
            <div class="rank-num">5</div>
            <div class="rank-text"
               onclick="location.href='detail.jsp?index=<%=ranking.get(4).getF_num()%>'">
               <%=ranking.get(4).getDrama()%>-<%=ranking.get(4).getF_name()%>
            </div>
         </div>
      </div>
   


<div class="intro">
         <h2 class="highlight">그 해 우리는 그 장소!</h2>
         <h2 class="highlight">나도 가 볼까?</h2>


         <div id="carouselExampleCaptions" class="carousel slide"
            data-bs-ride="carousel">
            <div class="carousel-indicators" style="z-index: 1;">
               <button type="button" data-bs-target="#carouselExampleCaptions"
                  data-bs-slide-to="0" class="active" aria-current="true"
                  aria-label="Slide 1"></button>
               <button type="button" data-bs-target="#carouselExampleCaptions"
                  data-bs-slide-to="1" aria-label="Slide 2"></button>
               <button type="button" data-bs-target="#carouselExampleCaptions"
                  data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>

            <div class="carousel-inner">
               <div class="carousel-item active">
                  <a href="detail.jsp?index=712"> <img
                     src="images/lotteworld.png" class="d-block w-100" alt="...">
                  </a>
                  <div class="carousel-caption d-block">
                     <!-- <h4 style="color: white;">롯데월드</h4> -->
                  </div>
               </div>
               <div class="carousel-item">
                  <a href="detail.jsp?index=698"> <img src="images/musiclib.png"
                     class="d-block w-100" alt="...">
                  </a>
                  <div class="carousel-caption d-block">
                     <!-- <h6 style="color: white;">의정부음악도서관</h6> -->
                  </div>
               </div>
               <div class="carousel-item">
                  <a href="detail.jsp?index=714"> <img src="images/sbridge.png"
                     class="d-block w-100" alt="...">
                  </a>
                  <div class="carousel-caption d-block">
                     <!-- <h4 style="color: white;">서강대교</h4> -->
                  </div>
               </div>
            </div>


            <button class="carousel-control-prev" type="button"
               data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
               <span class="carousel-control-prev-icon" aria-hidden="true"></span>
               <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button"
               data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
               <span class="carousel-control-next-icon" aria-hidden="true"></span>
               <span class="visually-hidden">Next</span>
            </button>
         </div>
      </div>
   </div>

   <footer>
      <div
         style="display: block !important; width: 100%; text-align: center; margin-bottom: 10px;">
         <%
         if (info == null) {
         %>
         <button class="btn" onclick="location.href='login.jsp'">로그인</button>
         <button class="btn" onclick="location.href='join.jsp'">회원가입</button>
         <%
         } else {
         %>
         <button class="btn" onclick="location.href='LogoutService'">로그아웃</button>
         <%
         }
         %>
         <button class="btn">한국어</button>
         <button class="btn">English</button>
      </div>
   </footer>
   <!-- Side navigation script -->
   <script>
      var myCarousel = document.querySelector('#myCarousel')
      var carousel = new bootstrap.Carousel(myCarousel)

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

   <!-- JavaScript 파일 연결 -->
   <!-- 여기서는 없어도 되긴 함 detail에서 먼저 js 만들고 여기도 연결해 봄 -->
   <!-- <script src="js/menu.js"></script> -->
   <script
      src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
