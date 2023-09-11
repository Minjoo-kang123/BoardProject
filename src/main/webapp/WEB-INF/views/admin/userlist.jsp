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


<style>
	.wrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	}
	.container{
		width : 80%
	}
	ul {
	  list-style-type: none;
	  padding: 0px;
  		margin-top:20px;
	  width: 100px;
	  background: gray;
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
  margin-left: 120px;
  margin-top:20px;
}
</style>
<meta charset="UTF-8">
<title>미승인 회원 list</title>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class ="wrapper">
	<div class = "container">	
		<div class = "context">
			<table class="table table-striped table-hover">
				<colgroup>
					<col style="width:15%;" />
					<col style="width:auto;" />
					<col style="width:15%;" />
				</colgroup>
				<thead>
					<tr>
						<th>사용자 ID</th>
						<th>이름</th>
						<th>가입신청날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty userList}" >
							<tr><td colspan="4" align="center">승인 대기중인 사용자가 없습니다.</td></tr>
						</c:when> 
						<c:when test="${!empty userList}">
							<c:forEach var="list" items="${userList}">
								<tr>
									<td><c:out value="${list.userId}" /></td>
									<td><a style = " display : block; " href="<c:url value='/admin/userdetail'>
											<c:param name='userId' value='${list.userId}'/> </c:url>"><c:out value="${list.username}"/></a></td>
									<td><c:out value="${list.joindate}"/></td>
								</tr>
							</c:forEach>
						</c:when>
					</c:choose>
				</tbody>
			</table>
			<br><br>
			<table class="table table-striped table-hover">
				<colgroup>
					<col style="width:15%;" />
					<col style="width:auto;" />
					<col style="width:10%;" />
				</colgroup>
				<thead>
					<tr>
						<th>사용자 ID</th>
						<th>이름</th>
						<th>권한</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty allUserList}" >
							<tr><td colspan="4" align="center">승인 대기중인 사용자가 없습니다.</td></tr>
						</c:when> 
						<c:when test="${!empty allUserList}">
							<c:forEach var="list" items="${allUserList}">
								<tr>
									<td><c:out value="${list.userId}" /></td>
									<td><c:out value="${list.username}"/></td>
									<td><c:out value="${list.auth}"/></td>
								</tr>
							</c:forEach>
						</c:when>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
</div>


</body>
</html>