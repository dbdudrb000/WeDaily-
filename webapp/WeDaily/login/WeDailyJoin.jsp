<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>

	<!-- 상단 메뉴바 css -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/topMenu.css">

	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>
	
	
	<style>
		@import 'https://fonts.googleapis.com/css?family=Dosis|Roboto:300,400';
* {
	margin: 0;
	padding: 0;
}

body {
	background: #ffc185;
}

.container{
	position:absolute;
	width: auto;
	height:auto;
	top: calc(50% - 240px);
	left: calc(50% - 160px);
}

form {
	position: absolute;
	text-align: center;
	background: #fff;
	width: 310px;
	height: 470px;
	border-radius: 5px;
	padding: 30px 20px 0 20px;
	box-shadow: 0 10px 50px 0 rgba(0, 0, 0, 0.25);
	box-sizing: border-box;
}

p {
	font-family: 'Roboto', sans-serif;
	font-weight: 100;
	text-transform: uppercase;
	font-size: 12px;
	color: #87613d;
	margin-bottom: 40px;
}

p > span {
	padding-top: 3px;
	display: block;
	font-weight: 400;
	font-size: 9px;
}

h3 {
	font-family: 'Dosis';
	font-size: 35px;
	text-transform: uppercase;
	color: #87613d;
	margin-bottom: 30px;
}

input,
button{
	outline: none !important; 
}

button.fb {
	border: none;
	background: #3b5998;
	width: 160px;
	height: 25px;
	font-family: 'Roboto', sans-serif;
	font-size: 12px;
	color: #fff;
	text-transform: uppercase;
	border-radius: 4px;
	border: 1px solid #29487d;
	cursor: pointer;
	margin-bottom: 20px;
	transition:all 0.3s linear;
}
button.fb:hover {
	background: #fff;
	color: #3b5998;
}

button.form-btn {
	position: absolute;
	width: 50%;
	height: 60px;
	bottom: 0;
	border: 0;
	font-family: 'Dosis';
	font-size: 24px;
	text-transform: uppercase;
	cursor: pointer;
}

button.form-btn.sx {
	left: 0;
	border-radius: 0 0 0 5px;
	background-color: rgba(255, 125, 0, 0.35);
	color: #fff;
	transition:all 0.3s linear;
}

button.form-btn.sx:hover {
	background-color:rgba(255, 125, 0, 0.65);
	color: #fff;
}

button.form-btn.sx.back {
	background-color: rgba(0, 0, 0, 0.15);
	transition:all 0.3s linear;
}

button.form-btn.sx.back:hover {
	background-color: rgba(0, 0, 0, 0.35);
}

button.form-btn.dx {
	right: 0;
	border-radius: 0 0 5px 0;
	background-color: #ff7d00;
	color: #fff;
}

input {
	border: none;
	border-bottom: 1px solid #ffc185;
	width: 85%;
	font-family: 'Roboto';
	color: #ff7d00;
	text-align: center;
	font-size: 21px;
	font-weight:100;
	margin-bottom:25px;
}

::-webkit-input-placeholder {
   color: #ffc185;
	font-family: 'Roboto';
	font-weight:100;
}

:-moz-placeholder {
   color: #ffc185;  
	font-family: 'Roboto';
	font-weight:100;
}

::-moz-placeholder {
   color: #ffc185;  
	font-family: 'Roboto';
	font-weight:100;
}

:-ms-input-placeholder {  
   color: #ffc185; 
	font-family: 'Roboto';
	font-weight:100;
}

.signIn input,
.signUp .w100 {
	width: 100%;
}

.signIn{
		z-index: 1;
		transform: perspective(100px) translate3d(100px, 0px, -30px);
		opacity: 0.5;
}

.signUp {
	z-index: 2;
}

.active-dx{
	animation-name: foregrounding-dx;
	animation-duration: 0.9s;
	animation-fill-mode: forwards;
}

.active-sx{
	animation-name: foregrounding-sx;
	animation-duration: 0.9s;
	animation-fill-mode: forwards;
}

.inactive-dx{
	animation-name: overshadowing-dx;
	animation-duration: 0.9s;
	animation-fill-mode: forwards;
}

.inactive-sx{
	animation-name: overshadowing-sx;
	animation-duration: 0.9s;
	animation-fill-mode: forwards;
}

@keyframes overshadowing-dx {
	0%{
		z-index:2;
		transform: perspective(100px) translate3d(0px, 0px, 0px);
		opacity: 1;
		box-shadow: 0 10px 50px 0 rgba(0, 0, 0, 0.25);
	}
	100%{
		z-index: 1;
		transform: perspective(100px) translate3d(100px, 0px, -30px);
		opacity: 0.5;
		box-shadow: 0 10px 20px 0 rgba(0, 0, 0, 0.25);
	}
}

