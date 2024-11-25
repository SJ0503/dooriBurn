<%@page import="dooriburn.com.model.CommentLikeDTO"%>
<%@page import="dooriburn.com.model.CommentLikeDAO"%>
<%@page import="dooriburn.com.model.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dooriburn.com.model.CommentDTO"%>
<%@page import="dooriburn.com.model.CommentDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="dooriburn.com.model.ContestDTO"%>
<%@page import="dooriburn.com.model.MemberDTO"%>
<%@page import="dooriburn.com.model.ContestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE HTML>
<html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>contestView</title>
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
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"> 
	<link rel="stylesheet" href="css/style2.css"> 
	<script src="js/modernizr-2.6.2.min.js"></script> 

	<style>
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
	/* 사진 업로드 style */
	#uploadLabel .btn-file {
	    background-color: #FFEEB9 !important;  
	    border-color: #FFEEB9 !important;  
	    color: #000 !important;
		border: 1px solid; 
        border-radius: 25px; 
        box-shadow: none;
        padding: 8px 15px; 
	} 
	/* 댓글 작성 style*/
     #uploadInput {
        background-color: #FFEEB9 !important;
        border-color: #FFEEB9 !important; 
        color: #000 !important; 
        border: 1px solid; 
        border-radius: 25px; 
        box-shadow: none;
        padding: 8px 15px; 
    }
    
 	#commentLikeDelButton{
        background-color: #FFEEB9 !important;
        border-color: #FFEEB9 !important; 
        color: #000 !important; 
        border: 1px solid; 
        border-radius: 25px; 
        box-shadow: none;
        padding: 7px 13px; 
    }
 	
	.btn btn-primary pull-right {
		margin-right: 10px !important;
		padding: 10px 20px !important;"
	}
	/* 버튼과 저작권 정보 사이에 여백 추가, 중간배열 */
	.button-container { 
	    margin-bottom: 20px; 
		display: flex; 
		justify-content: center;
	}
	.table img {
	  border: none; /* 이미지에 대한 경계 제거 */
	}
	
	.table .content-row td {
	  border-top: none; /* 콘텐츠와 이미지 사이의 경계 숨기기 */
	}
   
	.star-button {
    background: none;
    border: none;
    padding: 0;
    font-size: 16px;
    color: inherit;
    cursor: pointer;
    outline: none;
    color: #f53f82;
	}
	
	.star-button:hover {
		color: #ff005e
	}
	.star-button:active {
		color: #ff0029
	}
	.star-button:focus {
	    outline: none;
	} 
	.star-button .like-count {
	    margin-left: 5px;
	}
	
	</style>   
	</head> 
	<body>
	<%
	    // 로그인 정보 가져오기
	    MemberDTO info = (MemberDTO) session.getAttribute("info");
 
	    String cNumParam = request.getParameter("c_num"); 
	
	    int num = 0;
	    try {
	        if (cNumParam != null && !cNumParam.isEmpty()) {
	            num = Integer.parseInt(cNumParam);
	        }
	    } catch (NumberFormatException e) {
	        // 숫자로 변환할 수 없는 경우 처리 
	        response.getWriter().println("<script>alert('유효하지 않은 글 번호입니다.');location.href = 'contestBoard.jsp';</script>");
	        return;
	    }
	
	    if (num == 0) {
	        // 유효하지 않은 글 번호 처리 
	        response.getWriter().println("<script>alert('유효하지 않은 글입니다.');location.href = 'contestBoard.jsp';</script>");
	        return;
	    }	
	    ContestDTO dto = new ContestDAO().getView(num);
	    CommentDAO comDao = new CommentDAO();
	    CommentLikeDAO likeDao = new CommentLikeDAO();
	    ArrayList<CommentDTO> commentList = comDao.getComment(num);

		String exUrl = "SearchService?s_option=2&pageNum=1&search=";
	%>

	<header>
		<div class="banner" onclick="redirectToPage()">여기가 거기여?</div>
		<div class="menu-icon" onclick="openNav()">☰</div>
	</header>
	<div class="fh5co-loader"></div> 
	<div id="page"> 
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
	
     
	<!-- 공모전 게시글 -->
	<div class="container">
		<div class="row">  
	        <table class="table table-striped" style="text-align: center; border:1px solid #f9f9f9;">
	            <thead style="background-color: #eeeeee">
	                <tr onclick="redirectToContest()">
	                    <th colspan="4" style="clear: both; text-align: center; margin-top: 20px; color: black; font-size: 20px;">관광사진 공모전</th>
	                </tr>
	            </thead>
	            <tbody style="background-color: #f9f9f9;">
	                <tr>
	                    <td style="width: 20%; color: black;">제목</td>
	                    <td colspan="3"><%= dto.getC_title() %></td>
	                </tr>
	                <tr>
	                    <td style="color: black;">공모일</td>
	                    <td colspan="3"><%= dto.getC_create_date() %> ~ <%= dto.getC_delete_date() %></td>
	                </tr>
	                <tr> 
	                   <td colspan="4"><img src="boardImg/<%= dto.getC_img() %>" alt="공모전 이미지" style="display: block; margin: auto; max-width: 100%; height: auto;"></td>
	                </tr>  
	                <tr class="content-row">
	                	<td colspan="4" style="white-space: pre-wrap;"><%= dto.getC_content() %></td>
	                </tr>
	            </tbody> 
			</table>  
		</div>
		
	<%-- 목록 / 작성 / 삭제 --%>
		<div>
		    <a href="contestBoard.jsp" class="btn btn-primary pull-left" style="margin-left: 10px; padding: 10px 20px;">목록</a>
	        <% if (info != null && info.getEmail().equals("admin@gmail.com")) { %>
				<a href="javascript:;" onclick="confirmDelete(<%= cNumParam %>)" class="btn btn-primary pull-right">삭제</a>
				<a href="contestUpdate.jsp?c_num=<%= cNumParam %>" class="btn btn-primary pull-right">수정</a>
			<% } %>
		</div>
		<br>
		<br>
		<div style="clear: both; text-align: center; margin-top: 20px;">
		    <header style="background-color: white;">
		        <h4 style="display: inline-block;  padding: 10px;">공모전 응모를 위해 댓글에 사진을 첨부해주세요.</h4>
		    </header>
		</div> 
		
		
		
		<%-- 해당 게시글에 작성된 댓글 목록 --%> 
		<div class="container">
			<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<% 
				    MemberDAO memDAO = new MemberDAO(); 
					
				    if (commentList != null && !commentList.isEmpty()) {
                        for (CommentDTO comDto : commentList) {
                            String comEmail = comDto.getEmail();   
							String nick = memDAO.findNickByEmail(comEmail); 
	                        String comNick = (nick != null) ? nick : "Unknown";    
	    			%>
					    
				    <tr>
				    	<td style="text-align: left; margin-left: 10px;"><%= comNick %></td>
				    	<% if (info != null && (info.getEmail().equals(comEmail) || info.getEmail().equals("admin@gmail.com"))) { %>
							<td style="text-align: right; margin-right: 10px;">
            					<a href="javascript:;" onclick="confirmCommentDelete('<%= comDto.getCmt_num() %>')" class="btn btn-primary pull-right" id="commentLikeDelButton">삭제</a>	
            				</td>
					    <% } %>
				    </tr>
					<tr> 
						<td colspan="2"><img src="commentImg/<%= comDto.getCmt_img() %>" alt="공모전 이미지" style="display: block; margin: auto; max-width: 100%; height: auto; "></td>
                    </tr>
 		<%-- 좋아요 --%> 
                    <tr>  
						<td colspan="3" style="text-align: left; margin-left: 10px;">
						    <input type="hidden" id="cmt_num" value="<%= request.getParameter("cmt_num") %>"> 
						    <% 
							int like_cnt = likeDao.commentLikeCount(comDto.getCmt_num()); 
							%>
							<% if (info != null) { %>
							    <input type="hidden" id="userEmail" value="<%= info.getEmail() %>">
							    <% if(likeDao.userLiked(info.getEmail(), comDto.getCmt_num())) { %>
							        <button class="star-button"
							        onclick="CommentLikeClick(<%=comDto.getCmt_num()%>, '<%=info != null ? info.getEmail() : ""%>', this, <%=like_cnt%>)">♥ <span class="like-count"><%=like_cnt %></span></button>		
							    <%} else { %>
							        <button class="star-button"
							        onclick="CommentLikeClick(<%=comDto.getCmt_num()%>, '<%=info != null ? info.getEmail() : ""%>', this, <%=like_cnt%>)">♡  <span class="like-count"><%=like_cnt %></span></button>
							    <% } %>
							<% } else { %> 
									<button class="star-button" onclick="showLoginPrompt()">♡ <span class="like-count"><%=like_cnt %></span></button> 
							<% } %> 
						</td>    
                    </tr>  
					<% } %> <!-- for문 닫기 -->
					<% } else { %>
	                    <tr>
	                        <td colspan="3">등록된 댓글이 없습니다.</td>
	                    </tr>
                   	<% } %> 
				</table>
			</div>
		</div>
		<br>
	</div>
		
		<!-- 댓글 작성란 -->
		<div class="container">
			<div class="form-group"> 
				<% CommentDTO userComDto = new CommentDTO();  %>
				<form action="commentPostAction.jsp" method="post" encType = "multipart/form-data">
					<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
 						<tr>
							<td colspan="2" style="border-bottom:none; text-align: left;" valign="middle">
								<%if (info == null){%>
									<p></p>
								<% } else { %>
									<%= info.getNick() %>
								<%}%></td>
						</tr>
						<tr>
							<td>
							    <ul class="fh5co-social-icons">
							        <% if (info != null) { %>
							            <li>
							                <label for="file" id="uploadLabel">
							                    <div class="btn btn-file">
							                        <i class="icon-camera"></i> 공모전 사진 선택
							                    </div>
							                </label>
							                <input type="file" name="commentImg" id="file" style="display: none;" onchange="previewImage(this);">
							            </li>
							            <div id="imagePreview">
							                <img id="preview" src="" alt="" style="max-width: 100%; height: auto;">
							            </div>
							        <% } else { %>
							            <li>
							                <p><a href="login.jsp?from=/Drama/contestView.jsp?c_num=<%=cNumParam%>" style="color: #000">로그인 후 공모전에 응모할 수 있습니다.</a></p>
							            </li>
							        <% } %>
							    </ul>
							</td>	 					
						</tr> 
						<tr>  
							<td>
								<input type="hidden" name="c_num" value="<%= cNumParam %>"><br>
								<button type="button" id="uploadInput" value="댓글 작성" onclick="checkLogin()">댓글 작성</button>
								<!-- <input type="submit" id="uploadInput" value="댓글 작성" onclick="checkLogin()"> -->
							</td>
						</tr>  
					</table>
				</form>
			</div>
		</div> 
		 
 	<footer id="fh5co-footer" role="contentinfo"> 
 			<div class="button-container">
			   	<div>    
					<%if(info == null) {%>
						<button class="btn" onclick="location.href='login.jsp?from=/Drama/contestView.jsp?c_num=<%=cNumParam%>'">로그인</button>
						<button class="btn" onclick="location.href='join.jsp?from=/Drama/contestView.jsp?c_num=<%=cNumParam%>'">회원가입</button>
					<%} else { %>
						<button class="btn" onclick="location.href='LogoutService?from=/Drama/contestView.jsp?c_num=<%=cNumParam%>'">로그아웃</button>
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
 
	</div>
	   
 <!--  댓글 좋아요 ♡♥ -->
	<script> 
    function showLoginPrompt() { 
        if (confirm('로그인 후 댓글 좋아요를 할 수 있습니다. 로그인하시겠습니까?')) { 
            window.location.href = 'login.jsp?from=/Drama/contestView.jsp?c_num=<%=cNumParam%>';
        }
    }
	function CommentLikeClick(cmt_num, email, button, like_cnt) {
	    if (!email) {
	        alert("로그인이 필요합니다.");
	        return;
	    }

	    $.ajax({
	        type: 'POST',
	        url: '<%=request.getContextPath()%>/CommentLikeService',
	        data: { 
	            cmt_num: cmt_num,
	            email: email
	        },
	        success: function(response) {
	            console.log('좋아요 처리 성공:', response);
	            console.log(cmt_num);
	            var likeCountElement = button.querySelector('.like-count');
	            var currentCount = parseInt(likeCountElement.textContent);

	            if (button.textContent.includes('♥')) {
	                button.innerHTML = '♡ <span class="like-count">' + (currentCount - 1) + '</span>';
	                button.classList.remove('liked');
	            } else {
	                button.innerHTML = '♥ <span class="like-count">' + (currentCount + 1) + '</span>';
	                button.classList.add('liked');
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('좋아요 처리 오류:', error);
	        }
	    });
	}
	</script>
 
 	<!-- 목록으로 돌아가기 -->
 	<script>
    function redirectToContest() {
        window.location.href = 'contestBoard.jsp';
    }	 
 	</script>
	<!-- 댓글 사진 업로드시 미리보기 -->
	<script>
	    function previewImage(input) {
	        var preview = document.getElementById('preview');
	        if (input.files && input.files[0]) {
	            var reader = new FileReader();
	            reader.onload = function(e) {
	                preview.src = e.target.result;
	            }
	            reader.readAsDataURL(input.files[0]); // 파일을 읽어 데이터 URL로 변환
	        } else {
	            preview.src = "";  
	        }
	    }	     
	</script> 
	<!-- 로그인시 댓글 작성할 수 있게 confirm -->
	<script>
	function checkLogin(event) {
	    var loggedIn = <%= info != null ? "true" : "false" %>;
	    var file = document.getElementById("file").value;
	    if (!loggedIn) {
	        var confirmLogin = confirm("로그인 후에 댓글을 작성할 수 있습니다. 로그인 페이지로 이동하시겠습니까?");
	        if (confirmLogin) {
	            window.location.href = "login.jsp?from=/Drama/contestView.jsp?c_num=<%=cNumParam%>"; 
	        }
	        return false;
	    } else if(file == ""){
	    	
	    	alert("사진 업로드 해주세요.");
	    	
			return false;
	    }else{
	    	document.querySelector("form").submit();
	    	return true;
	    }
	    
	}
	</script>

	 
	<!-- 해당 글 삭제시 Confirm 창 -->
	<script>
		function confirmDelete(cNumParam) {
			var result = confirm("글을 삭제하시겠습니까?");
			if (result) {
	            location.href = "ContestDeleteService?c_num=" + cNumParam;  
			}
		} 
	<!-- 댓글 삭제시 Confirm 창 -->
		function confirmCommentDelete(cmt_num) {
			var result = confirm("댓글을 삭제하시겠습니까?");
			if (result) {
				location.href = "CommentDeleteService?c_num=<%= cNumParam %>&cmt_num=" + cmt_num;  
			}
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
