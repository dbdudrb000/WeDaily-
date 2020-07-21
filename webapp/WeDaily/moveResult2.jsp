<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Move Search Page</title>
	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>
	
	<!-- 메인페이지 CSS  -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/mainStyle.css">
	<!-- font asoum-->
	<link rel="stylesheet" href="/resources/css/fontawesome/all.css">
	
 <style>
 	#header2{
 		border: 1px solid #d7cfc0bf;
 	}
 	.searchButton{
 		border-right-style: inset;
    	margin-left: 40%;
 	}
 </style>
</head>
<body>

<div class="hold">
  <div class="header" id = "header2">
    <div class="container">
      <a href = "/moveMain">
      	<div id="logo"></div>
      </a>
      <ul class="nav">     	
      	<li><input type = "text" name = "search" id = "search"></li>
      	<li><button type = "button" onclick = "search()">검색</button></li>
      	<c:if test = "${sessionScope.loginList.userid == null }">
	        <li><a href="/WeDailyJoinView">로그인</a></li>
	        <li><a href="/WeDailyJoinView">회원가입</a></li>
	        <li><a href="#">Wow</a></li>
	        <li><a href="#">Wow</a></li>
        </c:if>
        <c:if test = "${sessionScope.loginList.userid != null }">
        	<li><a href="#">${sessionScope.loginList.userid}님!</a></li>
	        <li><a href="/WeDailyLogout">로그아웃</a></li>
	        <li><a href="#">Wow</a></li>
	        <li><a href="#">Wow</a></li>
        </c:if>
      </ul>
    </div>
  </div>
</div>


<div class="section bg">
  <div class="container">
    <h1>검색된 영화</h1>
    <h2>즐거운 영화 Time</h2>
    <div class="col three bg nopad pointer" style = "margin-left:35%;">
    <c:forEach var = "move" items = "${naverMove}">
      <div class="imgholder">
      	<img src = "${move.image}" style = "height:300px; width:100%;">
      </div>
      <h1 class="feature">${move.title}</h1>
      <p>평점: ${move.move_rating}</p>
      <h1 class="feature"><i class="fas fa-users"></i> 출연배우 <i class="fas fa-users"></i></h1>
      <p>${move.actor}</p>
      <button onclick = "location.href = '${move.move_link}'" class = "searchButton">상세보기</button>
      </c:forEach>
    </div>
    
  </div>
</div>


<script>
	function search(){
		var search = $("#search").val();
		
		if(search == ""){
			alert("정보를 입력해주세요.");
		}else{
			location.href = "/moveselect?search="+search;
		}
		
	}
</script>

</body>
</html>