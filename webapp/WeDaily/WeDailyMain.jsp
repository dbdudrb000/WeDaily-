<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WeDaily Home Page</title>
<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>


<link href="js/calendar/fullcalendar.css" />
<script src="js/common/jquery-ui.js"></script>
<script src="js/calendar/moment.min.js"></script>
<script src="js/calendar/fullcalendar.js"></script>
<style>
	ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    background-color: #333;
	}
	ul:after{
	    content:'';
	    display: block;
	    clear:both;
	}
	li {
	    float: right;
	}
	li a {
	    display: block;
	    color: white;
	    text-align: center;
	    padding: 14px 16px;
	    text-decoration: none;
	}
	li a:hover:not(.active) {
	    background-color: #111;
	}
	.logo{
		float: center;
	}


</style>


</head>
<body>	
	<nav>
		<ul>
			
	      <li><a href="#news"></a></li>
	      <li><a href="#contact">회원가입</a></li>
	      <li><a href="#about">로그인</a></li>
	      <li><a class="active" href="#home">Home</a></li>
	      </h3><li class = "logo" style = "color: antiquewhite; margin: 10px; margin-right: 31%; font-size: 23px;">WeDaily</li>
	    </ul>
	</nav>

	<form action = "/moveselect">
		<input type = "text" name = "search">
		<input type = "submit" value = "버튼">
	</form>
	
	
<script >

</script>


</body>
</html>