<%@page import="java.io.PrintWriter"%>
<%@page import="dooriburn.com.model.ContestDAO"%>
<%@page import="dooriburn.com.model.ContestDTO"%>
<%@page import="dooriburn.com.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE HTML>
<html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>contestUpdate</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Website Template by FreeHTML5.co" />
	<meta name="keywords" content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
	<meta name="author" content="FreeHTML5.co" />
   
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
	/* 사진 업로드 style*/
	#uploadLabel .btn-file {
	    background-color: #FFEEB9 !important;  
	    border-color: #FFEEB9 !important;  
	    color: #000 !important;
		border: 1px solid; 
        border-radius: 25px; 
        box-shadow: none;
        padding: 8px 15px; 
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
			MemberDTO info = (MemberDTO)session.getAttribute("info");  
		String exUrl = "SearchService?s_option=2&pageNum=1&search=";
		%>
	<header>
		<div class="banner" onclick="redirectToPage()">여기가 거기여?</div>
		<div class="menu-icon" onclick="openNav()">☰</div>
	</header>

	<div id="mySidenav" class="sidenav" style="width: 0;">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()" style="color:#545454;">&times;</a>
			<div class="menu-section">
				<h2>지역별로 찾기</h2>
				<div class="menu-items">
			      <%if(info !=null) {%>
      	<h1><b><%=info.getNick() %></b> 님 환영합니다</h1>
      <%}else{%>
      <h1><b>로그인</b>을 해주세요</h1>
      <%}%>
      <br>
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
 
	 
	<header id="fh5co-header" class="fh5co-cover" style="height: 100px;"> 
		<div class="overlay"></div>
		<div class="container"></div>
	</header>
		<%
			// 글 번호 가져오기
			int num = 0;
			if (request.getParameter("c_num") != null){
				num = Integer.parseInt(request.getParameter("c_num"));
			}
			if (num == 0) {
				PrintWriter script = response.getWriter();
		        script.println("<script>");
		        script.println("alert('유효하지 않는 글입니다.');"); // 경고창 메시지 오류 수정
		        script.println("location.href = 'contestBoard.jsp';");
		        script.println("</script>");
			}
			ContestDTO dto = new ContestDAO().getView(num);
			  
		%>
  
	<div class="container">
    <div class="row">
        <form method="post" action="contestUpdateAction.jsp?c_num=<%= dto.getC_num() %>" enctype="multipart/form-data">
            <table class="table table-striped" style="text-align: center; border:1px solid #f9f9f9">
                <thead>
                    <tr>
                        <th colspan="2" style="background-color: #f9f9f9; text-align: center;">공모전 게시글 수정</th> 
                    </tr>
                </thead>
                <tbody style="background-color: #f9f9f9;"> 
                    <tr> 
                        <td><input type="text" class="form-control" placeholder="제목을 입력해주세요." name="contestTitle" value="<%=dto.getC_title() %>" style="background-color: #f5f5f5;"></td>
                    </tr>
                    <tr> 
                        <td><textarea class="form-control" placeholder="내용을 입력해주세요." name="contestContent" style="height: 350px; background-color: #f5f5f5;"><%=dto.getC_content() %></textarea></td>
                    </tr>   
                    <tr> 
						<td>
						    <label for="file" id="uploadLabel">
						        <div class="btn btn-file">
						            <i class="icon-camera"></i> 사진 업로드
						        </div>
						    </label>
						    <input type="file" name="contestImg" id="file" style="display: none;" onchange="previewImage(this);">
						</td>                       
                    </tr> 
                    <tr>
                        <td>
                            <div id="imagePreview"></div>
                                <img id="preview" src="" alt="" style="max-width: 100%; height: auto;">
                        </td>
                    </tr>
                    
                </tbody>
            </table>
            <input type="hidden" name="c_num" value="<%= dto.getC_num() %>">
            <input type="submit" class="btn btn-primary pull-right" style="margin-right: 10px; padding: 10px 20px;" value="수정">
            <a href="contestBoard.jsp" class="btn btn-primary pull-left" style="margin-left: 10px; padding: 10px 20px;">목록</a>
        </form>        
    </div> 
</div> 
	
 	<footer id="fh5co-footer" role="contentinfo">
 		<!-- 버튼 -->
 			<div class="button-container">
			   	<div>    
					<%if(info == null) {%>
						<button class="btn" onclick="location.href='login.jsp'">로그인</button>
						<button class="btn" onclick="location.href='contact.jsp'">회원가입</button>
					<%}else{ %>
						<button class="btn" onclick="location.href='LogoutService'">로그아웃</button>
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

	<!-- 삭제 버튼 클릭시 Confirm 창 -->
	<script>
		function confirmUpdate(num) {
			var result = confirm("삭제하시겠습니까?");
			if (result) {
				location.href = "ContestDeleteService?c_num=" + num;
			}
		}
	</script>
	
	<!-- 수정 버튼 클릭시 Confirm 창 -->
	<script>
		function confirmUpdate(num) {
			var result = confirm("수정하시겠습니까?");
			if (result) {
				location.href = "ContestUpdateService?c_num=" + num;
			}
		}
	</script>
	 
	<!-- 업로드하는 사진 미리보기 -->
	<script>
	    function previewImage(input) {
	        var file = input.files[0];
	        var reader = new FileReader();
	
	        reader.onload = function(e) {
	            var preview = document.getElementById('imagePreview');
	            preview.innerHTML = '<img src="' + e.target.result + '" alt="이미지 미리보기" style="max-width: 100%; height: auto;">';
	        };
	
	        if (file) {
	            reader.readAsDataURL(file);
	        }
	    }
	
	    // 페이지 로드 후 기존 이미지 미리보기 초기화
	    window.onload = function() {
	        var existingImg = '<%= dto.getC_img() %>';
	        if (existingImg) {
	            var preview = document.getElementById('imagePreview');
	            preview.innerHTML = '<img src="boardImg/' + existingImg + '" alt="공모전 이미지" style="max-width: 100%; height: auto;">';
	        }
	    };
	
	    // 새로운 이미지 업로드 시 기존 이미지 숨기기
	    function hideExistingImage() {
	        var preview = document.getElementById('imagePreview');
	        preview.innerHTML = ''; // 이미지 미리보기 영역 비우기
	    }
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
