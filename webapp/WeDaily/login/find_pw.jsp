<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>
	
	<!-- 모달 css -->
 	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/wedaily_modal.css">  
												
	<!-- 메인페이지 CSS  -->
	<link href="/resources/css/wedaily/mainStyle.css" rel="stylesheet" type="text/css">	
	
	<!-- font asoum-->
	<link rel="stylesheet" href="/resources/css/fontawesome/all.css">
	<!-- mypage form CSS -->
	<link rel="stylesheet" type = "text/css" href="/resources/css/wedaily/mypage.css">
	
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
	.login_logo h3{
		font-size: 40px;
	    margin: 0px;
	    padding: 0px;
	    margin-left: 30%;
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
	.div_pw input[type=text] {
		width: 90%;
	    height: 45px;
	    border-radius: 10px;
	    margin: 23px;
	    border-color: cadetblue;
	    margin-top: 5px;
	    font-size: 25px;
	}
	.find_div input[type=text] {
		width: 40%;
		height: 45px;
		border-radius: 10px;
    	margin-left: 28%;
    	border-style: outset;
    	box-shadow: 0 7px 38px 0 crimson;
    	text-align: center;
    	font-size: 27px;
    	display:none;
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
	.div_side {
		margin-left: 30%;
    	font-size: 17px;
    	margin-top: 3%;
	}
	.div_side a,a:visited {
		margin: 10px;
		color: unset;
	}
	#find_modal-header {
		background: tan;
	}
	#find_close-modal {
		padding: 6px;
	    background-color: darkgrey;
	    border-radius: 13px;
	    margin-top: 14px;
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
	      <h1 class="hero" id="hero">비밀번호 찾기</h1>
	    </div>
	  </div>
	</div>
	
	<div id="join_div">
		<div id="join_form">
			<form action="/find_id" name="findId_form" method="POST" >
				<table>
					<div class="login_logo"><h3>비밀번호 찾기</h3></div>
					<div class="div_id">
						<input type="text" id="findName" name="findName" placeholder="이름을 입력해주세요.">	
					</div>
					<div class="div_pw">
						<input type="text" id="findid" name="findPhone" placeholder="아아디를 입력해주세요.">
					</div>	
					<div class="div_pw">
						<input type="text" id="findPhone" name="findPhone" placeholder="휴대폰 번호 '-'제외하고 입력해주세요.">
					</div>	
					<div class="find_div">
						<input type="text" id="find_id">
					</div>	
					<div class="div_button">
						<input type="button" value="비밀번호 찾기" onclick="find_pw()">
					</div>	
					<div class="div_side">
						<a href="/original_login">로그인</a>
						<a href="/find_place?find_place=find_id">id찾기</a>
						<a href="/original_join">회원가입</a>
					</div>		
				</table>
			</form>
		</div>
	</div>
	
	<!-- password update Modal -->
		<form action="/find_updatePw" method="POST" name="find_pw_form">
			<div class="modal" id="password_modal" style = "display: none;">
			  <div class="modal-sandbox"></div>
				  <div class="modal-box">
				    <div class="modal-header" id="find_modal-header">
				      <div class="x-modal" style = "text-align : right; cursor: pointer;"><a onclick = "modalclose()">&#10006;</a></div> 
				      <h1>비밀번호 변경</h1>
				    </div>
				    <div class="modal-body">
				      <input type = "text" id = "updatePassword1" placeholder="변경할 비밀번호" style = "margin:6px;" ><br>
				      <input type = "text" id = "updatePassword2" placeholder="다시 입력해주세요." name="modal_findPw"><br>
				      <input type="hidden" name="modal_findId" id="modal_findId">	      
				      <button class="close-modal"id="find_close-modal" onclick = "update()">변경하기</button>
				    </div>
				  </div>
			</div>
		</form>
	
<script>
	/* 정보 입력 후 맞으면은 modal창 open */
	function find_pw(){
		const data = {	userId : $("#findid").val(),
						userName : $("#findName").val(),
						phone : $("#findPhone").val()
					 };
		
		$.ajax({
			type : "GET",
			url : "/find_pw",
			data : data,
			error : function(error){
				alert("에러");
			},
			success : function(data){
				if(data == 0){
					alert("입력된 정보가 잘못되었습니다.");
				}else {
					document.getElementById("password_modal").style.display = "block";
					document.getElementById("modal_findId").value = $("#findid").val();
				}
			}
		});
	}
	
	/* modal close */
	function modalclose(modal){
		var mocal_close = document.getElementById("password_modal");
		
		if(mocal_close.style.display == "block"){
			mocal_close.style.display = "none";
		}else {
			mocal_close.style.display = "block";
		}
	}
	
	function update(){
		var pw1 = $("#updatePassword1").val();
		var pw2 = $("#updatePassword2").val();
		if(pw1 != pw2){
			alert("비밀번호가 일치하지 않습니다.");
		}else {
			find_pw_form.submit();
		}
	}
</script>
</body>
</html>