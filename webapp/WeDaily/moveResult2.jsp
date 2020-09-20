<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
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


<div class="section bg">
  <div class="container">
    <h1>검색된 영화</h1>
    <h2>즐거운 영화 Time</h2>
    <div class="col three bg nopad pointer" style = "margin-left:35%;">
    <c:forEach var = "move" items = "${naverMove}">
      <div class="imgholder">
      	<img src = "${move.image}" style = "height:300px; width:100%;">
      </div>
      <h1 class="feature" id = "title">${move.title}</h1>
      <p>평점: ${move.move_rating}</p>
      <p>제작년도: ${move.pubDate}년</p>
      <input type = "hidden" id = "opendt" value = "${move.pubDate}">
      <input type = "hidden" id = "nickname" value = "${sessionScope.loginList.nickname}">
      <h1 class="feature"><i class="fas fa-users"></i> 출연배우 <i class="fas fa-users"></i></h1>
      <p id = "actor">${move.actor}</p>
      <button onclick = "location.href = '${move.move_link}'" class = "searchButton">상세보기</button>
      </c:forEach>
      
	<c:if test = "${sessionScope.loginList.userid != null}">
		<c:forEach var = "move" items = "${naverMove}">
		<c:forEach var = "like" items = "${movelist}">
			<c:set var = "reTitle1" value = "${move.title}"/>
			<c:set var = "reTitle2" value = "${fn:replace(reTitle1,'<b>','')}"/>
			<c:set var = "reTitle3" value = "${fn:replace(reTitle2,'</b>','')}"/>    	   	
		<c:if test = "${reTitle3 == like.movetitle}">
		<c:set var = "isLike" value = "N"/>
			<c:if test = "${reTitle3 == like.movetitle}">	   		
				<c:set var = "isLike" value = "Y"/>
			</c:if>
			<c:if test = "${isLike =='Y'}">
				<br><h1>찜 하기<a onclick = "like(this)"> <i class="far fa-heart"></i></a></h1>
			</c:if>
			<c:if test = "${isLike =='N'}">
				<br><h1>찜 하기<a onclick = "like(this)"> <i class="fas fa-heart"></i></a></h1>${move.title},${reTitle3},${isLike}
			</c:if>
		</c:if>		      	
		</c:forEach>
		</c:forEach>
		
		<c:if test = "${reTitle3 != like.movetitle}">
			<c:if test = "${isLike == N }">
				<br><h1>찜 하기<a onclick = "like(this)"> <i class="fas fa-heart"></i></a></h1>
				<c:set var = "isLike" value = "X"/>
			</c:if>
		</c:if>
	</c:if>
	<c:if test = "${sessionScope.loginList.userid == null}">
		<br><h1>찜 하기<a onclick = "like(this)"> <i class="fas fa-heart"></i></a></h1>
	</c:if>
    </div>  
  </div>
</div>
													


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
	
	function like(target){
		
		var heart = $(target).find('i')[0];
		var heartpom = heart.className == 'fas fa-heart' ? 'Y' : 'N';
		var param = { title : document.getElementById('title').innerText,
					  moveopen : document.getElementById('opendt').value,
					  nickname : document.getElementById('nickname').value
					};
		if(param.nickname != null && param.nickname != ""){
			if(heartpom == "Y"){
				 $.ajax({
				    type : 'POST',
				    url : "/movelike?like=insert",
				    data : param,
				    error : function(error) {
				        alert("Error!");
				    },
				    success : function(data) {		        
				        heart.className = "far fa-heart";
					    alert("찜 추가하셨습니다.");
				    },
				    complete : function() {
				    }
				}); 
			}else{
				 $.ajax({
				    type : 'POST',
				    url : "/movelike?like=delete",
				    data : param,
				    error : function(error) {
				        alert("Error!");
				    },
				    success : function(data) {		            	
				        heart.className = "fas fa-heart";
					    alert("찜 취소하였습니다.");
				    },
				    complete : function() {
				    }
				}); 
			}
		}else{
			alert("로그인 후 이용가능합니다.");
		}
	}
</script>

</body>
</html>