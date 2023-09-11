<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" 
rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" 
integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<meta charset="UTF-8">
<title>회원 상세보기</title>

<style>
.join_ta{
	border : 1px solid;
	border-collapse:collapse;
	width : 100%
}
.me{
		padding-left : 10px;
		padding-right : 10px;
		height : 50px;
	}
.wrapper{
	width : 70%;
	margin : 0 auto;
	padding-top : 50px;
	}
</style>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class="wrapper">
	<table class="join_ta">
		<tr>
			<td class = "me" colspan = "3">회원승인</td>
		</tr>
		<tr>
			<td class = "me" >아이디</td>
			<td class = "me"  colspan = "2">${userinfo.userId}</td>
		</tr>
		<tr>
			<td class = "me" >이름</td>
			<td class = "me"  colspan = "2">${userinfo.username}</td>
		</tr>
		<tr>
			<td class = "me" >이메일</td>
			<td class = "me"  colspan = "2">${userinfo.email}</td>
		</tr>
		<tr>
			<td class = "me" >전화번호</td>
			<td  class = "me" colspan = "2">${userinfo.phone} </td>
		</tr>
		<tr>
			<td class = "me" >부서</td>
			<td class = "me"  colspan = "2">${userinfo.department}</td>
		</tr>
		<tr>
		<td class = "me" >
			<form method="post"  action="/admin/submit">
				<button class="btn btn-outline-primary">회원 승인</button> 
				<input type="hidden" name = "email" value = "${userinfo.email}"/>
				<input type="hidden" name = "userid" value = "${userinfo.userId}"/>
			</form>
		</td>
			<td><button class="btn btn-outline-primary" onclick="location.href='/admin'">리스트로 돌아가기</button> </td>
			
			<td class = "me" >
			<form method="post"  action="/admin/delete">
				<button class="btn btn-outline-primary">회원 미승인</button> 
				<input type="hidden" name = "email" value = "${userinfo.email}"/>
				<input type="hidden" name = "userid" value = "${userinfo.userId}"/>
			</form>
		</tr>
	</table>
</div>

</body>
</html>