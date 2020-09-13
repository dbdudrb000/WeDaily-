<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Main Page</title>
	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>
	
	<!-- 모달 css -->
 	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/wedaily_modal.css">  
												
	<!-- 메인페이지 CSS  -->
	<link href="/resources/css/wedaily/mainStyle.css" rel="stylesheet" type="text/css">	
	
	<!-- font asoum-->
	<link rel="stylesheet" href="/resources/css/fontawesome/all.css">
<style>
	.modal-header {
		background: burlywood;
	}
	.modal-body {
		background:#fdfcf0;
	}
</style>
</head>
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
      	<c:if test = "${loginList.userid == null }">
	        <li><a href="/WeDailyJoinView">로그인</a></li>
	        <li><a href="/WeDailyJoinView">회원가입</a></li>
	        <li><a href="/community_main?nickname=${loginList.nickname}">커뮤니티</a></li>
	        <li><a href="#">Wow</a></li>
        </c:if>
        <c:if test = "${loginList.userid != null }">
        	<li><a href="#">${loginList.userid}님!</a></li> 
        	<input type = "hidden" id = "userid" value = "${loginList.nickname}">      									
	        <li><a href="/WeDailyLogout">로그아웃</a></li>
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
      <h1 class="hero">WeDaily</h1>
      <h2 class="hero">환영합니다</h2>
      <div class="call"><a onclick = "alert('즐거운 하루 되세요^_^')"><span>^_^</span></a></div>
    </div>
  </div>
</div>

<div class="section" style="border-bottom: double;">
  <div class="container">
    <div class="col four">
      <a href = "#" onclick = "modal()"><h1 class="icon">[]</h1></a>
      <h1 class="service">영화순위</h1>
      <p style="font-weight:800;">영화순위가 궁금하시면은 클릭하십시오.</p>
    </div>
    <div class="col four">
      <a href="#" onclick="location.href='/reservation'"><h1 class="icon">[]</h1></a>
      <h1 class="service">CGV 예매하기</h1>
      <p style="font-weight: 800;">상영 시간표가 궁금하신가요?</p>
    </div>
    <div class="responsivegroup"></div>
    <div class="col four">
      <a href="#" onclick="cgvSns_modal()"><h1 class="icon">[]</h1></a>
      <h1 class="service">CGV SNS</h1>
      <p style="font-weight: 800;">CGV sns에서 다양한 정보를 얻어보세요.</p>
    </div>
    <div class="col four">
      <a href="#" onclick="appOpen()"><h1 class="icon">[]</h1></a>
      <h1 class="service">App 으로 이용하기</h1>
      <p style="font-weight: 800;">앱으로 편하게 이용하세요.</p>
    </div>
    <div class="group"></div>
  </div>
</div>

<div class="section">
  <div class="container">
    <h1 class="reset">간략소개</h1>
  </div>
</div>
<div class="section">
  <div class="footer">
    <div class="container white">
      <div class="col four left">
        <h1>What?</h1>
        <p>So that's it. This started out as 20 minutes of making fun of modern web dev. Then it turned into a few hours of it.</p>
        <p>I hope you've enjoyed looking at every modern website ever.</p>
        <p>I don't actually hate this style as long as the content is meaningful. In fact, I think this type of design is pretty cool and effective.</p>
      </div>
      <div class="col four left">
        <h1>How?</h1>
        <p>CSS3 and HTML. JS for header shrinking; optional. Site works perfectly with JS disabled (another gripe of mine with modern web dev).</p>
        <p>Only external libraries are GFonts.</p>
        <p>Moderately responsive, should work on anything modern.</p>
      </div>
      <div class="col four left">
        <h1>Why?</h1>
        <p>Many popular HTML themes have thousands of lines of HTML, thousands of lines of CSS and several JS plugins on every page amounting to tens of thousands of lines of JavaScript.</p>
        <p>I fail to see a valid reason for this, particularly the horrendous line counts that are usually due to unused features or badly designed code.</p>
      </div>
      <div class="col four left">
        <h1>Who?</h1>
        <p>I'm Andrew.</p>
        <p>You can get in touch with me through <a href="http://atunnecliffe.com">http://atunnecliffe.com</a> or <a href="mailto:andrew@atunnecliffe.com">emailing me</a>.</p>
      </div>
      <div class="group"></div>
    </div>
  </div>
</div>

