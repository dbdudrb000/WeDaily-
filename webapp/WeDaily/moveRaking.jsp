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
	
	</style>
</head>
<body>
<div class="hold">
  <div class="header">
    <div class="container">
      <a href = "/moveMain">
      	<div id="logo"></div>
      </a>
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




<div id="power-rankingDIV_1">
	<div id="power-rankingDIV_2" style = "margin-left:73%;">
		<table id="power-rankingTABLE_3">
			<tbody id="power-rankingTBODY_4">
				<tr id="power-rankingTR_5">
					<td colspan="5" id="power-rankingTD_6" style = "text-align:center;">
						  영화순위
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
						<div id="power-rankingDIV_82"> <!-- 랭킹변동이 OLD 일경우  -->
						</div><span id="power-rankingSPAN_23"> ${rank.rankInten}</span><br id="power-rankingBR_24" /><span id="power-rankingSPAN_25">${rank.openDt}</span>
					</c:if>
					</td>
					<td id="power-rankingTD_26">
						The Panthers are the seventh team in NFL history to win 15 games or more in the regular season. Three of the previous six made the Super Bowl and two won it.
					</td>
				</tr>
				<!-- <tr id="power-rankingTR_27">
					<td id="power-rankingTD_28">
						2
					</td>
					<td id="power-rankingTD_29">
						<a href="http://espn.go.com/nfl/team/_/name/den/denver-broncos" id="power-rankingA_30"></a>
						<div id="power-rankingDIV_31">
						</div>
						<div id="power-rankingDIV_32">
							<a href="http://espn.go.com/nfl/team/_/name/den/denver-broncos" id="power-rankingA_33">Broncos</a><br id="power-rankingBR_34" /><span id="power-rankingSPAN_35">12-4</span>
						</div>
					</td>
					<td id="power-rankingTD_36">
						<div id="power-rankingDIV_37">
						</div><span id="power-rankingSPAN_38">2</span><br id="power-rankingBR_39" /><span id="power-rankingSPAN_40">Last Week: 4</span>
					</td>
					<td id="power-rankingTD_41">
						Peyton Manning is back, but the Broncos just need someone to protect the ball. They ranked first in total defense for the first time in franchise history.
					</td>
				</tr> -->
				</c:forEach>
			</tbody>
		</table>
			</tbody>
		</table>
	</div>
</div>




</body>
</html>