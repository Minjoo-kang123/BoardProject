<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.head{
  	width : 100%;
  	padding-left:20%;
  	padding-right:20%;
  	background-color : #D3D3D3;
  	position: fixed;
  	height:20px;
}.menu{
  	width : 20%;
}
.wrapper {
	display: flex;
	justify-content: center;
	align-items: center;
}
.container{
  	width : 85%
}
ul {
  	list-style-type: none;
  	padding: 0px;
  	margin-top:20px;
  	width: 150px;
  	background: #D3D3D3;
  	height: 100%;
  	overflow: auto;
  	position: fixed;
}

li a {
  text-decoration: none;
  padding: 10px;
  display: block;
  color: #000;
  font-weight: bold;
}
.context{
  margin-left: 170px;
  margin-top:20px;
}
	
</style>
</head>
<body>
<div class = "head">
<table>
	<tr>
		<td class = "menu"><a href="/user/logout">로그아웃</a></td>
		<td class = "menu"><a href="/">홈</a></td>
		<c:if test = "${user.auth ==20}"> 
		<td class = "menu"><a href="/admin">관리자 메뉴</a></td>
		</c:if>
		<td class = "menu" >${user.username} 님 안녕하세요!</td>
	</tr>
</table>
</div>

</body>
</html>