@keyframes overshadowing-sx {
	0%{
		z-index:2;
		transform: perspective(100px) translate3d(0px, 0px, 0px);
		opacity: 1;
		box-shadow: 0 10px 50px 0 rgba(0, 0, 0, 0.25);
	}
	100%{
		z-index: 1;
		transform: perspective(100px) translate3d(-100px, 0px, -30px);
		opacity: 0.5;
		box-shadow: 0 10px 20px 0 rgba(0, 0, 0, 0.25);
	}
}

@keyframes foregrounding-dx {
	0%{
		z-index:1;
		transform: perspective(100px) translate3d(100px, 0px, -30px);
		opacity: 0.5;
	}
	50%{
		z-index:2;
		transform: perspective(100px) translate3d(400px, 0px, -30px);
	}
	100%{
		z-index:2;
		transform: perspective(100px) translate3d(0px, 0px, 0px);
		opacity: 1;
	}
}

@keyframes foregrounding-sx {
	0%{
		z-index:1;
		transform: perspective(100px) translate3d(-100px, 0px, -30px);
		opacity: 0.5;
	}
	50%{
		z-index:2;
		transform: perspective(100px) translate3d(-400px, 0px, -30px);
	}
	100%{
		z-index:2;
		transform: perspective(100px) translate3d(0px, 0px, 0px);
		opacity: 1;
	}
}
	
	</style>



</head>
<body>

	<nav>
		<ul>		
	      <li><a href="#news"></a></li>
	      <li><a href="/WeDailyJoinView">로그인 | 회원가입</a></li>
	      <li><a class="active" href="/move2">Home</a></li>
	      </h3><li class = "logo" style = "color: antiquewhite; margin: 10px; margin-right: 31%; font-size: 23px;">WeDaily</li>
	    </ul>
	</nav>
   
	<div class="container">
		<form class="signUp" name = "joinform" action = "/WeDailyjoinLogic">
			<h3>회원가입</h3>
				<input class="w100" type="text" placeholder="아이디" id = "id" name = "id" reqired/>
				<input type="text" placeholder="닉네임" id = "nick" name = "nickname" reqired />
				<input type="text" placeholder="비밀번호" id = "pw1" name = "password" reqired />
				<input type="text" placeholder="비밀번호 재확인" id = "pw2"reqired />
				<input type="text" placeholder="휴대폰 번호' - '제외" id = "phoneId" name = "phone" maxlength="11" reqired />
				<button class="form-btn sx log-in" type="button">Log In</button>
				<button class="form-btn dx" type = "button"onclick = "join()">Sign Up</button>
		</form>
		<form class="signIn" name = "loginform"action = "/WeDailyLoginLogic">
			<h3>로그인</h3>
			<button class="fb" type="button" onclick = "alert('서비스준비중.')">Log In With Facebook</button>
			<p>- or -</p>
			<input type="text" placeholder="ID 입력" name = "loginId" reqired />
			<input type="text" placeholder="password 입력" name = "loginPw" reqired />
			<button class="form-btn sx back" type="button">Back</button>
			<button class="form-btn dx" type="button" onclick = "login()">Log In</button>
		</form>
	</div>
   
   <script>
   /* codepen import */
   $(".log-in").click(function(){
		$(".signIn").addClass("active-dx");
		$(".signUp").addClass("inactive-sx");
		$(".signUp").removeClass("active-sx");
		$(".signIn").removeClass("inactive-dx");
	});

	$(".back").click(function(){
		$(".signUp").addClass("active-sx");
		$(".signIn").addClass("inactive-dx");
		$(".signIn").removeClass("active-dx");
		$(".signUp").removeClass("inactive-sx");
	});
   
	function join(){	
		var id = document.getElementById("id").value;
		var pw1 = document.getElementById("pw1").value;
		var pw2 = document.getElementById("pw2").value;
		var ninkname = document.getElementById("nick").value;
		var phone1 = document.getElementById("phoneId").value;
		
		if(pw1 != pw2){
			alert("비밀번호가 다릅니다.")
		}else if(id == "" || pw1 == "" && nickname == "" || phone1 == ""){
			alert("정보를 입력헤주십시오.");
		}else{
			joinform.submit();
		}	
	}
	
	function login(){
		var loginId = $("input[name=loginId]").val();
		var loginPw = $("input[name=loginPw]").val();
		
		if(loginId == "" || loginPw == ""){
			alert("정보들 입력해주세요.");
		}else{
			loginform.submit();
		}
	}
	
   </script>
   
   
   
</body>
</html>