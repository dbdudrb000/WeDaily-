<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reservation Page</title>


	<!-- 모달 css -->
 	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/wedaily_modal.css">  
												
	<!-- 메인페이지 CSS  -->
	<link href="/resources/css/wedaily/mainStyle.css" rel="stylesheet" type="text/css">
	
	<!-- 영화예매 box CSS -->
	<link href="/resources/css/wedaily/reservation.css" rel="stylesheet" type="text/css">	
	
	<!-- font asoum-->
	<link rel="stylesheet" href="/resources/css/fontawesome/all.css">
		
	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>
<style>
	#hero {
		font-size: x-large;
   		font-family: cursive;
	}

	
</style>
</head>
<body style = "background:#f6f1e7;">

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
	      <h3 class="hero" id="hero">영화시간표 </h3>
	    </div>
	  </div>
	</div>
	
	<!-- codepen.io < https://codepen.io/atelierbram/pen/gusxF > -->
<label class="wrapper" for="states" style="text-align: center;">예매 지역 선택</label>
	<div class="button dropdown"> 
	  <select id="colorselector" onchange="Area()">
	  	 <option id = "start" value="#">지역을 선택해주십시오.</option>
	     <option value="seoul">서울</option>
	     <option value="gyeong_gi_do">경기</option>
	     <option value="incheon">인천</option>
	     <option value="gang_won_do">강원</option>
	     <option value="daejeon">대전/충청</option>
	     <option value="daegoo">대구</option>
	     <option value="busan">부산/울산</option>
	     <option value="gyeong_sang">경상</option>
	     <option value="junla">광주/전라/제주</option>
	  </select>
	</div>

	<div class="output"> 
	  <div id="movie" class="colors yellow"> </div>
	  <div id="movie2" class="colors red"> </div>
	</div>


  
