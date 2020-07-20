<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WeDaily Home Page</title>
<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>



<!-- 상단 메뉴바 css -->
<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/topMenu.css">

<link href="js/calendar/fullcalendar.css" />
<script src="js/common/jquery-ui.js"></script>
<script src="js/calendar/moment.min.js"></script>
<script src="js/calendar/fullcalendar.js"></script>
<style>
	
	 .link {
		text-decoration:none;
		color : #646464;
	}
	
	
	
	
	/* 순위판 게시글 CSS 테스트 */
	 	table {
		background: #aaa;
		border-collapse: separate;
		box-shadow: inset 0 1px 0 #fff;
		font-size: 12px;
		margin: 30px auto;
		text-align: left;
		width: 310px;
		margin-top:-3%;
		margin-left: 3%;
	}	
	
	th {
		background: url(https://jackrugile.com/images/misc/noise-diagonal.png), linear-gradient(#777, #444);
		border-left: 1px solid #555;
		border-right: 1px solid #777;
		border-top: 1px solid #555;
		border-bottom: 1px solid #333;
		box-shadow: inset 0 1px 0 #999;
		color: #fff;
	  font-weight: bold;
		padding: 10px 15px;
		position: relative;
		text-shadow: 0 1px 0 #000;	
	}
	
	th:after {
		background: linear-gradient(rgba(255,255,255,0), rgba(255,255,255,.08));
		content: '';
		display: block;
		height: 25%;
		left: 0;
		margin: 1px 0 0 0;
		position: absolute;
		top: 25%;
		width: 100%;
	}
	
	th:first-child {
		border-left: 1px solid #777;	
		box-shadow: inset 1px 1px 0 #999;
	}
	
	th:last-child {
		box-shadow: inset -1px 1px 0 #999;
	}
	
	td {
		border-right: 1px solid #fff;
		border-left: 1px solid #e8e8e8;
		border-top: 1px solid #fff;
		border-bottom: 1px solid #e8e8e8;
		padding: 10px 15px;
		position: relative;
		transition: all 300ms;
	}
	
	td:first-child {
		box-shadow: inset 1px 0 0 #fff;
	}	
	
	td:last-child {
		border-right: 1px solid #e8e8e8;
		box-shadow: inset -1px 0 0 #fff;
	}	
	
	tr {
		background: url(https://jackrugile.com/images/misc/noise-diagonal.png);	
	}
	
	tr:nth-child(odd) td {
		background: #f1f1f1 url(https://jackrugile.com/images/misc/noise-diagonal.png);	
	}
	
	tr:last-of-type td {
		box-shadow: inset 0 -1px 0 #fff; 
	}
	
	tr:last-of-type td:first-child {
		box-shadow: inset 1px -1px 0 #fff;
	}	
	
	tr:last-of-type td:last-child {
		box-shadow: inset -1px -1px 0 #fff;
	}	
	
	tbody:hover td {
		color: transparent;
		text-shadow: 0 0 3px #aaa;
	}
	
	tbody:hover tr:hover td {
		color: #444;
		text-shadow: 0 1px 0 #fff;
	} 
	/* 테스트 END  */
	
	
	/* 영화순위 CSS */
	/* .content {
  	 	/* height: 100%; */
 	 	font-family: monospace;
	}
	
	.ranking {
		padding: 1rem;
		height: 71%;
		width: 36%;
		position: fixed;
		top: 50%;
		left: 20%;
		transform: translate(-50%, -50%);
	}
	
	.ranking-title {
		font-family: cursive;		
	}
	
	.table-ranking {
	    /* font-size: 1rem; */
	    border-collapse: collapse;
	    /* width: 101%; */
	    border: ridge;
	    -webkit-text-stroke: medium;
	}
	
	.table-ranking td, .table-ranking-head {
	    text-align: left;
	    padding: 0.8rem;
	}
	
	.table-ranking tr:nth-child(even) {
	    background-color: #BBDDDE;
	}
	
	@media only screen and (max-width: 600px) {
	.ranking-title {
	    font-size: 1.5rem;
	    }
	.ranking {
		padding: 1rem;
		height: 80%;
		width: 80%;
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
	    }
	} */
/* 영화순위 CSS EXIT*/

/* 검색창 CSS  */
.flexsearch--wrapper {
  height: auto;
  width: auto;
  max-width: 100%;
  overflow: hidden;
  background: transparent;
  margin: 0;
  position: static;
}

.flexsearch--form {
  overflow: hidden;
  position: relative;
  width: 19%;
  left: 32%;
}

.flexsearch--input-wrapper {
  padding: 0 66px 0 0;
  /* Right padding for submit button width */
  overflow: hidden;
}

.flexsearch--input {
  width: 100%;
}

/***********************
 * Configurable Styles *
 ***********************/
.flexsearch {
  padding: 0 25px 0 200px;
  /* Padding for other horizontal elements */
}

.flexsearch--input {
  -webkit-box-sizing: content-box;
  -moz-box-sizing: content-box;
  box-sizing: content-box;
  height: 60px;
  padding: 0 46px 0 10px;
  border-color: #888;
  border-radius: 35px;
  /* (height/2) + border-width */
  border-style: solid;
  border-width: 5px;
  margin-top: 15px;
  color: #333;
  font-family: 'Helvetica', sans-serif;
  font-size: 26px;
  -webkit-appearance: none;
  -moz-appearance: none;
}

.flexsearch--submit {
  position: absolute;
  right: 0;
  top: 0;
  display: block;
  width: 60px;
  height: 60px;
  padding: 0;
  border: none;
  margin-top: 20px;
  /* margin-top + border-width */
  margin-right: 5px;
  /* border-width */
  background: transparent;
  color: #888;
  font-family: 'Helvetica', sans-serif;
  font-size: 40px;
  line-height: 60px;
}

.flexsearch--input:focus {
  outline: none;
  border-color: #333;
}

.flexsearch--input:focus.flexsearch--submit {
  color: #333;
}

.flexsearch--submit:hover {
  color: #333;
  cursor: pointer;
}

::-webkit-input-placeholder {
  color: #888;
}

input:-moz-placeholder {
  color: #888;
}

/****************
 * Pretify demo *
 ****************/
.h1 {
  float: left;
  margin: 25px;
  color: #333;
  font-family: 'Helvetica', sans-serif;
  font-size: 45px;
  font-weight: bold;
  line-height: 45px;
  text-align: center;
}


/* @@@@@@@@@@@ */


</style>


</head>
<body style = "background:#f6f1e7;">	
	<nav>
		<ul class = "wedailUl">	
			<c:if test = "${loginList.userid == null }">
				<li><a href="#news"></a></li>
				<li><a href="/WeDailyJoinView">로그인 | 회원가입</a></li>
				<li><a class="active" href="/move">Home</a></li>
				</h3><li class = "logo" style = "color: antiquewhite; margin: 10px; margin-right: 27%; font-size: 23px;">WeDaily</li>
	    	</c:if>
	    	<c:if test = "${loginList.userid != null}">
		    	<li><a href="#news"></a></li>		    	
		    	 <li class="sub-menu-parent" tab-index="0">
		    	 	<a href = "#">${loginList.userid}님!</a>
			    	 	<ul class="sub-menu">
	        				<li><a href="/WeDailyLogout">로그아웃</a></li>
	        			</ul>
		    	 </li>
		    	 <li style = "cursor: pointer;"><a onclick = "alert('서비스 준비중입니다.')">영화 예매</a></li>	
				<li><a class="active" href="/move">Home</a></li>
				</h3><li class = "logo" style = "color: antiquewhite; margin: 10px; margin-right: 31%; font-size: 23px;">WeDaily</li>	
	    	</c:if>	
	    </ul>
	</nav>
	
	
	
	
	<div class="flexsearch">
		<div class="flexsearch--wrapper">
			<form class="flexsearch--form" action = "/moveselect">
				<div class="flexsearch--input-wrapper">							
					<input class="flexsearch--input" type="search" name = "search" placeholder="검색창">
					<input class="flexsearch--submit" type="submit" value="&#10140;"/>
				</div>
			</form>
		</div>
	</div>
	
	<!-- test -->
 <table>
		<caption>
		<h1 style = "font-family: serif; margin-left: 30%;" align = "left">일별 순위</h1>		
		</caption>	
			<thead>
				<tr align = "center">
					<th style = "width:5%;">순위</th>
					<th style = "width:20%;">제목</th>
					<th style = "width:20%;">개봉일</th>		
					<!-- <th style = "width:15%;">일별</th>	
					<th style = "width:10%;">누적</th> 	-->					
				</tr>
			</thead>
			<tbody>
			<c:forEach var = "rank" items = "${rankArr}">
				<tr align = "center">
						<td>${rank.rank}</td>
						<td>
				        	<a class = "link" href = "https://search.naver.com/search.naver?sm=top_sug.pre&fbm=1&acr=1&acq=%EC%82%B4&qdt=0&ie=utf8&query=${rank.movieNm}">${rank.movieNm}</a>
				        </td>	
						<td>${rank.openDt} </td>
						<%-- <td>${rank.audiCnt}</td>
						<td>${rank.audiAcc}</td>	 --%>	
				</tr>																								
			</c:forEach>
			</tbody>
		</table>   
	<!-- test  -->
	
	
	

	
	 
		
	
	
<script >


</script>


</body>
</html>