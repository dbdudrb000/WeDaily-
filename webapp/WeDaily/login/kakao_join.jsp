<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 회원가입</title>

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
	.join_keyword {
		font-size: 20px;
    	font-weight: 900;
	}
	.join_input > input[type=text],input[type=password] {
		width: 70%;
	    height: 23px;
	    border-color: cornflowerblue;
	    margin-top: 7px;
	    margin-right: 7px;
	    border-radius: 10px;
	}
	.form_interval {
		margin-top:20px;
	}
	.join_input > button {
		width: 104px;
	    height: 28px;
	    border-radius: 10px;
	    background-color: darkgray;
	}
	.join_input > select {
		width: 65px;
	    font-size: 16px;
	    height: 27px;
	    border-radius: 10px;
	}
	.finish_button {
		margin-left: 30%;
    	margin-top: 8%;
    	margin-bottom: -1%;
	}
	.finish_button > input[type=button] {
		width: 110px;
	    height: 50px;
	    border-radius: 12px;
	    color: steelblue;
	    border-right-color: steelblue;
	}
	.phone_comfirm {
		position: relative;
	    left: 30%;
	    top: 10px;
	    display:none;
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
	      <h1 class="hero" id="hero">카카오 회원가입</h1>
	      <h3 style="color: silver;">회원가입을 통해 더욱 많은 정보를 즐기실 수 있습니다.</h3>
	    </div>
	  </div>
	</div>
	
	<!-- 입력받아야 하는 정보 
	id: 카카오 response , 비밀번호 , 이름, 닉네임, 전화번호,  -->
	<div id="join_div">
		<div id="join_form">
			<form action="/WeDailyjoinLogic" name="join_from" >
				<table>
					<div class="join_keyword">아이디</div>
					<div class="join_input">
						<c:if test="${!empty kakaoid}">
							<input type="text" name="userId" id="userId" value="${kakaoid}" readonly>
							<input type="hidden" value="kakao" name="use">
							<input type="hidden" value="Y" id="overlapping">
						</c:if>
						<c:if test="${empty kakaoid}">
							<input type="text" name="userId" id="userId" required>
							<button type="button" onclick="idOverlapping()">중복확인</button>
							<input type="hidden" value="original" name="use">
							<input type="hidden" value="N" id="overlapping">
						</c:if>
					</div>
					<div class="form_interval">
						<div class="join_keyword">비밀번호</div>
						<div class="join_input">
							<input type="password" id="password1" name="password1" required>
						</div>
					</div>
					<div class="form_interval">
						<div class="join_keyword">비밀번호 확인</div>
						<div class="join_input">
							<input type="password" id="password2" name="password2" required>
						</div>
					</div>
					<div class="form_interval">
						<div class="join_keyword">이름</div>
						<div class="join_input">
							<c:if test="${!empty kakaoName}">
								<input type="text" id="userName" name="userName" value="${kakaoName}" readonly>
							</c:if>
							<c:if test="${empty kakaoName}">
								<input type="text" id="userName" name="userName" required>
							</c:if>
						</div>
					</div>
					<div class="form_interval">
						<div class="join_keyword">닉네임</div>
						<div class="join_input">
							<input type="text" id="nickname" name="nickname" required>
						</div>
					</div>
					<div class="form_interval">
						<div class="join_keyword">전화번호</div>
						<div class="join_input">
							<select id="phone_start">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="070">070</option>
							</select>
							<input type="text" placeholder="  '-'는 제외하고 작성하십시오." style="width:59%;" id="phoneId" name="phoneId">
							<button onclick="modal()" type="button" style="width:120px;">인증번호 보내기</button>
							<input type="hidden" id="phone_use" value="N">
						</div>
						<div class="phone_comfirm" id="phone_comfirmId">
							<input type="text" id="comfirm_number">
							<button onclick="smsConfirm()" type="button">인증하기</button>
						</div>
					</div>
					<div>
						<div class="finish_button">
							<input type="button" value="회원가입" onclick="join_submit()">				
							<input type="button" value="뒤로가기" onclick="history.back()">
						</div>
					</div>
				</table>
			</form>
		</div>
	</div>


<script>
	/* 문자인증 인증번호 보내는 함수() */
	function modal(){
		var phone_start = $("#phone_start").val();
		var modalVal = $("#phoneId").val();
		
		const phoneNumber = phone_start + modalVal;
		
	if(modalVal == ""){
		alert("휴대폰 번호를 입력해주세요.");
	}else{	
		
		// XMLHttpRequest 객체의 생성
		const xhr = new XMLHttpRequest();
		// 비동기 방식으로 Request를 오픈한다
		xhr.open('POST', '/smsStart', true);
		// 클라이언트가 서버로 전송할 데이터의 MIME-type 지정: json
		xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	
		xhr.onload = function (e) {
		  if (xhr.readyState === 4) {
		    if (xhr.status === 200) {
		    	debugger;			    	
		   	
		    	/* 인증번호 창 open  */
		    	var modalStyle = document.getElementById("phone_comfirmId");
		    	modalStyle.style.display = 'block';
		    			    	
		    	alert("전송되었습니다.");
		    	
		      console.log(xhr.responseText);
		    } else {
		    	alert("전송에 실패하였습니다. \n(문의 번호 : 1588-9999).");
		  	
		    	debugger;
		      console.error(xhr.statusText);
		    }
		  }
		};
		
		xhr.onerror = function (e) {
		  console.error(xhr.statusText);
		};
		
		const data = { phone : phoneNumber };
			xhr.send(JSON.stringify(data));
		 }
	}
	
	/* 문자인증번호 확인 하는 함수() */
	function smsConfirm(){

		var phone_start = $("#phone_start").val();
		var modalVal = $("#phoneId").val();	
		const phoneNumber = phone_start + modalVal;
		
		const comfirm_number = document.getElementById("comfirm_number").value;
		
		// XMLHttpRequest 객체의 생성
		const xhr = new XMLHttpRequest();
		// 비동기 방식으로 Request를 오픈한다
		xhr.open('POST', '/smsconfirm', true);
		// 클라이언트가 서버로 전송할 데이터의 MIME-type 지정: json
		xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

		xhr.onload = function (e) {
		  if (xhr.readyState === 4) {
		    if (xhr.status === 200) {
		    	debugger;
		    	
		    	var use = JSON.parse(xhr.responseText);
		    	console.log("use >> " + use);
		    	
		    	if(use.start){
		    		alert("인증 되었습니다.");
		    		
		    		document.getElementById("phone_use").value = "Y";
		    		document.getElementById("phoneId").value = phoneNumber;
		    		
		    		/* 인증완료 시 모달창 닫는 코드 */
		    		var modalStyle = document.getElementById("phone_comfirmId");
		    	modalStyle.style.display = 'none';
		    				    	
		    	}else{    		
		    		alert("인증 실패하였습니다.");
		      console.log(xhr.responseText);
		    } 
		    	debugger;
		      console.error(xhr.statusText);
		    
		  }else{
			  alert('');
		  }
		}
	};
		
		xhr.onerror = function (e) {
		  console.error(xhr.statusText);
		};
		
		const data = { phone_number : phoneNumber      ,                 
	 	   	   	   	   confirm      : comfirm_number    	 	   	   	   
		 	 	 	 };
		xhr.send(JSON.stringify(data));
		}
	
	/* 회원정보를 확인 후 회원가입 처리 */
	function join_submit(){
		var id = document.getElementById("userId").value;
		var userName = document.getElementById("userName").value;
		var nickname = document.getElementById("nickname").value;
		var pw1 = document.getElementById("password1").value;
		var pw2 = document.getElementById("password2").value;
		var phone_use = document.getElementById("phone_use").value;
		var lapping = document.getElementById("overlapping").value;
		
		if(id == "" || userName == "" || nickname == "" || pw1 == ""){
			alert("정보가 미작성되었습니다.");
		} else if(phone_use == "N"){
			alert("핸드폰 인증을 해주십시오.")
		} else if(pw1 != pw2){
			alert("비밀번호가 다릅니다.");
		}else if(lapping != "Y"){
			alert("아이디 중복체크를 해주십시오.");
		}else {
			join_from.submit();
		}
	}
	/* ID중복체크 하는 함수() */ 
	function idOverlapping(){
		const data = { 
						id : $("#userId").val()
				     };
		
		$.ajax({
			type : "POST",
			url : "/join/id_overlapping",
			data : data,
			error : function(error){
				alert("에러");
			},
			success : function(data){
				if(data == 1){
					alert("중복된 ID가 존재합니다.");
					document.getElementById("overlapping").value = "N";
				}else {
					alert("사용가능합니다.");
					document.getElementById("overlapping").value = "Y";
				}
			} // success AND
		});
	} // idOverlapping() AND
	
</script>
</body>
</html>