<script>
	/* selectBox 지역을 선택하면  최상단에 필요없는 문구를 "=== 지역 선택 ===" 으로 change 해준다. */
	$(function() {
		  $('#colorselector').change(function(){
		    $('#start').text('=== 지역 선택 ===');
		    document.getElementById("movie").style.display = "block";
		  });
		});		
	
	
	function search(){
		var search = $("#search").val();
		var userid = $("#userid").val();
		if(search == ""){
			alert("정보를 입력해주세요.");
		}else{
			location.href = "/moveselect?search="+search+"&userid="+userid;
		}		
	}
	
	/* selectBox 지역 선택시 선택한것의 value 값을 가지고 와서 그에 맞는 object정보를 가지고 온다. */
	function Area(){
		document.getElementById("movie").innerHTML = "";
		var search = $("#colorselector option:selected").val();
		
		/* movieList() 함수는 selectbox 선택한 지역 value 값으로 그지역 상영관의 object정보들을 가지고 오는 함수이다. 
		       해당  상영관의 object 정보들이 return 된다.  */
		var reSearch = movieList(search);
		
		var obj = JSON.parse(reSearch);
		//alert(obj.AreaList[1].TheaterName + "length >> " + obj.AreaList.length);
		
		 for(var i=0; i<obj.AreaList.length; i++){
			document.getElementById("movie").innerHTML += '<a class='+obj.AreaList[i].TheaterCode + ' onclick="movieTime('+"'"+obj.AreaList[i].RegionCode+"'"+','+"'"+obj.AreaList[i].TheaterCode+"'"+')">' +obj.AreaList[i].TheaterName + " | ";
		}      // onclick
		 
	}
	
	/* 지역 value를 비교해서  Area() 함수로 해당 지역 object 정보들을 return 하는것. */
	function movieList(search){
		
		if(search == "seoul"){
			// 서울 상영관 list
			var seoul = '{"AreaList":[{"RegionCode":"01","TheaterCode":"0321","TheaterName":"CAR CINEMA"},{"RegionCode":"01","TheaterCode":"0056","TheaterName":"CGV강남","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0001","TheaterName":"CGV강변","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0229","TheaterName":"CGV건대입구","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0010","TheaterName":"CGV구로","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0063","TheaterName":"CGV대학로","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0252","TheaterName":"CGV동대문","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0230","TheaterName":"CGV등촌","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0009","TheaterName":"CGV명동","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0105","TheaterName":"CGV명동역 씨네라이브러리","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0011","TheaterName":"CGV목동","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0057","TheaterName":"CGV미아","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0030","TheaterName":"CGV불광","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0046","TheaterName":"CGV상봉","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0300","TheaterName":"CGV성신여대입구","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0088","TheaterName":"CGV송파","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0276","TheaterName":"CGV수유","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0150","TheaterName":"CGV신촌아트레온","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0040","TheaterName":"CGV압구정","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0112","TheaterName":"CGV여의도","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0059","TheaterName":"CGV영등포","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0074","TheaterName":"CGV왕십리","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0013","TheaterName":"CGV용산아이파크몰","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0131","TheaterName":"CGV중계","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0199","TheaterName":"CGV천호","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0107","TheaterName":"CGV청담씨네시티","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0223","TheaterName":"CGV피카디리1958","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0164","TheaterName":"CGV하계","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"0191","TheaterName":"CGV홍대","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"P001","TheaterName":"CINE de CHEF 압구정","TheaterName_ENG":null,"IsSelected":false},{"RegionCode":"01","TheaterCode":"P013","TheaterName":"CINE de CHEF 용산아이파크몰","TheaterName_ENG":null,"IsSelected":false}]}';		
			
				return seoul;   
		}else if(search == "gyeong_gi_do"){
			// 경기도 object
			var gyeong_gi_do = '{"AreaList":[{"RegionCode":"02","TheaterCode":"0260","TheaterName":"CGV경기광주"},{"RegionCode":"02","TheaterCode":"0255","TheaterName":"CGV고양행신"},{"RegionCode":"02","TheaterCode":"0257","TheaterName":"CGV광교"},{"RegionCode":"02","TheaterCode":"0266","TheaterName":"CGV광교상현"},{"RegionCode":"02","TheaterCode":"0232","TheaterName":"CGV구리"},{"RegionCode":"02","TheaterCode":"0188","TheaterName":"CGV김포운양"},{"RegionCode":"02","TheaterCode":"0126","TheaterName":"CGV김포풍무"},{"RegionCode":"02","TheaterCode":"0298","TheaterName":"CGV김포한강"},{"RegionCode":"02","TheaterCode":"0124","TheaterName":"CGV동백"},{"RegionCode":"02","TheaterCode":"0041","TheaterName":"CGV동수원"},'+
													'{"RegionCode":"02","TheaterCode":"0106","TheaterName":"CGV동탄"},{"RegionCode":"02","TheaterCode":"0265","TheaterName":"CGV동탄역"},{"RegionCode":"02","TheaterCode":"0233","TheaterName":"CGV동탄호수공원"},{"RegionCode":"02","TheaterCode":"0226","TheaterName":"CGV배곧"},{"RegionCode":"02","TheaterCode":"0155","TheaterName":"CGV범계"},{"RegionCode":"02","TheaterCode":"0015","TheaterName":"CGV부천"},{"RegionCode":"02","TheaterCode":"0194","TheaterName":"CGV부천역"},{"RegionCode":"02","TheaterCode":"0287","TheaterName":"CGV부천옥길"},{"RegionCode":"02","TheaterCode":"0049","TheaterName":"CGV복수원"},{"RegionCode":"02","TheaterCode":"0242","TheaterName":"CGV산본"},'+
													'{"RegionCode":"02","TheaterCode":"0106","TheaterName":"CGV동탄"},{"RegionCode":"02","TheaterCode":"0265","TheaterName":"CGV동탄역"},{"RegionCode":"02","TheaterCode":"0233","TheaterName":"CGV동탄호수공원"},{"RegionCode":"02","TheaterCode":"0226","TheaterName":"CGV배곧"},{"RegionCode":"02","TheaterCode":"0155","TheaterName":"CGV범계"},{"RegionCode":"02","TheaterCode":"0015","TheaterName":"CGV부천"},{"RegionCode":"02","TheaterCode":"0194","TheaterName":"CGV부천역"},{"RegionCode":"02","TheaterCode":"0287","TheaterName":"CGV부천옥길"},{"RegionCode":"02","TheaterCode":"0049","TheaterName":"CGV복수원"},{"RegionCode":"02","TheaterCode":"0242","TheaterName":"CGV산본"},'+
													'{"RegionCode":"02","TheaterCode":"0196","TheaterName":"CGV서현"},{"RegionCode":"02","TheaterCode":"0304","TheaterName":"CGV성남모란"},{"RegionCode":"02","TheaterCode":"0143","TheaterName":"CGV소풍"},{"RegionCode":"02","TheaterCode":"0012","TheaterName":"CGV수원"},{"RegionCode":"02","TheaterCode":"0274","TheaterName":"CGV스타필드시티위례"},{"RegionCode":"02","TheaterCode":"0073","TheaterName":"CGV시흥"},{"RegionCode":"02","TheaterCode":"0211","TheaterName":"CGV안산"},{"RegionCode":"02","TheaterCode":"0279","TheaterName":"CGV안성"},{"RegionCode":"02","TheaterCode":"0003","TheaterName":"CGV야탑"},{"RegionCode":"02","TheaterCode":"0262","TheaterName":"CGV양주옥정"},'+
													'{"RegionCode":"02","TheaterCode":"0029","TheaterName":"CGV역곡"},{"RegionCode":"02","TheaterCode":"0004","TheaterName":"CGV오리"},{"RegionCode":"02","TheaterCode":"0305","TheaterName":"CGV오산"},{"RegionCode":"02","TheaterCode":"0307","TheaterName":"CGV오산중앙"},{"RegionCode":"02","TheaterCode":"0271","TheaterName":"CGV용인"},{"RegionCode":"02","TheaterCode":"0113","TheaterName":"CGV의정부"},{"RegionCode":"02","TheaterCode":"0187","TheaterName":"CGV의정부태흥"},{"RegionCode":"02","TheaterCode":"0205","TheaterName":"CGV이천"},{"RegionCode":"02","TheaterCode":"0054","TheaterName":"CGV일산"},{"RegionCode":"02","TheaterCode":"0320","TheaterName":"CGV정왕"},'+
													'{"RegionCode":"02","TheaterCode":"0055","TheaterName":"CGV죽전"},{"RegionCode":"02","TheaterCode":"0148","TheaterName":"CGV파주문산"},{"RegionCode":"02","TheaterCode":"0310","TheaterName":"CGV파주야당"},{"RegionCode":"02","TheaterCode":"0181","TheaterName":"CGV판교"},{"RegionCode":"02","TheaterCode":"0195","TheaterName":"CGV평촌"},{"RegionCode":"02","TheaterCode":"0052","TheaterName":"CGV평택"},{"RegionCode":"02","TheaterCode":"0214","TheaterName":"CGV평택소사"},{"RegionCode":"02","TheaterCode":"0309","TheaterName":"CGV포천"},{"RegionCode":"02","TheaterCode":"0301","TheaterName":"CGV화성봉담"},{"RegionCode":"02","TheaterCode":"0145","TheaterName":"CGV화정"}]}';   													
				return gyeong_gi_do;
		}else if(search == "incheon"){
			// 인천 상영관 list
			var incheon = '{"AreaList" : [{"RegionCode":"202","TheaterCode":"0043","TheaterName":"CGV계양 "},{"RegionCode":"202","TheaterCode":"0198","TheaterName":"CGV남주안 "},{"RegionCode":"202","TheaterCode":"0021","TheaterName":"CGV부평 "},{"RegionCode":"202","TheaterCode":"0247","TheaterName":"CGV연수역"},{"RegionCode":"202","TheaterCode":"0002","TheaterName":"CGV인천"},{"RegionCode":"202","TheaterCode":"0118","TheaterName":"CGV인천공항"},{"RegionCode":"202","TheaterCode":"0254","TheaterName":"CGV인천논현"},{"RegionCode":"202","TheaterCode":"0258","TheaterName":"CGV인천연수"},{"RegionCode":"202","TheaterCode":"0269","TheaterName":"CGV인천학익 "},{"RegionCode":"202","TheaterCode":"0308","TheaterName":"CGV주안역"},{"RegionCode":"202","TheaterCode":"0235","TheaterName":"CGV청라"}]}';
		
				return incheon;			
		}else if(search == "gang_won_do"){
			// 강원도 상영관 list
			var gang_won_do = '{"AreaList" : [{"RegionCode":"12","TheaterCode":"0139","TheaterName":"CGV강릉 "},{"RegionCode":"12","TheaterCode":"0144","TheaterName":"CGV원주 "},{"RegionCode":"12","TheaterCode":"0281","TheaterName":"CGV인제 "},{"RegionCode":"12","TheaterCode":"0070","TheaterName":"CGV춘천 "}]}';
			
				return gang_won_do;		
		}else if(search == "daejeon"){
			// 대천/충천 상영관 list
			var daejeon = '{"AreaList" : [{"RegionCode":"03%2C205","TheaterCode":"0207","TheaterName":"CGV당진"},{"RegionCode":"03%2C205","TheaterCode":"0007","TheaterName":"CGV대전"},{"RegionCode":"03%2C205","TheaterCode":"0286","TheaterName":"CGV대전가수원"},{"RegionCode":"03%2C205","TheaterCode":"0154","TheaterName":"CGV대전가오"},{"RegionCode":"03%2C205","TheaterCode":"0202","TheaterName":"CGV대전탄방"},{"RegionCode":"03%2C205","TheaterCode":"0127","TheaterName":"CGV대전터미널"},{"RegionCode":"03%2C205","TheaterCode":"0275","TheaterName":"CGV보령"},{"RegionCode":"03%2C205","TheaterCode":"0091","TheaterName":"CGV서산"},{"RegionCode":"03%2C205","TheaterCode":"0219","TheaterName":"CGV세종"},{"RegionCode":"03%2C205","TheaterCode":"0206","TheaterName":"CGV유성노은"},'+
											'{"RegionCode":"03%2C205","TheaterCode":"0044","TheaterName":"CGV천안"},{"RegionCode":"03%2C205","TheaterCode":"0293","TheaterName":"CGV천안터미널"},{"RegionCode":"03%2C205","TheaterCode":"0110","TheaterName":"CGV천안펜타포트"},{"RegionCode":"03%2C205","TheaterCode":"0228","TheaterName":"CGV청주(서문)"},{"RegionCode":"03%2C205","TheaterCode":"0297","TheaterName":"CGV청주성안길"},{"RegionCode":"03%2C205","TheaterCode":"0282","TheaterName":"CGV청주율량"},{"RegionCode":"03%2C205","TheaterCode":"0142","TheaterName":"CGV청주지웰시티"},{"RegionCode":"03%2C205","TheaterCode":"0319","TheaterName":"CGV청주터미널"},{"RegionCode":"03%2C205","TheaterCode":"0284","TheaterName":"CGV충북혁신"},{"RegionCode":"03%2C205","TheaterCode":"0217","TheaterName":"CGV홍성"}]}';	
				return daejeon;			
		}else if(search == "daegoo"){
		// 대구 상영관 list
			var daegoo = '{"AreaList" : [{"RegionCode":"11","TheaterCode":"0058","TheaterName":"CGV대구"},{"RegionCode":"11","TheaterCode":"0157","TheaterName":"CGV대구수성"},{"RegionCode":"11","TheaterCode":"0108","TheaterName":"CGV대구스타디움"},{"RegionCode":"11","TheaterCode":"0185","TheaterName":"CGV대구아카데미"},{"RegionCode":"11","TheaterCode":"0216","TheaterName":"CGV대구월성"},{"RegionCode":"11","TheaterCode":"0117","TheaterName":"CGV대구이시아"},{"RegionCode":"11","TheaterCode":"0071","TheaterName":"CGV대구칠곡"},{"RegionCode":"11","TheaterCode":"0147","TheaterName":"CGV대구한일"},{"RegionCode":"11","TheaterCode":"0109","TheaterName":"CGV대구현대"}]}';
		
				return daegoo;
		}else if(search == "busan"){
		// 부산/울산 상영관 list
			var busan = '{"AreaList" : [{"RegionCode":"05%2C207","TheaterCode":"0065","TheaterName":"CGV남포"},{"RegionCode":"05%2C207","TheaterCode":"0061","TheaterName":"CGV대연"},{"RegionCode":"05%2C207","TheaterCode":"0042","TheaterName":"CGV동래"},{"RegionCode":"05%2C207","TheaterCode":"0005","TheaterName":"CGV서면"},{"RegionCode":"05%2C207","TheaterCode":"0285","TheaterName":"CGV서면삼정타워"},{"RegionCode":"05%2C207","TheaterCode":"0089","TheaterName":"CGV센텀시티"},{"RegionCode":"05%2C207","TheaterCode":"0160","TheaterName":"CGV아시아드"},{"RegionCode":"05%2C207","TheaterCode":"0128","TheaterName":"CGV울산삼산"},{"RegionCode":"05%2C207","TheaterCode":"0264","TheaterName":"CGV울산신천"},{"RegionCode":"05%2C207","TheaterCode":"0246","TheaterName":"CGV울산진장"},'+
										'{"RegionCode":"05%2C207","TheaterCode":"0306","TheaterName":"CGV정관"},{"RegionCode":"05%2C207","TheaterCode":"0245","TheaterName":"CGV하단아트몰링"},{"RegionCode":"05%2C207","TheaterCode":"0318","TheaterName":"CGV해운대"},{"RegionCode":"05%2C207","TheaterCode":"0159","TheaterName":"CGV화명"},{"RegionCode":"05%2C207","TheaterCode":"0089","TheaterName":"CINE de CHEF 센텀"}]}';
			
				return busan;	
		}else if(search == "gyeong_sang"){
			// 경상 상영관 list
			var gyeong_sang = '{"AreaList" : [{"RegionCode":"204","TheaterCode":"0263","TheaterName":"CGV거제"},{"RegionCode":"204","TheaterCode":"0053","TheaterName":"CGV구미"},{"RegionCode":"204","TheaterCode":"0240","TheaterName":"CGV김천율곡"},{"RegionCode":"204","TheaterCode":"0028","TheaterName":"CGV김해"},{"RegionCode":"204","TheaterCode":"0311","TheaterName":"CGV김해율하"},{"RegionCode":"204","TheaterCode":"0239","TheaterName":"CGV김해장유"},{"RegionCode":"204","TheaterCode":"0033","TheaterName":"CGV마산"},{"RegionCode":"204","TheaterCode":"0097","TheaterName":"CGV북포항"},{"RegionCode":"204","TheaterCode":"0272","TheaterName":"CGV안동"},{"RegionCode":"204","TheaterCode":"0222","TheaterName":"CGV양산물금"},'+
													'{"RegionCode":"204","TheaterCode":"0234","TheaterName":"CGV양산삼호"},{"RegionCode":"204","TheaterCode":"0023","TheaterName":"CGV창원"},{"RegionCode":"204","TheaterCode":"0079","TheaterName":"CGV창원더시티"},{"RegionCode":"204","TheaterCode":"0156","TheaterName":"CGV통영"},{"RegionCode":"204","TheaterCode":"0045","TheaterName":"CGV포항"}]}';
				return gyeong_sang;			
		}else if(search == "junla"){
			// 광주/전라/제주 상영관 list    23
			var junla = '{"AreaList" : [{"RegionCode":"206%2C04","TheaterCode":"0220","TheaterName":"CGV광양"},{"RegionCode":"206%2C04","TheaterCode":"0221","TheaterName":"CGV광양 엘에프스퀘어"},{"RegionCode":"206%2C04","TheaterCode":"0295","TheaterName":"CGV광주금남로"},{"RegionCode":"206%2C04","TheaterCode":"0193","TheaterName":"CGV광주상무"},{"RegionCode":"206%2C04","TheaterCode":"0210","TheaterName":"CGV광주용봉"},{"RegionCode":"206%2C04","TheaterCode":"0218","TheaterName":"CGV광주첨단"},{"RegionCode":"206%2C04","TheaterCode":"0244","TheaterName":"CGV광주충장로"},{"RegionCode":"206%2C04","TheaterCode":"0090","TheaterName":"CGV광주터미널"},{"RegionCode":"206%2C04","TheaterCode":"0215","TheaterName":"CGV광주하남"},{"RegionCode":"206%2C04","TheaterCode":"0277","TheaterName":"CGV군산"},'+
										'{"RegionCode":"206%2C04","TheaterCode":"0237","TheaterName":"CGV나주"},{"RegionCode":"206%2C04","TheaterCode":"0289","TheaterName":"CGV목포"},{"RegionCode":"206%2C04","TheaterCode":"0280","TheaterName":"CGV목포평화광장"},{"RegionCode":"206%2C04","TheaterCode":"0225","TheaterName":"CGV서전주"},{"RegionCode":"206%2C04","TheaterCode":"0114","TheaterName":"CGV순천"},{"RegionCode":"206%2C04","TheaterCode":"0268","TheaterName":"CGV순천신대"},{"RegionCode":"206%2C04","TheaterCode":"0315","TheaterName":"CGV여수웅천"},{"RegionCode":"206%2C04","TheaterCode":"0020","TheaterName":"CGV익산"},{"RegionCode":"206%2C04","TheaterCode":"0213","TheaterName":"CGV전주고사"},{"RegionCode":"206%2C04","TheaterCode":"0179","TheaterName":"CGV전주효자"},'+
										'{"RegionCode":"206%2C04","TheaterCode":"0186","TheaterName":"CGV정읍"},{"RegionCode":"206%2C04","TheaterCode":"0302","TheaterName":"CGV제주"},{"RegionCode":"206%2C04","TheaterCode":"0259","TheaterName":"CGV제주노형"}]}';
				return junla;
		}
	} // movieList AND
	
	/* 해당 상영관을 클릭 하면 (지역 코드, 상영관 코드)를 받아와 controller에 보내는 펑션함수  */
	function movieTime(area, movies){
		// 	area:지역 코드  & movies:상영관 코드
		
		 var param = { area : area,
					   movies : movies 
					 }; 
						
		httpRequest = new XMLHttpRequest();

		if (!httpRequest) {
			alert('XMLHTTP 인스턴스를 만들 수가 없어요 ㅠㅠ');
			return false;
		}
		
		var formData = new FormData();
		formData.append('area', param.area);
		formData.append('movies', param.movies);
		
		httpRequest.onreadystatechange = alertContents;
		httpRequest.open('POST', '/movie_screening', true);
		httpRequest.send(formData);
		
		
	} // movieTime() AND 
	
	/* httpRequest 비동기 data를 보낸것을 alertContents() 로 통해 data를 받을 수 있다. */
	function alertContents() {
		if (httpRequest.readyState === XMLHttpRequest.DONE) {
			if (httpRequest.status === 200) {
				document.getElementById("movie2").style.display = "block";
				
				var titleList = JSON.parse(httpRequest.responseText).titleList;
				var movieHall = JSON.parse(httpRequest.responseText).movieHall;
				var movieTime = JSON.parse(httpRequest.responseText).movieTime;
				
				eleMake(titleList, movieHall, movieTime);
			} else {
				alert('request Error 발생!');
			}
		}
	} //alertContents() AND
	
	/* html안에 Element를 새롭게 그려주는 함수() */
	function eleMake(titleList, movieHall, movieTime){
		var draw = '';
		var time_count = 0;
		var hall_count = 0;
		
		for(var i=0; i<titleList.length; i++){
			draw += '<div class = "draws">';
			draw += '<i class="fas fa-ticket-alt"></i><span>'+titleList[i]+'</span><i class="fas fa-ticket-alt"></i><br><br>';
			for(var i2=0; i2<movieHall.length; i2++){
				
				if(movieHall[hall_count] == 'movieHall_checked'){
					hall_count++;
					break;
				}
				draw +='<i class="fas fa-tape"></i><span>[ '+movieHall[hall_count]+' ]</span><i class="fas fa-tape"></i><br>';
				hall_count++;
				
				for(var i3=0; i3<movieTime.length; i3++){
					if(movieTime[time_count] == 'movieTime_checked'){
						time_count++;
						break;
					}
					//draw += '[ <a onclick="alert('+"'"+movieTime[time_count]+"'"+')">'+movieTime[time_count]+'</a> ]<br><br>';
					draw += '[ <a onclick ="CgvReservation('+"'"+movieTime[time_count]+"'"+','+"'"+movieHall[hall_count-1]+"'"+')">'+movieTime[time_count]+'  ]</a><br><br>';
					time_count++;
					
				}
			}
			draw += '=====================================';
			draw += '</div>';
		}
		
		 document.getElementById("movie2").innerHTML = draw;
	} // eleMake() AND 
	
	/* CGV사이트로 영화 예매 하러가는 함수() 
	      마감된 시간표는 "마감된 영화표입니다." 라고 alert이 띄어진다.*/
	function CgvReservation(times,halls){
		 var result = confirm("헤당 상영관 : "+halls+"\n해당 영화시간 : "+times+"입니다.\n"+"CGV로 예매하러 가시겠습니까?\n\n※ 선택하신 정보는 자동입력 되지 않습니다. ※");
		 
		 if(times.indexOf("마감") != -1){
			 alert("마감된 영화표입니다.");
		 }else if(times.indexOf("매진") != -1){
			 alert('매진된 영화표입니다.');
		 }else if(result == true){
			 location.href="http://ticket.cgv.co.kr/Reservation/Reservation.aspx?MOVIE_CD=&MOVIE_CD_GROUP=&PLAY_YMD=20200903&THEATER_CD=0056&PLAY_NUM=&PLAY_START_TM=&AREA_CD=&SCREEN_CD=&THIRD_ITEM=";
		 }
		 
	}
	
	
</script>
	
</body>
</html>