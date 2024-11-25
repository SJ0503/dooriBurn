<%@page import="dooriburn.com.model.ReviewDTO"%>
<%@page import="dooriburn.com.model.ReviewDAO"%>
<%@page import="dooriburn.com.model.RankingDAO"%>
<%@page import="dooriburn.com.model.DramaSearchDTO"%>
<%@page import="dooriburn.com.model.DramaSearchDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dooriburn.com.model.ContestDTO"%>
<%@page import="dooriburn.com.model.ContestDAO"%>
<%@page import="dooriburn.com.model.MemberDTO"%>
<%@page import="dooriburn.com.model.FilmLikeDAO"%>
<%@page import="dooriburn.com.model.FilmLikeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Detail</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- jQuery 라이브러리 추가 -->
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- 카카오 맵 API 스크립트 -->


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
<link rel="stylesheet" href="css/detail.css">
<link rel="stylesheet" href="css/Realstyle.css">
<!-- <link rel="stylesheet" href="style.css/rivew.css">
 -->
<!-- 카카오 맵 API 스크립트 찾아서 연결해야 함!! -->
<style>
/* 배경 및 팝업 스타일 */
.background, .backgroundpop {
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 100vh;
   background-color: rgba(0, 0, 0, 0.3);
   z-index: 1000;
   display: none; /* 숨기기 */
}

.show {
   display: block; /* 보이기 */
   transition: all .5s;
}

.window, .windowpop {
   position: relative;
   width: 100%;
   height: 100%;
}

.popup {
   position: absolute;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
   background-color: #ffffff;
   box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);
   border-radius: 10px;
   width: 450px;
   height: 400px;
   transition: all .5s;  
}

/* 모바일 화면에 대한 스타일 */
@media (max-width: 768px) {
	.popup {
		width: 90%;
		max-width: 500px; /* 필요에 따라 최대 너비를 조정하세요 */
		height: 420px; /* 콘텐츠에 따라 높이를 조정합니다 */
		margin-bottom: 200px;
	}
}

/* 좋아요 버튼 스타일 */
.star-button {
   background: none;
}

.star-button {
   background: none;
   border: none;
   font-size: 24px;
   cursor: pointer;
   color: black;
   margin-left: 10px;
}

.star-button.liked {
   color: gold;
}

.star-button:focus {
   outline: none;
}

.place-container {
   display: flex;
   align-items: center;
}

.place-container h1 {
   margin: 0;
}

/* 리뷰 별점 스타일 */
.rating .filled {
   color: gold;
}

.rating .empty {
   color: transparent;
   -webkit-text-stroke: 1px gold;
   text-stroke: 1px gold;
}

/* 폼 스타일 */
#myform fieldset {
   display: inline-block;
   direction: rtl;
   border: 0;
}

#myform fieldset legend {
   text-align: right;
}

#myform input[type=radio] {
   display: none;
}

#myform label {
   font-size: 2em;
   color: transparent;
   text-shadow: 0 0 0 #f0f0f0;
}

#myform label:hover {
   text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

#myform label:hover ~ label {
   text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

#myform input[type=radio]:checked ~ label {
   text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

#reviewContents { 
    margin: 0 20px; 
    width: 90%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
    outline: none; /* 포커스 시 기본 윤곽선 제거 */
}

/* 포커스 상태에서 테두리 색상 변경 */
#reviewContents:focus {
    border-color: #FFA500; /* 주황색으로 테두리 색상 변경 */
}

   /* 메뉴 위치 우상단으로 조정 */ 
   . menu-icon { 
   position : absolute;
   top: 10px;
   right: 20px;
   cursor: pointer;
   color: #545454; 
}

.sidenav .menu-items a:hover {
   font-weight: bold !important; 
}


/* footer */
.footer {
	background-color: #efefef; 
}
#footerbutton {
	display: block !important; 
	width: 100%; 
	text-align: center;
	margin-top: 30px;  
	margin-bottom: 50px;
}
@media (max-width: 768px) {
	#footerbutton { 
		margin-top: 40px;
		margin-bottom: 140px;
	}
}

/* 드라마 제목 위에 여백 */
.text h1 {
    margin-top: 15px;  
    margin-bottom: 10px;  
}

.text p {
    margin: 0;  
}

