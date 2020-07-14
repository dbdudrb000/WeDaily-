<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>

	<!-- 모달 css -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/modal.css">
	
	<!-- 메인페이지 CSS  -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/mainStyle.css">

	<!-- font asoum-->
	<link rel="stylesheet" href="/resources/css/fontawesome/all.css">
<style>



</style>


</head>
<body>

	<div class="hold">
  <div class="header">
    <div class="container">
      <div id="logo">
      </div>
      <ul class="nav">     	
      	<li><input type = "text" name = "search" id = "search"></li>
      	<li><button type = "button" onclick = "search()">검색</button></li>
      	<c:if test = "${loginList.userid == null }">
	        <li><a href="/WeDailyJoinView">로그인</a></li>
	        <li><a href="/WeDailyJoinView">회원가입</a></li>
	        <li><a href="#">Wow</a></li>
	        <li><a href="#">Wow</a></li>
        </c:if>
        <c:if test = "${loginList.userid != null }">
        	<li><a href="#">${loginList.userid}님!</a></li>
	        <li><a href="/WeDailyLogout">로그아웃</a></li>
	        <li><a href="#">Wow</a></li>
	        <li><a href="#">Wow</a></li>
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
      <div class="call"><span>^_^</span></div>
    </div>
  </div>
</div>
<div class="section">
  <div class="container">
    <div class="col four">
      <a href = "#" onclick = "modal()"><h1 class="icon">[]</h1></a>
      <h1 class="service">영화순위</h1>
      <p style = "    font-weight: 800;">영화순위가 궁금하시면은 클릭하십시오.</p>
    </div>
    <div class="col four">
      <h1 class="icon">[]</h1>
      <h1 class="service">Wow</h1>
      <p>Wow wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="responsivegroup"></div>
    <div class="col four">
      <h1 class="icon">[]</h1>
      <h1 class="service">Wow</h1>
      <p>Wow wow wow wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="col four">
      <h1 class="icon">[]</h1>
      <h1 class="service">Wow</h1>
      <p>Wow wow wow wow wow wow wow</p>
    </div>
    <div class="group"></div>
  </div>
</div>
<div class="section bg">
  <div class="container">
    <h1>Wow wow</h1>
    <h2>Wow wow wow!</h2>
    <div class="col three bg nopad pointer">
      <div class="imgholder"></div>
      <h1 class="feature">Wow</h1>
      <p>Wow wow</p>
    </div>
    <div class="col three bg nopad pointer">
      <div class="imgholder"></div>
      <h1 class="feature">Wow</h1>
      <p>Wow wow wow</p>
    </div>
    <div class="col three bg nopad pointer">
      <div class="imgholder"></div>
      <h1 class="feature">Wow</h1>
      <p>Wow wow wow</p>
    </div>
    <div class="group margin"></div>
    <div class="col three bg nopad pointer">
      <div class="imgholder"></div>
      <h1 class="feature">Wow</h1>
      <p>Wow wow</p>
    </div>
    <div class="col three bg nopad pointer">
      <div class="imgholder"></div>
      <h1 class="feature">Wow</h1>
      <p>Wow wow wow</p>
    </div>
    <div class="col three bg nopad pointer">
      <div class="imgholder"></div>
      <h1 class="feature">Wow</h1>
      <p>Wow wow wow</p>
    </div>
    <div class="group"></div>
  </div>
</div>
<div class="section">
  <div class="container">
    <h1>Wow? Wow wow wow wow!</h1>
    <h2>Wow</h2>
    <div class="col three">
      <h1 class="icon side">[]</h1>
      <h1 class="feature side">Wow</h1>
      <p class="side">Wow wow wow wow wow wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="col three">
      <h1 class="icon side">[]</h1>
      <h1 class="feature side">Wow</h1>
      <p class="side">Wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="col three">
      <h1 class="icon side">[]</h1>
      <h1 class="feature side">Wow</h1>
      <p class="side">Wow wow wow wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="group margin"></div>
    <div class="col three">
      <h1 class="icon side">[]</h1>
      <h1 class="feature side">Wow</h1>
      <p class="side">Wow wow wow wow wow wow wow</p>
    </div>
    <div class="col three">
      <h1 class="icon side">[]</h1>
      <h1 class="feature side">Wow</h1>
      <p class="side">Wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="col three">
      <h1 class="icon side">[]</h1>
      <h1 class="feature side">Wow</h1>
      <p class="side">Wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="group margin"></div>
  </div>
</div>
<div class="section bg">
  <div class="container">
    <h1>Wow</h1>
    <h2>Wow wow wow wow</h2>
    <div class="col two bg margin extrapad">
      <h1 class="icon side">[]</h1>
      <span class="feature side">Wow</span><span class="side"> - Wow wow wow</span>
      <p class="side">Wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="col two bg margin extrapad">
      <h1 class="icon side">[]</h1>
      <span class="feature side">Wow wow</span><span class="side"> - Wow wow</span>
      <p class="side">Wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="group margin"></div>
    <div class="col two bg margin extrapad">
      <h1 class="icon side">[]</h1>
      <span class="feature side">Wow wow</span><span class="side"> - Wow</span>
      <p class="side">Wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="col two bg margin extrapad">
      <h1 class="icon side">[]</h1>
      <span class="feature side">Wow</span><span class="side"> - Wow wow</span>
      <p class="side">Wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="group"></div>
  </div>
</div>
<div class="section">
  <div class="container">
    <div class="col two">
      <h1 class="icon">[]</h1>
      <h1 class="service">Wow</h1>
      <p>Wow wow wow wow wow wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="col two">
      <h1 class="icon">[]</h1>
      <h1 class="service">Wow</h1>
      <p>Wow wow wow wow wow wow wow wow wow</p>
    </div>
    <div class="group"></div>
  </div>
</div>
<div class="section">
  <div class="container">
    <h1 class="reset">Terrible.</h1>
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

	<!-- 영화순위 모달창 -->
	<div class="modal" id="modal-name" style = "display: none;">
		<div class="modal-sandbox"></div>
		<div class="modal-box">
			<div class="modal-header">
				<a onclick = "modal()"><div class="x-modal" style = "text-align : right; cursor: pointer;">&#10006;</div></a>
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
		
		if(search == ""){
			alert("정보를 입력해주세요.");
		}else{
			location.href = "/moveselect?search="+search;
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
	
</script>


</body>
</html>