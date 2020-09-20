<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
	
	<!-- 로그인 main CSS -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/wedaily_login.css">
	<!-- 상단 메뉴바 css -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/topMenu.css">
	<!-- 모달 css -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/modal.css">

	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>
	
</head>
<body>

	<nav>
		<ul>		
	      <li><a href="#news"></a></li>
	      <li><a class="active" href="/moveMain">Home</a></li>
	      </h3><li class = "logo" style = "color: antiquewhite; margin: 10px; margin-right: 40%; font-size: 23px;">WeDaily</li>
	    </ul>
	</nav>
   
	<div class="container">									
		<form class="signIn" name = "joinform"action = "/WeDailyjoinLogic1" >
			<h3>회원가입</h3>
				<input class="w100" type="text" placeholder="아이디" id = "id" name = "idName" reqired  />
				
				<input type="text" placeholder="닉네임" id = "nick" name = "nickname" reqired />
				<input type="text" placeholder="비밀번호" id = "pw1" name = "password" reqired />
				<input type="text" placeholder="비밀번호 재확인" id = "pw2"reqired />
				<input type="number" placeholder="휴대폰 번호' - '제외" id = "phoneId" name = "phone" maxlength="11" reqired />
				<input type = "button" value = "인증번호 받기" onclick = "modal()" class="modal-trigger" data-modal="modal-name">
				
				<button class="form-btn sx back" type="button">Log In</button>
				<button class="form-btn dx" type = "button"onclick = "join()">Sign Up</button>
		</form>
		<form class="signUp" name = "loginform" action = "/WeDailyLoginLogic">
			<h3>로그인</h3>		
			<a href="${kakao_url}"><img src="resources/images/kakao_login.png" style="width:215px; height:40px; border-radius:10px;"></a>
			<p>- or -</p>
			<input type="text" placeholder="ID 입력" name = "loginId" reqired />
			<input type="password" placeholder="password 입력" name = "loginPw" reqired />
			<button class="form-btn sx log-in" type="button">Join</button>
			<button class="form-btn dx" type="button" onclick = "login()">Log In</button>
		</form>
		</form>		
	</div>
	
		<!-- Modal -->
		<div class="modal" id="modal-name" style = "display: none;">
		  <div class="modal-sandbox"></div>
			  <div class="modal-box">
			    <div class="modal-header">
			      <div class="x-modal" style = "text-align : right; cursor: pointer;">&#10006;</div> 
			      <input type = "hidden" value = "N" id = "phoneUse">
			      <h1>휴대폰 인증</h1>
			    </div>
			    <div class="modal-body">
			      <input type = "text" id = "modalText">	      
			      <button class="close-modal" onclick = "smsConfirm()">인증하기</button>
			    </div>
			  </div>
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
	
	$(".x-modal, .modal-sandbox").click(function(){
		  $(".modal").css({"display":"none"});
		  // $("body").css({"overflow-y": "auto"}); //Prevent double scrollbar.
		});
	
	
   
	function join(){	
		var id = document.getElementById("id").value;
		var pw1 = document.getElementById("pw1").value;
		var pw2 = document.getElementById("pw2").value;
		var ninkname = document.getElementById("nick").value;
		var phone1 = document.getElementById("phoneId").value;
		var use = document.getElementById('phoneUse').value;
		
		if(pw1 != pw2){
			alert("비밀번호가 다릅니다.")
		}else if(id == "" || pw1 == "" && nickname == "" || phone1 == ""){
			alert("정보를 입력헤주십시오.");
		}else if(use == "N"){
			alert('핸드폰 인증을 해주십시오..');
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
	

		/* 모달 javascript */
	function modal(){
			var modalVal = $("#phoneId").val();
			
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
			   	
			    	/* 모달창 여는 코드  */
			    	var modalStyle = document.getElementById("modal-name");
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
			
			const data = { phone : $("#phoneId").val() };
				xhr.send(JSON.stringify(data));
			 }
		
		}
	
	
	function smsConfirm(){

		if($("#modalText").val() == ""){
			alert("값을 입력해주세요.");
		}
			
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
		    		
		    		/* 인증완료 시 모달창 닫는 코드 */
		    		var modalStyle = document.getElementById("modal-name");
			    	modalStyle.style.display = 'none';
		    		
			    	document.getElementById('phoneUse').value = "Y";
			    	
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
		
		const data = { phone_number : $("#phoneId").val()      ,                 
	 	   	   	   	   confirm      : $("#modalText").val()    	 	   	   	   
		 	 	 	 };
		xhr.send(JSON.stringify(data));
		}
		
		
	
   </script>
   
   
   
</body>
</html>