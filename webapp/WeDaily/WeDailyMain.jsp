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
	
	
	
	/* 영화순위 CSS */
	.content {
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
	}
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


</style>


</head>
<body>	
	<nav>
		<ul>
			
			<c:if test = "${loginList.userid == null }">
				<li><a href="#news"></a></li>
				<li><a href="/WeDailyJoinView">로그인 | 회원가입</a></li>
				<li><a class="active" href="/move2">Home</a></li>
				</h3><li class = "logo" style = "color: antiquewhite; margin: 10px; margin-right: 31%; font-size: 23px;">WeDaily</li>
	    	</c:if>
	    	<c:if test = "${loginList.userid != null}">
		    	<li><a href="#news"></a></li>
				<li><a href = "#">${loginList.userid}님!</a></li>
				<li><a class="active" href="/move2">Home</a></li>
				</h3><li class = "logo" style = "color: antiquewhite; margin: 10px; margin-right: 31%; font-size: 23px;">WeDaily</li>	
	    	</c:if>
	    	
	    </ul>
	</nav>
	
	
	<div class="flexsearch">
		<div class="flexsearch--wrapper">
			<form class="flexsearch--form" action = "/moveselect">
				<div class="flexsearch--input-wrapper">
					<input class="flexsearch--input" type="search" name = "search" placeholder="검색창">
				</div>
					<input class="flexsearch--submit" type="submit" value="&#10140;"/>
			</form>
		</div>
	</div>
	
	<!-- 영화순위 -->
	<div class="content">
  <div class="ranking">
    <h2 class="ranking-title">일별 영화순위</h2>
    <table class="table-ranking">
      <tr>
        <th class="table-ranking-head">순위</th>
        <th class="table-ranking-head">제목</th>
        <th class="table-ranking-head">개봉일</th>
        <th class="table-ranking-head">일간</th>
        <th class="table-ranking-head">누적</th>
      </tr>
      <c:forEach var = "rank" items = "${rankArr}">
	      <tr class="table-ranking-content">
	        <td>${rank.rank}</td>
	        <td>
	        	<a class = "link" href = "https://search.naver.com/search.naver?sm=top_sug.pre&fbm=1&acr=1&acq=%EC%82%B4&qdt=0&ie=utf8&query=${rank.movieNm}">${rank.movieNm}</a>
	        </td>																																	
	        <td>${rank.openDt}</td>
	        <td>${rank.audiCnt}명</td>
	        <td>${rank.audiAcc}명</td>
	      </tr>
      </c:forEach>
      
      <!-- Show just top 5 on  the table -->
    </table>
  </div>
</div>
	
	
	
<script >

</script>


</body>
</html>