<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Move Raking</title>

	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>

	<!-- font asoum-->
	<link rel="stylesheet" href="/resources/css/fontawesome/all.css">
	
	<!-- 메인페이지 CSS  -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/mainStyle.css">
	
	<!-- raking CSS  -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/move_raking.css">
	
	<style>
	.link {
		text-decoration:none;
		color : #0F86FF;
	}
	
	body {
		   background-image: url(https://previews.123rf.com/images/fabiopagani/fabiopagani1501/fabiopagani150100015/35293810-%EB%B9%88%ED%8B%B0%EC%A7%80-%EC%98%81%ED%99%94-%ED%8E%B8%EC%A7%91-%EB%B0%94%ED%83%95-%ED%99%94%EB%A9%B4%EC%97%90-%EC%B4%88%EC%A0%90%EC%9D%B4-%EB%B0%B1%EA%B7%B8%EB%9D%BC%EC%9A%B4%EB%93%9C%EC%97%90%EC%84%9C-%ED%9D%91%EB%B0%B1%EC%9C%BC%EB%A1%9C-%ED%96%88-%EB%B3%B4%EB%93%9C.jpg);
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




<div id="power-rankingDIV_1">
	<div id="power-rankingDIV_2" style = "margin-left:73%;">
		<table id="power-rankingTABLE_3">
			<tbody id="power-rankingTBODY_4">
				<tr id="power-rankingTR_5">
					<td colspan="5" id="power-rankingTD_6" style = "text-align:center;">
						  영화순위  ( ${daily} )
					</td>
				</tr>
				<tr id="power-rankingTR_7">
					<td id="power-rankingTD_8" style = "text-align:center;">
						RANK
					</td>
					<td id="power-rankingTD_9" style = "text-align:center;">
						Title / 제목
					</td>
					<td id="power-rankingTD_10" style = "text-align:right;">
						순위변동
					</td>
					<td id="power-rankingTD_11" style = "text-align:center;">
						상세정보
					</td>
				</tr>
				<c:forEach var = "rank" items = "${rankArr}">
				<tr id="power-rankingTR_12">
					<td id="power-rankingTD_13">
						${rank.rank}
					</td>
					<td id="power-rankingTD_14">
						<a href="http://espn.go.com/nfl/team/_/name/car/carolina-panthers" id="power-rankingA_15"></a>
						<div id="power-rankingDIV_16">
						</div>
						<div id="power-rankingDIV_17">
							<a class = "link" href="https://search.naver.com/search.naver?sm=top_sug.pre&fbm=1&acr=1&acq=%EC%82%B4&qdt=0&ie=utf8&query=${rank.movieNm}">${rank.movieNm}</a><br id="power-rankingBR_19" /><span id="power-rankingSPAN_20">${rank.rank}</span>
						</div>
					</td>
					<td id="power-rankingTD_21">
					<c:if test = "${rank.rankOldAndNew == 'NEW'}">
						<div id="power-rankingDIV_22"> <!-- 랭킹변동이 NEW 일경우  -->
						</div><span id="power-rankingSPAN_23"> ${rank.rankInten}</span><br id="power-rankingBR_24" /><span id="power-rankingSPAN_25">${rank.openDt}</span>
					</c:if>
					<c:if test = "${rank.rankOldAndNew == 'OLD'}">
						ㅡ<span id="power-rankingSPAN_23"> ${rank.rankInten}</span><br id="power-rankingBR_24" /><span id="power-rankingSPAN_25">${rank.openDt}</span>
					</c:if>
					</td>
					<td id="power-rankingTD_26">
						제목: [${rank.movieNm}]<br>개봉일자: ${rank.openDt}<br><br>오늘 관객수:${rank.audiCnt}명<br><br>누적관객수: ${rank.audiAcc}명<br><br>
						상영횟수:${rank.showCnt}회 (해당날짜기준)<br><br>
						<input type = "button" value = "상세보기" onclick = "location.href = 'https://search.naver.com/search.naver?sm=top_sug.pre&fbm=1&acr=1&acq=%EC%82%B4&qdt=0&ie=utf8&query=${rank.movieNm}'">
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
			</tbody>
		</table>
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
</script>

</body>
</html>