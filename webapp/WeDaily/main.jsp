<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.min.css">
<link rel="stylesheet" href="${contextPath}/resources/css/earth.css">
<!-- 22, 23번 설문 질문의 css -->
<link rel="stylesheet"
	href="${contextPath}/resources/css/searchStyle.css">
<link rel="stylesheet" href="${contextPath}/resources/css/basic.css">
<title>심리 테스트</title>

<style type="text/css">
.siwper-slide span {
	height: 100%;
	width: 100%;
}
</style>

</head>
<body>
	
	<%
				HttpServletRequest req = (HttpServletRequest) request;
				String type = req.getParameter("type");
				if("A".equals(type)){
					type = "A";
				}else{
					type = "B";
				}
	%>
	<input type="text" id="chkId" /><button type="button" onclick="chkIds(chkId.value);">학번 등록확인</button>
	<br/>
	<br/>
	<button type="button" id="nextButton" onclick="clickNext()">NEXT</button>
	<form action="/psy/submit" id="psyFrm">
	<input type="hidden" name="answers" id="answers">
	<input type="hidden" name="type" id="type" value="<%=type%>">
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<span>
					<div class="container">
						<a target="_blank" href="https://youtu.be/mgGNTDT-i68"> <!----0--->
							<div class="globe__placeholder">
								<div class="globe__container">
									<div class="globe">
										<div class="globe__sphere"></div>
										<div class="globe__outer_shadow"></div>
										<div class="globe__reflections__bottom"></div>
										<div class="globe__worldmap">
											<div class="globe__worldmap__back"></div>
											<div class="globe__worldmap__front"></div>
										</div>
										<div class="globe__inner_shadow"></div>
										<div class="globe__reflections__top"></div>
									</div>
								</div>
							</div>
						</a>
					</div>
				</span>
			</div>	
			<%
				if("A".equals(type)){
					type = "aType";
				}else{
					type = "bType";
				}
				for (int i = 1; i < 72; i++) {
			%>
				<%
					if (i != 1 && i != 2 && i!=22 && i!=23 && i!=28 && i!=34 && i!=40 && i!=46 && i!=52 && i!=58 && i!=64 && i!=71) {
				%>
				<div class="swiper-slide">
					<img src="${contextPath}/resources/images/<%=i %>.PNG" style="width:1326; height:741">
					<%=i%>
				</div>
				<%
					}else if( i == 1){
				%>
				
					<div class="swiper-slide">
						<section id="languagePage">
						<h1>Select Language!</h1>
							<button type="button" id="language" onclick="clickNext();">korea</button>
							<button type="button" id="language" onclick="alert('korea를 선택해주세요.');">english</button>
							<button type="button" id="language" onclick="alert('korea를 선택해주세요.');">china</button>
							<button type="button" id="language" onclick="alert('korea를 선택해주세요.');">japan</button>
							<button type="button" id="language" onclick="alert('korea를 선택해주세요.');">austrailia</button>
							<button type="button" id="language" onclick="alert('korea를 선택해주세요.');">tibet</button>
							<button type="button" id="language" onclick="alert('korea를 선택해주세요.');">vietnam</button>
							<button type="button" id="language" onclick="alert('korea를 선택해주세요.');">taiwan</button>
						</section>
						<%=i%>
					</div>
				
				<%
					}else if( i == 2 ){
				%>
				
					<div class="swiper-slide">
						<section class="question">
						<h1>Select Language!</h1>
							<label for="country">당신의 국적을 입력하세요</label><br>
							<input class="input" placeholder="입력하세요." type="text" id="country" name="question"/>
						</section>
						<%-- <%=i%> --%>
					</div>
				
				<% 
					} else if (i == 22 && "aType".equals(type) ) {
				%>
					<div class="swiper-slide">
		
						<section class="question">
								<h1>집단 인식 조사</h1>
		
								<p>당신이 현재 속해 있는 여러 집단 중 당신이 중요하게 여기는 집단 하나를 떠올려주십시오. (가족, 친지
									제외)</p>
								<div class="searchdiv">
									<p>집단은 고유한 특성을 가진 개개인이 모인 집합체입니다. 당신이 떠올린 집단의 대다수 사람들과 당신은 어떤
										점에서 다른지 아래 빈 칸에 세 가지 이상 적어주십시오.</p>
								</div>
								
								<label for="fname">1. 당신이 떠올린 집단은 무엇입니까?</label><br> 
								<input class="input" placeholder="1." type="text" id="fname" name="question"><br> 
								<label for="differenceA1">2. 당신이 떠올린 집단의 대다수 사람들과 당신은 어떤 점에서 다릅니까?</label><br> 
								<input class="input" placeholder="1." type="text" id="differenceA1"	name="question"><br> 
								<input class="input" placeholder="2." type="text" id="differenceA2" name="question"><br>
								<input class="input" placeholder="3." type="text" id="differenceA3" name="question"><br> 
								
						</section>
						<%=i%>
					</div>
				<%
					} else if(i==23 && !("aType".equals(type)) ){
				%>
					<div class="swiper-slide">
		
						<section class="question">
								<h1>집단 인식 조사</h1>
								<p>당신이 현재 속해 있는 여러 집단 중 당신이 중요하게 여기는 집단 하나를 떠올려주십시오. (가족, 친지
									제외)</p>
								<div class="searchdiv">
									<p>집단은 비슷한 특성을 공유하는 개인들이 모인 집합체입니다. 당신이 떠올린 집단의 대다수 사람들과 당신은
										어떤 점에서 유사한지 아래 빈 칸에 세 가지 이상 적어주십시오.</p>
								</div>
								
								<label for="group1">1. 당신이 떠올린 집단은 무엇입니까?</label><br> 
								<input	class="input" type="text" placeholder="1." id="fname" name="question"><br> 
								<label for="differenceB1">2. 당신이 떠올린 집단의 대다수 사람들과 당신은 어떤 점에서 다릅니까?</label><br> 
								<input class="input" type="text" placeholder="1." id="differenceB1"	name="question"><br> 
								<input class="input" type="text" placeholder="2." id="differenceB2" name="question"><br>
								<input class="input" type="text" placeholder="3." id="differenceB3"	name="question"><br> 
		
						</section>
						<%=i%>
					</div>
				<%
					}else if(i==28){
				%>
					    <div class="swiper-slide">
					    <img src="${contextPath}/resources/images/28.png" style="width:1326; height:741"><br>

					    <section class = "question" data-total="100">
					        <input class="input" type="number" placeholder="한국 투자액" id="korea" name="question">억<br>       
				            <input class="input" type="number" placeholder="아시아 투자액" id="asia" name="question">억<br>      
					
					    </section>
					    <%=i %>
					    </div>
				<%
					}else if(i==34){
				%>
						<div class="swiper-slide">
						<img src="${contextPath}/resources/images/34.png" style="width:1326; height:741"><br>
	
					    <section class = "question" data-total="148">
				            <input class="input" type="number" placeholder="한국 투자액" id="korea" name="question">억<br>       
				            <input class="input" type="number" placeholder="아시아 투자액" id="asia" name="question">억<br>      
					    
					    </section>
					    <%=i %>
					    </div>
				<%
					}else if(i==40){
				%>
						<div class="swiper-slide">
						<img src="${contextPath}/resources/images/40.png" style="width:1326; height:741"><br>
	
					    <section class = "question" data-total="112">
				            <input class="input" type="number" placeholder="한국 투자액" id="korea" name="question">억<br>       
				            <input class="input" type="number" placeholder="아시아 투자액" id="asia" name="question">억<br>      
					    
					    </section>
					    <%=i %>
					    </div>
				<%
					}else if(i==46){
				%>
						<div class="swiper-slide">
						<img src="${contextPath}/resources/images/46.png" style="width:1326; height:741"><br>
	
					    <section class = "question" data-total="82">
				            <input class="input" type="number" placeholder="한국 투자액" id="korea" name="question">억<br>       
				            <input class="input" type="number" placeholder="아시아 투자액" id="asia" name="question">억<br>      
					    
					    </section>
					    <%=i %>
					    </div>
				<%
					}else if(i==52){
				%>
						<div class="swiper-slide">
						<img src="${contextPath}/resources/images/52.png" style="width:1326; height:741"><br>
	
					    <section class = "question" data-total="62">
				            <input class="input" type="number" placeholder="한국 투자액" id="korea" name="question">억<br>       
				            <input class="input" type="number" placeholder="아시아 투자액" id="asia" name="question">억<br>      
					    
					    </section>
					    <%=i %>
					    </div>
				<%
					}else if(i==58){
				%>
						<div class="swiper-slide">
						<img src="${contextPath}/resources/images/58.png" style="width:1326; height:741"><br>
	
					    <section class = "question" data-total="54">
				            <input class="input" type="number" placeholder="한국 투자액" id="korea" name="question">억<br>       
				            <input class="input" type="number" placeholder="아시아 투자액" id="asia" name="question">억<br>      
					    
					    </section>
					    <%=i %>
					    </div>
				<%
					}else if(i==64){
				%>
						<div class="swiper-slide">
						<img src="${contextPath}/resources/images/64.png" style="width:1326; height:741"><br>
	
					    <section class = "question" data-total="26">
				            <input class="input" type="number" placeholder="한국 투자액" id="korea" name="question">억<br>       
				            <input class="input" type="number" placeholder="아시아 투자액" id="asia" name="question">억<br>      
					    
					    </section>
					    <%=i %>
					    </div>
				<%
					} else if(i==71){
				%>
						<div class="swiper-slide">
						<h1>실험이 종료되었습니다. 크레딧 부여를 위한 정보를 입력해주십시오.</h1>
						<section class = "question">
					    	<input class="input" type="text" id="name" name="question" placeholder="name"><br>
					    	<input class="input" type="number" id="id" name="question" placeholder="id">
					    </section>
					    <%=i %>
					    </div>
				<%
					}
				%>
			<%
			}
			%>
			<input type="hidden" name="ar">
			
			<div class="swiper-slide">