#Post_a_review {
	    background-color: #FFEEB9 !important;  
	    border-color: #FFEEB9 !important;  
	    color: #000 !important;
		border: 1px solid; 
        border-radius: 25px; 
        box-shadow: none;
        padding: 8px 15px; 
        font-weight: 400; 
        font-size: 15px;
	}  
.review-btn {
		background-color: #FFEEB9 !important;  
	    border-color: #FFEEB9 !important;  
	    color: #000 !important;
		border: 1px solid; 
        border-radius: 25px; 
        box-shadow: none;
        padding: 8px 15px;
	}
#closepop { 
	margin: 5px 5px 0 0;
    background-color: #f9f9f9;
    border: none;  
    color: #000 !important;  
    border-radius: 10px;  
    padding: 5px 8px; 
    box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */ 
    cursor: pointer; /* 버튼처럼 보이게 하기 위해 포인터 커서 사용 */
    transition: box-shadow 0.3s ease; /* 호버 시 그림자 효과의 부드러운 전환 */
}

#closepop:hover {
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15); /* 호버 시 그림자 효과 변경 */
} 
	
/* CSS */
.rating-container {
    margin: 0; /* 전체 여백 제거 */
    padding: 0; /* 전체 여백 제거 */
}

.rating-header {
    margin-bottom: 10px; /* 별점 선택란과의 간격 조정 */
}

.text-bold {
    display: block; /* 블록 요소로 만들어 전체 너비를 차지하게 함 */
    text-align: left; /* 왼쪽 정렬 */
    margin: 5px;
    font-size: 20px;
    font-weight: 600;
    color: black;
}
 

.input_checkbox {
	margin: 0 10px 10px 10px; 
} 

        /* 숨길 checkbox 스타일 */
        .input_checkbox input[type="checkbox"] {
            display: none; /* 체크박스를 완전히 숨깁니다 */
        }

        /* label 스타일 */
        .input_checkbox .checkbox_wrapper {
            display: inline-block;
            margin: 4px; /* 각 체크박스와 라벨 간의 간격 */
        }

        .input_checkbox label {
            display: inline-block;  
            border: 1px solid #e9e9e9; /* 테두리 색상 */
            padding: 2px;
            border-radius: 5px;
            background-color: white; /* 배경 색상 */
            color: gray !important; /* 글자 색상 */
            font-weight: normal; /* 기본 글씨 두께 */
            font-size: 15px !important; /* 폰트 크기 조정 */
            box-shadow: 0 2px 3px rgba(0, 0, 0, 0.2); /* 기본 입체 효과 */
            cursor: pointer;
            transition: background-color 0.3s, box-shadow 0.3s, font-weight 0.3s; /* 부드러운 효과 */
        }

        /* 체크박스가 체크된 상태의 label 스타일 */
        .input_checkbox input[type="checkbox"]:checked + label {
            font-weight: 500; /* 체크된 상태에서 두꺼운 글씨 */
            box-shadow: 1px 3px 4px rgba(0, 0, 0, 0.2); /* 체크된 상태에서 강한 입체 효과 */
            color: black !important; 
			border: 1px solid lightgray; /* 테두리 색상 */
			background-color: #FFF183; /* 배경 색상 */ 
        }

        /* label의 hover 상태 */
        .input_checkbox label:hover {
            background-color: #B0B0B0; /* hover 시 배경 색상 */
            box-shadow: 0 3px 4px rgba(0, 0, 0, 0.1); /* hover 시 입체 효과 */
        }
