<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community Main Page</title>
	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>
	
	<!-- 모달 css -->
 	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/wedaily_modal.css">  
												
	<!-- 메인페이지 CSS  -->
	<link href="/resources/css/wedaily/mainStyle.css" rel="stylesheet" type="text/css">
	
	<!-- 커뮤니티 메인 CSS -->
	<link href="/resources/css/wedaily/community_main.css" rel="stylesheet" type="text/css">	
	
	<!-- font asoum-->
	<link rel="stylesheet" href="/resources/css/fontawesome/all.css">
	
<style>
	.search_div {
		margin-left: 70%;
    	padding: 12px;
    }
	.search_button {
		background-color: thistle;
	}
	.nosearch > h3{
		position: relative;
    	left: 80%;
    	top: 20px;
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

	<div class="section">
	  <div class="slider">
	    <div class="container slidercontent">
	      <h3 class="hero" id="hero">커뮤니티 게시판</h3>
	    </div>
	  </div>
	</div>
	
	<div id="container">
		<aside class="board_aside">
			<ul>
				<li><a onclick="board_location('insert','${sessionScope.loginList.userid}')">게시글 작성</a></li>
			</ul>
		</aside>
		
		<form class="board_form">	
			<table class="type09">
			    <thead>
			    <tr>
			        <th scope="cols" style="text-align: center;">제목</th>
			        <th scope="cols" style="text-align: center;">내용</th>
			        <th scope="cols" style="text-align: center;">종류</th>
			        <th scope="cols" style="text-align: center;">작성자</th>
			        <th scope="cols" style="text-align: center;">날짜</th>
			    </tr>
			    </thead>
			    <tbody>
			    <c:if test = "${ !empty boardList}">
				    <c:forEach var="boardList" items="${boardList}">  
					    <tr>
					        <th scope="table_td">${boardList.board_title}</th>
					        <input type="hidden" value = "${boardList.board_number}" name="board_number">				        
					        <c:if test="${fn:contains(boardList.board_detail,'<p>')}">
					        	<td class="table_detail"><a href="/board_look?number=${boardList.board_number}&user=${boardList.board_user}" style="color: darkslategrey;">이미지가 첨부되어 있습니다.</a></td>
					        </c:if>
					        <c:if test="${!fn:contains(boardList.board_detail,'<p>')}">
					        	<td class="table_detail"><a href="/board_look?number=${boardList.board_number}&user=${boardList.board_user}" style="color: darkslategrey;">${boardList.board_detail}</a></td>
					        </c:if>    
					        <td class="table_th">${boardList.board_kind}</td>
					        <td class="table_th">${boardList.board_user}</td>
					        
					        <td class="table_th"><c:out value="${fn:substring(boardList.board_createdt,0,10)}"/></td>
					        
					        <td id="update_input">
					        <c:if test="${boardList.board_user == sessionScope.loginList.nickname}">
					        	<nav class="dropdownmenu">
								  <ul> 
								    <li><a href="#"><i class="fas fa-ellipsis-v"></i></a>
								      <ul id="submenu">
								        <li><a onclick="location.href='/board_updatePage?number=${boardList.board_number}&user=${boardList.board_user}'">수정</a></li>
								        <li><a onclick="location.href='/delete_board?number=${boardList.board_number}&user=${boardList.board_user}'">삭제</a></li>       
								      </ul>
								    </li>
								  </ul>
								</nav>
							</c:if>
					        </td>
					    </tr>
				    </c:forEach>
			    </c:if>
			    <c:if test = "${empty boardList}">
			     	<td class="nosearch"><h3>등록된 게시글이 없습니다.</h3></td>
			    </c:if>	    
			    </tbody>
			</table>
		</form>
	</div>

	<div class="search_div">
		<select id="search_kind">
			<option value="제목_내용">제목+내용</option>
			<option value="글종류">글 종류</option>
			<option value="글작성자">글작성자</option>
		</select>
		<input type="text" id="keyword">
		<input type="button" value="검색" onclick="bottom_search()" class="search_button">
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

		/* 상황에 맞게 page 이동 */
	function board_location(use,user){
			
		if(user != null && user != ''){	
			if(use == "insert"){
				location.href='/community_main?use='+use;			
			}else if(use == "update"){
				alert('미지정');
			}else{
				// 미지정
			}
		}else{
			alert('로그인 후 이용가능합니다.');
		}
	}
	
		/* 검색기능 */
	function bottom_search(){
		const kind = document.getElementById("search_kind").value;
		const keyword = document.getElementById("keyword").value;
		
		location.href="/board_search?kind="+kind+"&keyword="+keyword;
	}
		
	function search(){
		var search = $("#search").val();
		var userid = $("#userid").val();
		if(search == ""){
			alert("정보를 입력해주세요.");
		}else{
			location.href = "/moveselect?search="+search+"&userid="+userid;
		}		
	}
</script>
</body>
</html>