<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>move search</title>

	<!-- 부트스트랩  CSS-->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    
	<!-- 부트스트랩 JS  -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>


	<!-- 상단 메뉴바 css -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/topMenu.css">
	<!-- 모달 css -->
	<link rel="stylesheet" type="text/css" href="/resources/css/wedaily/modal.css">

	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>

	<style>
		
	  font: 13px "Lucida sans", Arial, Helvetica;
	  color: #eee;
	  text-align: center;
	}
	
	a {
	  color: #ccc;
	}
	
	/*-------------------------------------*/
	
	.cf:before,
	.cf:after {
	  content: "";
	  display: table;
	}
	
	.cf:after {
	  clear: both;
	}
	
	.cf {
	  zoom: 1;
	}
	
	/*-------------------------------------*/
	
	.form-wrapper {
	  width: 450px;
	  padding: 5px;
	  margin: 50px auto 50px auto;
	  background: #444;
	  background: rgba(0, 0, 0, 0.2);
	  -moz-border-radius: 10px;
	  -webkit-border-radius: 10px;
	  border-radius: 10px;
	  -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4) inset,
	    0 1px 0 rgba(255, 255, 255, 0.2);
	  -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4) inset,
	    0 1px 0 rgba(255, 255, 255, 0.2);
	  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4) inset,
	    0 1px 0 rgba(255, 255, 255, 0.2);
	}
	
	.form-wrapper input {
	  width: 330px;
	  height: 40px;
	  padding: 10px 5px;
	  float: left;
	  font: bold 15px "lucida sans", "trebuchet MS", "Tahoma";
	  border: 0;
	  background: #eee;
	  -moz-border-radius: 3px 0 0 3px;
	  -webkit-border-radius: 3px 0 0 3px;
	  border-radius: 3px 0 0 3px;
	}
	
	.form-wrapper input:focus {
	  outline: 0;
	  background: #fff;
	  -moz-box-shadow: 0 0 2px rgba(0, 0, 0, 0.8) inset;
	  -webkit-box-shadow: 0 0 2px rgba(0, 0, 0, 0.8) inset;
	  box-shadow: 0 0 2px rgba(0, 0, 0, 0.8) inset;
	}
	
	.form-wrapper input::-webkit-input-placeholder {
	  color: #999;
	  font-weight: normal;
	  font-style: italic;
	}
	
	.form-wrapper input:-moz-placeholder {
	  color: #999;
	  font-weight: normal;
	  font-style: italic;
	}
	
	.form-wrapper input:-ms-input-placeholder {
	  color: #999;
	  font-weight: normal;
	  font-style: italic;
	}
	
	.form-wrapper button {
	  overflow: visible;
	  position: relative;
	  float: right;
	  border: 0;
	  padding: 0;
	  cursor: pointer;
	  height: 40px;
	  width: 110px;
	  font: bold 15px/40px "lucida sans", "trebuchet MS", "Tahoma";
	  color: #fff;
	  text-transform: uppercase;
	  background: #4b70a7;
	  -moz-border-radius: 0 3px 3px 0;
	  -webkit-border-radius: 0 3px 3px 0;
	  border-radius: 0 3px 3px 0;
	  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3);
	}
	
	.form-wrapper button:hover {
	  background: #e54040;
	}
	
	.form-wrapper button:active,
	.form-wrapper button:focus {
	  background: #c42f2f;
	}
	
	.form-wrapper button:before {
	  content: "";
	  position: absolute;
	  border-width: 8px 8px 8px 0;
	  border-style: solid solid solid none;
	  border-color: transparent #4b70a7 transparent;
	  top: 12px;
	  left: -6px;
	}
	
	.form-wrapper button:hover:before {
	  border-right-color: #e54040;
	}
	
	.form-wrapper button:focus:before {
	  border-right-color: #c42f2f;
	}
	
	.form-wrapper button::-moz-focus-inner {
	  border: 0;
	  padding: 0;
	}
	.byline p {
	  text-align: center;
	  color: #c6c6c6;
	  font: bold 18px Arial, Helvetica, Sans-serif;
	  text-shadow: 0 2px 3px rgba(0, 0, 0, 0.1);
	}
	
	.byline p a {
	  color: #d83c3c;
	  text-decoration: none;
	}
		
	/* 영화정보 CSS */
	
	.container {
		border-style: solid;
    	border-color: gold;	
	}
	
	
	.move_info_image > img {
		width: 250px;
	    margin-left: 11%;  
	    border-style: solid;
	    border-solid FONT-WEIGHT: 100;
	    border-color: coral;
	    float:left;
	}	
		
	/* 부트스트랩 재정의 css */
	#move_text{
		background-color: tan;
	    text-align: center;
	    border-radius: 110px / 80px;
	}
	
	/* 영화보여주는 창 CSS  ( codepen.io ) */
	
	/* codepen.io @@@@@@@@@@@@*/

	/* Global */
	img {
		max-width: 100%;
	}
	
	a {
		-webkit-transition: all 150ms ease;
		-moz-transition: all 150ms ease;
		-ms-transition: all 150ms ease;
		-o-transition: all 150ms ease;
		transition: all 150ms ease;
	}
	
	a:hover {
		-ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=50)";
		/* IE 8 */
		filter: alpha(opacity = 50); /* IE7 */
		opacity: 0.6;
		text-decoration: none;
	}
	
	/* Container */
	.container-fluid {
		background: #E6CFC5;
		margin: 40px auto 10px;
		padding: 20px 40px 0;
		max-width: 960px;
		box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
	}
	
	/* Page Header */
	.page-header {
		background: #f9f9f9;
		margin: -30px -40px 40px;
		padding: 20px 40px;
		border-top: 4px solid #ccc;
		color: #999;
		text-transform: uppercase;
	}
	
	.page-header h3 {
		line-height: 0.88rem;
		color: #000;
	}
	
	/* Thumbnail Box */
	.caption h4 {
		font-size: 1rem;
		color: #444;
	}
	
	.caption p {
		font-size: 0.75rem;
		color: #999;
	}
	
	.btn.btn-mini {
		font-size: 0.63rem;
	}
	
	/* Carousel Control */
	.control-box {
		text-align: right;
		width: 100%;
	}
	
	.carousel-control {
		background: #666;
		border: 0px;
		border-radius: 0px;
		display: inline-block;
		font-size: 34px;
		font-weight: 200;
		line-height: 18px;
		opacity: 0.5;
		padding: 4px 10px 0px;
		position: static;
		height: 30px;
		width: 15px;
	}
	
	/* Footer */
	.footer {
		margin: auto;
		width: 100%;
		max-width: 960px;
		display: block;
		font-size: 0.69rem;
	}
	
	.footer, .footer a {
		color: #c9e4f7;
	}
	
	p.right {
		float: right;
	}
	
	/* Mobile Only */
	@media ( max-width : 767px) {
		.page-header, .control-box {
			text-align: center;
		}
	}
	
	@media ( max-width : 479px) {
		.caption {
			word-break: break-all;		
		}
	}
	
	/* ADD-ON
	-------------------------------------------------- */
	body:after {
		content: "less than 320px";
		font-size: 1rem;
		font-weight: bold;
		position: fixed;
		bottom: 0;
		width: 100%;
		text-align: center;
		background-color: hsla(1, 60%, 40%, 0.7);
		color: #fff;
		height: 20px;
		padding-top: 0;
		margin-left: 0;
		left: 0
	}
	
	@media only screen and (min-width:320px) {
		body:after {
			content: "320 to 480px";
			background-color: hsla(90, 60%, 40%, 0.7);
			height: 20px;
			padding-top: 0;
			margin-left: 0
		}
	}
	
	@media only screen and (min-width:480px) {
		body:after {
			content: "480 to 768px";
			background-color: hsla(180, 60%, 40%, 0.7);
			height: 20px;
			padding-top: 0;
			margin-left: 0
		}
	}
	
	@media only screen and (min-width:768px) {
		body:after {
			content: "768 to 980px";
			background-color: hsla(270, 60%, 40%, 0.7);
			height: 20px;
			padding-top: 0;
			margin-left: 0
		}
	}
	
	@media only screen and (min-width:980px) {
		body:after {
			content: "980 to 1024px";
			background-color: hsla(300, 60%, 40%, 0.7);
			height: 20px;
			padding-top: 0;
			margin-left: 0
		}
	}
	
	@media only screen and (min-width:1024px) {
		body:after {
			content: "1024 and up";
			background-color: hsla(360, 60%, 40%, 0.7);
			height: 20px;
			padding-top: 0;
			margin-left: 0
		}
	}
	
	::selection {
		background: #ff5e99;
		color: #FFFFFF;
		text-shadow: 0;
	}
	
	::-moz-selection {
		background: #ff5e99;
		color: #FFFFFF;
	}
		
	a, a:focus, a:active, a:hover, object, embed {
		outline: none;
	}
	
	:-moz-any-link:focus {
		outline: none;
	}
	