</style>
</head>
<body>
   <%
   String index = request.getParameter("index");
   // 리뷰데이터뽑기
   ReviewDAO rv_dao = new ReviewDAO();
   ArrayList<ReviewDTO> rv_list = rv_dao.selectReview(index);

   DramaSearchDAO dao = new DramaSearchDAO();
   ArrayList<DramaSearchDTO> film_detail = dao.film_detail(index);
   FilmLikeDAO f_dao = new FilmLikeDAO();
   String drama = film_detail.get(0).getDrama();
   String place = film_detail.get(0).getFName();
   String addr = film_detail.get(0).getFAddr();
   double lat = film_detail.get(0).getLat();
   double lon = film_detail.get(0).getLon();
   String tel = film_detail.get(0).getScene();
   String time = film_detail.get(0).getFTel();
   String scene = film_detail.get(0).getFTime();
   String img_src = film_detail.get(0).getFimg();

   // 랭킹 누적하기
   RankingDAO rdao = new RankingDAO();
   rdao.Update(index);

   // 세션에서 사용자 정보 가져오기
   MemberDTO info = (MemberDTO) session.getAttribute("info");

	String exUrl = "SearchService?s_option=2&pageNum=1&search=";
   %>

   <!-- 배너 -->
   <header>
      <div class="banner" onclick="redirectToPage()">여기가 거기여?</div>
      <div class="menu-icon" onclick="openNav()">☰</div>
   </header>

   <!-- 메뉴 -->
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

   <!-- 상세 페이지 -->
   <!-- 추가 -->
   <div class="container">
      <header class="header">
         <img src="<%=img_src%>" alt="Aquarium" class="header-img">
      </header>
   </div>
   <section class="info">
      <div class="tags">

         <%
         ReviewDAO reviewdao = new ReviewDAO();
         ArrayList<String> mood = reviewdao.moodRanking(Integer.parseInt(index));
         for (int i = 0; i < mood.size(); i++) {
         %>
         <span>#<%=mood.get(i)%></span>
         <%
         }
         %>
      </div>
      <!-- 장소 이름과 좋아요 버튼을 감싸는 컨테이너 추가 -->
      <div class="place-container">
         <h1>
            <%=place%>
            <%
            // 촬영지 관심 등록 미등록
            if (info == null) {
            %>
            <button class="star-button"
               onclick="handleLikeClick(<%=index%>, '', this)">☆</button>
            <%
            } else {
            int n_index = Integer.parseInt(index);
            FilmLikeDTO dto = new FilmLikeDTO(info.getEmail(), n_index);

            if (f_dao.isLiked(dto)) {
            %>
            <button class="star-button"
               onclick="handleLikeClick(<%=index%>, '<%=info.getEmail()%>', this)">★</button>
            <%
            } else {
            %>
            <button class="star-button"
               onclick="handleLikeClick(<%=index%>, '<%=info.getEmail()%>', this)">☆</button>
            <%
            }
            }
            %>
         </h1>
      </div>
      <p class="address"><%=addr%></p>
      <p class="hours">
         영업시간:
         <%=scene%>
      </p>
      <p class="phone">
         전화번호:
         <%=time%>
      </p>



      <%-- <div class="tags">
         <div class="drama">
            <!-- 왼쪽 사진 -->
            <img src="images/drama_imagessss/<%=drama%>.jpg" alt="드라마 표지"
               class="image" style="width: 200px; height: 300px;">
            <!-- 오른쪽 텍스트 -->
            <div class="text">
               <h1><%=drama%></h1>
               <p><%=tel%></p>
            </div>
         </div>
      </div> --%>

      <%
      boolean isSpecialVideo712 = "712".equals(index);
      boolean isSpecialVideo714 = "714".equals(index);
      boolean isSpecialVideo698 = "698".equals(index);
      %>

      <div class="tags">
         <div class="drama">
            <!-- 왼쪽 사진 또는 동영상 -->
            <%
            if (isSpecialVideo712) {
            %>
            <iframe width="560" height="315"
               src="https://www.youtube.com/embed/-TlMJbalKS4?si=smqQ2Y8j9xM5SFmb"
               title="YouTube video player" frameborder="0"
               allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
               referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
            </iframe>
            <%
            } else if (isSpecialVideo714) {
            %>
            <iframe width="560" height="315"
               src="https://www.youtube.com/embed/rbB9Ejl5Xfg?si=TbuLdvtkXimc1QJL"
               title="YouTube video player" frameborder="0"
               allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
               referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
            </iframe>
            <%
            } else if (isSpecialVideo698) {
            %>
            <iframe width="560" height="315"
               src="https://www.youtube.com/embed/cy0oJypViEw?si=UbE2x0hkKe1e8vQm"
               title="YouTube video player" frameborder="0"
               allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
               referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
            <%
            } else {
            %>
            <img src="images/drama_imagessss/<%=drama%>.jpg" alt="드라마 표지"
               class="image" style="width: 43%; height: 90%;">
            <%
            }
            %>
            <!-- 오른쪽 텍스트 -->
            <div class="text">
               <h1><%=drama%></h1>
               <p><%=tel%></p>
            </div>
         </div>
      </div>




   </section>
   <!-- 여기까지 -->



   <div id="staticMap" style="width: 400 px; height: 400px;"></div>

   <!-- 리뷰 섹션 -->
   <div class="review">
      <div class="review-header">
         <h2 style="font-weight: bold;">Review</h2>
         <div>
            <%
            if (info == null) {
            %>
            <button class="review-btn" onclick="reviewLogin()">리뷰 작성하기</button>
            <%
            } else {
            %>
            <button class="review-btn" id="showpop" onclick="">리뷰 작성하기</button>
            <%
            }
            %>
            <div class="backgroundpop">
               <div class="windowpop">
                  <div class="popup">
                     <div align="right">
                        <button id="closepop">닫기</button>
                     </div>

                     <div style="margin: auto;">
                        <form class="mb-3" name="myform" id="myform" method="post"
                           action="ReviewUpdateService" onsubmit="return validateForm()">
                           <input type="text" name="index" style="display: none;"
                              value="<%=index%>">
                            <div class="rating-container">
	                           <fieldset>
	                           	<div>  
									<span class="text-bold">별점을 선택해주세요</span>
								</div> 
								<div class="rating-options">
		                              <input type="radio"  name="reviewStar" value="5" id="rate1">
		                              <label for="rate1">★</label> 
		                              <input type="radio" name="reviewStar" value="4" id="rate2">
		                              <label for="rate2">★</label> 
		                              <input type="radio" name="reviewStar" value="3" id="rate3">
		                              <label for="rate3">★</label>
		                              <input type="radio" name="reviewStar" value="2" id="rate4">
		                              <label for="rate4">★</label> 
		                              <input type="radio" name="reviewStar" value="1" id="rate5">
		                              <label for="rate5">★</label> 
	                              </div>
	                           </fieldset> 
                           </div>
                           <div class="input_checkbox"> 
						        <div class="checkbox_wrapper">
						            <input type="checkbox" id="family" value="가족" name="mood">
						            <label for="family">#가족</label>
						        </div>
						
						        <div class="checkbox_wrapper">
						            <input type="checkbox" id="date" value="데이트" name="mood">
						            <label for="date">#데이트</label>
						        </div>
						
						        <div class="checkbox_wrapper">
						            <input type="checkbox" id="nightView" value="야경" name="mood">
						            <label for="nightView">#야경</label>
						        </div>
						
						        <div class="checkbox_wrapper">
						            <input type="checkbox" id="friends" value="친구" name="mood">
						            <label for="friends">#친구</label>
						        </div>
						
						        <div class="checkbox_wrapper">
						            <input type="checkbox" id="restaurant" value="맛집" name="mood">
						            <label for="restaurant">#맛집</label>
						        </div>
						
						        <div class="checkbox_wrapper">
						            <input type="checkbox" id="photoSpot" value="사진 명소" name="mood">
						            <label for="photoSpot">#사진 명소</label>
						        </div>
						
						        <div class="checkbox_wrapper">
						            <input type="checkbox" id="walk" value="산책" name="mood">
						            <label for="walk">#산책</label>
						        </div>
						
						        <div class="checkbox_wrapper">
						            <input type="checkbox" id="rainyDay" value="비오는날" name="mood">
						            <label for="rainyDay">#비오는날</label>
						        </div>
						
						        <div class="checkbox_wrapper">
						            <input type="checkbox" id="dogFriendly" value="애견동반" name="mood">
						            <label for="dogFriendly">#애견동반</label>
						        </div>
						
						        <div class="checkbox_wrapper">
						            <input type="checkbox" id="party" value="파티" name="mood">
						            <label for="party">#파티</label>
						        </div>
                           </div>
                           <div> 
                              <textarea class="col-auto form-control" name="content"
                                 id="reviewContents" placeholder="좋은 리뷰을 남겨주시면 큰 힘이 됩니다!"></textarea>
                           </div>
                           <div align="center">
                              <input type="submit" value="작성" id="Post_a_review">
                           </div>
                        </form>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- 리뷰리스트뽑기 -->

      <%
      for (int i = 0; i < rv_list.size(); i++) {
      %>
      <div class="review-item">
         <div class="rating">
            <%
            int rating = rv_list.get(i).getRating();
            for (int star = 1; star <= 5; star++) {
               if (star <= rating) {
            %>
            <span class="filled">★</span>
            <%
            } else {
            %>
            <span class="empty">☆</span>
            <%
            }
            }
            %>
         </div>
         <%
         String[] moods = rv_list.get(i).getMood();
         for (int j = 0; j < moods.length; j++) {
         %>
         <b>#<%=moods[j]%>
         </b>
         <%
         }
         %>
         <h3><%=rv_list.get(i).getContent()%></h3>
         <p class="nickname"><%=rv_list.get(i).getNick()%></p>
         <p class="date"><%=rv_list.get(i).getDate()%></p>
      </div>
      <%
      }
      %>
   </div>

   <div id="lat" style="display: none;"><%=lat%></div>
   <div id="lon" style="display: none;"><%=lon%></div>
   <div id="place" style="display: none;"><%=place%></div>

	<footer class="footer">
		<div id="footerbutton">    
			<%if(info == null) {%>
				<button class="btn" onclick="location.href='login.jsp?from=/Drama/detail.jsp?index=<%=index%>'">로그인</button>
				<button class="btn" onclick="location.href='join.jsp?from=/Drama/detail.jsp?index=<%=index%>'">회원가입</button>
			<%} else { %>
				<button class="btn" onclick="location.href='LogoutService?from=/Drama/detail.jsp?index=<%=index%>'">로그아웃</button>
			<%} %>
				<button class="btn">한국어</button>
				<button class="btn">English</button>    
		</div>
	</footer> 

   <!-- JavaScript 파일 연결 -->
   <script src="js/menu.js"></script>
   <script src="js/map.js"></script>
   <!-- 리뷰pop버튼  -->
   <script>
         function show() {
          document.querySelector(".backgroundpop").className = "backgroundpop show";
         }
   
         function close() {
           document.querySelector(".backgroundpop").className = "backgroundpop";
         }
         
         function reviewLogin(){
        	 if (confirm('로그인 후 리뷰를 작성할 수 있습니다. 로그인하시겠습니까?')) { 
                 window.location.href = 'login.jsp?from=/Drama/detail.jsp?index=<%=index%>';
             }
          } 
         document.querySelector("#showpop").addEventListener("click", show);
         document.querySelector("#closepop").addEventListener("click", close); 
    </script>

   <!-- 좋아요 기능 JavaScript 추가 -->

   <script type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c1cac00685a32d9d2daf6b4bdb4fc80e"></script>



   <script type="text/javascript">
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
   </script>

   <script>
      // 이미지 지도에 표시할 마커입니다
      var lat = parseFloat(document.getElementById('lat').innerText);
                var lon = parseFloat(document.getElementById('lon').innerText);
      var place = document.getElementById('place').innerText;
      var marker = {
          position: new kakao.maps.LatLng(lat, lon), 
          text: place // text 옵션을 설정하면 마커 위에 텍스트를 함께 표시할 수 있습니다
      };
      
      var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div
          staticMapOption = { 
              center: new kakao.maps.LatLng(lat, lon), // 이미지 지도의 중심좌표
              level: 3, // 이미지 지도의 확대 레벨
              marker: marker // 이미지 지도에 표시할 마커
          };
      
      // 이미지 지도를 생성합니다
      var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
   </script>
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
   <!-- 리뷰 작성 조건 -->
   <script>
   function validateForm() {
	    var reviewStar = document.querySelector('input[name="reviewStar"]:checked');
	    var content = document.getElementById("reviewContents").value;
	    var moodCheckboxes = document.querySelectorAll('input[name="mood"]:checked');
	    
	    if (!reviewStar) {
	        alert("별점을 선택해 주야 됩니다");
	        return false;
	    }else if (content.trim() === "") {
	    	alert("내용을 입력하셔야 됩니다.");
	        return false;
		}else if (moodCheckboxes.length === 0) {
			alert("분위기 태그를 선택해야 됩니다.");
	        return false;
		}
	    return true;
   }
   </script>
</body>
</html>
