<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		 <c:forEach var = "move" items = "${titleArr}"> 	
			<tr>
				 <td>
				<img src = "${move.image}"> 
				</td> 
			</tr>
			<tr>
				<td>
					 ${move.title}  			
				</td>
			</tr>
			<tr>
				<td>
					 ${move.actor}			
				</td>
			</tr>   
		 </c:forEach> 
</body>
</html>