<!-- 영화순위 모달창 ( 주간,주말 )-->
<div class="modal" id="modal-name" style = "display: none;">
	<div class="modal-sandbox"></div>
	<div class="modal-box">
		<div class="modal-header">
			<a onclick = "modal()"><div class="x-modal" style = "text-align : right; cursor: pointer;">&#10006;</div></a>
			<input type = "hidden" value = "N" id = "phoneUse">
			<h1>영화순위</h1>
		</div>
	<div class="modal-body">
		<select name = "selectbox" id = "selectbox" style="border-radius: 10px; border: groove;">
			<option value = "none">===선택===</option>
			<option value = "today">오늘의 영화순위</option>
			<option value = "jugan">주간 영화순위</option>
			<option value = "jumal">주말 영화순위</option>
		</select>	      
		<button class="close-modal" onclick = "moveRanking()" style="background-color:white;">바로보기</button>
	</div>
	</div>
</div>

<!-- CGV SNS 모달 -->
<div class="modal" id="cgv_modal" style="display: none;">
  <div class="modal-sandbox"></div>
	  <div class="modal-box">
	    <div class="modal-header" id="cgvmodal_header">
	      <div class="x-modal" style = "text-align : right; cursor: pointer;"><a onclick = "cgvSns_modal()">&#10006;</a></div> 
	      <h1>CGV SNS 보러가기</h1>
	    </div>
	    <div class="modal-body" id="cgvModal_body">   
	      <select id="sns_selectbox" style="border-radius: 10px; border: groove;">
	      	<option value="not">선택 없음</option>
	      	<option value="facebook">CGV 페이스북</option>
	      	<option value="instaframe">CGV 인스타그램</option>
	      </select>
	      <button onclick="sns_button()" style="background-color:white;">바로가기</button>
	    </div>
	  </div>
</div>

<!-- QR코드로 app으로 이동하기  -->
<div class="modal" id="app_modal" style="display: none;">
	<div class="modal-sandbox"></div>
	<div class="modal-box">
		<div class="modal-header">
			<a onclick = "appOpen()"><div class="x-modal" style = "text-align : right; cursor: pointer;">&#10006;</div></a>
			<input type = "hidden" value = "N" id = "phoneUse">
			<h1>CGV앱으로 편하게 이용하세요.</h1>
		</div>
	<div class="modal-body">
		 <img src="http://img.cgv.co.kr/R2014//images/common/img_qrcode.gif">
	</div>
	</div>
</div>

<script>
window.onscroll = function() {
	  var el = document.getElementsByClassName('header')[0];
	  var className = 'small';
	  if (el.classList) {
	    if (window.scrollY > 10)
	      el.classList.add(className);
	    else
	      el.classList.remove(className);
	  }
	};
	
	function search(){
		var search = $("#search").val();
		var userid = $("#userid").val();
		if(search == ""){
			alert("정보를 입력해주세요.");
		}else{
			location.href = "/moveselect?search="+search+"&userid="+userid;
		}		
	}
	
	function modal(){
		var modalStyle = document.getElementById("modal-name");
		
    	if(modalStyle.style.display == 'block'){
    		modalStyle.style.display = 'none';	
    	}else{
    		modalStyle.style.display = 'block';
    	}   	   	
	}
	// 영화 순위 ( 주간 주말 어떠한 리스트를 볼 것인지 선택하는 selectbox )
	function moveRanking(){
		
		var target = $("select[name=selectbox]").val();
		
		if(target == "none"){
			alert("항목을 선택해주십시오.")
		}else{
			location.href = "/moveRanking?target="+target;;
		}	
	}
	
	function cgvSns_modal(){
		var sns = document.getElementById("cgv_modal"); 
		if(sns.style.display == "block"){
			sns.style.display = "none";	
		}else {
			sns.style.display = "block";
		}	
	}
	
	function sns_button(){
		var sns_search = document.getElementById("sns_selectbox").value;
		
		if(sns_search == "not"){
			alert("정보가 입력되지 않았습니다.");
		}else if(sns_search == "facebook"){
			location.href="https://www.facebook.com/CJCGV";
		}else {
			location.href="https://www.instagram.com/cgv_korea/";
		}
	}
	
	function appOpen(){
		var app_search = document.getElementById("app_modal");
		
		if(app_search.style.display == "block"){
			app_search.style.display = "none";
		}else {
			app_search.style.display = "block"
		}
	}
</script>


</body>
</html>