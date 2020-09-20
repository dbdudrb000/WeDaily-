<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Like_list Page</title>
	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>
	
	<!-- 모달 css -->
 	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/wedaily_modal.css">  
												
	<!-- 메인페이지 CSS  -->
	<link href="/resources/css/wedaily/mainStyle.css" rel="stylesheet" type="text/css">	
	
	<!-- font asoum-->
	<link rel="stylesheet" href="/resources/css/fontawesome/all.css">
	
	<!-- 커뮤니티 메인 CSS -->
	<link href="/resources/css/wedaily/community_main.css" rel="stylesheet" type="text/css">

</head>

<style>
	#hero {
		font-size: x-large;
    	font-family: serif;
	}
	#like_form {
		position: relative;
    	right: 11%;
	}
	.table_detail {
		width:45%;
	}
</style>
<body>
	<div class="hold">
	  <div class="header">
	    <div class="container" id="container">
	      <a href = "/moveMain">
	      	<!-- <div id="logo"></div> -->
	      </a> 
	      <ul class="nav"> 	
	      	<li id="main_logo"><a href="/moveMain">HOME</a></li>	
	      	<li><input type = "text" name = "search" id = "search"></li>
	      	<li><button type = "button" onclick = "search()">검색</button></li>
	      	<c:if test = "${ empty loginList }">
		        <li><a href="/original_login">로그인</a></li>
		        <li><a href="/original_join">회원가입</a></li>
		        <li><a href="/community_main?nickname=${loginList.nickname}">커뮤니티</a></li>
	        </c:if>
	        <c:if test = "${!empty loginList }">
	        	<li><a href="#">${loginList.nickname}님!</a></li> 
	        	<input type = "hidden" id = "userid" value = "${loginList.nickname}">      									
		        <li><a href="/WeDailyLogout?social=${loginList.social}">로그아웃</a></li>
		        <li id="dropdown"><a href="#">Mypage</a>
		        	<span id="sub_ul">		        		
	        			<a href="/wedailymypage?userid=${sessionScope.loginList.userid}">정보수정</a>
	        			<a href="/movie_like?nickname=${sessionScope.loginList.nickname}">찜 리스트</a>
	        		</span>
		        </li>
		        <li><a href="/community_main?nickname=${loginList.nickname}">커뮤니티</a></li>
	        </c:if>
	      </ul>
	    </div>
	  </div>
	</div>
	
	<div class="section">
	  <div class="slider">
	    <div class="container slidercontent">
	      <h3 class="hero" id="hero">찜 리스트 Page</h3>
	    </div>
	  </div>
	</div>
	
	<form class="board_form" id="like_form">	
		<table class="type09">
		    <thead>
		    <tr>
		        <th scope="cols" style="text-align: center;">순번</th>
		        <th scope="cols" style="text-align: center;">제목</th>
		        <th scope="cols" style="text-align: center;">오픈날짜</th>
		        <th scope="cols" style="text-align: center;">찜한 날짜</th>
		    </tr>
		    </thead>
		    <tbody>		  
			     <c:forEach var="likeList" items="${likeList}">
				    <tr>
				        <th scope="table_td">${likeList.move_num }</th>			        					       
				        <td class="table_detail">${likeList.movetitle}</td>     
				        <td class="table_th">${likeList.moveOpen}년도</td>        
				        <td class="table_th"><c:out value="${fn:substring(likeList.like_createdt,0,10)}"/></td>		        
				        <td id="update_input"><a onclick="like_delete('${likeList.movetitle}','${sessionScope.loginList.nickname}')"><i class="fas fa-times-circle"></i></a></td>
				        <input type="hidden" id="nickname" value="${sessionScope.loginList.nickname}">
				    </tr> 
				 </c:forEach> 
		    </tbody>
		</table>
	</form>
	
<script>
	function search(){
		var search = $("#search").val();
		var userid = $("#userid").val();
		if(search == ""){
			alert("정보를 입력해주세요.");
		}else{
			location.href = "/moveselect?search="+search+"&userid="+userid;
		}		
	}
	
	function like_delete(title,nickname){
		
		var use = confirm("찜 취소하시겠습니까?");
		
		if(use){		
			var param = { title : title ,
					      nickname : nickname,
					      like : "delete"
						};
			
			$.ajax({
				type : 'POST',
				url : "/movelike",
				data : param,
				error : function(error){
					alert("error");
				},
				success : function(data){
					alert("삭제되었습니다.");
					location.href="/movie_like?nickname="+nickname;
				}
			});	
		}
	} // like_delete AND
</script>	
	
	
</body>
</html>