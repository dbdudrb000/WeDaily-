<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>
	
	<!-- 모달 css -->
 	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/wedaily_modal.css">  
												
	<!-- 메인페이지 CSS  -->
	<link href="/resources/css/wedaily/mainStyle.css" rel="stylesheet" type="text/css">	
	
	<!-- font asoum-->
	<link rel="stylesheet" href="/resources/css/fontawesome/all.css">

<style>
	#hero {
		font-size: x-large;
    	font-family: cursive;
	}
	#join_div {
		margin-left: 35%;
    	margin-right: 35%;
	}
	#join_form {
		padding: 40px;
		box-shadow: 0 7px 25px 0 sienna;
    	background-color: white;
    	margin-top: 20%;
	}
	.login_logo h1{
		font-size: 60px;
	    margin: 0px;
	    padding: 0px;
	    margin-left: 40%;
	    font-weight: 700;
	}
	.div_id input[type=text] {
		width: 90%;
	    height: 45px;
	    border-radius: 10px;
	    margin: 23px;
	    border-color: cadetblue;
	    font-size: 25px;
	}
	.div_pw input[type=password] {
		width: 90%;
	    height: 45px;
	    border-radius: 10px;
	    margin: 23px;
	    border-color: cadetblue;
	    margin-top: 5px;
	    font-size: 25px;
	}
	.div_idStorage input[type=checkbox]{
		transform: scale(1.7);
	    margin-right: 2%;
	    position: relative;
	    top: -2px;
	}
	.div_idStorage {
		margin-left: 4%;	
	}
	.div_button input[type=button] {
		width: 35%;
	    height: 57px;
	    border-radius: 20px;
	    margin: 23px;
	    border-color: cadetblue;
	    font-size: 20px;
	    margin-left: 32%;
	    cursor: pointer;
	}
	.kakao_login img{
		margin-left: 32%;
	    width: 35%;
	    height: 51px;
	    border-radius: 15px;
	}
	.div_side {
		margin-left: 27%;
    	font-size: 17px;
    	margin-top: 6%;
	}
	.div_side a,a:visited {
		margin: 10px;
		color: unset;
	}
</style>

</head>
<body style="background: antiquewhite;">

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
	      <h1 class="hero" id="hero">로그인 페이지</h1>
	    
	    </div>
	  </div>
	</div>
	
	<div id="join_div">
		<div id="join_form">
			<form action="/WeDailyLoginLogic" name="login_form" >
				<table>
					<div class="login_logo"><h1>login</h1></div>
					<div class="div_id">
						<c:if test = "${cookie.id_storage_id.value == null}">
							<input type="text" placeholder="ID" id="loginId" name="loginId">
							<input type="hidden" value="N" id="cookie_check">
						</c:if>
						<c:if test = "${cookie.id_storage_id.value != null}">
							<input type="text" placeholder="ID" id="loginId" name="loginId" value="${cookie.id_storage_id.value}">
							<input type="hidden" value="Y" id="cookie_check">
						</c:if>
					</div>
					<div class="div_pw">
						<input type="password" placeholder="Password" id="loginPw" name="loginPw">
					</div>
					<div class="div_idStorage">
						<input type="checkbox" value="id_storage" name="id_check" id="id_check">아아디 저장하기
					</div>
					<div class="div_button">
						<input type="button" value="Login" onclick="formsubmit()">
					</div>
					<div class="kakao_login">
						<a href="${kakao_url}"><img src="resources/images/kakao_logo.png"></a>
					</div>
					<div class="div_side">
						<a href="/find_place?find_place=find_id">id찾기</a>
						<a href="/find_place?find_place=find_pw">비밀번호 찾기</a>
						<a href="/original_join">회원가입</a>
					</div>
				</table>
			</form>
		</div>
	</div>
	
<script>
	$(document).ready(function(){
		var cookie = $("#cookie_check").val();
		if(cookie == "Y"){
			 $("#id_check").attr("checked", true);
		}
	});


	function formsubmit(){
		var id = document.getElementById("loginId").value;
		var pw = document.getElementById("loginPw").value;
		
		if(id =="" && pw ==""){
			alert("정보를 입력해주십시오.");
		}else{
			login_form.submit();
		}
	}
</script>
	
</body>
</html>