input::-moz-focus-inner {
	border: 0;
	}

	.span3{
		margin: px;
	}
	#thumbnailsID{
		margin-right: 335px;
		list-style: none;
	}
	
	#thumbnailsID  a {
		border: ridge;
	}
	
	.page-header{
		text-align: center;
		background-color: #665C58;
	}
	#linkID{
		margin-left: 70px;
   	 	font-size: inherit;
	}
	
	#captionID{
		border: ridge;
	}
	</style>

</head>
<body style = "background-color:#f6f1e7;">

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
				<li><a class="active" href="/move2">Home</a></li>
				</h3><li class = "logo" style = "color: antiquewhite; margin: 10px; margin-right: 31%; font-size: 23px;">WeDaily</li>	
	    	</c:if>	
	    </ul>
	</nav>
	
	<!-- 검색창 -->
	<form class="form-wrapper cf" action = "/moveselect">
	  	<input type="text" placeholder="검색할 영화를 입력해주세요." name = "search" required>
		<button type="submit">검색</button>
	</form>
	<div class="byline">
	</div>		
	
	<!-- codepen.io  -->
	
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
			    <div class="page-header">
			        <h3>영화 검색</h3>
			        <p>Responsive Moving Box Carousel Demo</p>
			    </div>
			        
			    <div class="carousel slide" id="myCarousel">
			        <div class="carousel-inner" id = "carousel-innerID">
			            <div class="item active">
			                    <ul class="thumbnails" id = "thumbnailsID">
			                    	<c:forEach var = "move" items = "${naverMove}">
				                        <li class="span3">
				                            <div class="thumbnail">
				                                <a href="${move.move_link}"><img src="${move.image}" alt="" style ="width:200px;"></a>
				                            </div>
				                            <div class="caption" id = "captionID">
				                                <%-- <h4>제목 | ${move.title}</h4>
				                				<h4>평점 | ${move.move_rating}</h4>
				                				<h4>출연배우 | ${move.actor}</h4> --%>
				                				   <table>
				                					<tr>
				                						<th>제목:</th>
				                						<td>${move.title }</td>
				                					</tr>
				                					<tr>
				                						<th>평점:</th>
				                						<td>${move.move_rating}</td>
				                					</tr>
				                					<tr>
				                					<th>출연배우:</th>
				                					<td>${move.actor }</td>
				                					</tr>
				                				</table>	                   	
				                            </div>
				                        </li>
			                        </c:forEach>			                    
			                    </ul>		  
			              </div><!-- /Slide1 -->           
			        </div>
			   </div><!-- /#myCarousel -->		        
			</div><!-- /.span12 -->          
		</div><!-- /.row --> 
	</div><!-- /.container -->

                            
<!-- Delete This -->                        
<div class="footer">
<a href="http://simonalex.com/">&hearts; Redfrost</a> | <a href="https://twitter.github.com/bootstrap/">Get Bootstrap</a> | <a href="http://placehold.it/">Get Placeholder</a>   
    <p class="right">&lsaquo; Resize Window &rsaquo;</p>
    <p>&nbsp;</p>
    <p><strong>*VISIT THIS LINK FOR IE9 FIX: <a href="https://codepen.io/redfrost/pen/yKAmc"  target="_blank">https://codepen.io/redfrost/pen/yKAmc</a>        
<strong></p>    
</div>
	
	
	
	
</body>
</html>