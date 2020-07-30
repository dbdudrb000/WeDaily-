<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WeDaily Mypage</title>

	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>
	<!-- 메인페이지 CSS  -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/mainStyle.css">
	<!-- font asoum-->
	<link rel="stylesheet" href="/resources/css/fontawesome/all.css">
	<!-- mypage form CSS -->
	<link rel="stylesheet" type = "text/css" href="/resources/css/wedaily/mypage.css">
	<!-- 모달 css -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/modal.css">
<style>
		#modal_button2{
	    	margin-top: -23px; 
	    	margin-left: 53%;
	    }
	    #phone_number{
	    	margin-left: 33%;
	    }
	    #modalText{
	    	margin-left: 33%;
	    }
	    #modal_button{
	    	margin-left: 53%;
    		margin-top: -23px;
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
		        <li><a href="/wedailymypage">Mypage</a></li>
		        <li><a href="#">Wow</a></li>
	        </c:if>
	      </ul>
	    </div>
	  </div>
	</div>

	<div class="container mt-4">
	    <h1 class="display-4 text-center">
	      <i class="fas fa-book-open text-primary"></i> My<span class="text-primary">Page</span></h1>
	</div>
	
		<!-- mypage table html -->

	<div class="landing-page">
		<div class="form-appointment">
			<div class="wpcf7" id="wpcf7-f560-p590-o1">
				<form
					action="/landing-page-template-do-not-delete/#wpcf7-f560-p590-o1"
					method="post" class="wpcf7-form" novalidate="novalidate"
					_lpchecked="1">
					<div style="display: none;">
						<input type="hidden" name="_wpcf7" value="560"> <input
							type="hidden" name="_wpcf7_version" value="3.5"> <input
							type="hidden" name="_wpcf7_locale" value=""> <input
							type="hidden" name="_wpcf7_unit_tag" value="wpcf7-f560-p590-o1">
						<input type="hidden" name="_wpnonce" value="dbb28877d5">
					</div>
					<div class="group">
						<div style="width: 48%; float: left;">
							<span class="wpcf7-form-control-wrap text-680">
								<input type="text" name="text-680" value="ID : ${mypageUser.userid} " size="45"placeholder="아이디" readonly>
							</span><br> 
							<span class="wpcf7-form-control-wrap text-680">
								<input type="text" name="text-680" value="닉네임 : ${mypageUser.nickname}" size="45"placeholder="닉네임" readonly>
							</span><br> 
							<span class="wpcf7-form-control-wrap tel-630">
								<input type="text" value="PW : ${mypageUser.userpw}" size="45" placeholder="비밀번호" readonly>
							</span><br>  
							<span class="wpcf7-form-control-wrap tel-630"><input type="text" 
								  value="휴대폰 : ${fn:substring(mypageUser.phone,0,3)}-${fn:substring(mypageUser.phone,3,7)}-${fn:substring(mypageUser.phone,7,12)}" 
								  placeholder="휴대폰" readonly>
							</span><br> 															
							<span class="wpcf7-form-control-wrap textarea-398">
								<textarea cols="40" rows="10" placeholder="자기소개" readonly>${mypageUser.my_self}</textarea>
							</span>
						</div>
						<div style="width: 48%; float: right;">
							<h4>어떤 정보를 변경하시겠습니까?</h4>
							<p>							
								<input type = "button" value = "휴대폰" onclick = "modalopen()">&nbsp;
								<input type = "button" value = "비밀번호" onclick = "alert('서비스준비중')">&nbsp;
								<input type = "button" value = "자기소개" onclick = "alert('서비스준비중')">
							</p>
							<h4>서비스가 일상생활에 도움이 되셨습니까?</h4>
							<p>
								<span class="wpcf7-form-control-wrap checkbox-465">
									<span>
									<span>
										<label>
											<input type="radio" name="checkbox-465[]" value="매우만족">&nbsp;<span class="wpcf7-list-item-label">매우만족</span>
										</label>
									</span>
									<span class="wpcf7-list-item">
										<label>
											<input type="radio" name="checkbox-465[]" value="만족">&nbsp;<span class="wpcf7-list-item-label">만족</span>
										</label>
									</span>
									<span class="wpcf7-list-item">
										<label>
											<input type="radio" name="checkbox-465[]" value="보통">&nbsp;<span class="wpcf7-list-item-label">보통</span>
										</label>
									</span>
									<span class="wpcf7-list-item">
										<label>
											<input type="radio" name="checkbox-465[]" value="불만족">&nbsp;<span class="wpcf7-list-item-label">불만족</span>
										</label>
									</span>
									<span class="wpcf7-list-item">
										<label>
											<input type="radio" name="checkbox-465[]" value="매우 불만족">&nbsp;<span class="wpcf7-list-item-label">매우 불만족</span>
										</label>
									</span>
									</span>
									<input type = "button" value = "제출" onclick = " level()">
								</span>
							</p>
						</div>
					</div>
					<div style="text-align: center; padding-top: 2em; border-top: 1px solid rgb(153, 202, 129); margin-top: 1em;">
						<input type="button" id = "finish" value="확인" class="wpcf7-form-control wpcf7-submit" onclick = "finishs()" style="cursor: pointer;">
					</div>
					<div class="wpcf7-response-output wpcf7-display-none"></div>
				</form>
			</div>
		</div>
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
		      <input type = "text" id = "phone_number" style = "display:block;">
		      <button class="close-modal" id = "modal_button2" onclick = "modal()" style = "display:block;">인증번호 보내기</button>
		      
		      <input type = "text" id = "modalText" style = "display:none;">	      
		      <button class="close-modal" id = "modal_button" onclick = "smsConfirm()" style = "display:none;">인증하기</button>
		    </div>
		  </div>
	</div>


<script>
	function finishs(){
		var result = confirm("수정완료하셨습니까?");
		
		if(result){
			location.href = "/moveMain";
		}
	}	
	// 설문조사 radio 갑을 가져오는 로직
	function  level(){							
		var Survey = $("input[name='checkbox-465[]']");
		
		for(var i=0; i<Survey.length;i++){
			if(Survey[i].checked){
				alert(Survey[i].value);
				
				var param = { Survey : Survey[i].value };
				
				$.ajax({
				    type : 'POST',
				    url : "#",
				    data : param,
				    error : function(error) {
				        alert("Error!");
				    },
				    success : function(data) {		            	       
					    alert("참여해주셔서 감사합니다.");
				    },
				    complete : function() {
				    }
				}); 
			}	
		}
		
	}
	
	/* phone modal open */
	function modalopen(){	
		var modalStyle = document.getElementById("modal-name");
    	modalStyle.style.display = 'block';
	}
	
	
	function modal(){
		var modalVal = $("#phoneId").val();
	
		
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
		    	 
		    	var phone_number = document.getElementById("phone_number");
		    	var modal_button2 = document.getElementById("modal_button2");
		    	
		    	phone_number.style.display = 'none';	    	
		    	modal_button2.style.display = 'none';                   
		    	
		    	var modalText = document.getElementById("modalText");
		    	var modal_button = document.getElementById("modal_button");
		    	
		    	modalText.style.display = 'block';	    	
		    	modal_button.style.display = 'block';                   
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
		
		const data = { phone : $("#phone_number").val() };
			xhr.send(JSON.stringify(data));
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