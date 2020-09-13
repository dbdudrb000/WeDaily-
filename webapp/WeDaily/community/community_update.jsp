<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community Update Page</title>

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
	<!-- 에디터 -->
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	
<style>
	#editer_container {
		width: 50%;
	    margin-left: 25%;
	    margin-top: 8%;
	    position: relative;
    	top: -76px;
	}
	.editer_table input {
		width: 290px;
	    margin: 0px;
	    margin-left: 39px;
	}
	.editer_table th {
		font-size: larger;
    	font-weight: 600;
	}
	.editer_table td {
		width: 132px;
    	padding: 6px;
	}
	.editer_table {
		position: relative;
    	left: -30px;
	}
	.board_kind {
		position: relative;
    	right: -30px;
	}
	.kind_selectbox {
		margin-left: 12%;
 	    width: 32%;
	}
	.board_user {
		position: relative;
    	right: -7px;
	}
	.form_button {
		border-radius: 15px;
		    cursor: pointer;
	}
	#update_kind {
		position: relative;
	    left: -190%;
	    width: 85px;
	}
	#update_button {
		margin-left: 50%;
    	margin-top: 7px;
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
        	<li><a href="#">${loginList.nickname}님!</a></li> 
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
	      <h3 class="hero" id="hero">게시글 수정</h3>
	    </div>
	  </div>
	</div>
	
	<div id="editer_container">
		<form name="community_form" action="/boardUpdate_logic" method="POST">
			<table class="editer_table">
			<tr>
				<th>제목</th>
				<td><input type="text" name="update_title" value="${updateList.board_title}"></td>
				<input type="hidden" value="${updateList.board_number}" name="update_number">
			</tr>
			<tr>
				<th class="board_kind">게시글 종류</th>
				<td><input type="text" value="${updateList.board_kind}" name="update_kind" id="search_kind" style="width: 60px;  text-align: center;">
				</td>
				<td>
					<select class="kind_selectbox" name="select_kind" onchange="kind_change()" id="update_kind">
						<option value="">선택없음</option>
						<option value="영화추천">영화추천</option>
						<option value="감독추천">감독추천</option>
						<option value="배우추천">배우추천</option>
						<option value="감상평">감상평</option>
					</select>
				</td>
			</tr>
			<tr>
				<th class="board_user">작성자</th>
				<td>
					<input type="text" name="update_user" value="${updateList.board_user}" readonly style="background-color: #e2e2e2; border-style: outset;">
				</td>
			</tr>		
			</table>
				<textarea id="summernote" name="update_detail">${updateList.board_detail}</textarea>			
			<div style="margin-left: 81%;">    	
				<button type="button" onclick="updateSubmit()" class="form_button" id="update_button">수정하기</button>
			</div>
		</form>
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

	/* summernote 활성화 하기위해 필요한 javascript code */
	$('#summernote').summernote({
	    placeholder: 'Hello stand alone ui',
	    tabsize: 2,
	    height: 300,
	    toolbar: [
	      ['style', ['style']],
	      ['font', ['bold', 'underline', 'clear']],
	      ['color', ['color']],
	      ['para', ['ul', 'ol', 'paragraph']],
	      ['table', ['table']],
	      ['insert', ['link', 'picture', 'video']],
	      ['view', ['fullscreen', 'codeview', 'help']]
	    ]
	  });
	
	/* kind 선택한걸로 체인지 */
	function kind_change(){
		var kind = $("select[name=select_kind]").val();
		var search = document.getElementById("search_kind");
		
		search.value = kind;	
	} //kind_change() AND
	
	function updateSubmit(){
		var context = confirm("수정하시겠습니까?");
		
		if(context){
			community_form.submit();
		}
	}
</script>
</body>
</html>