<!-- 				<img src="https://image.flaticon.com/icons/png/128/1933/1933588.png" alt=""> -->
					<br> 수고하셨습니다.
			</div>

		</div>
	</div>
	</form>
	<!-- Swiper JS -->
	<script src="https://unpkg.com/swiper/js/swiper.js"></script>
	<!-- Include plugin after Swiper -->
	
	<script>
		
		var count = 0;
		var answer = [];
		var id = "이름|학번";
		
		function clickNext() {
			//마지막 페이지 여부 ? true -> id "이름|학번";
			//문제 여부 ? ture -> 해당 문제의 답 answer.push();
			//해당 페이지에 입력 값이 있는 지 체크
			//console.log(this);
			document.getElementById("nextButton").style.display="none";
			
			//국가 선택 화면에서는 next 버튼을 안보이게..
			if( swiper.activeIndex == 0 ){
				document.getElementById("nextButton").style.display="none";
			}
			else if( swiper.activeIndex == 71 ){
				document.getElementById("nextButton").style.display="none";
			}
			else {
				setTimeout(function() {
					//버튼보이기
					document.getElementById("nextButton").style.display="block";		
				}, 0500);
			}
			
			var input = document.getElementsByClassName("input");
			var loc = document.getElementsByClassName("swiper-slide")[swiper.activeIndex];
			var question = "question";
			var pass = true;
			var last = false;
			var page = swiper.activeIndex + 2;
			
			var inputValue = "";
			
		    	
	    	var secQ = "";
			for(var j = 0; j< loc.children.length; j++){
			    if(loc.children[j].className == "question"){
			    	secQ = loc.children[j];
			    }
			}
	    	
	    	//loc.getElementsByClassName('question')[0].children
	    	if(secQ){
		    	for(var j = 0; j< secQ.children.length; j++){
		    		if(secQ.children[j].name === question){
			    		if(secQ.children[j].value===""){
			    			pass = false;
			    		}
			    		
			    		//입력한 값 대입
			    		inputValue = secQ.children[j].value;
			    		if( swiper.activeIndex == 2 && ( inputValue != "대한민국" && inputValue != "한국" ) ){
			    			pass = false;
			    		}
			    		
		    		}
		    	}
	    
	    	
		    	//값이 모두 입력되었을때.
		    	if(pass){
		    		
		    		// 예산일때
		    		if(secQ.dataset.total){
		    			var price = 0;
		    			var total = secQ.dataset.total;
		    			for(var k =0; k<secQ.children.length; k++) {
		    			    if(secQ.children[k].type == "number"){
		    			        price = price + parseInt(secQ.children[k].value);
		    			    }
		    			}
		    			console.log("total : " + total);
		    			console.log("price : " + price);
		    			if(total == price){
		    				for(var l =0; l<secQ.children.length; l++) {
		    					if(secQ.children[l].type == "number"){
	    							answer.push(secQ.children[l].value);
		    					}
		    				}
	    				}else{
	    					pass = "numberErr";
	    				}
	
		    		// 문자일때
		    		} else {
		    			for(var k =0; k<secQ.children.length; k++) {
		    			    if(secQ.children[k].className == "input"){
				    			answer.push(secQ.children[k].value);
		    			    }
		    			}
		    		}
		    		
		    	}
			    	
	    	}
				
			if( swiper.activeIndex == 2 && ( inputValue != "대한민국" && inputValue != "한국" ) ){
				//대한민국 or 한국 만 입력받게..
				alert("대한민국 또는 한국만 입력해주세요.");
			} else if( pass == "numberErr"){
				alert("예산의 합이 맞지 않습니다.");
			}else if(pass && page === swiper.slides.length){
				//끝페이지
				if(chkIds(document.getElementById("id").value)){
					swiper.slideNext();
					console.log(answer);
					//Save
					saveAnswer( answer );
				}
			}else if( pass && page < swiper.slides.length ){
				//문항들..
					alert("next 버튼");
				swiper.slideNext();
					alert("next 버튼22");
			}else{
				alert("항목을 입력해주세요.");
			}
		}
		
		
		/* ========
		Debugger plugin, simple demo plugin to console.log some of callbacks
		======== */
		var myPlugin = {
			name : 'debugger',
			params : {
				debugger : false,
			},
			on : {
				init : function() {
					if (!this.params.debugger)
						return;
					//console.log('init');
				},
				click : function(e) {
					if (!this.params.debugger)
						return;
					//console.log('click');
				},
				tap : function(e) {
					if (!this.params.debugger)
						return;
					//console.log('tap');
				},
				doubleTap : function(e) {
					if (!this.params.debugger)
						return;
					//console.log('doubleTap');
				},
				sliderMove : function(e) {
					if (!this.params.debugger)
						return;
					//console.log('sliderMove');
				},
				slideChange : function() {
					if (!this.params.debugger)
						return;
					//console.log('slideChange', this.previousIndex, '->',
					//		this.activeIndex);
				},
				slideChangeTransitionStart : function() {
					if (!this.params.debugger)
						return;
					//console.log('slideChangeTransitionStart');
				},
				slideChangeTransitionEnd : function() {
					if (!this.params.debugger)
						return;
					//console.log('slideChangeTransitionEnd');
				},
				transitionStart : function() {
					if (!this.params.debugger)
						return;
					//console.log('transitionStart');
				},
				transitionEnd : function() {
					if (!this.params.debugger)
						return;
					//console.log('transitionEnd');
				},
				fromEdge : function() {
					if (!this.params.debugger)
						return;
					//console.log('fromEdge');
				},
				reachBeginning : function() {
					if (!this.params.debugger)
						return;
					//console.log('reachBeginning');
				},
				reachEnd : function() {
					if (!this.params.debugger)
						return;
					//console.log('reachEnd');
				},
			},
		};
	</script>

	<script>
		// Install Plugin To Swiper
		Swiper.use(myPlugin);

		// Init Swiper
		var swiper = new Swiper('.swiper-container', {
			//       pagination: {
			//         el: '.swiper-pagination',
			//         clickable: true,
			//       },
			allowTouchMove : false,
			
			navigation : {
				nextEl : '.swiper-button-next',
				prevEl : '.swiper-button-prev',
			},
			
			// Enable debugger
			debugger : true,

		});
		
		function saveAnswer(answer){
			psyFrm.answers.value = answer;
			psyFrm.submit();
		}
	var ids = [];
	<c:forEach var="vo" items="${voList}">
		ids.push(${vo.id});
	</c:forEach>
	
	function chkIds( val ){
		var existId = true;
		
		for(var id=0; id<ids.length; id++){
		    if(ids[id] == parseInt(val)){
		    	existId = false;
		    }
		}
		
		if(!existId){
			alert("이미 등록된 학번입니다.");
		}else{
			alert("사용가능한 학번입니다.");
		}
		
		return existId;
	}
	</script>
</body>
</html>